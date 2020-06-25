//Overrides the surgery step to require anasthetics for a smooth surgery
/datum/surgery_step/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	surgery.step_in_progress = TRUE
	var/speed_mod = 1
	var/advance = FALSE
	if(preop(user, target, target_zone, tool, surgery) == -1)
		surgery.step_in_progress = FALSE
		return FALSE
	if(tool)
		speed_mod = tool.toolspeed
			
	if(do_after(user, time * speed_mod, target = target))
		var/prob_chance = 100
		if(implement_type)	//this means it isn't a require hand or any item step.
			prob_chance = implements[implement_type]
		prob_chance *= surgery.get_propability_multiplier()

		if(ishuman(target) && target.stat == CONSCIOUS && target.mob_biotypes & MOB_ORGANIC && !target.IsUnconscious() && !target.InCritical() && !target.IsSleeping() && !HAS_TRAIT(target, TRAIT_PAINKILLER))
			prob_chance *= 0.4
			to_chat(user, "<span class='notice'>You feel like anesthetics could make this much easier.</span>")
			target.visible_message("<span class='warning'>[target] [pick("writhes in pain", "squirms and kicks in agony", "cries in pain as [target.p_their()] body violently jerks")], impeding the surgery!</span>", \
			"<span class='warning'>You[pick(" writhe as agonizing pain surges throught your entire body", " feel burning pain sending your body into a convulsion", "r body squirms as sickening pain fills every part of it")]!</span>")
			target.emote("scream")
			target.blood_volume -= 5
			target.apply_damage(rand(3,6), damagetype = BRUTE, def_zone = target_zone, blocked = FALSE, forced = FALSE)

		if((prob(prob_chance) || (iscyborg(user) && !silicons_obey_prob)) && chem_check(target) && !try_to_fail)
			if(success(user, target, target_zone, tool, surgery))
				advance = TRUE
		else
			if(failure(user, target, target_zone, tool, surgery))
				advance = TRUE
		if(advance && !repeatable)
			surgery.status++
			if(surgery.status > surgery.steps.len)
				surgery.complete()
	surgery.step_in_progress = FALSE
	return advance
