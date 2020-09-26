/obj/item/organ/intestines/cybernetic
	name = "cybernetic intestines"
	icon_state = "intestines-c"
	desc = "Even cyborgs deserve a throne."
	status = ORGAN_ROBOTIC

/obj/item/organ/intestines/cybernetic/emp_act(severity)
	applyOrganDamage(severity * 10)
