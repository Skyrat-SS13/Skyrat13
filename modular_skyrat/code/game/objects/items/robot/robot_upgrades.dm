/obj/item/borg/upgrade/xwelding
	name = "engineering cyborg experimental welding tool"
	desc = "An experimental welding tool replacement for the engineering module's standard welding tool."
	icon_state = "cyborg_upgrade3"
	require_module = 1
	module_type = list(/obj/item/robot_module/engineering)

/obj/item/borg/upgrade/xwelding/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/weldingtool/largetank/cyborg/WT in R.module)
			R.module.remove_module(WT, TRUE)

		var/obj/item/weldingtool/experimental/XW = new /obj/item/weldingtool/experimental(R.module)
		R.module.basic_modules += XW
		R.module.add_module(XW, FALSE, TRUE)

/obj/item/borg/upgrade/xwelding/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/weldingtool/experimental/XW in R.module)
			R.module.remove_module(XW, TRUE)

		var/obj/item/weldingtool/largetank/cyborg/WT = new (R.module)
		R.module.basic_modules += WT
		R.module.add_module(WT, FALSE, TRUE)
/* Shit doesnt work, work on it later
/obj/item/borg/upgrade/plasma
	name = "engineering cyborg plasma resource upgrade"
	desc = "An upgrade that allows cyborgs the ability to use plasma and assorted plasma products."
	icon_state = "cyborg_upgrade3"
	require_module = 1
	module_type = list(/obj/item/robot_module/engineering)

/obj/item/borg/upgrade/plasma/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		R.module.basic_modules += /obj/item/stack/sheet/plasmaglass/cyborg
		R.module.add_module(/obj/item/stack/sheet/plasmaglass/cyborg, FALSE, TRUE)
		R.module.basic_modules += /obj/item/stack/sheet/plasmarglass/cyborg
		R.module.add_module(/obj/item/stack/sheet/plasmarglass/cyborg, FALSE, TRUE)
		R.module.basic_modules += /obj/item/stack/sheet/plasteel/cyborg
		R.module.add_module(/obj/item/stack/sheet/plasteel/cyborg, FALSE, TRUE)
		R.module.basic_modules += /obj/item/stack/sheet/mineral/plasma/cyborg
		R.module.add_module(/obj/item/stack/sheet/mineral/plasma/cyborg, FALSE, TRUE)

/obj/item/borg/upgrade/plasma/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		R.module.remove_module(/obj/item/stack/sheet/plasmaglass/cyborg, TRUE)
		R.module.remove_module(/obj/item/stack/sheet/plasmarglass/cyborg, TRUE)
		R.module.remove_module(/obj/item/stack/sheet/plasteel/cyborg, TRUE)
		R.module.remove_module(/obj/item/stack/sheet/mineral/plasma/cyborg, TRUE)
*/