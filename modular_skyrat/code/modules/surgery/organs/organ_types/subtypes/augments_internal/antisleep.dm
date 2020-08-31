/obj/item/organ/cyberimp/brain/anti_sleep
	name = "CNS Jumpstarter"
	desc = "This implant will automatically attempt to jolt you awake when it detects you have fallen unconscious outside of REM sleeping cycles. Has a short cooldown. Conflicts with the CNS Rebooter, making them incompatible with eachother."
	implant_color = "#0356fc"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN //One or the other, not both.
	var/cooldown = FALSE

/obj/item/organ/cyberimp/brain/anti_sleep/on_life(mob/living/carbon/human/H)
	H = owner
	if(H.stat == UNCONSCIOUS && cooldown==FALSE)
		H.AdjustUnconscious(-100, FALSE)
		H.AdjustSleeping(-100, FALSE)
		to_chat(owner, "<span class='notice'>You feel a rush of energy course through your body!")
		cooldown = TRUE
		addtimer(CALLBACK(src, .proc/sleepytimerend), 50)
	else
		return

/obj/item/organ/cyberimp/brain/anti_sleep/proc/sleepytimerend()
	cooldown = FALSE
	to_chat(owner, "<span class='notice'>You hear a small beep in your head as your CNS Jumpstarter finishes recharging.")

/obj/item/organ/cyberimp/brain/anti_sleep/emp_act(severity, mob/living/carbon/human/H)
	. = ..()
	H = owner
	if(crit_fail || (organ_flags & ORGAN_FAILING) || . & EMP_PROTECT_SELF)
		return
	crit_fail = TRUE
	organ_flags |= ORGAN_FAILING
	H.AdjustUnconscious(200)
	cooldown = TRUE
	addtimer(CALLBACK(src, .proc/reboot), 90 / severity)

/obj/item/organ/cyberimp/brain/anti_sleep/proc/reboot()
	crit_fail = FALSE
	organ_flags &= ~ORGAN_FAILING
	cooldown = FALSE