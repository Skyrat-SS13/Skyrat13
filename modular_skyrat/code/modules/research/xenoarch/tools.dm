/obj/item/xenoarch
	name = "Parent Xenoarch"
	desc = "Debug. Parent Clean"
	icon = 'modular_skyrat/code/modules/research/xenoarch/tools.dmi'

/obj/item/xenoarch/Initialize()
	..()

/obj/item/xenoarch/clean/hammer
	name = "Parent hammer"
	desc = "Debug. Parent Hammer."
	var/cleandepth = 15

/obj/item/xenoarch/clean/hammer/cm1
	name = "mining hammer cm1"
	desc = "removes 1cm of material."
	icon_state = "pick1"
	cleandepth = 1

/obj/item/xenoarch/clean/hammer/cm2
	name = "mining hammer cm2"
	desc = "removes 2cm of material."
	icon_state = "pick2"
	cleandepth = 2

/obj/item/xenoarch/clean/hammer/cm3
	name = "mining hammer cm3"
	desc = "removes 3cm of material."
	icon_state = "pick3"
	cleandepth = 3

/obj/item/xenoarch/clean/hammer/cm4
	name = "mining hammer cm4"
	desc = "removes 4cm of material."
	icon_state = "pick4"
	cleandepth = 4

/obj/item/xenoarch/clean/hammer/cm5
	name = "mining hammer cm5"
	desc = "removes 5cm of material."
	icon_state = "pick5"
	cleandepth = 5

/obj/item/xenoarch/clean/hammer/cm6
	name = "mining hammer cm6"
	desc = "removes 6cm of material."
	icon_state = "pick6"
	cleandepth = 6

/obj/item/xenoarch/clean/hammer/cm15
	name = "mining hammer cm15"
	desc = "removes 15cm of material."
	icon_state = "pick_hand"
	cleandepth = 15

//

/obj/item/xenoarch/clean/brush
	name = "mining brush"
	desc = "cleans off the remaining debris."
	icon_state = "pick_brush"

//

/obj/item/xenoarch/help/scanner
	name = "mining scanner"
	desc = "inaccurately scans a rock's depths."
	icon_state = "scanner"

/obj/item/xenoarch/help/scanneradv
	name = "advanced mining scanner"
	desc = "accurately scans a rock's depths."
	icon_state = "adv_scanner"

/obj/item/xenoarch/help/measuring
	name = "measuring tape"
	desc = "measures how far a rock has been dug into."
	icon_state = "measuring"

/obj/item/xenoarch/help/research
	name = "research analyzer"
	desc = "deconstructs artifacts for research."
	icon_state = "researchscanner"

//

/obj/item/storage/belt/xenoarch
	name = "xenoarchaeologist belt"
	desc = "used to store your tools for xenoarchaeology."
	icon = 'modular_skyrat/code/modules/research/xenoarch/tools.dmi'
	icon_state = "miningbelt"

/obj/item/storage/belt/xenoarch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/static/list/can_hold = typecacheof(list(
		/obj/item/xenoarch/help,
		/obj/item/xenoarch/clean,
		/obj/item/mining_scanner,
		/obj/item/pickaxe,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/gps,
		/obj/item/xenoarch/help/research
		))
	STR.can_hold = can_hold
	STR.max_items = 14
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 200

/obj/item/storage/belt/xenoarch/full/PopulateContents()
	new /obj/item/xenoarch/help/measuring(src)
	new /obj/item/xenoarch/help/scanner(src)
	new /obj/item/xenoarch/clean/brush(src)
	new /obj/item/xenoarch/clean/hammer/cm15(src)
	new /obj/item/xenoarch/clean/hammer/cm6(src)
	new /obj/item/xenoarch/clean/hammer/cm5(src)
	new /obj/item/xenoarch/clean/hammer/cm4(src)
	new /obj/item/xenoarch/clean/hammer/cm3(src)
	new /obj/item/xenoarch/clean/hammer/cm2(src)
	new /obj/item/xenoarch/clean/hammer/cm1(src)
	new /obj/item/pickaxe(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/gps(src)
	new /obj/item/xenoarch/help/research(src)
	return

/obj/structure/closet/wardrobe/xenoarch
	name = "science wardrobe"
	icon_state = "science"
	icon_door = "science"

/obj/structure/closet/wardrobe/xenoarch/PopulateContents()
	new /obj/item/xenoarch/help/measuring(src)
	new /obj/item/xenoarch/help/scanner(src)
	new /obj/item/xenoarch/clean/brush(src)
	new /obj/item/xenoarch/clean/hammer/cm15(src)
	new /obj/item/xenoarch/clean/hammer/cm6(src)
	new /obj/item/xenoarch/clean/hammer/cm5(src)
	new /obj/item/xenoarch/clean/hammer/cm4(src)
	new /obj/item/xenoarch/clean/hammer/cm3(src)
	new /obj/item/xenoarch/clean/hammer/cm2(src)
	new /obj/item/xenoarch/clean/hammer/cm1(src)
	new /obj/item/pickaxe(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/gps(src)
	new /obj/item/xenoarch/help/research(src)
	new /obj/item/storage/belt/xenoarch(src)
	return

//

