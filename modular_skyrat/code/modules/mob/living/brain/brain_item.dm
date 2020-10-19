/obj/item/organ/brain
	damage_reduction = 0
	damage_modifier = 0
	damage_reduction = 0
	low_threshold = 50
	high_threshold = 150
	healing_factor = 0 //We use our own system to heal up
	
	var/brain_can_heal = TRUE
	var/damage_threshold_count = 10
	var/damage_threshold_value = 0
	var/healed_threshold = 1
	var/oxygen_reserve = 5
	var/last_wobble = 0
	var/wobble_duration = 1070
	relative_size = 70 //Cum is stored in the brain, and i have a headache
	pain_multiplier = 0 //We don't count towards bodypart pain

/obj/item/organ/brain/Destroy()
	. = ..()
	if(brainmob)
		brainmob.ghostize(voluntary = FALSE)

/obj/item/organ/brain/Initialize()
	. = ..()
	damage_threshold_value = round(maxHealth / damage_threshold_count)

/obj/item/organ/brain/proc/get_current_damage_threshold()
	return round(damage / damage_threshold_value)

/obj/item/organ/brain/proc/past_damage_threshold(threshold)
	return (get_current_damage_threshold() > threshold)

/obj/item/organ/brain/proc/handle_sudden_death(mob/living/carbon/victim, damage_suffered)
	//Roll endurance to see if we die suddenly
	var/sleep_duration = 3 SECONDS
	if(victim.mind)
		victim.Unconscious(sleep_duration * 5)
		victim.death_rattle()
		sleep(sleep_duration)
		victim.death_rattle()
		sleep(sleep_duration)
		victim.death_rattle()
		sleep(sleep_duration)
		var/roll = victim.mind.diceroll(STAT_DATUM(end), mod = -damage_suffered)
		if(roll >= DICE_SUCCESS)
			victim.death_rattle()
			sleep(sleep_duration)
			to_chat(victim, "<span class='userdanger'>You narrowly avoid death's grasp!</span>")
			if(roll >= DICE_CRIT_SUCCESS)
				victim.Unconscious(-sleep_duration * 2)
		else
			victim.death_rattle()
			sleep(sleep_duration)
			to_chat(victim, "<span class='userdanger'>You suddenly lose your grasp on life.</span>")
			victim.death()
	//Mindless mobs always receive a sudden death
	else
		victim.Unconscious(sleep_duration * 5)
		victim.death_rattle()
		sleep(sleep_duration)
		victim.death_rattle()
		sleep(sleep_duration)
		victim.death_rattle()
		sleep(sleep_duration)
		victim.death_rattle()
		sleep(sleep_duration)
		to_chat(victim, "<span class='userdanger'>You suddenly lose your grasp on life.</span>")
		victim.death()

/obj/item/organ/brain/proc/handle_sagging(mob/living/carbon/victim, damage_suffered)
	if(!victim)
		return
	//Always clear the chat. Sorry chief.
	if(victim.client?.chatOutput)
		victim.client.chatOutput.loaded = FALSE
		victim.client.chatOutput.start()
		victim.client.chatOutput.load()
	//If we have a mind, we do an endurance roll to determine if we go unconscious
	//otherwise assume that the mob is awful at everything
	if(victim.mind)
		switch(victim.mind.diceroll(STAT_DATUM(end), mod = -round(damage_suffered)))
			//We succeeded perfectly - Immobilized, but no dropping items
			if(DICE_CRIT_SUCCESS)
				victim.Immobilize(200)
			//We succeeded - Just get stunned
			if(DICE_SUCCESS)
				victim.Stun(400)
			//We failed - Unconsciousness
			if(DICE_FAILURE)
				victim.Unconscious(600)
			//We failed miserably - Gain a brain trauma along with unconsciousness
			if(DICE_CRIT_FAILURE)
				victim.Unconscious(600)
				victim.gain_trauma_type(pick(BRAIN_TRAUMA_SEVERE, BRAIN_TRAUMA_MILD))
	else
		victim.Unconscious(600)
	//Inform the victim
	var/message = pick("... WHAT HAPPENED? ...", "... WHERE AM I? ...", "... WHO AM I? ...")
	to_chat(victim, "<span class='deadsay'><span class='bigbold'>[message]</span></span>")

