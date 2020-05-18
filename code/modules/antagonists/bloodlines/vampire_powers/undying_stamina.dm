/datum/action/vampire/stamina
	name = "Undying Stamina"
	desc = "Your heart pumps faster and your rushes, making you regenerate stamina. This will not drain blood if no stamina is regenerated."
	button_icon_state = "power_stamina"
	warn_constant_cost = TRUE
	amToggle = TRUE
	bloodcost = 0
	required_bloodlevel = 450
	cooldown = 0

/datum/action/vampire/stamina/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if (owner.stat >= DEAD)
		return FALSE
	return TRUE

/datum/action/vampire/stamina/ActivatePower()
	to_chat(owner, "<span class='notice'>You feel your heart beat faster and your blood rush.</span>")
	var/mob/living/carbon/C = owner
	while(ContinueActive(owner))
		if(C.getStaminaLoss())
			var/effectiveness = 1
			if(C.getStaminaLoss() > 100)
				effectiveness = 2
				C.Jitter(5)
			C.blood_volume -= 0.6 * effectiveness
			C.adjustStaminaLoss(-3 * effectiveness)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/vampire/stamina/ContinueActive(mob/living/user, mob/living/target)
	return ..() && user.stat <= DEAD && user.blood_volume > required_bloodlevel