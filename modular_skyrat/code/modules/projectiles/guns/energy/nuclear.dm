/obj/item/gun/energy/e_gun/blueshield
	name = "energy revolver"
	desc = "An advanced energy revolver with the capacity to shoot both electrodes and lasers."
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/blueshield, /obj/item/ammo_casing/energy/laser)
	ammo_x_offset = 1
	charge_sections = 4
	fire_delay = 4
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	icon_state = "bsgun"
	item_state = "minidisable"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	obj_flags = UNIQUE_RENAME
	cell_type = /obj/item/stock_parts/cell/blueshield
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/e_gun/blueshield/pdw9
	name = "PDW-9 taser pistol"
	desc = "A military grade energy sidearm, used by many militia forces throughout the local sector. It comes with an internally recharging battery which is slow to recharge."
	ammo_x_offset = 2
	icon_state = "pdw9pistol"
	item_state = null
	cell_type = /obj/item/stock_parts/cell/pdw9

/obj/item/stock_parts/cell/blueshield
	name = "internal revolver power cell"
	maxcharge = 1500
	chargerate = 300

/obj/item/stock_parts/cell/pdw9
	name = "internal pistol power cell"
	maxcharge = 1000
	chargerate = 300
	self_recharge = TRUE
	var/obj/item/gun/energy/e_gun/blueshield/pdw9/parent

/obj/item/stock_parts/cell/pdw9/Initialize()
	. = ..()
	parent = loc

/obj/item/stock_parts/cell/pdw9/process()
	. = ..()
	parent.update_icon()