/obj/item/organ/brain/onDamage(d, maximum)
	. = ..()
	if(owner)
		//Do the wobble sound
		if((damage >= high_threshold) && (world.time >= last_wobble) && owner)
			last_wobble = world.time
			owner.playsound_local(get_turf(owner), 'modular_skyrat/sound/effects/ear_ring.ogg', 75, 0, channel = CHANNEL_EAR_RING)
		//Or stop it, if we got healed
		else if(damage <= high_threshold)
			owner.stop_sound_channel(CHANNEL_EAR_RING)
		//We received an amount of damage larger than 10, let's do something fun
		if(d > 10)
			// Choose between sudden death and sagging
			if(prob(50))
				spawn(0)
					handle_sudden_death(owner, d)
			else
				spawn(0)
					handle_sagging(owner, d)

/obj/item/organ/brain/on_life()
	. = ..()
	// Brain damage from low oxygenation or lack of blood.
	if(owner.needs_heart())
		// No heart? You are going to have a very bad time. Not 100% lethal because heart transplants should be a thing.
		var/blood_volume = owner.get_blood_oxygenation()
		if(blood_volume < BLOOD_VOLUME_SURVIVE)
			if(!owner.chem_effects[CE_STABLE] || prob(60))
				oxygen_reserve = max(0, oxygen_reserve-1)
		else
			oxygen_reserve = min(initial(oxygen_reserve), oxygen_reserve+1)
		if(!oxygen_reserve) //(hardcrit)
			owner.Stun(500)
		var/can_heal = damage && brain_can_heal && (damage < maxHealth) && (damage % damage_threshold_value || owner.chem_effects[CE_BRAIN_REGEN] || (!past_damage_threshold(3) && owner.chem_effects[CE_STABLE]))
		var/damprob = 0
		//Effects of bloodloss
		switch(blood_volume)
			if(BLOOD_VOLUME_SAFE to INFINITY)
				if(can_heal)
					damage = max(damage-1, 0)
			if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
				damprob = owner.chem_effects[CE_STABLE] ? 5 : 50
				if(!past_damage_threshold(2) && prob(damprob))
					applyOrganDamage(DAMAGE_LOW_OXYGENATION)
			if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
				owner.eye_blurry = max(owner.eye_blurry,6)
				damprob = owner.chem_effects[CE_STABLE] ? 10 : 75
				if(!past_damage_threshold(4) && prob(damprob))
					applyOrganDamage(DAMAGE_LOW_OXYGENATION)
				if(!owner.IsParalyzed() && prob(10))
					owner.Paralyze(rand(400,800))
					to_chat(owner, "<span class='warning'>You feel extremely [pick("dizzy","woozy","faint")]...</span>")
			if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
				owner.eye_blurry = max(owner.eye_blurry,6)
				damprob = owner.chem_effects[CE_STABLE] ? 15 : 100
				if(!past_damage_threshold(6) && prob(damprob))
					applyOrganDamage(DAMAGE_LOWER_OXYGENATION)
				if(!owner.IsParalyzed() && prob(15))
					owner.Paralyze(800)
					to_chat(owner, "<span class='warning'>You feel extremely [pick("dizzy","woozy","faint")]...</span>")
			// Also see heart.dm, being below this point puts you into cardiac arrest no matter what
			if(-(INFINITY) to BLOOD_VOLUME_SURVIVE)
				owner.eye_blurry = max(owner.eye_blurry,6)
				damprob = owner.chem_effects[CE_STABLE] ? 20 : 100
				if(prob(damprob))
					applyOrganDamage(DAMAGE_VERY_LOW_OXYGENATION)

/obj/item/organ/brain/ipc_positron
	name = "positronic brain carcass"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the chest of synthetic crewmembers."
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"

/obj/item/organ/brain/ipc_positron/Insert(mob/living/carbon/C, special = 0, drop_if_replaced = TRUE)
	..()
	owner = C
	C.internal_organs |= src
	C.internal_organs_slot[slot] = src
	loc = null

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(H.dna && H.dna.species && (REVIVESBYHEALING in H.dna.species.species_traits))
			if(H.health > H.dna.species.revivesbyhealreq && !H.hellbound)
				H.revive(0)

/obj/item/organ/brain/ipc_positron/emp_act(severity)
	switch(severity)
		if(1)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 75, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain heavily damaged.</span>")
		if(2)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain damaged.</span>")
