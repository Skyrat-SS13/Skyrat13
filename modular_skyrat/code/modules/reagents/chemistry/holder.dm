/datum/reagents/metabolize(mob/living/carbon/C, can_overdose = FALSE, liverless = FALSE)
	var/list/cached_reagents = reagent_list
	var/list/cached_addictions = addiction_list
	if(C)
		expose_temperature(C.bodytemperature, 0.25)
	var/need_mob_update = 0
	for(var/reagent in cached_reagents)
		var/datum/reagent/R = reagent
		if(QDELETED(R.holder))
			continue
		if(liverless && !R.self_consuming) //need to be metabolized
			continue
		if(!C)
			C = R.holder.my_atom
		//Reagent process flags handling
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			//Check if this mob's species is set and can process this type of reagent
			var/can_process = FALSE
			//If we somehow avoided getting a species or reagent_flags set, we'll assume we aren't meant to process ANY reagents
			if(H.dna && H.dna.species.reagent_flags)
				if((R.process_flags & REAGENT_SYNTHETIC) && (H.dna.species.reagent_flags & PROCESS_SYNTHETIC))		//SYNTHETIC-oriented reagents require PROCESS_SYNTHETIC
					can_process = TRUE
				if((R.process_flags & REAGENT_ORGANIC) && (H.dna.species.reagent_flags & PROCESS_ORGANIC))		//ORGANIC-oriented reagents require PROCESS_ORGANIC
					can_process = TRUE

			//If the mob can't process it, remove the reagent at it's normal rate without doing any addictions, overdoses, or on_mob_life() for the reagent
			if(!can_process)
				R.holder.remove_reagent(R.type, R.metabolization_rate)
				continue
		//We'll assume that non-human mobs lack the ability to process synthetic-oriented reagents (adjust this if we need to change that assumption)
		else
			if(R.process_flags == REAGENT_SYNTHETIC)
				R.holder.remove_reagent(R.type, R.metabolization_rate)
				continue

		if(!R.metabolizing)
			R.metabolizing = TRUE
			R.on_mob_metabolize(C)
		if(C && R)
			if(C.reagent_check(R) != 1)
				if(can_overdose)
					if(R.overdose_threshold)
						if(R.volume > R.overdose_threshold && !R.overdosed)
							R.overdosed = 1
							need_mob_update += R.overdose_start(C)
					if(R.addiction_threshold)
						if(R.volume > R.addiction_threshold && !is_type_in_list(R, cached_addictions))
							var/datum/reagent/new_reagent = new R.type()
							cached_addictions.Add(new_reagent)
					if(R.overdosed)
						need_mob_update += R.overdose_process(C)
					if(is_type_in_list(R,cached_addictions))
						for(var/addiction in cached_addictions)
							var/datum/reagent/A = addiction
							if(istype(R, A))
								A.addiction_stage = -15 // you're satisfied for a good while.
				need_mob_update += R.on_mob_life(C)

	if(can_overdose)
		if(addiction_tick == 6)
			addiction_tick = 1
			for(var/addiction in cached_addictions)
				var/datum/reagent/R = addiction
				if(C && R)
					R.addiction_stage++
					switch(R.addiction_stage)
						if(1 to R.addiction_stage1_end)
							need_mob_update += R.addiction_act_stage1(C)
						if(R.addiction_stage1_end to R.addiction_stage2_end)
							need_mob_update += R.addiction_act_stage2(C)
						if(R.addiction_stage2_end to R.addiction_stage3_end)
							need_mob_update += R.addiction_act_stage3(C)
						if(R.addiction_stage3_end to R.addiction_stage4_end)
							need_mob_update += R.addiction_act_stage4(C)
						if(R.addiction_stage4_end to INFINITY)
							remove_addiction(R)
						else
							SEND_SIGNAL(C, COMSIG_CLEAR_MOOD_EVENT, "[R.type]_overdose")
		addiction_tick++
	if(C && need_mob_update) //some of the metabolized reagents had effects on the mob that requires some updates.
		C.updatehealth()
		C.update_mobility()
		C.update_stamina()
	update_total()
