/obj/item/robot_module/proc/add_module(obj/item/I, nonstandard, requires_rebuild)
	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I

		if(is_type_in_list(S, list(/obj/item/stack/sheet/metal, /obj/item/stack/rods, /obj/item/stack/tile/plasteel)))
			if(S.custom_materials?.len && S.custom_materials[getmaterialref(/datum/material/iron)])
				S.cost = S.custom_materials[getmaterialref(/datum/material/iron)] * 0.25
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
/* testing
/obj/item/robot_module/butler
	name = "Service"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/crowbar/cyborg,
		/obj/item/reagent_containers/food/drinks/drinkingglass,
		/obj/item/reagent_containers/food/condiment/enzyme,
		/obj/item/pen,
		/obj/item/toy/crayon/spraycan/borg,
		/obj/item/hand_labeler/borg,
		/obj/item/razor,
		/obj/item/instrument/violin,
		/obj/item/instrument/guitar,
		/obj/item/rsf/cyborg,
		/obj/item/reagent_containers/dropper,
		/obj/item/lighter,
		/obj/item/storage/bag/tray,
		/obj/item/reagent_containers/borghypo/beershaker,
		/obj/item/reagent_containers/borghypo/juiceshaker,
		/obj/item/reagent_containers/borghypo/sodashaker,
		/obj/item/reagent_containers/borghypo/miscshaker,
		/obj/item/borg/lollipop,
		/obj/item/screwdriver/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/soap/nanotrasen,
		/obj/item/storage/bag/trash/cyborg,
		/obj/item/mop/cyborg,
		/obj/item/lightreplacer/cyborg,
		/obj/item/holosign_creator,
		/obj/item/reagent_containers/spray/cyborg_drying)
	emag_modules = list(/obj/item/reagent_containers/borghypo/borgshaker/hacked)
	ratvar_modules = list(/obj/item/clockwork/slab/cyborg/service,
		/obj/item/borg/sight/xray/truesight_lens)
	moduleselect_icon = "service"
	hat_offset = 0
	clean_on_move = TRUE
*/
obj/item/robot_module/butler/Initialize()
	basic_modules -= /obj/item/reagent_containers/borghypo/borgshaker
	basic_modules += /obj/item/reagent_containers/borghypo/beershaker
	basic_modules += /obj/item/reagent_containers/borghypo/juiceshaker
	basic_modules += /obj/item/reagent_containers/borghypo/sodashaker
	basic_modules += /obj/item/reagent_containers/borghypo/miscshaker
	. = ..()

/datum/robot_energy_storage/plasma
	name = "Plasma Buffer Container"
	recharge_rate = 0