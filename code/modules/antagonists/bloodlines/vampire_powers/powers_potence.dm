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

/datum/action/vampire/fists
	name = "Fists of Caine"
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

/datum/action/vampire/fists/ActivatePower()
	var/mob/living/carbon/user = owner

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

/datum/action/vampire/overwhelming_power/ActivatePower()
	var/mob/living/carbon/user = owner