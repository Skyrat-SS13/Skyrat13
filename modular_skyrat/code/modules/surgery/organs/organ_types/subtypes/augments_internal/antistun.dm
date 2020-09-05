#define STUN_SET_AMOUNT 40
/obj/item/organ/cyberimp/brain/anti_stun
	name = "CNS Rebooter implant"
	desc = "This implant will automatically give you back control over your central nervous system, reducing downtime when stunned."
	implant_color = "#FFFF00"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN

/obj/item/organ/cyberimp/brain/anti_stun/on_life()
	. = ..()
	if(!. || crit_fail)
		return
	owner.adjustStaminaLoss(-3.5, FALSE) //Citadel edit, makes it more useful in Stamina based combat
	owner.HealAllImmobilityUpTo(STUN_SET_AMOUNT)

/obj/item/organ/cyberimp/brain/anti_stun/emp_act(severity)
	. = ..()
	if(crit_fail || (organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	crit_fail = TRUE
	organ_flags |= ORGAN_FAILING
	addtimer(CALLBACK(src, .proc/reboot), 90 / severity)

/obj/item/organ/cyberimp/brain/anti_stun/proc/reboot()
	crit_fail = FALSE
	organ_flags &= ~ORGAN_FAILING
