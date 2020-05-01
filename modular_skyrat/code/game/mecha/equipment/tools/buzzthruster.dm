//the buzz's thruster (serves no actual purpose codewise - it actually just "enables" an action that mechas have by default.)
/obj/item/mecha_parts/mecha_equipment/buzzthrusters
	name = "buzz type exosuit thrusters"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_punching_glove" //actual icon soon(tm)
	force = 0
	max_integrity = 300
	selectable = 0
	harmful = FALSE

/obj/item/mecha_parts/mecha_equipment/buzzthrusters/buzz/can_attach(obj/mecha/M)
	if(!istype(M, /obj/mecha/working/ripley/buzz)) //sorry, buzz only equipment sweatie
		return FALSE
	if(M.equipment.len<M.max_equip)
		return TRUE
	return FALSE
