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
	relative_size = 70 //Cum is stored in the brain, and i have a headache
	pain_multiplier = 0 //We don't count towards bodypart pain

/obj/item/organ/brain/Initialize()
	. = ..()
	damage_threshold_value = round(maxHealth / damage_threshold_count)

/obj/item/organ/brain/proc/get_current_damage_threshold()
	return round(damage / damage_threshold_value)

/obj/item/organ/brain/proc/past_damage_threshold(threshold)
	return (get_current_damage_threshold() > threshold)

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
					applyOrganDamage(DAMAGE_LOW_OXYGENATION)
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
