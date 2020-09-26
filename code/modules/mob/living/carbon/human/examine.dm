/mob/living/carbon/human/examine(mob/user)
	//this is very slightly better than it was because you can use it more places. still can't do \his[src] though.
	var/t_He = p_they(TRUE)
	var/t_he = p_they()
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	var/screwy_self = ((user == src) && (HAS_TRAIT(user, TRAIT_SCREWY_CHECKSELF)))
	var/obscure_name
	var/species_visible //Skyrat edit
	var/species_name_string //Skyrat edit

	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE)) //skyrat - moved this higher
	//Skyrat stuff
	if(skipface || get_visible_name() == "Unknown")
		species_visible = FALSE
	else
		species_visible = TRUE

	if(!species_visible)
		species_name_string = "!"
	else if (dna.custom_species)
		species_name_string = ", [prefix_a_or_an(dna.custom_species)] <EM>[dna.custom_species]</EM>!"
	else
		species_name_string = ", [prefix_a_or_an(dna.species.name)] <EM>[dna.species.name]</EM>!"
	//End of skyrat stuff

	. = list("<span class='info'>*---------*\nThis is <EM>[!obscure_name ? name : "Unknown"]</EM>[species_name_string]") //Skyrat edit

	var/vampDesc = ReturnVampExamine(user) // Vamps recognize the names of other vamps.
	var/vassDesc = ReturnVassalExamine(user) // Vassals recognize each other's marks.
	if (vampDesc != "") // If we don't do it this way, we add a blank space to the string...something to do with this -->  . += ""
		. += vampDesc
	if (vassDesc != "")
		. += vassDesc

	var/list/obscured = check_obscured_slots()

	//Skyrat changes - edited that to only show the extra species tidbit if it's unknown or he's got a custom species
	//and also underwear slots :)
	if(skipface || get_visible_name() == "Unknown")
		. += "You can't make out what species they are."
	else if(dna.custom_species)
		. += "[t_He] [t_is] [prefix_a_or_an(dna.species.name)] [dna.species.name]!"

	//Underwear
	var/undies_hidden = underwear_hidden()
	if(w_underwear && !undies_hidden)
		. += "[t_He] [t_is] wearing [w_underwear.get_examine_string(user)]."
	if(w_socks && !undies_hidden)
		. += "[t_He] [t_is] wearing [w_socks.get_examine_string(user)]."
	if(w_shirt && !undies_hidden)
		. += "[t_He] [t_is] wearing [w_shirt.get_examine_string(user)]."
	//Wrist slot because you're epic
	if(wrists && !(SLOT_WRISTS in obscured))
		. += "[t_He] [t_is] wearing [wrists.get_examine_string(user)]."
	//End of skyrat changes

	//uniform
	if(w_uniform && !(SLOT_W_UNIFORM in obscured))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(length(U.attached_accessories) && !(U.flags_inv & HIDEACCESSORY))
				var/list/weehoo = list()
				var/dumb_icons = ""
				for(var/obj/item/clothing/accessory/attached_accessory in U.attached_accessories)
					if(!(attached_accessory.flags_inv & HIDEACCESSORY))
						weehoo += "\a [attached_accessory]"
						dumb_icons = "[dumb_icons][icon2html(attached_accessory, user)]"
				if(length(weehoo))
					accessory_msg += " with [dumb_icons] "
					if(length(U.attached_accessories) >= 2)
						accessory_msg += jointext(weehoo, ", ", 1, max(1, length(weehoo) - 1))
						accessory_msg += " and [weehoo[length(weehoo)]]"
					else
						accessory_msg += weehoo[1]


		. += "[t_He] [t_is] wearing [w_uniform.get_examine_string(user)][accessory_msg]."
	//head
	if(head)
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head."
	//suit/armor
	if(wear_suit)
		. += "[t_He] [t_is] wearing [wear_suit.get_examine_string(user)]."
		//suit/armor storage
		if(s_store && !(SLOT_S_STORE in obscured))
			. += "[t_He] [t_is] carrying [s_store.get_examine_string(user)] on [t_his] [wear_suit.name]."
	//back
	if(back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	//Hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	//gloves
	if(gloves && !(SLOT_GLOVES in obscured))
		. += "[t_He] [t_has] [gloves.get_examine_string(user)] on [t_his] hands."
	else if(length(blood_DNA))
		var/hand_number = get_num_arms(FALSE)
		if(hand_number)
			. += "<span class='warning'>[t_He] [t_has] [hand_number > 1 ? "" : "a"] blood-stained hand[hand_number > 1 ? "s" : ""]!</span>"

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/restraints/handcuffs/cable))
			. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] restrained with cable!</span>"
		else
			. += "<span class='warning'>[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!</span>"

	//belt
	if(belt)
		. += "[t_He] [t_has] [belt.get_examine_string(user)] about [t_his] waist."

	//shoes
	if(shoes && !(SLOT_SHOES in obscured))
		. += "[t_He] [t_is] wearing [shoes.get_examine_string(user)] on [t_his] feet."
	
	//sticky tape
	var/obj/item/bodypart/head/HD = get_bodypart(BODY_ZONE_HEAD)
	if(!wear_mask && istype(HD) && HD.tapered)
		. += "<span class='warning'>[t_He] [t_has] \a <b><a href='?src=[REF(HD)];tape=[HD.tapered];'>[HD.tapered.get_examine_string(user)]</a></b> covering [t_his] mouth!</span>"

	//mask
	if(wear_mask && !(SLOT_WEAR_MASK in obscured))
		. += "[t_He] [t_has] [wear_mask.get_examine_string(user)] on [t_his] face."

	if(wear_neck && !(SLOT_NECK in obscured))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck."

	//eyes
	if(!(SLOT_GLASSES in obscured))
		if(glasses)
			. += "[t_He] [t_has] [glasses.get_examine_string(user)] covering [t_his] eyes."
		else if(eye_color == BLOODCULT_EYE && iscultist(src) && HAS_TRAIT(src, TRAIT_CULT_EYES))
			. += "<span class='warning'><B>[t_His] eyes are glowing an unnatural red!</B></span>"
		else if(HAS_TRAIT(src, TRAIT_HIJACKER))
			var/obj/item/implant/hijack/H = user.getImplant(/obj/item/implant/hijack)
			if (H && !H.stealthmode && H.toggled)
				. += "<b><font color=orange>[t_His] eyes are flickering a bright yellow!</font></b>"

	//ears
	if(ears && !(SLOT_EARS_LEFT in obscured)) //skyrat edit
		. += "[t_He] [t_has] [ears.get_examine_string(user)] on [t_his] left ear."
	
	//skyrat edit - extra ear slot haha
	if(ears_extra && !(SLOT_EARS_RIGHT in obscured))
		. += "[t_He] [t_has] [ears_extra.get_examine_string(user)] on [t_his] right ear."
	
	//wearing two ear items makes you look like an idiot
	if((istype(ears, /obj/item/radio/headset) && !(SLOT_EARS_LEFT in obscured)) && (istype(ears_extra, /obj/item/radio/headset) && !(SLOT_EARS_RIGHT in obscured)))
		. += "<span class='warning'>[t_He] looks quite tacky wearing both \an [ears.name] and \an [ears_extra.name] on [t_his] head.</span>"
	
	//

	//ID
	if(wear_id)
		. += "[t_He] [t_is] wearing [wear_id.get_examine_string(user)]."

	//Status effects
	if(!screwy_self)
		var/effects_exam = status_effect_examines()
		if(!isnull(effects_exam))
			. += effects_exam

	//CIT CHANGES START HERE - adds genital details to examine text
	if(LAZYLEN(internal_organs))
		for(var/obj/item/organ/genital/dicc in internal_organs)
			if(istype(dicc) && dicc.is_exposed())
				. |= dicc.genital_examine(user)

	var/cursed_stuff = attempt_vr(src,"examine_bellies",args) //vore Code
	if(cursed_stuff)
		. += cursed_stuff
	//END OF CIT CHANGES

	//Jitters
	if(!screwy_self)
		switch(jitteriness)
			if(300 to INFINITY)
				. += "<span class='warning'><B>[t_He] [t_is] convulsing violently!</B></span>"
			if(200 to 300)
				. += "<span class='warning'>[t_He] [t_is] extremely jittery.</span>"
			if(100 to 200)
				. += "<span class='warning'>[t_He] [t_is] twitching ever so slightly.</span>"

	var/temp = getBruteLoss() //no need to calculate each of these twice

	var/list/msg = list()

	if(client && client.prefs) // Skyrat Change
		if(client.prefs.toggles & VERB_CONSENT) // Skyrat Change
			. += "[t_His] player has allowed lewd verbs.\n" // Skyrat Change
		else // Skyrat Change
			. += "[t_His] player has not allowed lewd verbs.\n" // Skyrat Change

	var/list/missing = ALL_BODYPARTS
	var/list/disabled = list()
	if(!screwy_self)
		for(var/obj/item/bodypart/BP in bodyparts)
			//skyrat edit
			if(BP.is_disabled())
				disabled += BP
			for(var/obj/item/I in BP.embedded_objects)
			//skyrat edit
				if(I.isEmbedHarmless())
					msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] stuck to [t_his] [BP.name]!</B>\n"
				else
					msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] embedded in [t_his] [BP.name]!</B>\n"
			//
			if(BP.etching && !clothingonpart(BP))
				msg += "<B>[t_His] [BP.name] has \"[BP.etching]\" etched on it!</B>\n"
			for(var/datum/wound/W in BP.wounds)
				if(W.get_examine_description(user))
					msg += "[W.get_examine_description(user)]\n"
					if(istype(W, /datum/wound/slash/critical/incision))
						for(var/obj/item/organ/O in getorganszone(BP.body_zone))
							for(var/i in O.surgical_examine(user))
								msg += "<B>[icon2html(O.examine_icon ? O.examine_icon : O, user, O.examine_icon_state ? O.examine_icon_state : O.icon_state)] [i]</B>\n"
			//
			missing -= BP.body_zone

	if(!screwy_self)
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
	if(!screwy_self)
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

	if(!screwy_self && !(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor cellular damage.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> cellular damage!\n"
			else
				msg += "<b>[t_He] [t_has] severe cellular damage!</b>\n"

	if(!screwy_self)
		if(fire_stacks > 0)
			msg += "[t_He] [t_is] covered in something flammable.\n"
		if(fire_stacks < 0)
			msg += "[t_He] look[p_s()] a little soaked.\n"


	if(pulledby && pulledby.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] [t_is] severely malnourished.\n"
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy.\n"
		else
			msg += "[t_He] [t_is] quite chubby.\n"
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out.\n"
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out.\n"
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted.\n"
	if(!screwy_self)
		if(ShowAsPaleExamine())
			var/apparent_blood_volume = blood_volume
			switch(apparent_blood_volume)
				if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
					msg += "[t_He] [t_has] pale skin.\n"
				if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
					msg += "<b>[t_He] look[p_s()] like pale death.</b>\n"
				if(-INFINITY to BLOOD_VOLUME_BAD)
					msg += "<span class='deadsay'><b>[t_He] resemble[p_s()] a crushed, empty juice pouch.</b></span>\n"
	
	var/bleed_text
	var/list/obj/item/bodypart/bleeding_limbs = list()
	var/list/obj/item/bodypart/grasped_limbs = list()
	if(!screwy_self)
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
		
		if(reagents.has_reagent(/datum/reagent/teslium))
			msg += "[t_He] [t_is] emitting a gentle blue glow!\n"

		if(islist(stun_absorption))
			for(var/i in stun_absorption)
				if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
					msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]\n"

		if(drunkenness && !skipface && !(stat == DEAD)) //Drunkenness
			switch(drunkenness)
				if(11 to 21)
					msg += "[t_He] [t_is] slightly flushed.\n"
				if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
					msg += "[t_He] [t_is] flushed.\n"
				if(41.01 to 51)
					msg += "[t_He] [t_is] quite flushed and [t_his] breath smells of alcohol.\n"
				if(51.01 to 61)
					msg += "[t_He] [t_is] very flushed and [t_his] movements jerky, with breath reeking of alcohol.\n"
				if(61.01 to 91)
					msg += "[t_He] look[p_s()] like a drunken mess.\n"
				if(91.01 to INFINITY)
					msg += "[t_He] [t_is] a shitfaced, slobbering wreck.\n"

		if(reagents.has_reagent(/datum/reagent/fermi/astral))
			if(mind)
				msg += "[t_He] has wild, spacey eyes and they have a strange, abnormal look to them.\n"
			else
				msg += "[t_He] has wild, spacey eyes and they don't look like they're all there.\n"

	if(isliving(user))
		var/mob/living/L = user
		if(src != user && HAS_TRAIT(L, TRAIT_EMPATH) && !(stat != CONSCIOUS))
			if (a_intent != INTENT_HELP)
				msg += "[t_He] seem[p_s()] to be on guard.\n"
			if (getOxyLoss() >= 10)
				msg += "[t_He] seem[p_s()] winded.\n"
			if (getToxLoss() >= 10)
				msg += "[t_He] seem[p_s()] sickly.\n"
			var/datum/component/mood/mood = GetComponent(/datum/component/mood)
			if(mood.sanity <= SANITY_DISTURBED)
				msg += "[t_He] seem[p_s()] distressed.\n"
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empath", /datum/mood_event/sad_empath, src)
			if(mood.shown_mood >= 6) //So roundstart people aren't all "happy" and that antags don't show their true happiness.
				msg += "[t_He] seem[p_s()] to have had something nice happen to them recently.\n"
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empathH", /datum/mood_event/happy_empath, src)
			if (HAS_TRAIT(src, TRAIT_BLIND))
				msg += "[t_He] appear[p_s()] to be staring off into space.\n"
			if (HAS_TRAIT(src, TRAIT_DEAF))
				msg += "[t_He] appear[p_s()] to not be responding to noises.\n"

	var/obj/item/organ/vocal_cords/Vc = user.getorganslot(ORGAN_SLOT_VOICE)
	if(Vc)
		if(istype(Vc, /obj/item/organ/vocal_cords/velvet))
			if(client.prefs.cit_toggles & HYPNO)
				msg += "<span class='velvet'><i>You feel your chords resonate looking at them.</i></span>\n"

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
	if(!screwy_self)
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
		
		if((consciousness != LOOKS_DEAD) && getorgan(/obj/item/organ/brain))
			if(!key)
				. += "<span class='deadsay'>[t_He] [t_is] totally catatonic. The stresses of life in deep-space must have been too much for [t_him]. Any recovery is unlikely.</span>\n"
			else if(!client)
				. += "[t_He] [t_has] a blank, absent-minded stare and [t_has] been completely unresponsive to anything for [round(((world.time - lastclienttime) / (1 MINUTES)),1)] minutes. [t_He] may snap out of it soon.\n" //SKYRAT CHANGE - ssd indicator
		
		if(consciousness_msg)
			. += consciousness_msg
	//

	//Skyrat changes begin
	var/scar_severity = 0
	if(!screwy_self)
		for(var/i in all_scars)
			var/datum/scar/S = i
			if(istype(S) && S.is_visible(checkviewer = FALSE))
				scar_severity += (S.severity/2)

		switch(scar_severity)
			if(WOUND_SEVERITY_TRIVIAL)
				msg += "<span class='smallnotice'><i>[t_He] [t_has] visible scarring, you can look again to take a closer look...</i></span>\n"
			if(WOUND_SEVERITY_MODERATE to WOUND_SEVERITY_SEVERE)
				msg += "<span class='notice'><i>[t_He] [t_has] several bad scars, you can look again to take a closer look...</i></span>\n"
			if(WOUND_SEVERITY_CRITICAL to WOUND_SEVERITY_PERMANENT)
				msg += "<span class='notice'><b><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></b></span>\n"
			if(WOUND_SEVERITY_LOSS to INFINITY)
				msg += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>\n"

	if(gunpointing)
		msg += "<b>[t_He] [t_is] holding [gunpointing.target.name] at gunpoint with [gunpointing.aimed_gun.name]!</b>\n"
	if(gunpointed.len)
		for(var/datum/gunpoint/GP in gunpointed)
			msg += "<b>[GP.source.name] [GP.source.p_are()] holding [t_him] at gunpoint with [GP.aimed_gun.name]!</b>\n"
	
	//Skyrat changes end

	if(length(msg))
		. += "<span class='warning'>[msg.Join("")]</span>"

	var/trait_exam = common_trait_examine()
	if(!screwy_self)
		if(!isnull(trait_exam))
			. += trait_exam

	var/traitstring = get_trait_string()
	if(ishuman(user))
		var/obj/item/organ/cyberimp/eyes/hud/CIH = H.getorgan(/obj/item/organ/cyberimp/eyes/hud)
		if(istype(H.glasses, /obj/item/clothing/glasses/hud) || CIH)
			var/perpname = get_face_name(get_id_name(""))
			if(perpname)
				var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
				if(R)
					. += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]\n<a href='?src=[REF(src)];hud=1;photo_front=1'>\[Front photo\]</a><a href='?src=[REF(src)];hud=1;photo_side=1'>\[Side photo\]</a>"
				if(istype(H.glasses, /obj/item/clothing/glasses/hud/health) || istype(CIH, /obj/item/organ/cyberimp/eyes/hud/medical))
					var/list/cyberimp_detect = list()
					for(var/obj/item/organ/cyberimp/CI in internal_organs)
						if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
							cyberimp_detect += "[name] is modified with a [CI.name]."
					if(length(cyberimp_detect))
						. += "Detected cybernetic modifications:"
						. += cyberimp_detect.Join("<BR>")
					if(R)
						var/health_r = R.fields["p_stat"]
						. += "<a href='?src=[REF(src)];hud=m;p_stat=1'>\[[health_r]\]</a>"
						health_r = R.fields["m_stat"]
						. += "<a href='?src=[REF(src)];hud=m;m_stat=1'>\[[health_r]\]</a>"
					R = find_record("name", perpname, GLOB.data_core.medical)
					if(R)
						. += "<a href='?src=[REF(src)];hud=m;evaluation=1'>\[Medical evaluation\]</a>"
					if(traitstring)
						. += "<span class='info'>Detected physiological traits:\n[traitstring]</span>"



				if(istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(CIH, /obj/item/organ/cyberimp/eyes/hud/security))
					if(!user.stat && user != src)
					//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
						var/criminal = "None"

						R = find_record("name", perpname, GLOB.data_core.security)
						if(R)
							criminal = R.fields["criminal"]

						. += jointext(list("<span class='deptradio'>Criminal status:</span> <a href='?src=[REF(src)];hud=s;status=1'>\[[criminal]\]</a>",
							"<span class='deptradio'>Security record:</span> <a href='?src=[REF(src)];hud=s;view=1'>\[View\]</a>",
							"<a href='?src=[REF(src)];hud=s;add_crime=1'>\[Add crime\]</a>",
							"<a href='?src=[REF(src)];hud=s;view_comment=1'>\[View comment log\]</a>",
							"<a href='?src=[REF(src)];hud=s;add_comment=1'>\[Add comment\]</a>"), "")
	else if(isobserver(user) && traitstring)
		. += "<span class='info'><b>Traits:</b> [traitstring]</span>"

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .) //This also handles flavor texts now
	var/invisible_man = skipface || get_visible_name() == "Unknown" // SKYRAT EDIT -- BEGIN
	if(!invisible_man)
		if(client)
			. += "OOC Notes: <a href='?src=[REF(src)];skyrat_ooc_notes=1'>\[View\]</a>" // SKYRAT EDIT -- END
	//SKYRAT EDIT - admin lookup on records/extra flavor
	if(client)
		var/list/line = list()
		if(user.client?.holder && isobserver(user))
			if(client.prefs.general_records)
				line += "<a href='?src=[REF(src)];general_records=1'>\[GEN\]</a>"
			if(client.prefs.security_records)
				line += "<a href='?src=[REF(src)];security_records=1'>\[SEC\]</a>"
			if(client.prefs.medical_records)
				line += "<a href='?src=[REF(src)];medical_records=1'>\[MED\]</a>"
			if(client.prefs.flavor_background)
				line += "<a href='?src=[REF(src)];flavor_background=1'>\[BG\]</a>"
			if(client.prefs.character_skills)
				line += "<a href='?src=[REF(src)];character_skills=1'>\[SKL\]</a>"
			if(client.prefs.exploitable_info)
				line += "<a href='?src=[REF(src)];exploitable_info=1'>\[EXP\]</a>"
		else if(user.mind?.antag_datums && client.prefs.exploitable_info)
			for(var/a in user.mind.antag_datums)
				var/datum/antagonist/curious_antag = a
				if(!(curious_antag.antag_flags & CAN_SEE_EXPOITABLE_INFO))
					continue
				line += "<a href='?src=[REF(src)];exploitable_info=1'>\[Exploitable Info\]</a>"
				break

		. += line.Join()
	//END OF SKYRAT EDIT
	. += "*---------*</span>"

