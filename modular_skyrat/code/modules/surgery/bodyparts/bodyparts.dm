//Update_limb changes because synths
/obj/item/bodypart/proc/update_limb(dropping_limb, mob/living/carbon/source)
	var/mob/living/carbon/C
	if(source)
		C = source
		if(!original_owner)
			original_owner = source
	else if(original_owner && owner != original_owner) //Foreign limb
		no_update = TRUE
	else
		C = owner
		no_update = FALSE

	if(HAS_TRAIT(C, TRAIT_HUSK) && is_organic_limb())
		species_id = "husk" //overrides species_id
		dmg_overlay_type = "" //no damage overlay shown when husked
		should_draw_gender = FALSE
		color_src = FALSE
		base_bp_icon = DEFAULT_BODYPART_ICON
		no_update = TRUE
		body_markings = "husk" // reeee
		aux_marking = "husk"

	if(no_update)
		return

	if(!animal_origin)
		var/mob/living/carbon/human/H = C
		color_src = FALSE

		var/datum/species/S = H.dna.species
		base_bp_icon = S?.icon_limbs || DEFAULT_BODYPART_ICON
		species_id = S.limbs_id
		species_flags_list = H.dna.species.species_traits

		//body marking memes
		var/list/colorlist = list()
		colorlist.Cut()
		colorlist += ReadRGB("[H.dna.features["mcolor"]]0")
		colorlist += ReadRGB("[H.dna.features["mcolor2"]]0")
		colorlist += ReadRGB("[H.dna.features["mcolor3"]]0")
		colorlist += list(0,0,0, S.hair_alpha)
		for(var/index=1, index<=colorlist.len, index++)
			colorlist[index] = colorlist[index]/255

		if(S.use_skintones)
			skin_tone = H.skin_tone
			base_bp_icon = (base_bp_icon == DEFAULT_BODYPART_ICON) ? DEFAULT_BODYPART_ICON_ORGANIC : base_bp_icon
		else
			skin_tone = ""

		body_gender = H.dna.features["body_model"]
		should_draw_gender = S.sexes

		var/mut_colors = (MUTCOLORS in S.species_traits)
		if(mut_colors)
			if(S.fixed_mut_color)
				species_color = S.fixed_mut_color
			else
				species_color = H.dna.features["mcolor"]
			base_bp_icon = (base_bp_icon == DEFAULT_BODYPART_ICON) ? DEFAULT_BODYPART_ICON_ORGANIC : base_bp_icon
		else
			species_color = ""

		if(base_bp_icon != DEFAULT_BODYPART_ICON)
			color_src = mut_colors ? MUTCOLORS : ((H.dna.skin_tone_override && S.use_skintones == USE_SKINTONES_GRAYSCALE_CUSTOM) ? CUSTOM_SKINTONE : SKINTONE)

		if(S.mutant_bodyparts["legs"])
			if(body_zone == BODY_ZONE_L_LEG || body_zone == BODY_ZONE_R_LEG)
				if(DIGITIGRADE in S.species_traits)
					digitigrade_type = lowertext(H.dna.features["legs"])
			else
				digitigrade_type = null

		if(S.mutant_bodyparts["mam_body_markings"])
			var/datum/sprite_accessory/Smark
			Smark = GLOB.mam_body_markings_list[H.dna.features["mam_body_markings"]]
			if(Smark)
				body_markings_icon = Smark.icon
			if(H.dna.features["mam_body_markings"] != "None")
				body_markings = Smark?.icon_state || lowertext(H.dna.features["mam_body_markings"])
				aux_marking = Smark?.icon_state || lowertext(H.dna.features["mam_body_markings"])
			else
				body_markings = "plain"
				aux_marking = "plain"
			markings_color = list(colorlist)

		else
			body_markings = null
			aux_marking = null

		if(!dropping_limb && H.dna.check_mutation(HULK))
			mutation_color = "00aa00"
		else
			mutation_color = ""

		if(istype(S, /datum/species/synth))
			var/datum/species/synth/synthspecies = S
			var/redundantactualhealth = (100 - (owner.getBruteLoss() + owner.getFireLoss() + owner.getOxyLoss() + owner.getToxLoss() + owner.getCloneLoss()))
			if(synthspecies.isdisguised == FALSE || (synthspecies.actualhealth < 45) || (redundantactualhealth < 45))
				base_bp_icon = initial(synthspecies.icon_limbs)

		dmg_overlay_type = S.damage_overlay_type

	else if(animal_origin == MONKEY_BODYPART) //currently monkeys are the only non human mob to have damage overlays.
		dmg_overlay_type = animal_origin

	if(status == BODYPART_ROBOTIC)
		dmg_overlay_type = "robotic"
		body_markings = null
		aux_marking = null

	if(dropping_limb)
		no_update = TRUE //when attached, the limb won't be affected by the appearance changes of its mob owner.
