/obj/item/robot_module/proc/add_module(obj/item/I, nonstandard, requires_rebuild)
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

/obj/item/robot_module/peacekeeper/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/peace_icons = sortList(list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
		"Borgi" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "borgi"),
		"Spider" = image(icon = 'modular_citadel/icons/mob/robots.dmi', icon_state = "whitespider"),
		"Sleek" = image(icon = 'modular_skyrat/icons/mob/customrobot.dmi', icon_state = "sleekpeace"),
		"Marina" = image(icon = 'modular_skyrat/icons/mob/customrobot.dmi', icon_state = "marinapeace")
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
		else
			return FALSE
	return ..()