/obj/item/bodypart
	var/synthetic = FALSE //Synthetic bodyparts can have patches applied but are harder to repair by conventional means
	var/render_like_organic = FALSE //Skyrat change - for robotic limbs that pretend to be organic, for the sake of features, icon paths etc. etc.

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/heal_damage(brute, burn, stamina, only_robotic = FALSE, only_organic = TRUE, updating_health = TRUE)

	if(only_robotic && status != BODYPART_ROBOTIC) //This makes organic limbs not heal when the proc is in Robotic mode.
		return

	if(only_organic && status != BODYPART_ORGANIC) //This makes robolimbs not healable by chems.
		return

	brute_dam	= round(max(brute_dam - brute, 0), DAMAGE_PRECISION)
	burn_dam	= round(max(burn_dam - burn, 0), DAMAGE_PRECISION)
	stamina_dam = round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION)
	if(owner && updating_health)
		owner.updatehealth()
	if(owner.dna && owner.dna.species && (REVIVESBYHEALING in owner.dna.species.species_traits))
		if(owner.health > owner.dna.species.revivesbyhealreq && !owner.hellbound)
			owner.revive(0)
			owner.cure_husk(0) // If it has REVIVESBYHEALING, it probably can't be cloned. No husk cure.
	consider_processing()
	update_disabled()
	return update_bodypart_damage_state() 

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
			if(body_zone == BODY_ZONE_L_LEG || body_zone == BODY_ZONE_R_LEG || body_zone == BODY_ZONE_PRECISE_R_FOOT || body_zone == BODY_ZONE_PRECISE_L_FOOT)
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
		if(!render_like_organic)
			body_markings = null
			aux_marking = null

	if(dropping_limb)
		no_update = TRUE //when attached, the limb won't be affected by the appearance changes of its mob owner.

