#define INIT_ANNOUNCE(X) to_chat(world, "<span class='boldannounce'>[X]</span>"); log_world(X)
/datum/controller/subsystem/mapping
	name = "Mapping"
	init_order = INIT_ORDER_MAPPING
	flags = SS_NO_FIRE

	nuke_tiles = list()
	nuke_threats = list()

	datum/map_config/config
	datum/map_config/next_map_config

	list/map_templates = list()

	list/ruins_templates = list()
	list/space_ruins_templates = list()
	list/lava_ruins_templates = list()
	var/list/ice_ruins_templates = list()
	var/list/ice_ruins_underground_templates = list()
	list/shuttle_templates = list()
	list/shelter_templates = list()

	list/areas_in_z = list()

	loading_ruins = FALSE
	list/turf/unused_turfs = list()				//Not actually unused turfs they're unused but reserved for use for whatever requests them. "[zlevel_of_turf]" = list(turfs)
	list/datum/turf_reservations		//list of turf reservations
	list/used_turfs = list()				//list of turf = datum/turf_reservation

	clearing_reserved_turfs = FALSE

	// Z-manager stuff
	station_start  // should only be used for maploading-related tasks
	space_levels_so_far = 0
	list/z_list
	datum/space_level/transit
	datum/space_level/empty_space

/datum/controller/subsystem/mapping/Initialize(timeofday)
	HACK_LoadMapConfig()
	if(initialized)
		return
	if(config.defaulted)
		var/old_config = config
		config = global.config.defaultmap
		if(!config || config.defaulted)
			to_chat(world, "<span class='boldannounce'>Unable to load next or default map config, defaulting to Box Station</span>")
			config = old_config
	GLOB.year_integer += config.year_offset
	GLOB.announcertype = (config.announcertype == "standard" ? (prob(1) ? "medibot" : "classic") : config.announcertype)
	loadWorld()
	repopulate_sorted_areas()
	process_teleport_locs()			//Sets up the wizard teleport locations
	preloadTemplates()
#ifndef LOWMEMORYMODE
	// Create space ruin levels
	while (space_levels_so_far < config.space_ruin_levels)
		++space_levels_so_far
		add_new_zlevel("Empty Area [space_levels_so_far]", ZTRAITS_SPACE)
	// and one level with no ruins
	for (var/i in 1 to config.space_empty_levels)
		++space_levels_so_far
		empty_space = add_new_zlevel("Empty Area [space_levels_so_far]", list(ZTRAIT_LINKAGE = CROSSLINKED))
	// and the transit level
	transit = add_new_zlevel("Transit/Reserved", list(ZTRAIT_RESERVED = TRUE))

	// Pick a random away mission.
	if(CONFIG_GET(flag/roundstart_away))
		createRandomZlevel()


	// Generate mining ruins
	loading_ruins = TRUE
	var/list/lava_ruins = levels_by_trait(ZTRAIT_LAVA_RUINS)
	if (lava_ruins.len)
		seedRuins(lava_ruins, CONFIG_GET(number/lavaland_budget), list(/area/lavaland/surface/outdoors/unexplored), lava_ruins_templates)
		for (var/lava_z in lava_ruins)
			spawn_rivers(lava_z)
	var/list/ice_ruins = levels_by_trait(ZTRAIT_ICE_RUINS)
	if (ice_ruins.len)
		// needs to be whitelisted for underground too so place_below ruins work
		seedRuins(ice_ruins, CONFIG_GET(number/icemoon_budget), list(/area/icemoon/surface/outdoors/unexplored, /area/icemoon/underground/unexplored), ice_ruins_templates)
		for (var/ice_z in ice_ruins)
			spawn_rivers(ice_z, 4, /turf/open/openspace/icemoon, /area/icemoon/surface/outdoors/unexplored)

	var/list/ice_ruins_underground = levels_by_trait(ZTRAIT_ICE_RUINS_UNDERGROUND)
	if (ice_ruins_underground.len)
		seedRuins(ice_ruins_underground, CONFIG_GET(number/icemoon_budget), list(/area/icemoon/underground/unexplored), ice_ruins_underground_templates)
		for (var/ice_z in ice_ruins_underground)
			spawn_rivers(ice_z, 4, /turf/open/lava/plasma/ice_moon, /area/icemoon/underground/unexplored)


	// Generate deep space ruins
	var/list/space_ruins = levels_by_trait(ZTRAIT_SPACE_RUINS)
	if (space_ruins.len)
		seedRuins(space_ruins, CONFIG_GET(number/space_budget), /area/space, space_ruins_templates)
	SSmapping.seedStation()
	loading_ruins = FALSE
#endif
	repopulate_sorted_areas()
	// Set up Z-level transitions.
	setup_map_transitions()
	generate_station_area_list()
	initialize_reserved_level(transit.z_value)
	return ..()

