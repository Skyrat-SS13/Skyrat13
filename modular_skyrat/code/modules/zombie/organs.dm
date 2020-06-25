/obj/item/organ/zombie_infection
	desc = "A black web of pus and viscera, filled with curious swirling dots."

/obj/item/organ/zombie_infection/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	else
		owner.adjustFireLoss(40 * severity)
