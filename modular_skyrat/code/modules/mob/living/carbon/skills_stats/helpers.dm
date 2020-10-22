//Skill and stat helpers
//Code shamelessly stolen from IS12 warfare, thanks based Mattroks

//Mind helpers
//Get a damage modifier based on a stat and/or skill
/datum/mind/proc/get_skillstat_damagemod(used_stat, used_skill)
	var/modifier = 1

	if(used_stat)
		var/datum/stats/stat = mob_stats[used_stat]
		if(stat)
			modifier *= stat.get_generic_modifier(1, FALSE)
	
	if(used_skill)
		var/datum/skills/skill = mob_skills[used_skill]
		if(skill)
			modifier *= skill.get_generic_modifier(1, FALSE)

	return modifier

//DICE ROLL
//Add this to the action and specify what will happen in each outcome.
//Important! you should not use more than one stat in proc but if you really want to, you should multiply amount of dices and crit according to how much of them you added to the formula.
//For example: two stats will need 6d6 dicetype and also 20 crit instead of 10.
//REMEMBER THIS: when adding proc to action you BOUND to specify SUCCESS and CRIT_FAILURE in it! FAILURE may do nothing and CRIT_SUCCESS may be same as SUCCESS though.
/datum/mind/proc/diceroll(stats = 0, skills = 0, dicetype = "3d6", crit = 10, mod = 0)
	//We need numbers, not paths nor datums
	if(istype(stats, /datum))
		var/datum/stats/states = stats
		stats = states.level
	if(istype(skills, /datum))
		var/datum/skills/skilles = skills
		skills = skilles.level
	if(ispath(stats))
		var/datum/stats/stat = mob_stats[stats]
		stats = stat.level
	if(ispath(skills))
		var/datum/skills/skill = mob_skills[skills]
		skills = skill.level
	//Get the carbon mob, if the mind controls one
	var/mob/living/carbon/carbonmob = current
	if(!istype(carbonmob))
		carbonmob = null
	
	//Do the dice roll
	var/dice = roll(dicetype)

	//Get the mood modifier if applicable
	var/moodmod = 0
	if(carbonmob)
		moodmod = carbonmob.mood_mod()
	
	//Get the fatigue modifier
	var/fatiguemod = 0
	if(carbonmob)
		fatiguemod = carbonmob.fatigue_mod()

	//Sum up all the modifiers
	var/modifier = mod + moodmod + fatiguemod

	//Get the necessary number to pass the roll
	var/sum = stats + skills + modifier

	//Excessive painkilling fucks up dicerolls
	if(carbonmob?.chem_effects[CE_PAINKILLER] >= 75)
		sum -= 5
	
	//Fraggots always have a 50% chance to fail at a diceroll miserably
	if(carbonmob?.fraggot && prob(50))
		return DICE_CRIT_FAILURE
	
	//Finally, return whether it was a failure or a success
	if(dice <= sum)
		if(dice <= sum - crit || dice <= 4)
			return DICE_CRIT_SUCCESS
		else
			return DICE_SUCCESS
	else
		if(dice >= sum + crit || dice >= 17)
			return DICE_CRIT_FAILURE
		else
			return DICE_FAILURE

