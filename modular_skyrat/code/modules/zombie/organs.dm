/obj/item/organ/zombie_infection
	desc = "A black web of pus and viscera, filled with curious swirling dots."
	icon = 'modular_skyrat/icons/obj/items/nanitetumor.dmi'
	icon_state = "nanitetumor"

/obj/item/organ/zombie_infection/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	else
		owner.adjustFireLoss(10 * severity)
		owner.DefaultCombatKnockdown(50 * severity)
