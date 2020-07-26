/mob/living/carbon/examine(mob/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		handle_eye_contact(user, TRUE)
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
	var/obj/item/bodypart/head/HD = get_bodypart(BODY_ZONE_HEAD)
	if(!wear_mask && istype(HD) && HD.tapered)
		. += "<span class='warning'>[t_He] [t_has] \a <b><a href='?src=[REF(HD)];tape=[HD.tapered];'>[HD.tapered.get_examine_string(user)]</a></b> covering [t_his] mouth!</span>"
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
		//skyrat edit
		for(var/obj/item/I in BP.embedded_objects)
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] stuck to [t_his] [BP.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] embedded in [t_his] [BP.name]!</B>\n"
		if(BP.etching)
			msg += "<B>[t_His] [BP.name] has \"[BP.etching]\" etched on it!</B>\n"
		for(var/datum/wound/W in BP.wounds)
			msg += "[W.get_examine_description(user)]\n"
			if(istype(W, /datum/wound/slash/critical/incision))
				for(var/obj/item/organ/O in getorganszone(BP.body_zone))
					for(var/i in O.surgical_examine(user))
						msg += "<B>[icon2html(O.examine_icon ? O.examine_icon : O, user, O.examine_icon_state ? O.examine_icon_state : O.icon_state)] [i]</B>\n"
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
			if(L.severity == WOUND_SEVERITY_LOSS)
				var/list/children_atomization = SSquirks.atomize_bodypart_heritage(L.limb?.body_zone)
				if((L.fake_body_zone == t) || (L.fake_body_zone in children_atomization)) //There is already a missing parent bodypart or loss wound for us, no need to be redundant
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
	if(is_bleeding())
		var/list/obj/item/bodypart/bleeding_limbs = list()

		for(var/i in bodyparts)
			var/obj/item/bodypart/BP = i
			if(BP.get_bleed_rate() && !BP.current_gauze)
				bleeding_limbs += BP

		var/num_bleeds = LAZYLEN(bleeding_limbs)

		var/bleed_text
		if(appears_dead)
			bleed_text = "<span class='deadsay'><B>Blood is visible in [t_his] open"
		else
			bleed_text = "<B>[t_He] [t_is] bleeding from [t_his]"
		
		switch(num_bleeds)
			if(1 to 2)
				bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
			if(3 to INFINITY)
				for(var/i in 1 to (num_bleeds - 1))
					var/obj/item/bodypart/BP = bleeding_limbs[i]
					bleed_text += " [BP.name],"
				bleed_text += " and [bleeding_limbs[num_bleeds].name]"
		
		if(appears_dead)
			bleed_text += ", but it has pooled and is not flowing.</span>"
		else
			if(reagents.has_reagent(/datum/reagent/toxin/heparin))
				bleed_text += " incredibly quickly!"
		
		if(bleed_text)
			bleed_text += "</B>\n"
		
		msg += bleed_text
	
	var/list/obj/item/bodypart/suppress_limbs = list()
	for(var/i in bodyparts)
		var/obj/item/bodypart/BP = i
		if(BP.status & BODYPART_NOBLEED)
			suppress_limbs += BP

	var/num_suppress = LAZYLEN(suppress_limbs)
	var/suppress_text = "<span class='notice'><B>[t_His]"
	switch(num_suppress)
		if(1 to 2)
			suppress_text += " [suppress_limbs[1].name][num_suppress == 2 ? " and [suppress_limbs[2].name]" : ""]"
		if(3 to INFINITY)
			for(var/i in 1 to (num_suppress - 1))
				var/obj/item/bodypart/BP = suppress_limbs[i]
				suppress_text += " [BP.name],"
			suppress_text += " and [suppress_limbs[num_suppress].name]"
	suppress_text += "[num_suppress == 1 ? " is impervious to bleeding" : " are impervious to bleeding"]"
	
	suppress_text += ".</B></span>\n"
	if(num_suppress)
		msg += suppress_text
	
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
	if((src == user) && HAS_TRAIT(user, TRAIT_SCREWY_CHECKSELF))
		return ..()

	var/list/visible_scars = list()
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(istype(S) && S.is_visible(user))
			LAZYADD(visible_scars, S)

	var/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
	
	for(var/obj/item/bodypart/BP in bodyparts)
		var/how_brute
		var/how_burn
		var/max_sev = 0

		if(!BP.brute_dam)
			how_brute = BP.no_brute_msg
			max_sev = max(max_sev, 0)
		else if(BP.brute_dam < (BP.max_damage * 0.33))
			how_brute = BP.light_brute_msg
			max_sev = max(max_sev, 1)
		else if(BP.brute_dam < (BP.max_damage * 0.66))
			how_brute = BP.medium_brute_msg
			max_sev = max(max_sev, 2)
		else if(BP.brute_dam <= BP.max_damage)
			how_brute = BP.heavy_brute_msg
			max_sev = max(max_sev, 3)

		if(!BP.burn_dam)
			how_burn = BP.no_burn_msg
			max_sev = max(max_sev, 0)
		else if(BP.burn_dam < (BP.max_damage * 0.33))
			how_burn = BP.light_burn_msg
			max_sev = max(max_sev, 1)
		else if(BP.burn_dam < (BP.max_damage * 0.66))
			how_burn = BP.medium_burn_msg
			max_sev = max(max_sev, 2)
		else if(BP.burn_dam <= BP.max_damage)
			how_burn = BP.heavy_burn_msg
			max_sev = max(max_sev, 3)
		
		var/style
		switch(max_sev)
			if(0)
				style = "tinynotice"
			if(1)
				style = "tinydanger"
			if(2)
				style = "smalldanger"
			if(3)
				style = "danger"
		var/aaa = ""
		aaa += "\t<span class='[style]'>[capitalize(p_their())] [BP.name] is "
		if((how_brute == BP.no_brute_msg) && (how_burn != BP.no_burn_msg))
			aaa += "[how_brute], but it is [how_burn]"
		else if((how_brute == BP.no_brute_msg) && (how_burn == BP.no_burn_msg))
			aaa += "[how_brute] and [how_burn]"
		else if((how_brute != BP.no_brute_msg) && (how_burn == BP.no_burn_msg))
			aaa += "[how_burn], but it is [how_brute]"
		else if((how_brute != BP.no_brute_msg) && (how_burn != BP.no_burn_msg))
			aaa += "[how_brute] and [how_burn]"
		aaa += "[max_sev >= 3 ? "!" : "."]</span>"
		msg += aaa

	for(var/i in visible_scars)
		var/datum/scar/S = i
		var/scar_text = S.get_examine_description(user)
		if(scar_text)
			msg += "[scar_text]"

	return msg
