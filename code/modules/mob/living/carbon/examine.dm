/mob/living/carbon/examine(mob/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		handle_eye_contact(user, TRUE)
	var/t_He = p_they(TRUE)
	var/t_he = p_they()
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

	//holy shit this is a big skyrat edit
	/* skyrat edit
	var/list/missing = get_missing_limbs()
	*/
	var/list/msg = list()

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
			if(W.get_examine_description(user))
				msg += "[W.get_examine_description(user)]\n"
				if(istype(W, /datum/wound/slash/critical/incision) || istype(W, /datum/wound/mechanical/slash/critical/incision))
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
	var/bruteloss = getBruteLoss()
	var/burnloss = getFireLoss()
	var/cellularloss = getCloneLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(bruteloss)
			if (bruteloss < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if (bruteloss < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		if(burnloss)
			if (burnloss < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (burnloss < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		if(cellularloss)
			if(cellularloss < 25)
				msg += "[t_He] [t_is] slightly deformed.\n"
			else if (cellularloss < 50)
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
	
	var/bleed_text
	var/list/obj/item/bodypart/bleeding_limbs = list()
	var/list/obj/item/bodypart/grasped_limbs = list()
	//skyrat edit
	if(is_bleeding())
		for(var/i in bodyparts)
			var/obj/item/bodypart/BP = i
			if(BP.grasped_by)
				grasped_limbs += BP
			if(BP.get_bleed_rate() && !BP.current_gauze)
				bleeding_limbs += BP

		var/num_bleeds = LAZYLEN(bleeding_limbs)
		if(length(bleeding_limbs))
			bleed_text += "<B>[t_He] [t_is] bleeding from [t_his]"
		
		if(bleed_text)
			switch(num_bleeds)
				if(1 to 2)
					bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
				if(3 to INFINITY)
					for(var/i in 1 to (num_bleeds - 1))
						var/obj/item/bodypart/BP = bleeding_limbs[i]
						bleed_text += " [BP.name],"
					bleed_text += " and [bleeding_limbs[num_bleeds].name]"
		
			if(reagents.has_reagent(/datum/reagent/toxin/heparin))
				bleed_text += " incredibly quickly"
			
			bleed_text += "!"
			bleed_text += "</B>\n"

		for(var/obj/item/bodypart/grasped_part in grasped_limbs)
			bleed_text += "[t_He] [t_is] holding [t_his] [grasped_part.name] to slow the bleeding!\n"
		
		msg += bleed_text
	
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
	
	//CONSCIOUSNESS
	var/dist = get_dist(user, src)
	var/consciousness = LOOKS_CONSCIOUS
	var/damage = (getBruteLoss() + getFireLoss()) //If we are very damaged, it's easier to recognize whether or not we are dead

	var/mob/living/carbon/human/H = user
	var/has_health_hud = FALSE
	var/consciousness_msg = null
	if(istype(H))
		var/obj/item/organ/cyberimp/eyes/hud/CIH = H.getorgan(/obj/item/organ/cyberimp/eyes/hud)
		var/obj/item/clothing/glasses/hud/health/health = H.glasses
		if(istype(health) || (istype(CIH) && (CIH.HUD_type == DATA_HUD_MEDICAL_BASIC || CIH.HUD_type == DATA_HUD_MEDICAL_ADVANCED)))
			has_health_hud = TRUE
	if(has_health_hud)
		if(IsSleeping())
			consciousness = LOOKS_SLEEPY
			consciousness_msg = "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."
		if(InCritical())
			consciousness = LOOKS_UNCONSCIOUS
			consciousness_msg = "<span class='warning'>[t_His] life signs are shallow and labored[IsUnconscious() ? ", and [t_he] is unconscious" : ""].</span>"
		if(InFullCritical())
			consciousness = LOOKS_VERYUNCONSCIOUS
			consciousness_msg = "<span class='warning'>[t_His] life signs are very shallow and labored, [IsUnconscious() ? "[t_he] is completely unconscious and " : ""][t_he] appears to be undergoing shock.</span>"
		if(stat == DEAD)
			consciousness = LOOKS_DEAD
			consciousness_msg = "<span class='deadsay'>[t_He] [t_is] limp and unresponsive, with no signs of life.[(length(bleeding_limbs) && !(mob_biotypes & MOB_UNDEAD)) || (length(bleeding_limbs) && (mob_biotypes & MOB_UNDEAD) && (stat == DEAD)) ? "\n[t_His] bleeding has pooled, and is not flowing." : ""]</span>"
			if(suiciding)
				consciousness_msg += "\n<span class='deadsay'>[t_He] appear[p_s()] to have committed suicide... there is no hope of recovery.</span>"
			if(hellbound)
				consciousness_msg += "\n<span class='deadsay'>[t_His] soul seems to have been ripped out of [t_his] body.  Revival is impossible.</span>"
			if(!getorgan(/obj/item/organ/brain) || (!key && !get_ghost(FALSE)))
				consciousness_msg += "\n<span class='deadsay'>[t_His] body seems empty, [t_his] soul has since departed.</span>"
	else
		if(IsSleeping() || HAS_TRAIT(src, TRAIT_LOOKSSLEEPY) || (consciousness == LOOKS_SLEEPY))
			consciousness = LOOKS_SLEEPY
			if(dist <= 2)
				consciousness_msg = "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."
			else if(dist <= 10)
				consciousness_msg = "[t_He] [t_is]n't responding to anything around [t_him] and seems to be either asleep or unconscious. Hard to tell without getting closer."
		if(InCritical() || HAS_TRAIT(src, TRAIT_LOOKSUNCONSCIOUS) || (consciousness == LOOKS_UNCONSCIOUS))
			consciousness = LOOKS_UNCONSCIOUS
			if((dist <= 2 && is_face_visible() && !HAS_TRAIT(src, TRAIT_NOBREATH)) || (damage >= 75))
				consciousness_msg = "<span class='warning'>[t_His] breathing is shallow and labored[IsUnconscious() ? ", and [t_he] seems to be unconscious" : ""].</span>"
			else if((dist <= 10) && IsUnconscious())
				consciousness = LOOKS_SLEEPY
				consciousness_msg = "[t_He] [t_is]n't responding to anything around [t_him] and seems to be either asleep or unconscious. Hard to tell without getting closer."
		if(InFullCritical() || HAS_TRAIT(src, TRAIT_LOOKSVERYUNCONSCIOUS) || (consciousness == LOOKS_VERYUNCONSCIOUS))
			consciousness = LOOKS_VERYUNCONSCIOUS
			if((dist <= 2) || (damage >= 75))
				consciousness_msg = "<span class='warning'>[t_He] seems to have no identifiable breath[IsUnconscious() ? ", and [t_he] seems to be unconscious" : ""].</span>"
			else if((dist <= 10) && IsUnconscious())
				consciousness = LOOKS_SLEEPY
				consciousness_msg = "[t_He] [t_is]n't responding to anything around [t_him] and seems to be either asleep or unconscious. Hard to tell without getting closer."
		if((stat == DEAD) || (mob_biotypes & MOB_UNDEAD) || HAS_TRAIT(src, TRAIT_LOOKSDEAD) || HAS_TRAIT(src, TRAIT_FAKEDEATH) || (consciousness == LOOKS_DEAD))
			consciousness = LOOKS_DEAD
			if((dist <= 2) || (damage >= 75) || (mob_biotypes & MOB_UNDEAD))
				consciousness_msg = "<span class='deadsay'>[t_He] [t_is] limp and unresponsive, with no signs of life.[(length(bleeding_limbs) && !(mob_biotypes & MOB_UNDEAD)) || (length(bleeding_limbs) && (mob_biotypes & MOB_UNDEAD) && (stat == DEAD)) ? "\n[t_His] bleeding has pooled, and is not flowing." : ""]</span>"
				if(suiciding)
					consciousness_msg += "\n<span class='deadsay'>[t_He] appear[p_s()] to have committed suicide... there is no hope of recovery.</span>"
				if(hellbound)
					consciousness_msg += "\n<span class='deadsay'>[t_His] soul seems to have been ripped out of [t_his] body.  Revival is impossible.</span>"
				if(!getorgan(/obj/item/organ/brain) || (!key && !get_ghost(FALSE)))
					consciousness_msg += "\n<span class='deadsay'>[t_His] body seems empty, [t_his] soul has since departed.</span>"
			else if(dist <= 10 && (lying || IsUnconscious()))
				consciousness_msg = "[t_He] [t_is]n't responding to anything around [t_him] and seems to be either asleep or unconscious. Hard to tell without getting closer."
		
		if(HAS_TRAIT(src, TRAIT_LOOKSCONSCIOUS))
			consciousness = LOOKS_CONSCIOUS
			consciousness_msg = null
	
	if(consciousness_msg)
		. += consciousness_msg
	//

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
	var/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
	if((src == user) && HAS_TRAIT(user, TRAIT_SCREWY_CHECKSELF))
		msg |= "\t<span class='smallnotice'>[p_they(TRUE)] [p_have()] no significantly damaged bodyparts.</span>"
		msg |= "\t<span class='smallnotice'><i>[p_they(TRUE)] [p_have()] no visible scars.</i></span>"
		return msg

	var/t_His = p_their(TRUE)
	var/list/damaged_bodypart_text = list()
	for(var/obj/item/bodypart/BP in bodyparts)
		var/how_brute = ""
		var/how_burn = ""
		var/max_sev = 0
		var/sev = 0
		var/styletext = "tinydanger"
		var/text = ""
		if(!BP.brute_dam && !BP.burn_dam)
			continue
		if(BP.brute_dam >= (BP.max_damage/3))
			sev = round(BP.brute_dam/BP.max_damage * 3, 1)
			max_sev = max(max_sev, sev)
			switch(sev)
				if(1)
					how_brute = BP.light_brute_msg
				if(2)
					how_brute = BP.medium_brute_msg
				if(3)
					how_brute = BP.heavy_brute_msg
		if(BP.burn_dam >= (BP.max_damage/3))
			sev = round(BP.burn_dam/BP.max_damage * 3, 1)
			max_sev = max(max_sev, sev)
			switch(sev)
				if(1)
					how_burn = BP.light_burn_msg
				if(2)
					how_burn = BP.medium_burn_msg
				if(3)
					how_burn = BP.heavy_burn_msg
		switch(max_sev)
			if(1)
				styletext = "tinydanger"
			if(2)
				styletext = "smalldanger"
			if(3)
				styletext = "danger"
		if(how_brute && how_burn)
			text = "\t<span class='[styletext]'>[p_their(TRUE)] [BP.name] is [how_brute] and [how_burn][max_sev >= 2 ? "!" : "."]</span>"
		else if(how_brute)
			text = "\t<span class='[styletext]'>[p_their(TRUE)] [BP.name] is [how_brute][max_sev >= 2 ? "!" : "."]</span>"
		else if(how_burn)
			text = "\t<span class='[styletext]'>[p_their(TRUE)] [BP.name] is [how_burn][max_sev >= 2 ? "!" : "."]</span>"
		
		if(length(text))
			damaged_bodypart_text |= text
	
	msg |= damaged_bodypart_text

	if(!length(damaged_bodypart_text))
		msg |= "\t<span class='smallnotice'>[p_they(TRUE)] [p_have()] no significantly damaged bodyparts.</span>"
	
	var/list/obj/item/bodypart/gauzed_limbs = list()
	for(var/i in bodyparts)
		var/obj/item/bodypart/BP = i
		if(BP.current_gauze)
			gauzed_limbs += BP
	var/num_gauze = LAZYLEN(gauzed_limbs)
	var/gauze_text = "\t<span class='notice'>[t_His]"
	switch(num_gauze)
		if(1 to 2)
			gauze_text += " <a href='?src=[REF(gauzed_limbs[1])];gauze=1;'>"
			gauze_text += "[gauzed_limbs[1].name]"
			gauze_text += "</a>"
			gauze_text += "[num_gauze == 2 ? " and <a href='?src=[REF(gauzed_limbs[2])];gauze=1;'>[gauzed_limbs[2].name]</a>" : ""]"
		if(3 to INFINITY)
			for(var/i in 1 to (num_gauze - 1))
				var/obj/item/bodypart/BP = gauzed_limbs[i]
				gauze_text += " <a href='?src=[REF(BP)];gauze=1;'>[BP.name]</a>,"
			gauze_text += " and <a href='?src=[REF(gauzed_limbs[num_gauze])];gauze=1;'>[gauzed_limbs[num_gauze].name]</a>"
	gauze_text += "[num_gauze == 1 ? " is gauzed" : " are gauzed"]"
	
	gauze_text += ".</span>"
	if(num_gauze)
		msg += gauze_text

	var/list/obj/item/bodypart/suppress_limbs = list()
	for(var/i in bodyparts)
		var/obj/item/bodypart/BP = i
		if(BP.status & BODYPART_NOBLEED)
			suppress_limbs += BP

	var/num_suppress = LAZYLEN(suppress_limbs)
	var/suppress_text = "\t<span class='notice'><B>[t_His]"
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
	
	var/list/visible_scars = list()
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(istype(S) && S.is_visible(user))
			LAZYADD(visible_scars, S)
	
	for(var/i in visible_scars)
		var/datum/scar/S = i
		var/scar_text = S.get_examine_description(user)
		if(scar_text)
			msg |= "\t[scar_text]"
	
	if(!length(visible_scars))
		msg |= "\t<span class='smallnotice'><i>[p_they(TRUE)] [p_have()] no visible scars.</i></span>"
	
	return msg
//
