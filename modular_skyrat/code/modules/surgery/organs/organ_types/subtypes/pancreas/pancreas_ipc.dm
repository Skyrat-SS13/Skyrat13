/obj/item/organ/pancreas/robot_ipc
	name = "regulator"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "regulator-ipc"
	desc = "Synthetic \"insulin\" injections."
	status = ORGAN_ROBOTIC

/obj/item/organ/pancreas/robot_ipc/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			damage+=100
		if(2)
			damage+=50
