/obj/item/organ/heart/robot_ipc
	name = "hydraulic engine"
	desc = "An engine used to get mechanical energy out from the energy of fluids. Nessecary for a functional IPC. It resembles a heart"
	icon_state = "heart-c"
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/heart/robot_ipc/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.adjustStaminaLoss(50)
		if(2)
			owner.adjustStaminaLoss(25)
