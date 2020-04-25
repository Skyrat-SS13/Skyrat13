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
	var/oldloc
	var/turf/currentloc
	var/stam
	var/stamold

/datum/status_effect/stealthsuit/on_remove()
	. = ..()
	animate(owner, , alpha = 255, time = 10)

/datum/status_effect/stealthsuit/tick()
	. = ..()
	currentloc = get_turf(owner)
	if(owner.alpha >= 10 && currentloc == oldloc && (owner.alpha - 45 >= 10)) //ALMOST completely invisible
		animate(owner, owner.alpha -= 45, time = 5)
	else if((owner.alpha >= 10) && (owner.alpha - 45 < 10) && (currentloc == oldloc))
		animate(owner, owner.alpha = 10, time = 5)
	oldloc = currentloc

/datum/status_effect/stealthsuit/process()
	..()
	inhand = owner.get_active_held_item()
	inhandl = owner.get_inactive_held_item()
	health = owner.health
	stam = owner.getStaminaLoss()
	if((inhand != inhandold) || (inhandl != inhandlold) || (health != healthold) || (stam > stamold))
		if(owner.alpha <= 113) //making it announce everytime you pick something up is annoying bro
			to_chat(owner, "<span class='warning'>Something interferes with your suit's stealth system, revealing you!</span>")
		playsound(owner.loc, "sparks", 100, 1)
		animate(owner, alpha = 255, time = 2)
	inhandold = inhand
	inhandlold = inhandl
	healthold = health
	stamold = stam

/obj/screen/alert/status_effect/stealthsuit
	name = "Stealth Suit"
	desc = "You are one with the dark. You'll get more and more invisible over time, as long as you stay immobile. The invisibility effect is reset whenever you interact with something."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "stealth"
