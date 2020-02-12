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
