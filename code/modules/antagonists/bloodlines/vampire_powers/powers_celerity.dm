/datum/action/vampire/accelerate
	name = "Accelerate"
	desc = "You fill your body with adrenaline, allowing you to run faster and shrug off any fatigue for a short period of time."
	button_icon_state = "power_speed"

	required_discipline = /datum/discipline/celerity
	bloodcost = 50
	powercost = 20
	cooldown = 100 		
	amToggle = FALSE
	level_max = 3

	purchasable = TRUE 
	can_be_immobilized = TRUE

/datum/action/vampire/accelerate/ActivatePower()
	var/mob/living/carbon/user = owner
	user.reagents.add_reagent(/datum/reagent/medicine/stimulants, 2)
	user.playsound_local(get_turf(user), 'sound/effects/singlebeat.ogg', 40, 1)