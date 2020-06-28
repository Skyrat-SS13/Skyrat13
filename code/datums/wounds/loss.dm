//skyrat edit
/*
	Dismemberment
*/

/datum/wound/loss
	name = "Dismembered"
	desc = "Patient's limb has been violently dismembered, leaving only a severely damaged stump."
	viable_zones = ALL_BODYPARTS
	severity = WOUND_SEVERITY_LOSS
	threshold_minimum = 180
	status_effect_type = null
	scarring_descriptions = list("is several skintone shades paler than the rest of the body", "is a gruesome patchwork of artificial flesh", "has a large series of attachment scars at the articulation points")

/datum/wound/loss/proc/apply_dismember(obj/item/bodypart/L, wounding_type=WOUND_SLASH)
	if(!istype(L) || !L.owner || !(L.body_zone in viable_zones) || isalien(L.owner) || !L.can_dismember())
		qdel(src)
		return

	if(ishuman(L.owner))
		var/mob/living/carbon/human/H = L.owner
		if(organic_only && ((NOBLOOD in H.dna.species.species_traits) || !L.is_organic_limb()))
			qdel(src)
			return

	switch(wounding_type)
		if(WOUND_BLUNT)
			occur_text = "is shattered through the last bone holding it together, severing it completely!"
		if(WOUND_SLASH)
			occur_text = "is slashed through the last tissue holding it together, severing it completely!"
		if(WOUND_PIERCE)
			occur_text = "is pierced through the last tissue holding it together, severing it completely!"

	var/mob/living/carbon/victim = L.owner
	if(prob(40))
		victim.confused += 5

	var/msg = "<b><span class='danger'>[victim]'s [L.name] [occur_text]!</span></b>"

	victim.visible_message(msg, "<span class='userdanger'>Your [L.name] [occur_text]!</span>")

	second_wind()
	L.dismember(silent = TRUE)
	qdel(src)

/datum/wound/slash/loss
	name = "Dismembered"
	desc = "Patient's limb has been violently dismembered, leaving only a severely damaged stump."
	treat_text = "Immediate surgical reattachment of the lost limb, if possible, or suture/cauterization of the stump."
	examine_desc = "has been violently severed from their body"
	sound_effect = 'modular_skyrat/sound/effects/dismember.ogg'
	viable_zones = ALL_BODYPARTS
	severity = WOUND_SEVERITY_LOSS
	ignore_preexisting = TRUE
	initial_flow = 2
	minimum_flow = 0.5
	clot_rate = 0
	max_per_type = 4
	threshold_penalty = 80
	demotes_to = null
	threshold_minimum = 180
	status_effect_type = /datum/status_effect/wound/loss
	scarring_descriptions = list("is several skintone shades paler than the rest of the body", "is a gruesome patchwork of artificial flesh", "has a large series of attachment scars at the articulation points")
