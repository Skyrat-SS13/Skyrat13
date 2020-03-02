/client/place_ruin()
	set category = "Debug"
	set name = "Spawn Ruin"
	set desc = "Attempt to randomly place a specific ruin."
	if (!holder)
		return

	var/list/exists = list()
	for(var/landmark in GLOB.ruin_landmarks)
		var/obj/effect/landmark/ruin/L = landmark
		exists[L.ruin_template] = landmark

	var/list/names = list()
	names += "---- Space Ruins ----"
	for(var/name in SSmapping.space_ruins_templates)
		names[name] = list(SSmapping.space_ruins_templates[name], ZTRAIT_SPACE_RUINS, list(/area/space))
	names += "---- Lava Ruins ----"
	for(var/name in SSmapping.lava_ruins_templates)
		names[name] = list(SSmapping.lava_ruins_templates[name], ZTRAIT_LAVA_RUINS, list(/area/lavaland/surface/outdoors/unexplored))
	names += "---- Ice Ruins ----"
	for(var/name in SSmapping.ice_ruins_templates)
		names[name] = list(SSmapping.ice_ruins_templates[name], ZTRAIT_ICE_RUINS, list(/area/icemoon/surface/outdoors/unexplored, /area/icemoon/underground/unexplored))
	names += "---- Ice Underground Ruins ----"
	for(var/name in SSmapping.ice_ruins_underground_templates)
		names[name] = list(SSmapping.ice_ruins_underground_templates[name], ZTRAIT_ICE_RUINS_UNDERGROUND, list(/area/icemoon/underground/unexplored))

	var/ruinname = input("Select ruin", "Spawn Ruin") as null|anything in sortList(names)
	var/data = names[ruinname]
	if (!data)
		return
	var/datum/map_template/ruin/template = data[1]
	if (exists[template])
		var/response = alert("There is already a [template] in existence.", "Spawn Ruin", "Jump", "Place Another", "Cancel")
		if (response == "Jump")
			usr.forceMove(get_turf(exists[template]))
			return
		else if (response == "Cancel")
			return

	var/len = GLOB.ruin_landmarks.len
	seedRuins(SSmapping.levels_by_trait(data[2]), max(1, template.cost), data[3], list(ruinname = template))
	if (GLOB.ruin_landmarks.len > len)
		var/obj/effect/landmark/ruin/landmark = GLOB.ruin_landmarks[GLOB.ruin_landmarks.len]
		log_admin("[key_name(src)] randomly spawned ruin [ruinname] at [COORD(landmark)].")
		usr.forceMove(get_turf(landmark))
		to_chat(src, "<span class='name'>[template.name]</span>")
		to_chat(src, "<span class='italics'>[template.description]</span>")
	else
		to_chat(src, "<span class='warning'>Failed to place [template.name].</span>")