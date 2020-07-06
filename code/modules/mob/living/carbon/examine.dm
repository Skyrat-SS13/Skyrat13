/mob/living/carbon/examine(mob/user)
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()

	. = list("<span class='info'>*---------*\nThis is [icon2html(src, user)] \a <EM>[src]</EM>!")

	if (handcuffed)
		. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!</span>"
	if (head)
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head."
	if (wear_mask)
		. += "[t_He] [t_is] wearing [wear_mask.get_examine_string(user)] on [t_his] face."
	if (wear_neck)
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck.\n"

	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	if (back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."
	var/appears_dead = 0
	if (stat == DEAD)
		appears_dead = 1
		if(getorgan(/obj/item/organ/brain))
			. += "<span class='deadsay'>[t_He] [t_is] limp and unresponsive, with no signs of life.</span>"
		else if(get_bodypart(BODY_ZONE_HEAD))
			. += "<span class='deadsay'>It appears that [t_his] brain is missing...</span>"
	
	//holy shit this is a big skyrat edit
	/* skyrat edit
	var/list/missing = get_missing_limbs()
	*/
	var/list/msg = list("<span class='warning'>")

	var/list/missing = ALL_BODYPARTS
	var/list/disabled = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		//skyrat edit
		if(BP.is_disabled())
			disabled += BP
		//
		missing -= BP.body_zone
		for(var/obj/item/I in BP.embedded_objects)
		//skyrat edit
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] stuck to [t_his] [BP.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] embedded in [t_his] [BP.name]!</B>\n"
		for(var/datum/wound/W in BP.wounds)
			msg += "[W.get_examine_description(user)]\n"
		//

	for(var/X in disabled)
		var/obj/item/bodypart/BP = X
		var/damage_text
		//skyrat edit
		if(BP.is_disabled() != BODYPART_DISABLED_WOUND) // skip if it's disabled by a wound (cuz we'll be able to see the bone sticking out!)
			if(!(BP.get_damage(include_stamina = FALSE) >= BP.max_damage)) //we don't care if it's stamcritted
				damage_text = "limp and lifeless"
			else
				damage_text = (BP.brute_dam >= BP.burn_dam) ? BP.heavy_brute_msg : BP.heavy_burn_msg
			msg += "<B>[capitalize(t_his)] [BP.name] is [damage_text]!</B>\n"
		//

	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/t in missing)
		var/should_msg = "<B>[capitalize(t_his)] [parse_zone(t)] is missing!</B>\n"
		if(t==BODY_ZONE_HEAD)
			should_msg = "<span class='deadsay'><B>[t_His] [parse_zone(t)] is missing!</B></span>\n"
		else if(t == BODY_ZONE_L_ARM || t == BODY_ZONE_L_LEG || t == BODY_ZONE_PRECISE_L_FOOT || t == BODY_ZONE_PRECISE_R_FOOT)
			l_limbs_missing++
		else if(t == BODY_ZONE_R_ARM || t == BODY_ZONE_R_LEG || t == BODY_ZONE_PRECISE_L_HAND || t == BODY_ZONE_PRECISE_R_HAND)
			r_limbs_missing++
		
		for(var/datum/wound/L in all_wounds)
			if(L.severity == WOUND_SEVERITY_PERMANENT)
				if((L.fake_body_zone == t) || (L.fake_body_zone == SSquirks.bodypart_child_to_parent[t]))
					should_msg = null
		
		if(SSquirks.bodypart_child_to_parent[t])
			if(SSquirks.bodypart_child_to_parent[t] in missing)
				should_msg = null

		if(should_msg)
			msg += should_msg

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		msg += "[t_He] look[p_s()] all right now.\n"
	else if(l_limbs_missing == 0 && r_limbs_missing >= 4)
		msg += "[t_He] really keeps to the left.\n"
	else if(l_limbs_missing >= 4 && r_limbs_missing >= 4)
		msg += "[t_He] [p_do()]n't seem all there.\n"
	var/temp = getBruteLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_is] slightly deformed.\n"
			else if (temp < 50)
				msg += "[t_He] [t_is] <b>moderately</b> deformed!\n"
			else
				msg += "<b>[t_He] [t_is] severely deformed!</b>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_He] seem[p_s()] to be clumsy and unable to think.\n"

	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked.\n"

	if(pulledby && pulledby.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"
	//skyrat edit
	var/scar_severity = 0
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(istype(S) && S.is_visible(user))
			scar_severity += S.severity

	switch(scar_severity)
		if(WOUND_SEVERITY_TRIVIAL)
			msg += "<span class='smallnotice'><i>[t_He] [t_has] visible scarring, you can look again to take a closer look...</i></span>\n"
		if(WOUND_SEVERITY_MODERATE to WOUND_SEVERITY_SEVERE)
			msg += "<span class='notice'><i>[t_He] [t_has] several bad scars, you can look again to take a closer look...</i></span>\n"
		if(WOUND_SEVERITY_CRITICAL to WOUND_SEVERITY_PERMANENT)
			msg += "<span class='notice'><b><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></b></span>\n"
		if(WOUND_SEVERITY_LOSS to INFINITY)
			msg += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>\n"
	//

	if(msg.len)
		. += "<span class='warning'>[msg.Join("")]</span>"

	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			. += "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."
		else if(InCritical())
			. += "[t_His] breathing is shallow and labored."

		if(digitalcamo)
			. += "[t_He] [t_is] moving [t_his] body in an unnatural and blatantly unsimian manner."

	if(SEND_SIGNAL(src, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		. += "[t_He] [t_is] visibly tense[CHECK_MOBILITY(src, MOBILITY_STAND) ? "." : ", and [t_is] standing in combative stance."]"

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.shown_mood)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				. += "[t_He] look[p_s()] depressed."
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				. += "[t_He] look[p_s()] very sad."
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				. += "[t_He] look[p_s()] a bit down."
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				. += "[t_He] look[p_s()] quite happy."
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				. += "[t_He] look[p_s()] very happy."
			if(MOOD_LEVEL_HAPPY4 to INFINITY)
				. += "[t_He] look[p_s()] ecstatic."
	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)
	. += "*---------*</span>"

//skyrat edit
/mob/living/carbon/examine_more(mob/user)
	if(!all_scars || !all_scars.len || (src == user && HAS_TRAIT(user, TRAIT_SCREWY_CHECKSELF)))
		return ..()

	var/list/visible_scars
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(istype(S) && S.is_visible(user))
			LAZYADD(visible_scars, S)

	if(!visible_scars)
		return ..()

	var/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
	for(var/i in visible_scars)
		var/datum/scar/S = i
		var/scar_text = S.get_examine_description(user)
		if(scar_text)
			msg += "[scar_text]"

	return msg
