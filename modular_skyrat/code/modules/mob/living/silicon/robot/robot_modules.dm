/obj/item/robot_module/proc/add_module(obj/item/I, nonstandard, requires_rebuild)
	rad_flags |= RAD_NO_CONTAMINATE
	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I

		if(is_type_in_list(S, list(/obj/item/stack/sheet/metal, /obj/item/stack/rods, /obj/item/stack/tile/plasteel)))
			if(S.custom_materials?.len && S.custom_materials[SSmaterials.GetMaterialRef(/datum/material/iron)])
				S.cost = S.custom_materials[SSmaterials.GetMaterialRef(/datum/material/iron)] * 0.25
			S.source = get_or_create_estorage(/datum/robot_energy_storage/metal)

		else if(istype(S, /obj/item/stack/sheet/glass))
			S.cost = 500
			S.source = get_or_create_estorage(/datum/robot_energy_storage/glass)

		else if(istype(S, /obj/item/stack/sheet/rglass/cyborg))
			var/obj/item/stack/sheet/rglass/cyborg/G = S
			G.source = get_or_create_estorage(/datum/robot_energy_storage/metal)
			G.glasource = get_or_create_estorage(/datum/robot_energy_storage/glass)

		else if(istype(S, /obj/item/stack/sheet/plasmaglass/cyborg))
			//var/obj/item/stack/sheet/plasmaglass/cyborg/G = S
			//G.plasource = get_or_create_estorage(/datum/robot_energy_storage/plasma)
			//G.glasource = get_or_create_estorage(/datum/robot_energy_storage/glass)
			S.cost = 500
			S.source = get_or_create_estorage(/datum/robot_energy_storage/plasma)

		else if(istype(S, /obj/item/stack/sheet/plasmarglass/cyborg))
			//var/obj/item/stack/sheet/plasmarglass/cyborg/G = S
			//G.plasource = get_or_create_estorage(/datum/robot_energy_storage/plasma)
			//G.glasource = get_or_create_estorage(/datum/robot_energy_storage/glass)
			S.cost = 1000
			S.source = get_or_create_estorage(/datum/robot_energy_storage/plasma)

		else if(istype(S, /obj/item/stack/sheet/plasteel/cyborg))
			//var/obj/item/stack/sheet/plasteel/cyborg/G = S
			//G.source = get_or_create_estorage(/datum/robot_energy_storage/metal)
			//G.plasource = get_or_create_estorage(/datum/robot_energy_storage/plasma)
			S.cost = 500
			S.source = get_or_create_estorage(/datum/robot_energy_storage/plasma)

		else if(istype(S, /obj/item/stack/sheet/mineral/plasma/cyborg))
			S.cost = 500
			S.source = get_or_create_estorage(/datum/robot_energy_storage/plasma)

		else if(istype(S, /obj/item/stack/medical))
			S.cost = 250
			S.source = get_or_create_estorage(/datum/robot_energy_storage/medical)

		else if(istype(S, /obj/item/stack/cable_coil))
			S.cost = 1
			S.source = get_or_create_estorage(/datum/robot_energy_storage/wire)

		else if(istype(S, /obj/item/stack/marker_beacon))
			S.cost = 1
			S.source = get_or_create_estorage(/datum/robot_energy_storage/beacon)

		else if(istype(S, /obj/item/stack/packageWrap))
			S.cost = 1
			S.source = get_or_create_estorage(/datum/robot_energy_storage/wrapping_paper)

		if(S && S.source)
			S.custom_materials = null
			S.is_cyborg = 1

	if(I.loc != src)
		I.forceMove(src)
	modules += I
	ADD_TRAIT(I, TRAIT_NODROP, CYBORG_ITEM_TRAIT)
	I.mouse_opacity = MOUSE_OPACITY_OPAQUE
	if(nonstandard)
		added_modules += I
	if(requires_rebuild)
		rebuild_modules()
	return I

/obj/item/robot_module/engineering/Initialize()
	basic_modules += /obj/item/pen
	basic_modules += /obj/item/electronics/airlock
	basic_modules += /obj/item/stack/sheet/plasmaglass/cyborg
	basic_modules += /obj/item/stack/sheet/plasmarglass/cyborg
	basic_modules += /obj/item/stack/sheet/plasteel/cyborg
	basic_modules += /obj/item/stack/sheet/mineral/plasma/cyborg
	. = ..()

obj/item/robot_module/butler/Initialize()
	basic_modules -= /obj/item/reagent_containers/borghypo/borgshaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/beershaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/juiceshaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/sodashaker
	basic_modules += /obj/item/reagent_containers/borghypo/borgshaker/miscshaker
	. = ..()

