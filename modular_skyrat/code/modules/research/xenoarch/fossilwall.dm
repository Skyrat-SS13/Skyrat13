/obj/item/stack/ore/fossil
	icon = 'modular_skyrat/code/modules/research/xenoarch/fossil.dmi'
	icon_state = "strange"
	item_state = "strange"
	points = 64
	custom_materials = list(/datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/glass
	mats_per_stack = 1

/obj/item/stack/ore/fossil/faunafossil

/obj/item/stack/ore/fossil/faunafossil/Initialize()
	var/randomstate = rand(1,4)
	if(randomstate == 1)
		icon_state = "bone"
		item_state = "bone"
	else if(randomstate == 2)
		icon_state = "shell"
		item_state = "shell"
	else if(randomstate == 3)
		icon_state = "hskull"
		item_state = "hskull"
	else if(randomstate == 4)
		icon_state = "skull"
		item_state = "skull"
	..()

/obj/item/stack/ore/fossil/florafossil

/obj/item/stack/ore/fossil/florafossil/Initialize()
	var/randomstate = rand(1,4)
	if(randomstate == 1)
		icon_state = "plant1"
		item_state = "plant1"
	else if(randomstate == 2)
		icon_state = "plant2"
		item_state = "plant2"
	else if(randomstate == 3)
		icon_state = "plant3"
		item_state = "plant3"
	else if(randomstate == 4)
		icon_state = "plant4"
		item_state = "plant4"
	..()

/turf/closed/mineral/fossil
	mineralType = /obj/item/stack/ore/fossil
	spreadChance = 5
	spread = 1
	icon = 'modular_skyrat/code/modules/research/xenoarch/fossilwall.dmi'
	scan_state = "arch2"

/turf/closed/mineral/random/volcanic/New()
	mineralSpawnChanceList += list(/turf/closed/mineral/fossil = 12)
	. = ..()