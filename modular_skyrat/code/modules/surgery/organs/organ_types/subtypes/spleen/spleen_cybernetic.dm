/obj/item/organ/spleen/cybernetic
	name = "cybernetic spleen"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "spleen-c"
	desc = "Needs no exspleenation."
	status = ORGAN_ROBOTIC

/obj/item/organ/spleen/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			damage+=100
		if(2)
			damage+=50
