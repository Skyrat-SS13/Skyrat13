/*
/obj/effect/proc_holder/vampire/vitality
	panel = "Supernatural Vitality"
	name = "Enhance your body with regenerative properties, quickly regenerating brute, oxygen and some burn damage. This will drain blood over time, but only if it actually heals you. Fire halts the regeneration"
	desc = "" // Fluff
	var/helptext = "" // Details
	var/power_cost = 0 //Cost of power to use the ability
	var/blood_cost = 0 //Cost of blood to use the ability
	var/blood_req = 0 //Requirement in blood to use the ability, in percentages

/obj/effect/proc_holder/vampire/vitality/Trigger(mob/user)
*/

/datum/action/vampire/vitality
	name = "Supernatural Vitality"
	desc = "Enhance your body with regenerative properties, quickly regenerating brute damage aswell as some burn damage. Being set on fire halts the regeneration. This wont drain your blood if it's not healing you."
	button_icon_state = "power_vitality"
	warn_constant_cost = TRUE
	amToggle = TRUE
	bloodcost = 0
	required_bloodlevel = 450
	cooldown = 0

/datum/action/vampire/vitality/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if (owner.stat >= DEAD)
		return FALSE
	return TRUE

/datum/action/vampire/vitality/ActivatePower()
	to_chat(owner, "<span class='notice'>You feel your wounds mending.</span>")
	var/mob/living/carbon/C = owner
	var/mob/living/carbon/human/H
	if(ishuman(owner))
		H = owner
	while(ContinueActive(owner))
		if(!(C.fire_stacks) && (C.getFireLoss() || C.getBruteLoss() || C.getToxLoss()))
			var/effectiveness = 1
			if(C.health < 30)
				effectiveness = 2
			C.adjustBruteLoss(-1.5 * effectiveness)
			C.adjustFireLoss(-0.5 * effectiveness)
			C.adjustToxLoss(-0.5 * effectiveness, forced = TRUE)
			C.blood_volume -= 0.3 * effectiveness
			//C.adjustStaminaLoss(-15)
			// Stop Bleeding
			if(istype(H) && H.bleed_rate > 0 && rand(20) == 0)
				H.bleed_rate --
			//C.Jitter(5)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/vampire/vitality/ContinueActive(mob/living/user, mob/living/target)
	return ..() && user.stat <= DEAD && user.blood_volume > required_bloodlevel