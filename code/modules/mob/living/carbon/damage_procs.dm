/mob/living/carbon/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE) //skyrat edit
	SEND_SIGNAL(src, COMSIG_MOB_APPLY_DAMGE, damage, damagetype, def_zone)
	var/hit_percent = (100-blocked)/100
	if(!forced && hit_percent <= 0)
		return 0

	var/obj/item/bodypart/BP = null
	if(isbodypart(def_zone)) //we specified a bodypart object
		BP = def_zone
	else
		if(def_zone)
			def_zone = ran_zone(def_zone)
		BP = get_bodypart(check_zone(def_zone))

	var/damage_amount = forced ? damage : damage * hit_percent
	switch(damagetype)
		if(BRUTE)
			if(BP)
				if(damage > 0 ? BP.receive_damage(brute = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(brute = abs(damage_amount), only_robotic = FALSE, only_organic = FALSE))
					update_damage_overlays()
			else //no bodypart, we deal damage with a more general method.
				adjustBruteLoss(damage_amount, forced = forced)
		if(BURN)
			if(BP)
				if(damage > 0 ? BP.receive_damage(burn = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(burn = abs(damage_amount), only_robotic = FALSE, only_organic = FALSE))
					update_damage_overlays()
			else
				adjustFireLoss(damage_amount, forced = forced)
		if(PAIN)
			if(BP)
				if(damage > 0 ? BP.receive_damage(pain = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(pain = abs(damage_amount), only_robotic = FALSE, only_organic = FALSE))
					update_damage_overlays()
			else
				adjustPainLoss(damage_amount, forced = forced)
		if(TOX)
			if(BP)
				if(damage > 0 ? BP.receive_damage(toxin = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(toxin = abs(damage_amount), only_robotic = FALSE, only_organic = FALSE))
					update_damage_overlays()
			else
				adjustToxLoss(damage_amount, forced = forced)
		if(CLONE)
			if(BP)
				if(damage > 0 ? BP.receive_damage(clone = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(clone = abs(damage_amount), only_robotic = FALSE, only_organic = TRUE))
					update_damage_overlays()
			else
				adjustCloneLoss(damage_amount, forced = forced)
		if(STAMINA)
			if(BP)
				if(damage > 0 ? BP.receive_damage(stamina = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(stamina = abs(damage_amount), only_robotic = FALSE, only_organic = TRUE))
					update_damage_overlays()
			else
				adjustStaminaLoss(damage_amount, forced = forced)
		if(OXY)
			adjustOxyLoss(damage_amount, forced = forced)
	return TRUE

//These procs fetch a cumulative total damage from all bodyparts
/mob/living/carbon/getBruteLoss()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += BP.brute_dam

/mob/living/carbon/getFireLoss()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += BP.burn_dam

/mob/living/carbon/getStaminaLoss()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += round(BP.stamina_dam * BP.stam_damage_coeff, DAMAGE_PRECISION)

/mob/living/carbon/getPainLoss()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += BP.get_pain()

/mob/living/carbon/getToxLoss()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += BP.tox_dam

/mob/living/carbon/getCloneLoss()
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += BP.clone_dam

/mob/living/carbon/getOxyLoss()
	. = 0
	if(needs_lungs())
		var/obj/item/organ/lungs/lungs = getorganslot(ORGAN_SLOT_LUNGS)
		if(!lungs)
			return maxHealth/2
		return lungs.get_oxygen_deprivation()

/mob/living/carbon/adjustOxyLoss(amount, updating_health = TRUE, forced = FALSE)
	. = 0
	if(!needs_lungs())
		return
	var/obj/item/organ/lungs/breathe_organ = getorganslot(ORGAN_SLOT_LUNGS)
	if(breathe_organ)
		if(amount > 0)
			breathe_organ.add_oxygen_deprivation(abs(amount))
		else
			breathe_organ.remove_oxygen_deprivation(abs(amount))
	if(updating_health)
		updatehealth()
		update_health_hud()

/mob/living/carbon/setOxyLoss(amount, updating_health, forced)
	if(!needs_lungs() || (amount < 0))
		return
	var/obj/item/organ/lungs/breathe_organ = getorganslot(ORGAN_SLOT_LUNGS)
	if(breathe_organ)
		breathe_organ.oxygen_deprivation = 0
		breathe_organ.add_oxygen_deprivation(abs(amount))
	if(updating_health)
		updatehealth()
		update_health_hud()

/mob/living/carbon/adjustBruteLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && amount < 0 && HAS_TRAIT(src,TRAIT_NONATURALHEAL))
		return FALSE
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(amount > 0)
		take_overall_damage(brute = amount, updating_health = updating_health)
	else
		heal_overall_damage(brute = abs(amount), only_organic = TRUE, only_robotic = FALSE, updating_health = updating_health)
	return amount

/mob/living/carbon/adjustPainLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(amount > 0)
		take_overall_damage(pain = amount, updating_health = updating_health)
	else
		heal_overall_damage(pain = abs(amount), only_organic = TRUE, only_robotic = FALSE, updating_health = updating_health)
	return amount

/mob/living/carbon/adjustFireLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && amount < 0 && HAS_TRAIT(src,TRAIT_NONATURALHEAL))	//Vamps don't heal naturally.
		return FALSE
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(amount > 0)
		take_overall_damage(burn = amount, updating_health = updating_health)
	else
		heal_overall_damage(burn = abs(amount), only_organic = TRUE, only_robotic = FALSE, updating_health = updating_health)
	return amount

/mob/living/carbon/adjustStaminaLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(amount > 0)
		take_overall_damage(stamina = amount, updating_health = updating_health)
	else
		heal_overall_damage(stamina = abs(amount), only_organic = FALSE, only_robotic = FALSE, updating_health = updating_health)
	return amount

/mob/living/carbon/adjustToxLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(!forced && HAS_TRAIT(src, TRAIT_TOXINLOVER)) //damage becomes healing and healing becomes damage
		amount = -amount
		if(amount > 0)
			blood_volume -= 3 * amount		//5x was too much, this is punishing enough.
		else
			blood_volume -= amount
	if(amount > 0)
		take_overall_damage(toxin = amount, updating_health = updating_health)
	else
		heal_overall_damage(toxin = abs(amount), only_organic = FALSE, only_robotic = FALSE, updating_health = updating_health)
	return amount

/mob/living/carbon/adjustCloneLoss(amount, updating_health = TRUE, forced = FALSE)
	if(!forced && (status_flags & GODMODE))
		return FALSE
	if(amount > 0)
		take_overall_damage(clone = amount, updating_health = updating_health)
	else
		heal_overall_damage(clone = abs(amount), only_organic = FALSE, only_robotic = FALSE, updating_health = updating_health)
	return amount

/mob/living/carbon/setStaminaLoss(amount, updating = TRUE, forced = FALSE)
	var/current = getStaminaLoss()
	var/diff = amount - current
	if(!diff)
		return
	adjustStaminaLoss(diff, updating, forced)

/mob/living/carbon/setCloneLoss(amount, updating = TRUE, forced = FALSE)
	var/current = getCloneLoss()
	var/diff = amount - current
	if(!diff)
		return
	adjustCloneLoss(diff, updating, forced)

/mob/living/carbon/setToxLoss(amount, updating = TRUE, forced = FALSE)
	var/current = getToxLoss()
	var/diff = amount - current
	if(!diff)
		return
	adjustToxLoss(diff, updating, forced)

/mob/living/carbon/setPainLoss(amount, updating = TRUE, forced = FALSE)
	var/current = getPainLoss()
	var/diff = amount - current
	if(!diff)
		return
	adjustPainLoss(diff, updating, forced)

/** adjustOrganLoss
  * inputs: slot (organ slot, like ORGAN_SLOT_HEART), amount (damage to be done), and maximum (currently an arbitrarily large number, can be set so as to limit damage)
  * outputs:
  * description: If an organ exists in the slot requested, and we are capable of taking damage (we don't have GODMODE on), call the damage proc on that organ.
  */
/mob/living/carbon/adjustOrganLoss(slot, amount, maximum)
	var/obj/item/organ/O = getorganslot(slot)
	if(O && !(status_flags & GODMODE))
		if(!maximum)
			maximum = O.maxHealth
		O.applyOrganDamage(amount, maximum)
		O.onDamage(amount, maximum)

/** setOrganLoss
  * inputs: slot (organ slot, like ORGAN_SLOT_HEART), amount(damage to be set to)
  * outputs:
  * description: If an organ exists in the slot requested, and we are capable of taking damage (we don't have GODMODE on), call the set damage proc on that organ, which can
  *				 set or clear the failing variable on that organ, making it either cease or start functions again, unlike adjustOrganLoss.
  */
/mob/living/carbon/setOrganLoss(slot, amount)
	var/obj/item/organ/O = getorganslot(slot)
	if(O && !(status_flags & GODMODE))
		O.setOrganDamage(amount)
		O.onSetDamage(amount)

/** getOrganLoss
  * inputs: slot (organ slot, like ORGAN_SLOT_HEART)
  * outputs: organ damage
  * description: If an organ exists in the slot requested, return the amount of damage that organ has
  */
/mob/living/carbon/getOrganLoss(slot)
	var/obj/item/organ/O = getorganslot(slot)
	if(O)
		return O.damage

/mob/living/carbon/proc/adjustAllOrganLoss(amount, maximum)
	for(var/obj/item/organ/O in internal_organs)
		if(O && !(status_flags & GODMODE))
			continue
		if(!maximum)
			maximum = O.maxHealth
		O.applyOrganDamage(amount, maximum)
		O.onDamage(amount, maximum)

/mob/living/carbon/proc/getFailingOrgans()
	.=list()
	for(var/obj/item/organ/O in internal_organs)
		if(O.organ_flags & ORGAN_FAILING)
			.+=O

////////////////////////////////////////////

//Returns a list of damaged bodyparts
/mob/living/carbon/proc/get_damaged_bodyparts(brute = FALSE, burn = FALSE, stamina = FALSE, status, toxin = FALSE, pain = FALSE, clone = FALSE)
	var/list/obj/item/bodypart/parts = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(status && !(BP.status & status))
			continue
		if((brute && BP.brute_dam) || (burn && BP.burn_dam) || (stamina && BP.stamina_dam) || (toxin && BP.tox_dam) || (pain && BP.pain_dam) || (clone && BP.clone_dam))
			parts += BP
	return parts

//Returns a list of damageable bodyparts
/mob/living/carbon/proc/get_damageable_bodyparts()
	var/list/obj/item/bodypart/parts = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.brute_dam + BP.burn_dam < BP.max_damage)
			parts += BP
	return parts

//Heals ONE bodypart randomly selected from damaged ones.
//It automatically updates damage overlays if necessary
//It automatically updates health status
/mob/living/carbon/heal_bodypart_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE, only_robotic = FALSE, only_organic = TRUE, pain = 0, toxin = 0, clone = 0)
	var/list/obj/item/bodypart/parts = get_damaged_bodyparts(brute, burn, stamina, NONE, toxin, pain, clone)
	if(!parts.len)
		return
	var/obj/item/bodypart/picked = pick(parts)
	if(picked.heal_damage(brute = brute, burn = burn, stamina = stamina, pain = pain, toxin = toxin, clone = clone, only_robotic = only_robotic, only_organic = only_organic, updating_health = TRUE))
		update_damage_overlays()

//Damages ONE bodypart randomly selected from damagable ones.
//It automatically updates damage overlays if necessary
//It automatically updates health status
/mob/living/carbon/take_bodypart_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE, required_status, check_armor = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE, pain = 0, toxin = 0, clone = 0) //skyrat edit
	var/list/obj/item/bodypart/parts = get_damageable_bodyparts()
	if(!parts.len)
		return
	var/obj/item/bodypart/picked = pick(parts)
	if(picked.receive_damage(brute = brute, burn = burn, stamina = stamina, pain = pain, toxin = toxin, clone = clone, blocked = (check_armor ? run_armor_check(picked, (brute ? "melee" : "fire")) : FALSE), wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness))
		update_damage_overlays()

//Heal MANY bodyparts, in random order
/mob/living/carbon/heal_overall_damage(brute = 0, burn = 0, stamina = 0, only_robotic = FALSE, only_organic = TRUE, updating_health = TRUE, pain = 0, toxin = 0, clone = 0)
	var/list/obj/item/bodypart/parts = get_damaged_bodyparts(brute, burn, stamina, NONE, toxin, pain, clone)

	var/update = 0
	while(parts.len && (brute > 0 || burn > 0 || stamina > 0 || pain > 0 || toxin > 0 || clone > 0))
		var/obj/item/bodypart/picked = pick(parts)

		var/brute_was = picked.brute_dam
		var/burn_was = picked.burn_dam
		var/stamina_was = picked.stamina_dam
		var/tox_was = picked.tox_dam
		var/pain_was = picked.pain_dam
		var/clone_was = picked.clone_dam

		update |= picked.heal_damage(brute = brute, burn = burn, stamina = stamina, pain = pain, toxin = toxin, clone = clone, updating_health = FALSE, only_robotic = only_robotic, only_organic = only_organic)

		brute = round(brute - (brute_was - picked.brute_dam), DAMAGE_PRECISION)
		burn = round(burn - (burn_was - picked.burn_dam), DAMAGE_PRECISION)
		stamina = round(stamina - (stamina_was - picked.stamina_dam), DAMAGE_PRECISION)
		pain = round(pain - (pain_was - picked.pain_dam), DAMAGE_PRECISION)
		toxin = round(toxin - (tox_was - picked.tox_dam), DAMAGE_PRECISION)
		clone = round(clone - (clone_was - picked.clone_dam), DAMAGE_PRECISION)

		parts -= picked
	if(updating_health)
		updatehealth()
	if(update)
		update_damage_overlays()
	update_stamina() //CIT CHANGE - makes sure update_stamina() always gets called after a health update
	update_pain()

// damage MANY bodyparts, in random order
/mob/living/carbon/take_overall_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE, pain = 0, toxin = 0, clone = 0)
	if(status_flags & GODMODE)
		return	//godmode

	var/list/obj/item/bodypart/parts = get_damageable_bodyparts()
	var/update = 0
	while(parts.len && (brute > 0 || burn > 0 || stamina > 0 || pain > 0 || toxin > 0 || clone > 0))
		var/obj/item/bodypart/picked = pick(parts)
		var/brute_per_part = round(brute/parts.len, DAMAGE_PRECISION)
		var/burn_per_part = round(burn/parts.len, DAMAGE_PRECISION)
		var/stamina_per_part = round(stamina/parts.len, DAMAGE_PRECISION)
		var/pain_per_part = round(pain/parts.len, DAMAGE_PRECISION)
		var/tox_per_part = round(toxin/parts.len, DAMAGE_PRECISION)
		var/clone_per_part = round(clone/parts.len, DAMAGE_PRECISION)

		var/brute_was = picked.brute_dam
		var/burn_was = picked.burn_dam
		var/stamina_was = picked.stamina_dam
		var/tox_was = picked.tox_dam
		var/pain_was = picked.pain_dam
		var/clone_was = picked.clone_dam

		update |= picked.receive_damage(brute = brute_per_part, burn = burn_per_part, stamina = stamina_per_part, pain = pain_per_part, toxin = tox_per_part, clone = clone_per_part, blocked = FALSE, updating_health = FALSE)

		brute	= round(brute - (picked.brute_dam - brute_was), DAMAGE_PRECISION)
		burn	= round(burn - (picked.burn_dam - burn_was), DAMAGE_PRECISION)
		stamina = round(stamina - (picked.stamina_dam - stamina_was), DAMAGE_PRECISION)
		pain = round(pain - (picked.pain_dam - pain_was), DAMAGE_PRECISION)
		toxin = round(toxin - (picked.tox_dam - tox_was), DAMAGE_PRECISION)
		clone = round(clone - (picked.clone_dam - clone_was), DAMAGE_PRECISION)

		parts -= picked
	if(updating_health)
		updatehealth()
	if(update)
		update_damage_overlays()
	update_stamina()
	update_pain()

//skyrat edit
///Returns a list of bodyparts with wounds (in case someone has a wound on an otherwise fully healed limb)
/mob/living/carbon/proc/get_wounded_bodyparts(brute = FALSE, burn = FALSE, stamina = FALSE, status, pain = FALSE, toxin = FALSE, clone = FALSE)
	var/list/obj/item/bodypart/parts = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(LAZYLEN(BP.wounds))
			parts += BP
	return parts
