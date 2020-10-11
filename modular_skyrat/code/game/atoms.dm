// Trash that should not exist
/atom
	var/abandoned_code = FALSE

/atom/Initialize(mapload, ...)
	..()
	if(abandoned_code)
		QDEL_IN(src, 1 SECONDS)

// Germ / infection stuff
/atom
	var/germ_level = GERM_LEVEL_AMBIENT

// Used to add or reduce germ level on an atom
/atom/proc/janitize(add_germs, minimum_germs = 0, maximum_germs = MAXIMUM_GERM_LEVEL)
	germ_level = clamp(germ_level + add_germs, minimum_germs, maximum_germs)

// Stumbling makes you fall like a jackass
/atom/Bumped(atom/movable/AM)
	. = ..()
	if(iscarbon(AM))
		var/mob/living/carbon/C = AM
		if(C.IsStumble())
			deal_with_stumbling_idiot(AM)

/atom/proc/deal_with_stumbling_idiot(mob/living/carbon/idiot)
	if(!idiot.IsStumble())
		return
	if(idiot.mind)
		//Deal with knockdown
		switch(idiot.mind.diceroll(STAT_DATUM(dex)))
			if(DICE_FAILURE)
				idiot.DefaultCombatKnockdown(rand(100, 200))
			if(DICE_CRIT_FAILURE)
				idiot.DefaultCombatKnockdown(rand(200, 400))
		//Deal with damage
		switch(idiot.mind.diceroll(STAT_DATUM(end)))
			if(DICE_FAILURE)
				var/obj/item/bodypart/head = idiot.get_bodypart(BODY_ZONE_HEAD)
				if(head)
					head.receive_damage(MAX_STAT - GET_STAT_LEVEL(idiot, end))
			if(DICE_CRIT_FAILURE)
				var/obj/item/bodypart/head = idiot.get_bodypart(BODY_ZONE_HEAD)
				if(head)
					head.receive_damage((MAX_STAT - GET_STAT_LEVEL(idiot, end)) * 2)
				idiot.Stun(rand(300, 450))
	else
		var/obj/item/bodypart/head = idiot.get_bodypart(BODY_ZONE_HEAD)
		if(head)
			head.receive_damage(rand(2, 6))
		idiot.DefaultCombatKnockdown(rand(100, 200))
	sound_hint(src, idiot)
