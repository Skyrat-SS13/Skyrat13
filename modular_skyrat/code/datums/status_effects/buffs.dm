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

/datum/status_effect/fists_of_caine
	id = "fists_of_caine"
	alert_type = /obj/screen/alert/status_effect/fists_of_caine
	duration = 600
	tick_interval = 0
	var/datum/martial_art/MA

/datum/status_effect/fists_of_caine/on_apply()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod *= 0.8
		H.physiology.stamina_mod *= 0.5
		H.dna.species.punchdamagelow += 6
		H.dna.species.punchdamagehigh += 8
		if(!MA)
			MA = new /datum/martial_art/fists_of_caine
		MA.teach(H)


/datum/status_effect/fists_of_caine/on_remove()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.physiology.brute_mod *= 1.25
		H.physiology.stamina_mod *= 2
		H.dna.species.punchdamagelow -= 6
		H.dna.species.punchdamagehigh -= 8
		MA.remove(H)

/obj/screen/alert/status_effect/fists_of_caine
	name = "Fists of Caine"
	desc = "Ambidexterity and power surges through you."
	icon = 'modular_skyrat/icons/mob/actions/vampire.dmi'
	icon_state = "fists_status"