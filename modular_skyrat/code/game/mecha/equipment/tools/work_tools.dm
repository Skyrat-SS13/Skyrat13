//Hydraulic clamps
//clamp change so clarke dont get the clam p
/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/can_attach(obj/mecha/working/ripley/M as obj)
	if(..())
		if(istype(M) && !istype(M, /obj/mecha/working/ripley/clarke))
			return 1
	return 0

//the buzz's hydraulic clamp
/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/buzz
	name = "titanium alloy hydraulic clamp"
	desc = "Equipment for Buzz type exosuits. Lifts objects and loads them into cargo."
	icon = 'modular_skyrat/icons/mecha/mecha_equipment.dmi'
	icon_state = "buzzclamp"
	equip_cooldown = 10 //slightly speedier
	energy_drain = 6.5 //more energy efficient
	dam_force = 20 //same damage
	harmful = TRUE
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 0.6 //slightly speedier x2