//Handle parrying an attack
/datum/mind/proc/handle_parry(mob/living/carbon/human/victim, obj/item/weapon, total_damage, mob/user)
	. = FALSE
	//Insufficient info, go back.
	if(!victim || !user)
		return
	if(!total_damage && weapon)
		total_damage = weapon.force
	//We are on click cooldown, we can't parry
	if(victim.next_move > world.time)
		return
	//We are dodging, we can't parry
	if(victim.dodge_parry == DP_DODGE)
		return
	//Combat mode is inactive, we can't parry
	if(!SEND_SIGNAL(victim, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		return
	//We are hitting ourselves, can't parry
	if(victim == user)
		return
	//Attacker is behind us, we can't parry
	if(get_dir(user, victim) & victim.dir)
		return
	//Victim is unconscious, can't parry
	if(victim.stat >= UNCONSCIOUS)
		return
	//Do a dice roll based on melee skill and dexterity, modifier being half the total damage
	switch(diceroll(GET_STAT_LEVEL(victim, dex)*0.25, GET_SKILL_LEVEL(victim, melee)*0.75, mod = -abs(round(total_damage/2))))
		//Always go through, no questions asked on crit successes
		if(DICE_CRIT_SUCCESS)
			victim.changeNext_move(CLICK_CD_MELEE)
			//We don't have an active hand item - just redirect damage to the active hand
			if(!victim.get_active_held_item())
				var/obj/item/bodypart/BP = victim.get_active_hand()
				if(BP)
					var/hamdarmor = victim.getarmor(BP.body_zone, "melee")
					if(hamdarmor < 30)
						total_damage *= clamp(1 - (hamdarmor/100), 0, 1)
						BP.receive_damage(total_damage)
				else
					return
			return TRUE
		//Normal successes will roll 50% * (level/MAX_SKILL) on melee
		if(DICE_SUCCESS)
			var/mod = GET_SKILL_LEVEL(victim, melee)/MAX_SKILL
			var/base_chance = 75
			if(!victim.get_active_held_item())
				base_chance = 50
			if(victim.combat_intent == CI_DEFEND)
				base_chance += 15 * mod
			if(prob(base_chance * mod))
				victim.changeNext_move(CLICK_CD_MELEE)
				//We don't have an active hand item - just redirect damage to the active hand
				if(!victim.get_active_held_item())
					var/obj/item/bodypart/BP = victim.get_active_hand()
					if(BP)
						var/hamdarmor = victim.getarmor(BP.body_zone, "melee")
						if(hamdarmor < 30)
							total_damage *= clamp(1 - (hamdarmor/100), 0, 1)
							BP.receive_damage(total_damage)
					else
						return FALSE
				return TRUE

//Handle dodging an attack
/datum/mind/proc/handle_dodge(mob/living/carbon/human/victim, obj/item/weapon, total_damage, mob/user)
	. = FALSE
	//Insufficient info, go back.
	if(!victim || !user)
		return
	if(!total_damage && weapon)
		total_damage = weapon.force
	//We are on click cooldown, we can't parry
	if(victim.next_move > world.time)
		return
	//We are parrying, we can't dodge
	if(victim.dodge_parry == DP_PARRY)
		return
	//Combat mode is inactive, we can't dodge
	if(!SEND_SIGNAL(victim, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		return
	//We are hitting ourselves, can't dodge
	if(victim == user)
		return
	//Attacker is behind us, we can't dodge
	if(get_dir(user, victim) & victim.dir)
		return
	//Victim is unconscious, can't dodge
	if(victim.stat >= UNCONSCIOUS)
		return
	//Do a dice roll based on melee skill and dexterity, modifier being the total damage
	//(thus parrying is almost always preferrable, unless you are unarmed)
	switch(diceroll(GET_STAT_LEVEL(victim, dex)*0.25, GET_SKILL_LEVEL(victim, melee)*0.75, mod = -abs(round(total_damage))))
		//Always go through, no questions asked on crit successes
		if(DICE_CRIT_SUCCESS)
			victim.changeNext_move(CLICK_CD_MELEE)
			return TRUE
		//Normal successes will roll 40% * (level/MAX_SKILL) on melee
		if(DICE_SUCCESS)
			var/mod = GET_SKILL_LEVEL(victim, melee)/MAX_SKILL
			var/base_chance = 75
			if(victim.combat_intent == CI_DEFEND)
				base_chance += 15 * mod
			//Projectiles are hard to dodge for obvious reasons
			if(isprojectile(weapon))
				base_chance -= 25 * (1 - mod)
			if(prob(base_chance * mod))
				victim.changeNext_move(CLICK_CD_MELEE)
				return TRUE

///Carbon dice roll modifiers
//Converts mood level into a bonus or malus for a dice roll
/mob/living/carbon/proc/mood_mod()
	. = 0
	var/datum/component/mood/mood = GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.mood_level)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				return -4
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				return -3
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				return -2
			if(MOOD_LEVEL_SAD2 to MOOD_LEVEL_SAD1)
				return -1
			if(MOOD_LEVEL_SAD1 to MOOD_LEVEL_NEUTRAL)
				return 0
			if(MOOD_LEVEL_NEUTRAL to MOOD_LEVEL_HAPPY1)
				return 1
			if(MOOD_LEVEL_HAPPY1 to MOOD_LEVEL_HAPPY2)
				return 2
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				return 3
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				return 4
			else
				return 0

//Converts stamina level into a bonus or malus for a dice roll
/mob/living/carbon/proc/fatigue_mod()
	. = 0
	switch(getStaminaLoss())
		if(-INFINITY to 0)
			return 2
		if(1 to 20)
			return 0
		if(21 to 40)
			return -1
		if(41 to 60)
			return -2
		if(61 to 80)
			return -3
		if(81 to 100)
			return -4
		if(100 to INFINITY)
			return -5
		else
			return -5
