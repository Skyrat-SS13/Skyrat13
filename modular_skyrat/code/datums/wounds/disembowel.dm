/*
	Disembowelment
*/
/datum/wound/disembowel
	name = "Disembowelment"
	desc = "Patient's limb has been violently avulsioned, to the point of large chunks of flesh and organs getting lost."
	viable_zones = ALL_BODYPARTS
	wound_type = WOUND_LIST_DISEMBOWEL
	severity = WOUND_SEVERITY_LOSS
	ignore_preexisting = TRUE
	threshold_minimum = 180
	status_effect_type = null
	scarring_descriptions = list("has a large, wide and slithering keloid scar", "is a gruesome patchwork of badly healed flesh and skin", "has a large series of connected hypertrophic scars")
	biology_required = list()
	required_status = null

/datum/wound/disembowel/proc/apply_disembowel(obj/item/bodypart/L, wounding_type=WOUND_SLASH)
	var/list/organs = L?.owner?.getorganszone(L.body_zone)
	for(var/obj/item/organ/genital/G in organs)
		organs -= G
	if(!istype(L) || !L.owner || !(L.body_zone in viable_zones) || isalien(L.owner) || !L.disembowable || HAS_TRAIT(L.owner, TRAIT_NOGUT) || HAS_TRAIT(L.owner, TRAIT_NODISMEMBER) || !length(organs))
		qdel(src)
		return

	if(ishuman(L.owner))
		var/mob/living/carbon/human/H = L.owner
		if((required_status & BODYPART_ORGANIC) && !L.is_organic_limb())
			qdel(src)
			return
		else if((required_status & BODYPART_ROBOTIC) && !L.is_robotic_limb())
			qdel(src)
			return
		
		for(var/biology_flag in biology_required)
			if(!(biology_flag in H.dna.species.species_traits))
				qdel(src)
				return

	occur_text = "is slashed deep through it's flesh, letting organs and bits of flesh fall out"
	switch(wounding_type)
		if(WOUND_BLUNT)
			occur_text = "is crushed through it's wounds, all organs inside gruesomely fall out"
			if(L.is_robotic_limb())
				occur_text = "is shattered through it's exoskeleton, spitting out internal components"
		if(WOUND_SLASH)
			occur_text = "is slashed deep through it's flesh, letting organs and bits of flesh fall out"
			if(L.is_robotic_limb())
				occur_text = "is slashed through it's exoskeleton, internal components rapidly falling out"
		if(WOUND_PIERCE)
			occur_text = "is deeply pierced through, internal organs easily falling out of the gaping wound"
			if(L.is_robotic_limb())
				occur_text = "is deeply pierced through, internal components easily falling out of the gaping hole"
		if(WOUND_BURN)
			occur_text = "gets a hole burned through it, slightly charred organs falling out"
			if(L.is_robotic_limb())
				occur_text = "gets a critical amount of metal molten, opening a gaping hole from which slightly components fall through"

	var/mob/living/carbon/victim = L.owner
	victim.confused += 10
	if(prob(30))
		victim.vomit(50, 20, 25)

	var/msg = "<b><span class='danger'>[victim]'s [L.name] [occur_text]!</span></b>"

	victim.visible_message(msg, "<span class='userdanger'>Your [L.name] [occur_text]!</span>")

	//apply the blood gush effect
	if(wounding_type != WOUND_BURN && L.owner)
		var/direction = L.owner.dir
		direction = turn(direction, 180)
		var/bodypart_turn = 0 //relative north
		if(L.body_zone in list(BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT, BODY_ZONE_PRECISE_L_HAND))
			bodypart_turn = -90 //relative east
		else if(L.body_zone in list(BODY_ZONE_R_ARM, BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_R_HAND))
			bodypart_turn = 90 //relative west
		direction = turn(direction, bodypart_turn)
		var/dist = rand(3, 5)
		var/turf/targ = get_ranged_target_turf(L.owner, direction, dist)
		if(targ)
			var/obj/effect/decal/cleanable/blood/hitsplatter/B = new(L.owner.loc, L.owner.get_blood_dna_list())
			B.add_blood_DNA(L.owner.get_blood_dna_list())
			B.GoTo(targ, dist)

	second_wind()
	log_wound(victim, src)
	qdel(src)
	return L.disembowel(dam_type = (wounding_type == WOUND_BURN ? BURN : BRUTE),silent = TRUE, wound = TRUE)

