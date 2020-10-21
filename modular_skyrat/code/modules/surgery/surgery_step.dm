//Overrides the surgery step to require anasthetics for a smooth surgery
//also lets you do self-surgery again bottom text
/datum/surgery_step/initiate(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	surgery.step_in_progress = TRUE
	var/speed_mod = (user == target ? 0.25 : 1) //self-surgery is hard
	var/advance = FALSE
	var/obj/item/bodypart/affecting = target.get_bodypart(target_zone)
	if(preop(user, target, target_zone, tool, surgery) == -1)
		surgery.step_in_progress = FALSE
		return FALSE
	
	if(tool)
		speed_mod = tool.toolspeed
	
	if(user.mind)
		var/datum/skills/surgery/surgerye = GET_SKILL(user, surgery)
		if(surgerye)
			speed_mod *= surgerye.get_speed_mod()
			
	if(do_after(user, time * speed_mod, target = target))
		var/prob_chance = 100
		if(implement_type)	//this means it isn't a require hand or any item step.
			prob_chance = implements[implement_type]
		if(target == user) //self-surgery is hard
			if(user.mind)
				var/datum/skills/surgery/surgerye = GET_SKILL(user, surgery)
				if(surgerye && surgerye <= 10)
					speed_mod *= 0.6
			else
				prob_chance *= 0.6
		if(!target.lying) //doing surgery on someone who's not even lying down is VERY hard
			if(user.mind)
				var/datum/skills/surgery/surgerye = GET_SKILL(user, surgery)
				if(surgerye && surgerye.level <= 10)
					prob_chance *= 0.5
			else
				prob_chance *= 0.5
		
		prob_chance *= surgery.get_probability_multiplier()

		if((ishuman(target) || ismonkey(target)) && affecting && affecting.is_organic_limb() && (target.stat == CONSCIOUS) && (target.mob_biotypes & MOB_ORGANIC) && !target.IsUnconscious() && !target.InCritical() && !HAS_TRAIT(target, TRAIT_PAINKILLER) && !(target.chem_effects[CE_PAINKILLER] >= 50))
			if(user.mind)
				var/datum/skills/surgery/surgerye = GET_SKILL(user, surgery)
				if(surgerye && surgerye.level <= 10)
					prob_chance *= surgerye.no_anesthesia_punishment()
			else
				prob_chance *= 0.4
			
			to_chat(user, "<span class='notice'>You feel like anesthetics could make this much easier.</span>")
			target.visible_message("<span class='warning'>[target] [pick("writhes in pain", "squirms and kicks in agony", "cries in pain as [target.p_their()] body violently jerks")], impeding the surgery!</span>", \
			"<span class='warning'>You[pick(" writhe as agonizing pain surges throught your entire body", " feel burning pain sending your body into a convulsion", "r body squirms as sickening pain fills every part of it")]!</span>")
			target.emote("scream")
			target.blood_volume -= 5
			target.add_splatter_floor(get_turf(target))
			target.apply_damage(rand(3,6), damagetype = BRUTE, def_zone = target_zone, blocked = FALSE, forced = FALSE)

		//Dice roll
		var/didntfuckup = TRUE
		if(user.mind && (user.mind.diceroll(STAT_DATUM(int), SKILL_DATUM(surgery), dicetype = "6d6", mod = -(round(100 - prob_chance)/2)) <= DICE_FAILURE))
			didntfuckup = FALSE
		if(didntfuckup || (iscyborg(user) && !silicons_obey_prob && chem_check(target) && !try_to_fail))
			if(success(user, target, target_zone, tool, surgery))
				advance = TRUE
		else
			if(failure(user, target, target_zone, tool, surgery))
				advance = TRUE
		spread_germs_to_bodypart(affecting, user, tool)
		if(advance && !repeatable)
			surgery.status++
			if(surgery.status > surgery.steps.len)
				surgery.complete()
	surgery.step_in_progress = FALSE
	return advance

/proc/spread_germs_to_bodypart(obj/item/bodypart/BP, mob/living/carbon/human/user, obj/item/tool)
	if(!istype(user) || !istype(BP) || BP.is_robotic_limb())
		return

	//Germs from the surgeon
	var/our_germ_level = user.germ_level
	if(user.gloves)
		our_germ_level = user.gloves.germ_level
	
	//Germs from the tool
	if(tool && (tool.germ_level >= our_germ_level))
		our_germ_level += tool.germ_level
	
	//Germs from the dirtiness on the surgery room
	for(var/turf/open/floor/floor in view(2, get_turf(BP.owner)))
		our_germ_level += floor.dirtiness
	
	//Germs from the wounds on the bodypart
	for(var/datum/wound/W in BP.wounds)
		our_germ_level += W.germ_level
	
	//Germs from organs inside the bodypart
	for(var/obj/item/organ/O in BP.get_organs())
		if(O.germ_level)
			our_germ_level += O.germ_level
	
	//Divide it by 10 to be reasonable
	our_germ_level = CEILING(our_germ_level/10, 1)

	//If the patient has antibiotics, kill germs by an amount equal to 10x the antibiotic force
	//e.g. nalixidic acid has 35 force, thus would decrease germs here by 350
	var/antibiotics = BP.owner.get_antibiotics()
	our_germ_level = max(0, our_germ_level - antibiotics)

	//Germ level is increased/decreased depending on a diceroll
	if(user.mind)
		var/diceroll = user.mind.diceroll(STAT_DATUM(int), SKILL_DATUM(surgery), "6d6")
		switch(diceroll)
			if(DICE_CRIT_SUCCESS)
				our_germ_level *= 0.5
			if(DICE_FAILURE)
				our_germ_level *= 2
			if(DICE_CRIT_FAILURE)
				our_germ_level *= 3

	if(our_germ_level <= (WOUND_SANITIZATION_STERILIZER/2))
		return

	//If we still have germs, let's get that W
	//First, nfect the wounds on the bodypart
	for(var/datum/wound/W in BP.wounds)
		if(W.germ_level < INFECTION_LEVEL_TWO)
			W.germ_level += our_germ_level
	
	//Infect the organs on the bodypart
	for(var/obj/item/organ/O in BP.get_organs())
		if(O.germ_level < INFECTION_LEVEL_TWO)
			O.germ_level += our_germ_level

	//Infect the bodypart
	if(BP.germ_level < INFECTION_LEVEL_TWO)
		BP.germ_level += our_germ_level
