/obj/item/organ/heart/gland/trauma
	true_name = "white matter randomiser"
	cooldown_low = 800
	cooldown_high = 1200
	uses = 3	//skyrats change start						
	icon_state = "emp"
	mind_control_uses = 3
	mind_control_duration = 1800

/obj/item/organ/heart/gland/trauma/activate()
	to_chat(owner, "<span class='warning'>You feel a spike of pain in your head.</span>")
	if(prob(33))
		owner.gain_trauma_type(BRAIN_TRAUMA_SPECIAL)
	else
		owner.gain_trauma_type(BRAIN_TRAUMA_MILD)	//skyrats change end
