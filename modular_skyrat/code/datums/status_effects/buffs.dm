//argent
/datum/status_effect/blooddrunk/argent
	id = "argent"
	duration = 100
	tick_interval = 0
	alert_type = /obj/screen/alert/status_effect/argent

/obj/screen/alert/status_effect/argent
	name = "Argent Energized"
	desc = "Argent energy rushes through your body! You'll only take 10% damage for the duration of the energy rush!"
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "argent"

//stealth suit
/datum/status_effect/stealthsuit
	id = "stealthsuit"
	duration = -1
	tick_interval = 20
	alert_type = /obj/screen/alert/status_effect/stealthsuit
	var/obj/item/inhand
	var/obj/item/inhandl
	var/health
	var/healthold
	var/obj/item/inhandold
	var/obj/item/inhandlold
	var/turf/oldturf
	var/turf/currentturf
	var/stam
	var/stamold

/datum/status_effect/stealthsuit/on_remove()
	. = ..()
	owner.alpha = 255

/datum/status_effect/stealthsuit/tick()
	. = ..()
	currentturf = get_turf(owner)
	if(currentturf == oldturf) //ALMOST completely invisible
		owner.alpha = max(owner.alpha - 45, 10)
	oldturf = currentturf

/datum/status_effect/stealthsuit/process()
	..()
	inhand = owner.get_active_held_item()
	inhandl = owner.get_inactive_held_item()
	health = owner.health
	stam = owner.getStaminaLoss()
	if((inhand != inhandold) || (inhandl != inhandlold) || (health != healthold) || (stam > stamold))
		if(owner.alpha <= 127) //making it announce everytime you pick something up is annoying bro
			to_chat(owner, "<span class='warning'>Something interferes with your suit's stealth system, revealing you!</span>")
		playsound(owner.loc, "sparks", 100, 1)
		owner.alpha = 255
	inhandold = inhand
	inhandlold = inhandl
	healthold = health
	stamold = stam

/obj/screen/alert/status_effect/stealthsuit
	name = "Stealth Suit"
	desc = "You are one with the dark. You'll get more and more invisible over time, as long as you stay immobile. The invisibility effect is reset whenever you interact with something."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "stealth"

/obj/screen/alert/status_effect/regenerative_core
	name = "Regenerating Tendrils"
	desc = "The tendrils slowly heal your damaged carcass."
	icon_state = "regenerative_core"

/datum/status_effect/regenerative_core
	id = "Regenerative Core"
	duration = 10 SECONDS
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /obj/screen/alert/status_effect/regenerative_core
	var/nutrition = 50
	var/salve_amount = 30
	var/brute_heal = 20
	var/burn_heal = 20
	var/toxin_heal = 20
	var/firestacks_heal = 20
	var/brute_heal_proc = 4.5
	var/burn_heal_proc = 4.5
	var/toxin_heal_proc = 4.5

/datum/status_effect/regenerative_core/on_apply()
	. = ..()
	owner.adjust_nutrition(nutrition)
	owner.reagents?.add_reagent(/datum/reagent/medicine/mine_salve, salve_amount)
	owner.reagents?.reaction(owner, TOUCH)
	owner.adjustBruteLoss(-brute_heal)
	owner.adjustFireLoss(-burn_heal)
	owner.adjustToxLoss(toxin_heal)
	owner.adjust_fire_stacks(-firestacks_heal)
	return TRUE

/datum/status_effect/regenerative_core/process()
	. = ..()
	owner.adjustBruteLoss(-brute_heal_proc)
	owner.adjustFireLoss(-burn_heal_proc)
	owner.adjustToxLoss(-toxin_heal_proc)