/obj/item/robot_module/miner/Initialize()
	basic_modules += /obj/item/card/id/miningborg
	. = ..()

/datum/robot_energy_storage/plasma
	name = "Plasma Buffer Container"
	recharge_rate = 0

/obj/item/robot_module/standard/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/standard_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
		"Marina" = image(icon = 'modular_skyrat/icons/mob/robotssd.dmi', icon_state = "marinasd"),
		"Heavy" = image(icon = 'modular_skyrat/icons/mob/robotssd.dmi', icon_state = "heavysd"),
		"Eyebot" = image(icon = 'modular_skyrat/icons/mob/robotssd.dmi', icon_state = "eyebotsd"),
		"Robot" = image(icon = 'modular_skyrat/icons/mob/robotssd.dmi', icon_state = "robot_old"),
		"Bootyborg" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "bootysd"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "male_bootysd"),
		"Protectron" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "protectron_standard"),
		"Miss m" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "missm_sd")
		)
	if(R.client && R.client.ckey == "banangarang")
		var/image/cus_maid = image(icon = 'modular_skyrat/icons/mob/robo-maid2.dmi', icon_state = "robomaid_sd")
		standard_icons["RoboMaid"] = cus_maid
	standard_icons = sortList(standard_icons)
	var/standard_borg_icon = show_radial_menu(R, R , standard_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(standard_borg_icon)
		if("Default")
			cyborg_base_icon = "robot"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Marina")
			cyborg_base_icon = "marinasd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			has_snowflake_deadsprite = TRUE
		if("Heavy")
			cyborg_base_icon = "heavysd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			has_snowflake_deadsprite = TRUE
		if("Eyebot")
			cyborg_base_icon = "eyebotsd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			has_snowflake_deadsprite = TRUE
		if("Robot")
			cyborg_base_icon = "robot_old"
			cyborg_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			has_snowflake_deadsprite = TRUE
		if("Bootyborg")
			cyborg_base_icon = "bootysd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootysd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_standard"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Miss m")
			cyborg_base_icon = "missm_sd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("RoboMaid")
			cyborg_base_icon = "robomaid_sd"
			cyborg_icon_override = 'modular_skyrat/icons/mob/robo-maid2.dmi'
		else
			return FALSE
	return ..()

/obj/item/robot_module/peacekeeper/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/peace_icons = sortList(list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
		"Borgi" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "borgi"),
		"Spider" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "whitespider"),
		"Sleek" = image(icon = 'modular_skyrat/icons/mob/customrobot.dmi', icon_state = "sleekpeace"),
		"Marina" = image(icon = 'modular_skyrat/icons/mob/customrobot.dmi', icon_state = "marinapeace"),
		"Bootyborg" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "bootypeace"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "male_bootypeace"),
		"Protectron" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "protectron_peacekeeper")
		))
	var/peace_borg_icon = show_radial_menu(R, R , peace_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(peace_borg_icon)
		if("Default")
			cyborg_base_icon = "peace"
		if("Sleek")
			cyborg_base_icon = "sleekpeace"
			cyborg_icon_override = 'modular_skyrat/icons/mob/customrobot.dmi'
			has_snowflake_deadsprite = TRUE
		if("Spider")
			cyborg_base_icon = "whitespider"
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
		if("Borgi")
			cyborg_base_icon = "borgi"
			moduleselect_icon = "borgi"
			moduleselect_alternate_icon = 'modular_citadel/icons/ui/screen_cyborg.dmi'
			hat_offset = INFINITY
			cyborg_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			has_snowflake_deadsprite = TRUE
		if("Marina")
			cyborg_base_icon = "marinapeace"
			cyborg_icon_override = 'modular_skyrat/icons/mob/customrobot.dmi'
			has_snowflake_deadsprite = TRUE
		if("Bootyborg")
			cyborg_base_icon = "bootypeace"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootypeace"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_peacekeeper"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		else
			return FALSE
	return ..()

/obj/item/robot_module/clown/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/clown_icons = sortList(list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
		"Bootyborg" = image(icon = 'modular_skyrat/icons/mob/clownborgs.dmi', icon_state = "bootyclown"),
		"Bootyborg" = image(icon = 'modular_skyrat/icons/mob/clownborgs.dmi', icon_state = "male_bootyclown"),
		"Marina" = image(icon = 'modular_skyrat/icons/mob/clownborgs.dmi', icon_state = "marina_mommy"),
		"Garish" = image(icon = 'modular_skyrat/icons/mob/clownborgs.dmi', icon_state = "garish"),
		"Robot" = image(icon = 'modular_skyrat/icons/mob/clownborgs.dmi', icon_state = "clownbot"),
		"Sleek" = image(icon = 'modular_skyrat/icons/mob/clownborgs.dmi', icon_state = "clownman")
		))
	var/clown_borg_icon = show_radial_menu(R, R , clown_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(clown_borg_icon)
		if("Default")
			cyborg_base_icon = "clown"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Bootyborg")
			cyborg_base_icon = "bootyclown"
			cyborg_icon_override = 'modular_skyrat/icons/mob/clownborgs.dmi'
		
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyclown"
			cyborg_icon_override = 'modular_skyrat/icons/mob/clownborgs.dmi'

		if("Marina")
			cyborg_base_icon = "marina_mommy"
			cyborg_icon_override = 'modular_skyrat/icons/mob/clownborgs.dmi'
			has_snowflake_deadsprite = TRUE
		if("Garish")
			cyborg_base_icon = "garish"
			cyborg_icon_override = 'modular_skyrat/icons/mob/clownborgs.dmi'
		if("Robot")
			cyborg_base_icon = "clownbot"
			cyborg_icon_override = 'modular_skyrat/icons/mob/clownborgs.dmi'
		if("Sleek")
			cyborg_base_icon = "clownman"
			cyborg_icon_override = 'modular_skyrat/icons/mob/clownborgs.dmi'
			has_snowflake_deadsprite = TRUE
		else
			return FALSE
	return ..()

/obj/item/robot_module/syndicatejack
	name = "Syndicate" 
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/extinguisher,
		/obj/item/weldingtool/experimental,
		/obj/item/screwdriver/nuke,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/weapon/gripper,
		/obj/item/cyborg_clamp,
		/obj/item/lightreplacer/cyborg,
		/obj/item/stack/sheet/metal/cyborg,
		/obj/item/stack/sheet/glass/cyborg,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/destTagger/borg,
		/obj/item/stack/cable_coil/cyborg,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/stack/medical/gauze/cyborg,
		/obj/item/twohanded/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes/advanced,
		/obj/item/retractor/advanced,
		/obj/item/surgicaldrill/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/gun/medbeam,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/borg/lollipop,
		/obj/item/holosign_creator/cyborg,
		/obj/item/stamp/chameleon,
		/obj/item/borg_shapeshifter
		)

	ratvar_modules = list(
	/obj/item/clockwork/slab/cyborg/medical,
	/obj/item/clockwork/slab/cyborg/engineer,
	/obj/item/clockwork/replica_fabricator/cyborg)

	cyborg_base_icon = "synd_engi"
	moduleselect_icon = "malf"
	added_channels = list(RADIO_CHANNEL_SYNDICATE = 1) //Skyrat change
	magpulsing = TRUE
	hat_offset = INFINITY
	canDispose = TRUE

