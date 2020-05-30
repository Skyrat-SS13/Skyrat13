/datum/action/vampire/accelerate
	name = "Accelerate"
	desc = "You fill your body with adrenaline, allowing you to run faster and shrug off any fatigue for a short period of time."
	button_icon_state = "power_speed"

	required_discipline = /datum/discipline/celerity
	bloodcost = 50
	powercost = 20
	cooldown = 100 		
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	can_be_immobilized = TRUE

/datum/action/vampire/accelerate/ActivatePower()
	var/mob/living/carbon/user = owner
	user.reagents.add_reagent(/datum/reagent/medicine/stimulants, 2)
	user.playsound_local(get_turf(user), 'sound/effects/singlebeat.ogg', 40, 1)

/datum/action/vampire/blink
	name = "Blink"
	desc = "Move so fast that you teleport a couple tiles forward."
	button_icon_state = "power_blink"

	required_discipline = /datum/discipline/celerity
	bloodcost = 20
	powercost = 0
	cooldown = 20	
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	must_be_capacitated = TRUE

/datum/action/vampire/blink/CheckCanUse(display_error)
	. = ..()
	var/mob/living/carbon/C = owner
	if (!CHECK_MOBILITY(C, MOBILITY_MOVE))
		if(display_error)
			to_chat(owner, "<span class='warning'>You must be standing to use Blink.</span>")
		return FALSE

/datum/action/vampire/blink/ActivatePower()
	var/mob/living/carbon/user = owner
	