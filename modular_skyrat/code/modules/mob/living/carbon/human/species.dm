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
					if(HAS_TRAIT(H, TRAIT_MASO) && prob(damage_amount))
						H.mob_climax(forced_climax=TRUE)

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