/obj/item/robot_module/syndicatejack/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/syndicatejack_icons = sortList(list(
		"Saboteur" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_engi"),
		"Medical" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_medical"),
		"Assault" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_sec"),
		"Heavy" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "syndieheavy"),
		"Miss m" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "missm_syndie"),
		"Spider" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "spidersyndi"),
		"Booty Striker" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "bootynukie"),
		"Booty Syndicate" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "bootysyndie"),
		"Male Booty Striker" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "male_bootynukie"),
		"Male Booty Syndicate" = image(icon = 'modular_skyrat/icons/mob/moreborgsmodels.dmi', icon_state = "male_bootysyndie"),
		))
	var/syndiejack_icon = show_radial_menu(R, R , syndicatejack_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(syndiejack_icon)
		if("Saboteur")
			cyborg_base_icon = "synd_engi"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Medical")
			cyborg_base_icon = "synd_medical"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Assault")
			cyborg_base_icon = "synd_sec"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "syndieheavy"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Miss m")
			cyborg_base_icon = "missm_syndie"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Spider")
			cyborg_base_icon = "spidersyndi"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Booty Striker")
			cyborg_base_icon = "bootynukie"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Booty Syndicate")
			cyborg_base_icon = "bootysyndie"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Male Booty Striker")
			cyborg_base_icon = "male_bootynukie"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		if("Male Booty Syndicate")
			cyborg_base_icon = "male_bootysyndie"
			cyborg_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		else
			return FALSE
	return ..()
	
/obj/item/robot_module/syndicatejack/rebuild_modules()
    ..()
    var/mob/living/silicon/robot/syndicatejack = loc
    syndicatejack.scrambledcodes = TRUE // We're rouge now

/obj/item/robot_module/syndicatejack/remove_module(obj/item/I, delete_after)
    ..()
    var/mob/living/silicon/robot/syndicatejack = loc
    syndicatejack.scrambledcodes = FALSE // Friends with the AI again