/datum/action/vampire/earthshock
	name = "Earthshock"
	desc = "Violently slam your fists down to the ground, damaging and knocking nearby enemies down."
	button_icon_state = "power_earthshock"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	must_be_capacitated = TRUE

/datum/action/vampire/earthshock/ActivatePower()
	var/mob/living/carbon/user = owner
	user.visible_message("<span class='warning'>[user] violently slams [user.p_their()] fist into the floor, leaving it quaking!</span>", \
						 "<span class='notice'>You slam your fists into the floor, leaving it quaking.</span>")
	playsound(src, 'sound/effects/meteorimpact.ogg', 40, 1)
	var/list/affected = viewers(2, user)
	for(var/mob/living/l in affected)
		if(l != user)
			l.DefaultCombatKnockdown(200)
			l.adjustBruteLoss(15)
		shake_camera(l, 3, 1)
	user.log_message("used Earthshock, knocking [LAZYLEN(affected)] people down", LOG_ATTACK)

/datum/action/vampire/fists
	name = "Fists of Caine"
	desc = "Indulge yourself into a combatative trance, dodging projectiles and resisting the hardest blows, all while delivering devastating punches to the enemies. You'll also gain a couple new moves for the duration."
	button_icon_state = "power_earthshock"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	must_be_capacitated = TRUE

/datum/action/vampire/fists/ActivatePower()
	var/mob/living/carbon/user = owner
	user.apply_status_effect(STATUS_EFFECT_FISTS_OF_CAINE)

/datum/action/vampire/overwhelming_power
	name = "Overwhelming Power"
	desc = "Burst of power surges through you and breaks all restraints, including handcuffs legcuffs and straight jackets!"
	button_icon_state = "power_earthshock"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1
	purchasable = TRUE

/datum/action/vampire/overwhelming_power/CheckCanUse(display_error)
	. = ..()
	var/mob/living/carbon/user = owner
	if(!user.handcuffed || user.legcuffed)
		return FALSE

/datum/action/vampire/overwhelming_power/ActivatePower()
	var/mob/living/carbon/user = owner
	if(user.handcuffed)
		var/obj/O = user.handcuffed
		user.visible_message("<span class='warning'>[user] tenses up and breaks the [O.name] with sheer force!</span>", \
						 "<span class='notice'>You tense up and break [O.name] with sheer force.</span>")
		user.dropItemToGround(O)
	if(user.legcuffed)
		var/obj/O = user.legcuffed
		user.visible_message("<span class='warning'>[user] tenses up and breaks the [O.name] with sheer force!</span>", \
						 "<span class='notice'>You tense up and break [O.name] with sheer force.</span>")
		user.dropItemToGround(O)
	user.log_message("has freed themselves from restraints", LOG_ATTACK)

/datum/action/vampire/predatory_leap
	name = "Predatory Leap"
	desc = "Indulge yourself into a combatative trance, dodging projectiles and resisting the hardest blows, all while delivering devastating punches to the enemies. You'll also gain a couple new moves for the duration."
	button_icon_state = "power_earthshock"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	must_be_capacitated = TRUE

/datum/action/vampire/predatory_leap/ActivatePower()
	var/mob/living/carbon/user = owner