/obj/item/organ/kidneys/cybernetic
	name = "cybernetic kidneys"
	icon_state = "kidneys-c"
	desc = "Urine trouble."
	status = ORGAN_ROBOTIC

/obj/item/organ/kidneys/emp_act(severity)
	applyOrganDamage(severity * 10)