/obj/item/bodypart/proc/get_limb_icon(dropped)
	cut_overlays()
	icon_state = "" //to erase the default sprite, we're building the visual aspects of the bodypart through overlays alone.

	. = list()

	var/image_dir = 0
	var/icon_gender = (body_gender == FEMALE) ? "f" : "m" //gender of the icon, if applicable

	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(brutestate)
				. += image('modular_skyrat/icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
			if(burnstate)
				. += image('modular_skyrat/icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)
			to_chat(owner, "[dmg_overlay_type]_[body_zone]_[brutestate]0")
			to_chat(owner, "[dmg_overlay_type]_[body_zone]_0[burnstate]")

		if(!isnull(body_markings) && status == BODYPART_ORGANIC)
			if(!use_digitigrade)
				if((body_zone == BODY_ZONE_CHEST) || (body_zone == BODY_ZONE_PRECISE_GROIN))
					. += image(body_markings_icon, "[body_markings]_[body_zone]_[icon_gender]", -MARKING_LAYER, image_dir)
				else
					. += image(body_markings_icon, "[body_markings]_[body_zone]", -MARKING_LAYER, image_dir)
			else
				. += image(body_markings_icon, "[body_markings]_[digitigrade_type]_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)

	var/image/limb = image(layer = -BODYPARTS_LAYER, dir = image_dir)
	var/list/aux = list()
	var/image/marking
	var/list/auxmarking = list()

	. += limb

	if(animal_origin)
		if(is_organic_limb())
			limb.icon = 'icons/mob/animal_parts.dmi'
			if(species_id == "husk")
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"
		return

	if(body_zone != BODY_ZONE_HEAD && body_zone != BODY_ZONE_CHEST && body_zone != BODY_ZONE_PRECISE_GROIN)
		should_draw_gender = FALSE

	if(is_organic_limb() || render_like_organic)
		limb.icon = base_bp_icon || 'icons/mob/human_parts.dmi'
		if(should_draw_gender)
			limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
		else if (use_digitigrade)
			if(base_bp_icon == DEFAULT_BODYPART_ICON_ORGANIC) //Compatibility hack for the current iconset.
				limb.icon_state = "[digitigrade_type]_[use_digitigrade]_[body_zone]"
			else
				limb.icon_state = "[species_id]_[digitigrade_type]_[use_digitigrade]_[body_zone]"
		else
			limb.icon_state = "[species_id]_[body_zone]"

		// Body markings
		if(!isnull(body_markings))
			if(species_id == "husk")
				marking = image('modular_citadel/icons/mob/markings_notmammals.dmi', "husk_[body_zone]", -MARKING_LAYER, image_dir)
			else if(species_id == "husk" && use_digitigrade)
				marking = image('modular_citadel/icons/mob/markings_notmammals.dmi', "husk_[digitigrade_type]_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)

			else if(!use_digitigrade)
				if((body_zone == BODY_ZONE_CHEST) || (body_zone == BODY_ZONE_PRECISE_GROIN))
					marking = image(body_markings_icon, "[body_markings]_[body_zone]_[icon_gender]", -MARKING_LAYER, image_dir)
				else
					marking = image(body_markings_icon, "[body_markings]_[body_zone]", -MARKING_LAYER, image_dir)
			else
				marking = image(body_markings_icon, "[body_markings]_[digitigrade_type]_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)

			. += marking

		// Citadel End

		if(aux_icons)
			for(var/I in aux_icons)
				var/aux_layer = aux_icons[I]
				aux += image(limb.icon, "[species_id]_[I]", -aux_layer, image_dir)
				if(!isnull(aux_marking))
					if(species_id == "husk")
						auxmarking += image('modular_citadel/icons/mob/markings_notmammals.dmi', "husk_[I]", -aux_layer, image_dir)
					else
						auxmarking += image(body_markings_icon, "[body_markings]_[I]", -aux_layer, image_dir)
			. += aux
			. += auxmarking

	else
		limb.icon = icon
		if(should_draw_gender)
			limb.icon_state = "[body_zone]_[icon_gender]"
		else
			limb.icon_state = "[body_zone]"

		if(aux_icons)
			for(var/I in aux_icons)
				var/aux_layer = aux_icons[I]
				aux += image(limb.icon, "[I]", -aux_layer, image_dir)
				if(!isnull(aux_marking))
					if(species_id == "husk")
						auxmarking += image('modular_citadel/icons/mob/markings_notmammals.dmi', "husk_[I]", -aux_layer, image_dir)
					else
						auxmarking += image(body_markings_icon, "[body_markings]_[I]", -aux_layer, image_dir)
			. += auxmarking
			. += aux

		if(!isnull(body_markings))
			if(species_id == "husk")
				marking = image('modular_citadel/icons/mob/markings_notmammals.dmi', "husk_[body_zone]", -MARKING_LAYER, image_dir)
			else if(species_id == "husk" && use_digitigrade)
				marking = image('modular_citadel/icons/mob/markings_notmammals.dmi', "husk_digitigrade_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)

			else if(!use_digitigrade)
				if((body_zone == BODY_ZONE_CHEST) || (body_zone == BODY_ZONE_PRECISE_GROIN))
					marking = image(body_markings_icon, "[body_markings]_[body_zone]_[icon_gender]", -MARKING_LAYER, image_dir)
				else
					marking = image(body_markings_icon, "[body_markings]_[body_zone]", -MARKING_LAYER, image_dir)
			else
				marking = image(body_markings_icon, "[body_markings]_[digitigrade_type]_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)
			. += marking
		return

	if(color_src) //TODO - add color matrix support for base species limbs
		var/draw_color = mutation_color || species_color
		var/grayscale = FALSE
		if(!draw_color)
			draw_color = SKINTONE2HEX(skin_tone)
			grayscale = color_src == CUSTOM_SKINTONE //Cause human limbs have a very pale pink hue by def.
		else
			draw_color = "#[draw_color]"
		if(draw_color)
			if(grayscale)
				limb.icon_state += "_g"
			limb.color = draw_color
			if(aux_icons)
				for(var/a in aux)
					var/image/I = a
					if(grayscale)
						I.icon_state += "_g"
					I.color = draw_color
				if(!isnull(aux_marking))
					for(var/a in auxmarking)
						var/image/I = a
						if(species_id == "husk")
							I.color = "#141414"
						else
							I.color = list(markings_color)

			if(!isnull(body_markings))
				if(species_id == "husk")
					marking.color = "#141414"
				else
					marking.color = list(markings_color)

/obj/item/bodypart/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = FALSE)
	. = ..()
	if(status == BODYPART_ROBOTIC)
		if(src.owner)
			if((brute+burn)>3 && prob((20+brute+burn)))
				do_sparks(3,FALSE,src.owner)