/datum/wound/slash/critical/incision/disembowel
	name = "Disembowelment"
	desc = "Patient's limb has been violently avulsioned, to the point of large chunks of flesh and organs getting lost."
	treat_text = "Immediate surgical closure of the wound, as well as reimplantation of lost organs."
	examine_desc = "has a wide and gaping wound, enough to see through the flesh"
	sound_effect = 'modular_skyrat/sound/effects/dismember.ogg'
	viable_zones = ALL_BODYPARTS
	severity = WOUND_SEVERITY_CRITICAL
	wound_type = WOUND_LIST_DISEMBOWEL
	ignore_preexisting = TRUE
	initial_flow = 2
	minimum_flow = 0
	clot_rate = 0
	max_per_type = 4
	threshold_penalty = 80
	demotes_to = null
	threshold_minimum = 180
	status_effect_type = /datum/status_effect/wound/slash/critical
	scarring_descriptions = list("is several skintone shades paler than the rest of the body", "is a gruesome patchwork of artificial flesh", "has a large series of attachment scars at the articulation points")
	required_status = BODYPART_ORGANIC
	biology_required = list()
	sound_effect = 'sound/misc/splort.ogg'
	occur_text = null

/datum/wound/slash/critical/incision/disembowel/apply_wound(obj/item/bodypart/L, silent, datum/wound/old_wound, smited)
	. = ..()
	switch(L.body_zone)
		if(BODY_ZONE_HEAD)
			initial_flow = 3
			minimum_flow = 0
		if(BODY_ZONE_CHEST)
			initial_flow = 4
			minimum_flow = 0
		if(BODY_ZONE_PRECISE_GROIN)
			initial_flow = 4
			minimum_flow = 0.2
		if(BODY_ZONE_L_ARM)
			initial_flow = 2.5
			minimum_flow = 0.5
		if(BODY_ZONE_R_ARM)
			initial_flow = 2.5
			minimum_flow = 0.5
		if(BODY_ZONE_PRECISE_L_HAND)
			initial_flow = 1.5
			minimum_flow = 0.75
		if(BODY_ZONE_PRECISE_R_HAND)
			initial_flow = 1.5
			minimum_flow = 0.75
		if(BODY_ZONE_L_LEG)
			initial_flow = 3
			minimum_flow = 0.3
		if(BODY_ZONE_R_LEG)
			initial_flow = 3
			minimum_flow = 0.3
		if(BODY_ZONE_PRECISE_L_FOOT)
			initial_flow = 2
			minimum_flow = 0.5
		if(BODY_ZONE_PRECISE_R_FOOT)
			initial_flow = 2
			minimum_flow = 0.5

/datum/wound/mechanical/slash/critical/incision/disembowel
	name = "Disemboweled"
	desc = "Patient's limb has been violently shredded, to the point of large chunks of metal and components getting lost."
	treat_text = "Immediate welding of the wound, as well as reattachment of lost components."
	examine_desc = "has a wide and gaping tear, enough to see through the exoskeleton"
	sound_effect = 'modular_skyrat/sound/effects/dismember.ogg'
	viable_zones = ALL_BODYPARTS
	severity = WOUND_SEVERITY_CRITICAL
	wound_type = WOUND_LIST_DISEMBOWEL
	initial_flow = 2
	minimum_flow = 0.5
	clot_rate = 0
	max_per_type = 4
	threshold_penalty = 80
	demotes_to = null
	threshold_minimum = 180
	status_effect_type = /datum/status_effect/wound/slash/critical
	scarring_descriptions = list("is several skintone shades paler than the rest of the body", "is a gruesome patchwork of artificial flesh", "has a large series of attachment scars at the articulation points")
	required_status = BODYPART_ROBOTIC
	biology_required = list()
	occur_text = null

/datum/wound/mechanical/slash/critical/incision/disembowel/get_examine_description(mob/user)
	. = ..()
	if(limb.body_zone == BODY_ZONE_HEAD)
		return "<span class='deadsay'>[..()]</span>"

/datum/wound/mechanical/slash/critical/incision/disembowel/apply_wound(obj/item/bodypart/L, silent, datum/wound/old_wound, smited)
	. = ..()
	switch(L.body_zone)
		if(BODY_ZONE_HEAD)
			initial_flow = 3
			minimum_flow = 0
		if(BODY_ZONE_CHEST)
			initial_flow = 4
			minimum_flow = 0
		if(BODY_ZONE_PRECISE_GROIN)
			initial_flow = 4
			minimum_flow = 0.2
		if(BODY_ZONE_L_ARM)
			initial_flow = 2.5
			minimum_flow = 0.5
		if(BODY_ZONE_R_ARM)
			initial_flow = 2.5
			minimum_flow = 0.5
		if(BODY_ZONE_PRECISE_L_HAND)
			initial_flow = 1.5
			minimum_flow = 0.75
		if(BODY_ZONE_PRECISE_R_HAND)
			initial_flow = 1.5
			minimum_flow = 0.75
		if(BODY_ZONE_L_LEG)
			initial_flow = 3
			minimum_flow = 0.3
		if(BODY_ZONE_R_LEG)
			initial_flow = 3
			minimum_flow = 0.3
		if(BODY_ZONE_PRECISE_L_FOOT)
			initial_flow = 2
			minimum_flow = 0.5
		if(BODY_ZONE_PRECISE_R_FOOT)
			initial_flow = 2
			minimum_flow = 0.5
