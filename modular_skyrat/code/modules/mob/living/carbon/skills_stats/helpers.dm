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
//For example: two stats will need 6d6 dicetype and also 20 crit instead of 1.
//REMEMBER THIS: when adding proc to action you BOUND to specify SUCCESS and CRIT_FAILURE in it! FAILURE may do nothing and CRIT_SUCCESS may be same as SUCCESS though.
/datum/mind/proc/diceroll(stats = 0, skills = 0, dicetype = "3d6", crit = 10, mod = 0)
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
	var/sum = (stats + skills) * (2 + modifier)

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
