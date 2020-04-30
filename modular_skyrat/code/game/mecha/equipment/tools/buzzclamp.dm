//the buzz's hydraulic clamp
/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/buzz
	name = "titanium alloy hydraulic clamp"
	desc = "Equipment for Buzz type exosuits. Lifts objects and loads them into cargo."
	icon_state = "mecha_clamp"
	equip_cooldown = 10 //slightly speedier
	energy_drain = 6.5 //more energy efficient
	dam_force = 20 //same damage
	harmful = TRUE
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 0.6 //slightly speedier x2

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/buzz/can_attach(obj/mecha/M)
	if(!istype(M, /obj/mecha/working/ripley/buzz)) //sorry, buzz only equipment sweatie
		return FALSE
	if(M.equipment.len<M.max_equip)
		return TRUE
	return FALSE
