/datum/reagent/toxin/plasma
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/toxin/acid
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/toxin/chloralhydrate
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Chloral hydrate, tirizene and mute toxin are contents of sleeping pen. Probably up to debate whether synths should or should not be affected by such things, maybe sleepy pen should have a unique chem so chloral won't work on synths

/datum/reagent/toxin/staminatoxin
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/toxin/mutetoxin
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/plasma/on_mob_life(mob/living/carbon/C)
	if(C.isRobotic())
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..() 

/datum/reagent/toxin/bonehurtingjuice //oof ouch
	name = "Bone Hurting Juice"
	description = "A strange substance that looks a lot like water. Drinking it is oddly tempting. Oof ouch."
	color = "#AAAAAA77" //RGBA: 170, 170, 170, 77
	toxpwr = 0
	taste_description = "bone hurting"
	overdose_threshold = 25
	value = REAGENT_VALUE_EXCEPTIONAL //because it's very funny.
	var/maxhurt = 4 //how many bones it can hurt before going useless on overdosing
	var/count = 0
	var/hurtchance = 0.75 //multiplier for chance to hurt a bone on each process while overdosing (amount of juice in the body * hurtchance)

/datum/reagent/toxin/bonehurtingjuice/on_mob_add(mob/living/carbon/M)
	M.say("oof ouch my bones", forced = /datum/reagent/toxin/bonehurtingjuice)

/datum/reagent/toxin/bonehurtingjuice/on_mob_life(mob/living/carbon/M)
	M.adjustStaminaLoss(7.5, 0)
	if(HAS_TRAIT(M, TRAIT_CALCIUM_HEALER))
		M.adjustBruteLoss(3.5, 0)
	if(prob(12))
		switch(rand(1, 3))
			if(1)
				var/list/possible_says = list("oof.", "ouch!", "my bones.", "oof ouch.", "oof ouch my bones.")
				M.say(pick(possible_says), forced = /datum/reagent/toxin/bonehurtingjuice)
			if(2)
				var/list/possible_mes = list("oofs softly.", "looks like their bones hurt.", "grimaces, as though their bones hurt.")
				M.say("*custom " + pick(possible_mes), forced = /datum/reagent/toxin/bonehurtingjuice)
			if(3)
				to_chat(M, "<span class='warning'>Your bones hurt!</span>")
	return ..()

/datum/reagent/toxin/bonehurtingjuice/overdose_process(mob/living/carbon/M)
	if(prob(M.reagents.get_reagent_amount(/datum/reagent/toxin/bonehurtingjuice) * hurtchance) && iscarbon(M) && (count < maxhurt)) //big oof
		var/selected_part = pick(ALL_BODYPARTS)
		var/obj/item/bodypart/bp = M.get_bodypart(selected_part)
		if(M.dna.species.type != /datum/species/skeleton || M.dna.species.type != /datum/species/plasmaman || M.dna.species.type != /datum/species/golem/bone) //We're so sorry skeletons, you're so misunderstood
			if(bp)
				playsound(M, get_sfx("desceration"), 50, TRUE, -1)
				M.visible_message("<span class='warning'>[M]'s bones hurt too much!!</span>", "<span class='danger'>Your bones hurt too much!!</span>")
				M.say("OOF!!", forced = /datum/reagent/toxin/bonehurtingjuice)
				var/datum/wound/blunt/severe/W = new()
				W.apply_wound(bp)
				count++
			else //SUCH A LUST FOR REVENGE!!!
				to_chat(M, "<span class='warning'>A phantom limb hurts!</span>")
				M.say("Why are we still here, just to suffer?", forced = /datum/reagent/toxin/bonehurtingjuice)
		else //you just want to socialize
			if(bp)
				playsound(M, get_sfx("desceration"), 50, TRUE, -1)
				M.visible_message("<span class='warning'>[M] rattles loudly and flails around!!</span>", "<span class='danger'>Your bones hurt so much that your missing muscles spasm!!</span>")
				M.say("OOF!!", forced=/datum/reagent/toxin/bonehurtingjuice)
				var/datum/wound/blunt/severe/W = new()
				W.apply_wound(bp)
				count++
				if(!(bp.body_zone in ORGAN_BODYPARTS))
					bp.dismember()
			else
				to_chat(M, "<span class='warning'>Your missing arm aches from wherever you left it.</span>")
				M.emote("sigh")
	return ..()
