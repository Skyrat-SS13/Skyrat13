/datum/species
	var/list/bloodtypes = list() //If a race has more than one possible bloodtype, set it here. If you input a non-existant (in game terms) blood type i am going to smack you.
	var/list/bloodreagents = list() //If a race has more than one possible blood reagent, set it here. Note: Do not use the datums themselves, use their names.
	var/rainbowblood = FALSE //Set to true if this race can have blood colors different from the default one.
	var/clonemod = 1
	var/toxmod = 1
	var/revivesbyhealreq = 0 //They need to pass that health number to revive if they possess the REVIVESBYHEALING trait
	var/reagent_flags = PROCESS_ORGANIC //Used for metabolizing reagents. We're going to assume you're a meatbag unless you say otherwise.
	var/icon_eyes = 'icons/mob/human_face.dmi'
	var/list/languagewhitelist = list()
	var/list/descriptors = list(
		/datum/mob_descriptor/height = "default",
		/datum/mob_descriptor/build = "default",
	)
	var/static/list/pain_emote_by_power = list(
	"100" = "agonyscream",
	"90" = "whimper",
	"80" = "moan",
	"70" = "cry",
	"60" = "gargle",
	"50" = "moan",
	"40" = "moan",
	"30" = "groan",
	"20" = "groan",
	"10" = "grunt", //Below 10 pain, we shouldn't emote.
	)
	var/static/list/cry_male = list(
	'modular_skyrat/sound/gore/cry_male1.ogg',
	'modular_skyrat/sound/gore/cry_male2.ogg',
	'modular_skyrat/sound/gore/cry_male3.ogg',
	'modular_skyrat/sound/gore/cry_male4.ogg',
	)
	var/static/list/cry_female = list(
	'modular_skyrat/sound/gore/cry_female1.ogg',
	'modular_skyrat/sound/gore/cry_female2.ogg',
	'modular_skyrat/sound/gore/cry_female3.ogg',
	'modular_skyrat/sound/gore/cry_female4.ogg',
	'modular_skyrat/sound/gore/cry_female5.ogg',
	'modular_skyrat/sound/gore/cry_female6.ogg',
	)
	var/static/list/coughs_male = list(
	'modular_skyrat/sound/gore/cough_male1.ogg',
	'modular_skyrat/sound/gore/cough_male2.ogg',
	'modular_skyrat/sound/gore/cough_male3.ogg',
	'modular_skyrat/sound/gore/cough_male4.ogg',
	'modular_skyrat/sound/gore/cough_male5.ogg',
	'modular_skyrat/sound/gore/cough_male6.ogg',
	'modular_skyrat/sound/gore/cough_male7.ogg',
	'modular_skyrat/sound/gore/cough_male8.ogg',
	'modular_skyrat/sound/gore/cough_male9.ogg',
	'modular_skyrat/sound/gore/cough_male10.ogg',
	'modular_skyrat/sound/gore/cough_male11.ogg',
	'modular_skyrat/sound/gore/cough_male12.ogg',
	'modular_skyrat/sound/gore/cough_male13.ogg',
	)
	var/static/list/coughs_female = list(
	'modular_skyrat/sound/gore/cough_female1.ogg',
	'modular_skyrat/sound/gore/cough_female2.ogg',
	'modular_skyrat/sound/gore/cough_female3.ogg',
	'modular_skyrat/sound/gore/cough_female4.ogg',
	'modular_skyrat/sound/gore/cough_female5.ogg',
	'modular_skyrat/sound/gore/cough_female6.ogg',
	)
	var/static/list/agony_sounds_male = list(
	'modular_skyrat/sound/gore/agony_male1.ogg',
	'modular_skyrat/sound/gore/agony_male2.ogg',
	'modular_skyrat/sound/gore/agony_male3.ogg',
	'modular_skyrat/sound/gore/agony_male4.ogg',
	'modular_skyrat/sound/gore/agony_male5.ogg',
	'modular_skyrat/sound/gore/agony_male6.ogg',
	'modular_skyrat/sound/gore/agony_male7.ogg',
	'modular_skyrat/sound/gore/agony_male8.ogg',
	'modular_skyrat/sound/gore/agony_male9.ogg',
	'modular_skyrat/sound/gore/agony_male10.ogg',
	'modular_skyrat/sound/gore/agony_male11.ogg',
	'modular_skyrat/sound/gore/agony_male12.ogg',
	'modular_skyrat/sound/gore/agony_male13.ogg',
	'modular_skyrat/sound/gore/concorado_scream.ogg',
	)
	var/static/list/agony_sounds_female = list(
	'modular_skyrat/sound/gore/agony_female1.ogg',
	'modular_skyrat/sound/gore/agony_female2.ogg',
	'modular_skyrat/sound/gore/agony_female3.ogg',
	'modular_skyrat/sound/gore/agony_female4.ogg',
	'modular_skyrat/sound/gore/agony_female5.ogg',
	'modular_skyrat/sound/gore/agony_female6.ogg',
	'modular_skyrat/sound/gore/agony_female7.ogg',
	'modular_skyrat/sound/gore/agony_female8.ogg',
	)
	var/static/list/agony_gasps_male = list(
	'modular_skyrat/sound/gore/gasp_male1.ogg',
	'modular_skyrat/sound/gore/gasp_male2.ogg',
	'modular_skyrat/sound/gore/gasp_male3.ogg',
	'modular_skyrat/sound/gore/gasp_male4.ogg',
	'modular_skyrat/sound/gore/gasp_male5.ogg',
	'modular_skyrat/sound/gore/gasp_male6.ogg',
	'modular_skyrat/sound/gore/gasp_male7.ogg',
	)
	var/static/list/agony_gasps_female = list(
	'modular_skyrat/sound/gore/gasp_female1.ogg',
	'modular_skyrat/sound/gore/gasp_female2.ogg',
	'modular_skyrat/sound/gore/gasp_female3.ogg',
	'modular_skyrat/sound/gore/gasp_female4.ogg',
	'modular_skyrat/sound/gore/gasp_female5.ogg',
	'modular_skyrat/sound/gore/gasp_female6.ogg',
	'modular_skyrat/sound/gore/gasp_female7.ogg',
	)
	var/static/list/agony_moans_male = list(
	'modular_skyrat/sound/gore/male_moan1.ogg',
	'modular_skyrat/sound/gore/male_moan2.ogg',
	'modular_skyrat/sound/gore/male_moan3.ogg',
	'modular_skyrat/sound/gore/male_moan4.ogg',
	'modular_skyrat/sound/gore/male_moan5.ogg',
	)
	var/static/list/agony_moans_female = list(
	'modular_skyrat/sound/gore/female_moan1.ogg',
	'modular_skyrat/sound/gore/female_moan2.ogg',
	'modular_skyrat/sound/gore/female_moan3.ogg',
	'modular_skyrat/sound/gore/female_moan4.ogg',
	'modular_skyrat/sound/gore/female_moan5.ogg',
	'modular_skyrat/sound/gore/female_moan6.ogg',
	'modular_skyrat/sound/gore/female_moan7.ogg',
	'modular_skyrat/sound/gore/female_moan8.ogg',
	)
	var/static/list/death_rattles_male = list(
	'modular_skyrat/sound/gore/deathgasp_male1.ogg',
	)
	var/static/list/death_rattles_female = list(
	'modular_skyrat/sound/gore/deathgasp_male1.ogg',
	)
	var/kick_verb = "kick"
	var/bite_verb = "bite"

