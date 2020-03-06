/datum/status_effect/radioactive
	id = "radioactive"
	duration = 20
	alert_type = /obj/screen/alert/status_effect/blooddrunk/radioactive
	var/last_health = 0
	var/last_bruteloss = 0
	var/last_fireloss = 0
	var/last_toxloss = 0
	var/last_oxyloss = 0
	var/last_cloneloss = 0
	var/last_staminaloss = 0
	tick_interval = 0

/obj/screen/alert/status_effect/blooddrunk/radioactive
	name = "Radioactive"
	desc = "You radiate energy! Your pulse thunders in your ears! Nothing can harm you!" //not true, and the item description mentions its actual effect

/datum/status_effect/radioactive/on_apply()
	. = ..()
	if(.)
		owner.maxHealth *= 20
		owner.bruteloss *= 20
		owner.fireloss *= 20
		if(iscarbon(owner))
			var/mob/living/carbon/C = owner
			for(var/X in C.bodyparts)
				var/obj/item/bodypart/BP = X
				BP.max_damage *= 20
				BP.brute_dam *= 20
				BP.burn_dam *= 20
		owner.toxloss *= 20
		owner.oxyloss *= 20
		owner.cloneloss *= 20
		owner.staminaloss += -10 // CIT CHANGE - makes blooddrunk status effect not exhaust you
		owner.updatehealth()
		last_health = owner.health
		last_bruteloss = owner.getBruteLoss()
		last_fireloss = owner.getFireLoss()
		last_toxloss = owner.getToxLoss()
		last_oxyloss = owner.getOxyLoss()
		last_cloneloss = owner.getCloneLoss()
		last_staminaloss = owner.getStaminaLoss()
		owner.log_message("gained radioactive stun immunity", LOG_ATTACK)
		owner.add_stun_absorption("radioactive", INFINITY, 4)
		ADD_TRAIT(owner, TRAIT_RADIMMUNE, "radioactive")
		owner.playsound_local(get_turf(owner), 'sound/effects/singlebeat.ogg', 40, 1)

/datum/status_effect/radioactive/tick() //multiply the effect of healing by 20
	if(owner.health > last_health)
		var/needs_health_update = FALSE
		var/new_bruteloss = owner.getBruteLoss()
		if(new_bruteloss < last_bruteloss)
			var/heal_amount = (new_bruteloss - last_bruteloss) * 20
			owner.adjustBruteLoss(heal_amount, updating_health = FALSE)
			new_bruteloss = owner.getBruteLoss()
			needs_health_update = TRUE
		last_bruteloss = new_bruteloss

		var/new_fireloss = owner.getFireLoss()
		if(new_fireloss < last_fireloss)
			var/heal_amount = (new_fireloss - last_fireloss) * 20
			owner.adjustFireLoss(heal_amount, updating_health = FALSE)
			new_fireloss = owner.getFireLoss()
			needs_health_update = TRUE
		last_fireloss = new_fireloss

		var/new_toxloss = owner.getToxLoss()
		if(new_toxloss < last_toxloss)
			var/heal_amount = (new_toxloss - last_toxloss) * 20
			owner.adjustToxLoss(heal_amount, updating_health = FALSE)
			new_toxloss = owner.getToxLoss()
			needs_health_update = TRUE
		last_toxloss = new_toxloss

		var/new_oxyloss = owner.getOxyLoss()
		if(new_oxyloss < last_oxyloss)
			var/heal_amount = (new_oxyloss - last_oxyloss) * 20
			owner.adjustOxyLoss(heal_amount, updating_health = FALSE)
			new_oxyloss = owner.getOxyLoss()
			needs_health_update = TRUE
		last_oxyloss = new_oxyloss

		var/new_cloneloss = owner.getCloneLoss()
		if(new_cloneloss < last_cloneloss)
			var/heal_amount = (new_cloneloss - last_cloneloss) * 20
			owner.adjustCloneLoss(heal_amount, updating_health = FALSE)
			new_cloneloss = owner.getCloneLoss()
			needs_health_update = TRUE
		last_cloneloss = new_cloneloss

		var/new_staminaloss = owner.getStaminaLoss()
		if(new_staminaloss < last_staminaloss)
			var/heal_amount = -5 // CIT CHANGE - makes blood drunk status effect not exhaust you
			owner.adjustStaminaLoss(heal_amount, FALSE)
			new_staminaloss = owner.getStaminaLoss()
			needs_health_update = TRUE
		last_staminaloss = new_staminaloss

		if(needs_health_update)
			owner.updatehealth()
			owner.playsound_local(get_turf(owner), 'sound/effects/singlebeat.ogg', 40, 1)
	last_health = owner.health

/datum/status_effect/radioactive/on_remove()
	tick()
	owner.maxHealth *= 0.05
	owner.bruteloss *= 0.05
	owner.fireloss *= 0.05
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		for(var/X in C.bodyparts)
			var/obj/item/bodypart/BP = X
			BP.brute_dam *= 0.05
			BP.burn_dam *= 0.05
			BP.max_damage /= 20
	owner.toxloss *= 0.05
	owner.oxyloss *= 0.05
	owner.cloneloss *= 0.05
	owner.staminaloss *= 0.05
	owner.updatehealth()
	REMOVE_TRAIT(owner, TRAIT_RADIMMUNE, "radioactive")
	owner.log_message("lost radioactive stun immunity", LOG_ATTACK)
	if(islist(owner.stun_absorption) && owner.stun_absorption["radioactive"])
		owner.stun_absorption -= "radioactive"