/mob/living/proc/status_effect_examines(pronoun_replacement) //You can include this in any mob's examine() to show the examine texts of status effects!
	var/list/dat = list()
	if(!pronoun_replacement)
		pronoun_replacement = p_they(TRUE)
	for(var/V in status_effects)
		var/datum/status_effect/E = V
		if(E.examine_text)
			var/new_text = replacetext(E.examine_text, "SUBJECTPRONOUN", pronoun_replacement)
			new_text = replacetext(new_text, "[pronoun_replacement] is", "[pronoun_replacement] [p_are()]") //To make sure something become "They are" or "She is", not "They are" and "She are"
			dat += "[new_text]\n" //dat.Join("\n") doesn't work here, for some reason
	if(dat.len)
		return dat.Join()

//skyrat edit - baystation descriptors, examine more stuff
/mob/living/carbon/human/proc/show_descriptors_to(mob/user)
	. = list()
	if(LAZYLEN(dna?.species?.descriptors))
		if(user == src)
			for(var/entry in dna.species.descriptors)
				//currently using third person for consistency, but in the future i might make it so that
				//examining yourself is first person across the board.
				var/datum/mob_descriptor/descriptor = dna.species.descriptors[entry]
				. += "<span class='info'><b>[descriptor.get_third_person_message_start(src)] [descriptor.get_standalone_value_descriptor(descriptor.current_value)].</b></span>"
		else
			for(var/entry in dna.species.descriptors)
				var/datum/mob_descriptor/descriptor = dna.species.descriptors[entry]
				. += "<span class='info'></b>[descriptor.get_comparative_value_descriptor(src, user, descriptor.current_value)]</b></span>"

/mob/living/carbon/human/examine_more(mob/user)
	var/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
	for(var/i in show_descriptors_to(user))
		msg |= "\t[i]"
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
			msg += "\t[scar_text]"
	
	if(!length(visible_scars))
		msg += "\t<span class='smallnotice'><i>[p_they(TRUE)] [p_have()] no visible scars.</i></span>"
	
	return msg
//
