/obj/item/gun/energy/e_gun/blueshield
	name = "energy revolver"
	desc = "An advanced energy revolver with the capacity to shoot both electrodes and lasers."
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/blueshield, /obj/item/ammo_casing/energy/laser)
	ammo_x_offset = 1
	shaded_charge = 1
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

/obj/item/gun/energy/gun/blueshield/pdw9
	name = "PDW-9 taser pistol"
	desc = "A military grade energy sidearm, used by many militia forces throughout the frontier."
	icon_state = "pdw9pistol"

/obj/item/stock_parts/cell/blueshield
	name = "internal revolver power cell"
	maxcharge = 1500
	chargerate = 300
