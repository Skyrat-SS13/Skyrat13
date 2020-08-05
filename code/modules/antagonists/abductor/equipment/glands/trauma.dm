/obj/item/organ/heart/gland/trauma
	true_name = "white matter randomiser"
	cooldown_low = 800
	cooldown_high = 1200
	uses = 5
	icon_state = "emp"
	mind_control_uses = 3
	mind_control_duration = 1800

/obj/item/organ/heart/gland/trauma/activate()	//Skyrats change start
	to_chat(owner, "<span class='warning'>You feel a spike of pain in your head.</span>")
	if(prob(50))
		owner.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, rand(TRAUMA_RESILIENCE_BASIC, TRAUMA_RESILIENCE_SURGERY))
	else
		owner.gain_trauma_type(BRAIN_TRAUMA_MILD, (TRAUMA_RESILIENCE_BASIC)) //skyrats change end
