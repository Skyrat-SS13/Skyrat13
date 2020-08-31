//skyrat meme
/mob/living/carbon
	var/immunity 		= 100		//current immune system strength
	var/immunity_norm 	= 100		//it will regenerate to this value

/mob/living/carbon/proc/create_bodyparts()
	var/l_hand_index_next = -1
	var/r_hand_index_next = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/O = new X()
		O.owner = src
		bodyparts.Remove(X)
		bodyparts.Add(O)
		if(O.body_part == HAND_LEFT)
			l_hand_index_next += 2
			O.held_index = l_hand_index_next //1, 3, 5, 7...
			hand_bodyparts += O
		else if(O.body_part == HAND_RIGHT)
			r_hand_index_next += 2
			O.held_index = r_hand_index_next //2, 4, 6, 8...
			hand_bodyparts += O

/mob/living/carbon/handle_diseases()
	. = ..()
	if(immunity > 0.2 * immunity_norm && immunity < immunity_norm)
		immunity = min(immunity + 0.25, immunity_norm)

/mob/living/carbon/proc/virus_immunity()
	. = 0
	var/antibiotic_boost = reagents.get_reagent_amount(/datum/reagent/medicine/spaceacillin) / 20
	return max(immunity/100 * (1+antibiotic_boost), antibiotic_boost)

/mob/living/carbon/proc/immunity_weakness()
	return max(2-virus_immunity(), 0)

/mob/living/carbon/proc/get_antibiotics()
	. = 0
	. += chem_effects[CE_ANTIBIOTIC]

/mob/living/carbon/succumb()
	set name = "Succumb"
	set category = "IC"
	if(src.has_status_effect(/datum/status_effect/chem/enthrall))
		var/datum/status_effect/chem/enthrall/E = src.has_status_effect(/datum/status_effect/chem/enthrall)
		if(E.phase < 3)
			if(HAS_TRAIT(src, TRAIT_MINDSHIELD))
				to_chat(src, "<span class='notice'>Your mindshield prevents your mind from giving in!</span>")
			else if(src.mind.assigned_role in GLOB.command_positions)
				to_chat(src, "<span class='notice'>Your dedication to your department prevents you from giving in!</span>")
			else
				E.enthrallTally += 20
				to_chat(src, "<span class='notice'>You give into [E.master]'s influence.</span>")
	if(InShock())
		log_message("Has succumbed to death while in [InFullShock() ? "hard":"soft"] shock with [round(health, 0.1)] points of health!", LOG_ATTACK)
		adjustOxyLoss(health - HEALTH_THRESHOLD_DEAD)
		updatehealth()
		to_chat(src, "<span class='notice'>You have given up life and succumbed to death.</span>")
		death()

/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(gunpointing)
		var/dir = get_dir(get_turf(gunpointing.source),get_turf(gunpointing.target))
		if(dir)
			setDir(dir)