/datum/species/proc/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, forced = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE)
	var/hit_percent = (100-(blocked+armor))/100
	hit_percent = (hit_percent * (100-H.physiology.damage_resistance))/100
	if(!forced && hit_percent <= 0)
		return 0

	var/obj/item/bodypart/BP = null
	if(isbodypart(def_zone))
		BP = def_zone
	else
		if(def_zone)
			def_zone = ran_zone(def_zone)
			BP = H.get_bodypart(check_zone(def_zone))

	switch(damagetype)
		if(BRUTE)
			H.damageoverlaytemp = 20
			var/damage_amount = forced ? damage : damage * hit_percent * brutemod * H.physiology.brute_mod
			if(BP)
				if(damage > 0 ? BP.receive_damage(brute = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(abs(damage_amount), 0))
					H.update_damage_overlays()

			else//no bodypart, we deal damage with a more general method.
				H.adjustBruteLoss(damage_amount)
		if(BURN)
			H.damageoverlaytemp = 20
			var/damage_amount = forced ? damage : damage * hit_percent * burnmod * H.physiology.burn_mod
			if(BP)
				if(damage > 0 ? BP.receive_damage(burn = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(0, abs(damage_amount)))
					H.update_damage_overlays()
			else
				H.adjustFireLoss(damage_amount)
		if(TOX)
			var/damage_amount = forced ? damage : damage * hit_percent * toxmod * H.physiology.tox_mod
			H.adjustToxLoss(damage_amount)
			if((H.health > revivesbyhealreq) && (REVIVESBYHEALING in species_traits))
				if((NOBLOOD in species_traits) || (H.blood_volume >= BLOOD_VOLUME_OKAY))
					H.revive(0)
					H.cure_husk(0)
		if(OXY)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.oxy_mod
			H.adjustOxyLoss(damage_amount)
			if((H.health > revivesbyhealreq) && (REVIVESBYHEALING in species_traits))
				if((NOBLOOD in species_traits) || (H.blood_volume >= BLOOD_VOLUME_OKAY))
					H.revive(0)
					H.cure_husk(0)
		if(CLONE)
			var/damage_amount = forced ? damage : damage * hit_percent * clonemod * H.physiology.clone_mod
			H.adjustCloneLoss(damage_amount)
			if((H.health > revivesbyhealreq) && (REVIVESBYHEALING in species_traits))
				if((NOBLOOD in species_traits) || (H.blood_volume >= BLOOD_VOLUME_OKAY))
					H.revive(0)
					H.cure_husk(0)
		if(STAMINA)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.stamina_mod
			if(BP)
				if(damage > 0 ? BP.receive_damage(stamina = damage_amount, wound_bonus = wound_bonus, bare_wound_bonus = bare_wound_bonus, sharpness = sharpness) : BP.heal_damage(0, 0, abs(damage * hit_percent * H.physiology.stamina_mod), only_robotic = FALSE, only_organic = FALSE))
					H.update_stamina()
			else
				H.adjustStaminaLoss(damage_amount)
		if(BRAIN)
			var/damage_amount = forced ? damage : damage * hit_percent * H.physiology.brain_mod
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, damage_amount)
	return 1

/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return

/datum/species/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(ROBOTIC_LIMBS in species_traits)
		for(var/obj/item/bodypart/B in C.bodyparts)
			B.change_bodypart_status(BODYPART_ROBOTIC, FALSE, TRUE) // Makes all Bodyparts robotic.
			B.render_like_organic = TRUE

	if(TRAIT_TOXIMMUNE in inherent_traits)
		C.setToxLoss(0, TRUE, TRUE)

/datum/species/on_species_loss(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(ROBOTIC_LIMBS in species_traits)
		for(var/obj/item/bodypart/B in C.bodyparts)
			B.change_bodypart_status(BODYPART_ORGANIC, FALSE, TRUE)
			B.render_like_organic = FALSE

/datum/species/proc/get_pain_emote(power)
	if((NOPAIN in species_traits) || (ROBOTIC_LIMBS in species_traits)) //Synthetics don't grunt because of "pain"
		return
	power = round(min(100, power), 10)
	var/emote_string
	if(power >= PAIN_EMOTE_MINIMUM)
		emote_string = pain_emote_by_power["[power]"]
	return emote_string

/datum/species/proc/agony_scream(var/mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("agonyscream")

/datum/species/proc/agony_gargle(var/mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("gargle")

/datum/species/proc/agony_gasp(var/mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("agonygasp")

/datum/species/proc/death_rattle(var/mob/living/carbon/human/H)
	if(!istype(H))
		return FALSE
	H.emote("deathrattle")

//Kicking
/datum/species/proc/kick(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(!attacker_style && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to harm [target]!</span>")
		return FALSE
	if(IS_STAMCRIT(user))
		to_chat(user, "<span class='warning'>You're too exhausted.</span>")
		return FALSE
	if(target.check_martial_melee_block())
		target.visible_message("<span class='warning'>[target] blocks [user]'s attack!</span>", target = user, \
			target_message = "<span class='warning'>[target] blocks your attack!</span>")
		return FALSE

	if(target.mind?.handle_parry(target, null, 0, user))
		playsound(get_turf(target), 'modular_skyrat/sound/attack/parry.ogg', 70)
		var/held_item
		if(target.get_active_held_item())
			held_item = " with [target.p_their()] [target.get_active_held_item()]"
		else
			held_item = " with [target.p_their()] bare hands"
		target.visible_message("<span class='danger'>[target] blocks [user][held_item]!</span>")
		return FALSE

	if(target.mind?.handle_dodge(target, null, 0, user))
		//Make the victim step to an adjacent tile because ooooooh dodge
		var/list/turf/dodge_turfs = list()
		for(var/turf/open/O in range(1,target))
			if(target.CanReach(O))
				dodge_turfs += O
		//No available turfs == we can't actually dodge
		if(length(dodge_turfs))
			var/turf/yoink = pick(dodge_turfs)
			//We moved to the tile, therefore we parried successfully
			if(target.Move(yoink, get_dir(target, yoink)))
				playsound(get_turf(target), miss_sound, 70)
				target.visible_message("<span class='danger'>[target] dodges [user]!</span>")
				return FALSE

	//Kicks drain double the stamina
	if(HAS_TRAIT(user, TRAIT_PUGILIST))
		user.adjustStaminaLossBuffered(3)
	else
		user.adjustStaminaLossBuffered(7)

	if(attacker_style && attacker_style.harm_act(user,target))
		return TRUE
	else
		var/atk_verb = user.dna.species.kick_verb
		switch(atk_verb)
			if(ATTACK_EFFECT_KICK)
				user.do_attack_animation(target, ATTACK_EFFECT_KICK)
			if(ATTACK_EFFECT_CLAW)
				user.do_attack_animation(target, ATTACK_EFFECT_CLAW)
			if(ATTACK_EFFECT_SMASH)
				user.do_attack_animation(target, ATTACK_EFFECT_SMASH)
			else
				user.do_attack_animation(target, ATTACK_EFFECT_PUNCH)

		var/damage = (user.dna.species.punchdamagelow + user.dna.species.punchdamagehigh)/2

		//Kicks deal 2x the normal damage of punches
		damage *= 2

		//Raw damage is affected by the user's strength
		var/str_mod = 1
		if(user.mind)
			str_mod = user.mind.get_skillstat_damagemod(STAT_DATUM(str))
		damage *= str_mod

		//Combat intents change how much your boot deals
		var/c_intent = user.combat_intent
		switch(c_intent)
			if(CI_STRONG)
				damage *= 1.5 //fuck it
			if(CI_WEAK)
				damage *= 0.25

		var/kickedstam = target.getStaminaLoss()
		var/kickedbrute = target.getBruteLoss()

		//CITADEL CHANGES - makes resting and disabled combat mode reduce punch damage, makes being out of combat mode result in you taking more damage
		if(SEND_SIGNAL(target, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_INACTIVE))
			damage *= 1.1
		if(!CHECK_MOBILITY(user, MOBILITY_STAND))
			damage *= 0.5 //Kicking while down? Not very effective.
		if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_INACTIVE))
			damage *= 0.9
		//END OF CITADEL CHANGES

		//If the user has bad st, sometimes... the attack gets really shit
		var/pitiful = FALSE
		if(user.mind && GET_STAT_LEVEL(user, str) < 10)
			switch(user.mind.diceroll(STAT_DATUM(str)))
				if(DICE_CRIT_FAILURE)
					damage *= 0.4
					pitiful = TRUE
		
		//The probability of hitting the correct zone depends on dexterity
		//and also on which limb we aim at
		//since this is a kick, chance to miss is almost doubled
		var/obj/item/bodypart/supposed_to_affect = target.get_bodypart(user.zone_selected)
		var/ran_zone_prob = 35
		var/extra_zone_prob = 25
		if(supposed_to_affect)
			ran_zone_prob = supposed_to_affect.zone_prob * 0.75
			extra_zone_prob = supposed_to_affect.extra_zone_prob * 0.5
		if(user.mind)
			var/datum/stats/dex/dex = GET_STAT(user, dex)
			if(dex)
				ran_zone_prob = dex.get_ran_zone_prob(ran_zone_prob, extra_zone_prob)

		//Aimed combat intent means we almost never miss, at the cost of stamina
		//we deduct stamina later down, based on endurance
		switch(c_intent)
			if(CI_AIMED)
				ran_zone_prob = 100
				if(user.mind)
					var/datum/stats/dex/dex = GET_STAT(user, dex)
					if(dex)
						ran_zone_prob = 80 + dex.level
		
		//Get the bodypart we actually affect
		var/obj/item/bodypart/affecting = target.get_bodypart(ran_zone(user.zone_selected, ran_zone_prob))

		var/missed = FALSE
		//Dice roll to see if we fuck up
		if(user.mind && user.mind.diceroll(GET_STAT_LEVEL(user, dex)*0.3, GET_SKILL_LEVEL(user, melee)*0.7) <= DICE_CRIT_FAILURE)
			missed = TRUE
		//Aimed combat intent means we never miss, at the cost of stamina
		switch(c_intent)
			if(CI_AIMED)
				missed = FALSE
				var/endurance_mod = 1
				if(user.mind)
					var/datum/stats/end = GET_STAT(user, dex)
					endurance_mod = round((MAX_STAT/2)/end.level, 0.1)
				user.adjustStaminaLoss(7 * endurance_mod)

		if(!damage || !affecting || (missed && target != user))//future-proofing for species that have 0 damage/weird cases where no zone is targeted
			playsound(target.loc, user.dna.species.miss_sound, 25, TRUE, -1)
			target.visible_message("<span class='danger'>[user]'s [atk_verb] misses [target]!</span>", \
							"<span class='danger'>You avoid [user]'s [atk_verb]!</span>", "<span class='hear'>You hear a swoosh!</span>", COMBAT_MESSAGE_RANGE, null, \
							user, "<span class='warning'>Your [atk_verb] misses [target]!</span>")
			log_combat(user, target, "attempted to punch")
			return FALSE


		var/armor_block = target.run_armor_check(affecting, "melee")

		playsound(target.loc, user.dna.species.attack_sound, 25, 1, -1)

		target.lastattacker = user.real_name
		target.lastattackerckey = user.ckey
		user.dna.species.spec_unarmedattacked(user, target)

		if(user.limb_destroyer)
			target.dismembering_strike(user, affecting.body_zone)

		
		target.apply_damage(damage, BRUTE, affecting, armor_block)
		target.apply_damage(damage*2, STAMINA, affecting, armor_block)
		log_combat(user, target, "kicked")
		
		//Knockdown and stuff
		target.do_stat_effects(user, null, damage)

		//Attack message
		target.visible_message("<span class='danger'>[user][pitiful ? " pitifully" : ""] [atk_verb]s [target] on their [affecting.name]![target.wound_message]</span>", \
					"<span class='userdanger'>[user][pitiful ? " pitifully" : ""] [atk_verb]s you on your [affecting.name]![target.wound_message]</span>", null, COMBAT_MESSAGE_RANGE, null, \
					user, "<span class='danger'>You[pitiful ? " pitifully" : ""] [atk_verb] [target] on their [affecting.name]![target.wound_message]</span>")
		
		//Clean the descriptive string
		target.wound_message = ""
		
		if((target.stat != DEAD) && damage >= (user.dna.species.punchstunthreshold*1.5))
			if((kickedstam > 50) && prob(kickedstam*0.5)) //If our punch victim has been hit above the threshold, and they have more than 50 stamina damage, roll for stun, probability of 1% per 2 stamina damage
				target.visible_message("<span class='danger'>[user] knocks [target] down!</span>", \
								"<span class='userdanger'>You're knocked down by [user]!</span>",
								"<span class='hear'>You hear aggressive shuffling followed by a loud thud!</span>", COMBAT_MESSAGE_RANGE, null,
								user, "<span class='danger'>You knock [target] down!</span>")

				var/knockdown_duration = 40 + (kickedstam + (kickedbrute*0.5))*0.8 - armor_block
				target.DefaultCombatKnockdown(knockdown_duration)
				target.forcesay(GLOB.hit_appends)
				log_combat(user, target, "got a stun punch with their previous punch")

				if(HAS_TRAIT(user, TRAIT_KI_VAMPIRE) && !HAS_TRAIT(target, TRAIT_NOBREATH) && (kickedbrute < 100)) //If we're a ki vampire we also sap them of lifeforce, but only if they're not too beat up. Also living organics only.
					user.adjustBruteLoss(-5)
					user.adjustFireLoss(-5)
					user.adjustStaminaLoss(-20)

					target.adjustCloneLoss(10)
					target.adjustBruteLoss(10)

		else if(!(target.mobility_flags & MOBILITY_STAND))
			target.forcesay(GLOB.hit_appends)

//Biting
/datum/species/proc/bite(mob/living/carbon/human/user, mob/living/carbon/human/target, datum/martial_art/attacker_style)
	if(!attacker_style && HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to harm [target]!</span>")
		return FALSE
	if(IS_STAMCRIT(user))
		to_chat(user, "<span class='warning'>You're too exhausted.</span>")
		return FALSE
	//British people don't bite
	var/obj/item/bodypart/teeth_part = user.get_bodypart(BODY_ZONE_HEAD)
	if(!teeth_part || !teeth_part.get_teeth_amount())
		to_chat(user, "<span class='warning'>You can't bite without teeth!</span>")
		return FALSE
	if(target.check_martial_melee_block())
		target.visible_message("<span class='warning'>[target] blocks [user]'s attack!</span>", target = user, \
			target_message = "<span class='warning'>[target] blocks your attack!</span>")
		return FALSE

	if(target.mind?.handle_parry(target, null, 0, user))
		playsound(get_turf(target), 'modular_skyrat/sound/attack/parry.ogg', 70)
		var/held_item
		if(target.get_active_held_item())
			held_item = " with [target.p_their()] [target.get_active_held_item()]"
		else
			held_item = " with [target.p_their()] bare hands"
		target.visible_message("<span class='danger'>[target] blocks [user][held_item]!</span>")
		return FALSE

	if(target.mind?.handle_dodge(target, null, 0, user))
		//Make the victim step to an adjacent tile because ooooooh dodge
		var/list/turf/dodge_turfs = list()
		for(var/turf/open/O in range(1,target))
			if(target.CanReach(O))
				dodge_turfs += O
		//No available turfs == we can't actually dodge
		if(length(dodge_turfs))
			var/turf/yoink = pick(dodge_turfs)
			//We moved to the tile, therefore we parried successfully
			if(target.Move(yoink, get_dir(target, yoink)))
				playsound(get_turf(target), miss_sound, 70)
				target.visible_message("<span class='danger'>[target] dodges [user]!</span>")
				return FALSE

	//Kicks drain double the stamina
	if(HAS_TRAIT(user, TRAIT_PUGILIST))
		user.adjustStaminaLossBuffered(3)
	else
		user.adjustStaminaLossBuffered(7)

	if(attacker_style && attacker_style.harm_act(user,target))
		return TRUE
	else
		var/atk_verb = user.dna.species.bite_verb
		switch(atk_verb)
			if(ATTACK_EFFECT_BITE)
				user.do_attack_animation(target, ATTACK_EFFECT_BITE)
			else
				user.do_attack_animation(target, ATTACK_EFFECT_PUNCH)

		var/damage = (user.dna.species.punchdamagelow + user.dna.species.punchdamagehigh)/2

		//Bites deal 0.5x the normal damage of punches assuming you're not british
		//(but cause punctures)
		damage *= 0.5
		damage *= (teeth_part.get_teeth_amount()/teeth_part.max_teeth)

		//Raw damage is affected by the user's strength
		var/str_mod = 1
		if(user.mind)
			str_mod = user.mind.get_skillstat_damagemod(STAT_DATUM(str))
		damage *= str_mod

		//Combat intents change how much your boot deals
		var/c_intent = user.combat_intent
		switch(c_intent)
			if(CI_STRONG)
				damage *= 2 //fuck it
			if(CI_WEAK)
				damage *= 0.25

		//CITADEL CHANGES - makes resting and disabled combat mode reduce punch damage, makes being out of combat mode result in you taking more damage
		if(SEND_SIGNAL(target, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_INACTIVE))
			damage *= 1.1
		if(!CHECK_MOBILITY(user, MOBILITY_STAND))
			damage *= 0.5 //Kicking while down? Not very effective.
		if(SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_INACTIVE))
			damage *= 0.9
		//END OF CITADEL CHANGES

		//If the user has bad st, sometimes... the attack gets really shit
		var/pitiful = FALSE
		if(user.mind && GET_STAT_LEVEL(user, str) <= 10)
			switch(user.mind.diceroll(STAT_DATUM(str)))
				if(DICE_CRIT_FAILURE)
					damage *= 0.4
					pitiful = TRUE
		
		//The probability of hitting the correct zone depends on dexterity
		//and also on which limb we aim at
		//since this is a bite, chance to miss is doubled
		var/obj/item/bodypart/supposed_to_affect = target.get_bodypart(user.zone_selected)
		var/ran_zone_prob = 35
		var/extra_zone_prob = 25
		if(supposed_to_affect)
			ran_zone_prob = supposed_to_affect.zone_prob * 0.5
			extra_zone_prob = supposed_to_affect.extra_zone_prob * 0.5
		if(user.mind)
			var/datum/stats/dex/dex = GET_STAT(user, dex)
			if(dex)
				ran_zone_prob = dex.get_ran_zone_prob(ran_zone_prob, extra_zone_prob)

		//Aimed combat intent means we almost never miss, at the cost of stamina
		//we deduct stamina later down, based on endurance
		switch(c_intent)
			if(CI_AIMED)
				ran_zone_prob = 100
				if(user.mind)
					var/datum/stats/dex/dex = GET_STAT(user, dex)
					if(dex)
						ran_zone_prob = 80 + dex.level
		
		//Get the bodypart we actually affect
		var/obj/item/bodypart/affecting = target.get_bodypart(ran_zone(user.zone_selected, ran_zone_prob))

		var/missed = FALSE
		//Dice roll to see if we fuck up
		if(user.mind && user.mind.diceroll(GET_STAT_LEVEL(user, dex)*0.3, GET_SKILL_LEVEL(user, melee)*0.7) <= DICE_CRIT_FAILURE)
			missed = TRUE
		//Aimed combat intent means we never miss, at the cost of stamina
		switch(c_intent)
			if(CI_AIMED)
				missed = FALSE
				var/endurance_mod = 1
				if(user.mind)
					var/datum/stats/end = GET_STAT(user, dex)
					endurance_mod = round((MAX_STAT/2)/end.level, 0.1)
				user.adjustStaminaLoss(7 * endurance_mod)
		
		if(!damage || !affecting || (missed && target != user))//future-proofing for species that have 0 damage/weird cases where no zone is targeted
			playsound(target.loc, user.dna.species.miss_sound, 25, TRUE, -1)
			target.visible_message("<span class='danger'>[user]'s [atk_verb] misses [target]!</span>", \
							"<span class='danger'>You avoid [user]'s [atk_verb]!</span>", "<span class='hear'>You hear a swoosh!</span>", COMBAT_MESSAGE_RANGE, null, \
							user, "<span class='warning'>Your [atk_verb] misses [target]!</span>")
			log_combat(user, target, "attempted to punch")
			return FALSE


		var/armor_block = target.run_armor_check(affecting, "melee")

		playsound(target.loc, 'sound/weapons/bite.ogg', 25, 1, -1)
		target.lastattacker = user.real_name
		target.lastattackerckey = user.ckey
		user.dna.species.spec_unarmedattacked(user, target)

		if(user.limb_destroyer)
			target.dismembering_strike(user, affecting.body_zone)

		
		target.apply_damage(damage, BRUTE, affecting, armor_block, sharpness = SHARP_POINTY, wound_bonus = 5)
		target.apply_damage(damage*2, STAMINA, affecting, armor_block)
		log_combat(user, target, "bitten")
		
		//Knockdown and stuff
		target.do_stat_effects(user, null, damage)

		//Attack message
		target.visible_message("<span class='danger'>[user][pitiful ? " pitifully" : ""] [atk_verb]s [target] on their [affecting.name]![target.wound_message]</span>", \
					"<span class='userdanger'>[user][pitiful ? " pitifully" : ""] [atk_verb]s you on your [affecting.name]![target.wound_message]</span>", null, COMBAT_MESSAGE_RANGE, null, \
					user, "<span class='danger'>You[pitiful ? " pitifully" : ""] [atk_verb] [target] on their [affecting.name]![target.wound_message]</span>")

		//Clean the descriptive string
		target.wound_message = ""
