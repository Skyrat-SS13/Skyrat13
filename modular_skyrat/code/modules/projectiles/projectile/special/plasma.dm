/obj/item/projectile/plasma
	dismemberment = 5 //Every 1 out of 20 shots dismember in a depressurized environment, in an ideal world.
	pressure_decrease = 0.2

/obj/item/projectile/plasma/adv
	dismemberment = 10

/obj/item/projectile/plasma/adv/mech
	dismemberment = 5

/obj/item/projectile/plasma/Initialize()
	. = ..()
	if(!lavaland_equipment_pressure_check(get_turf(src)))
		name = "weakened [name]"
		dismemberment *= pressure_decrease
		damage *= pressure_decrease
		pressure_decrease_active = TRUE