/datum/controller/subsystem/mapping/Recover()
	flags |= SS_NO_INIT
	initialized = SSmapping.initialized
	map_templates = SSmapping.map_templates
	ruins_templates = SSmapping.ruins_templates
	space_ruins_templates = SSmapping.space_ruins_templates
	lava_ruins_templates = SSmapping.lava_ruins_templates
	ice_ruins_templates = SSmapping.ice_ruins_templates
	ice_ruins_underground_templates = SSmapping.ice_ruins_underground_templates
	shuttle_templates = SSmapping.shuttle_templates
	shelter_templates = SSmapping.shelter_templates
	unused_turfs = SSmapping.unused_turfs
	turf_reservations = SSmapping.turf_reservations
	used_turfs = SSmapping.used_turfs

	config = SSmapping.config
	next_map_config = SSmapping.next_map_config

	clearing_reserved_turfs = SSmapping.clearing_reserved_turfs

	z_list = SSmapping.z_list

/datum/controller/subsystem/mapping/loadWorld()
	//if any of these fail, something has gone horribly, HORRIBLY, wrong
	var/list/FailedZs = list()

	// ensure we have space_level datums for compiled-in maps
	InitializeDefaultZLevels()

	// load the station
	station_start = world.maxz + 1
	INIT_ANNOUNCE("Loading [config.map_name]...")
	LoadGroup(FailedZs, "Station", config.map_path, config.map_file, config.traits, ZTRAITS_STATION)

	if(SSdbcore.Connect())
		var/datum/DBQuery/query_round_map_name = SSdbcore.NewQuery("UPDATE [format_table_name("round")] SET map_name = '[config.map_name]' WHERE id = [GLOB.round_id]")
		query_round_map_name.Execute()
		qdel(query_round_map_name)

#ifndef LOWMEMORYMODE
	// TODO: remove this when the DB is prepared for the z-levels getting reordered
	while (world.maxz < (5 - 1) && space_levels_so_far < config.space_ruin_levels)
		++space_levels_so_far
		add_new_zlevel("Empty Area [space_levels_so_far]", ZTRAITS_SPACE)

	// load mining
	if (config.minetype == "random")
		config.minetype = pickweightAllowZero(GLOB.mining_maps)

	GLOB.current_mining_map = config.minetype
	if(config.minetype == "lavaland")
		LoadGroup(FailedZs, "Lavaland", "map_files/Mining", "Lavaland.dmm", default_traits = ZTRAITS_LAVALAND)
	else if (config.minetype == "icemoon")
		LoadGroup(FailedZs, "Ice moon Underground", "modular_skyrat/_map/map_files/Mining", "IcemoonUnderground.dmm", default_traits = ZTRAITS_ICEMOON_UNDERGROUND)
		LoadGroup(FailedZs, "Ice moon", "modular_skyrat/_map/map_files/Mining", "Icemoon.dmm", default_traits = ZTRAITS_ICEMOON)
	else if (!isnull(config.minetype))
		INIT_ANNOUNCE("WARNING: An unknown minetype '[config.minetype]' was set! This is being ignored! Update the maploader code!")
	// reset the mining map to random so if an admin sets the mining map it isn't stuck to that forever
	GLOB.next_mining_map = "random"
	var/datum/map_config/VM = load_map_config()
	SSmapping.changemap(VM)
#endif

	if(LAZYLEN(FailedZs))	//but seriously, unless the server's filesystem is messed up this will never happen
		var/msg = "RED ALERT! The following map files failed to load: [FailedZs[1]]"
		if(FailedZs.len > 1)
			for(var/I in 2 to FailedZs.len)
				msg += ", [FailedZs[I]]"
		msg += ". Yell at your server host!"
		INIT_ANNOUNCE(msg)
#undef INIT_ANNOUNCE

/datum/controller/subsystem/mapping/preloadRuinTemplates()
	// Still supporting bans by filename
	var/list/banned = generateMapList("[global.config.directory]/lavaruinblacklist.txt")
	banned += generateMapList("[global.config.directory]/spaceruinblacklist.txt")
	banned += generateMapList("[global.config.directory]/iceruinblacklist.txt")

	for(var/item in sortList(subtypesof(/datum/map_template/ruin), /proc/cmp_ruincost_priority))
		var/datum/map_template/ruin/ruin_type = item
		// screen out the abstract subtypes
		if(!initial(ruin_type.id))
			continue
		var/datum/map_template/ruin/R = new ruin_type()

		if(banned.Find(R.mappath))
			continue

		map_templates[R.name] = R
		ruins_templates[R.name] = R

		if(istype(R, /datum/map_template/ruin/lavaland))
			lava_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/icemoon/underground))
			ice_ruins_underground_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/icemoon))
			ice_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/space))
			space_ruins_templates[R.name] = R
		else if(istype(R, /datum/map_template/ruin/station))
			station_room_templates[R.name] = R