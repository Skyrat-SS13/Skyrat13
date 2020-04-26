//Less dismember on high pressures
/obj/item/projectile/plasma/Initialize()
	. = ..()
	if(!lavaland_equipment_pressure_check(get_turf(src)))
		name = "weakened [name]"
		dismemberment *= pressure_decrease
		damage *= pressure_decrease
		pressure_decrease_active = TRUE
