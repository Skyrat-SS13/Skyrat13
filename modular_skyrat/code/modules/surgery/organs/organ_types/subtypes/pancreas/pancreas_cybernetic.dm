/obj/item/organ/pancreas/cybernetic
	name = "cybernetic pancreas"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "pancreas-c"
	desc = "Synthetic insulin injections."
	status = ORGAN_ROBOTIC

/obj/item/organ/pancreas/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			damage+=100
		if(2)
			damage+=50
