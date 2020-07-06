/obj/item/bodypart
	name = "limb"
	desc = "Why is it detached..."
	force = 3
	throwforce = 3
	icon = 'modular_skyrat/icons/mob/human_parts.dmi' //skyrat edit
	w_class = WEIGHT_CLASS_SMALL
	icon_state = ""
	layer = BELOW_MOB_LAYER //so it isn't hidden behind objects when on the floor
	var/mob/living/carbon/owner = null
	var/mob/living/carbon/original_owner = null
	var/status = BODYPART_ORGANIC
	var/needs_processing = FALSE

	var/body_zone //BODY_ZONE_CHEST, BODY_ZONE_L_ARM, etc , used for def_zone
	var/list/aux_icons // associative list, currently used on hands
	var/body_part = null //bitflag used to check which clothes cover this bodypart
	var/use_digitigrade = NOT_DIGITIGRADE //Used for alternate legs, useless elsewhere
	var/list/embedded_objects = list()
	var/held_index = 0 //are we a hand? if so, which one!
	var/is_pseudopart = FALSE //For limbs that don't really exist, eg chainsaws

	var/disabled = BODYPART_NOT_DISABLED //If disabled, limb is as good as missing
	var/body_damage_coeff = 1 //Multiplier of the limb's damage that gets applied to the mob
	var/stam_damage_coeff = 0.75
	var/brutestate = 0
	var/burnstate = 0
	var/brute_dam = 0
	var/burn_dam = 0
	var/stamina_dam = 0
	var/max_stamina_damage = 0
	var/incoming_stam_mult = 1 //Multiplier for incoming staminaloss, decreases when taking staminaloss when the limb is disabled, resets back to 1 when limb is no longer disabled.
	var/max_damage = 0
	var/stam_heal_tick = 0		//per Life(). Defaults to 0 due to citadel changes

	var/brute_reduction = 0 //Subtracted to brute damage taken
	var/burn_reduction = 0	//Subtracted to burn damage taken

	//Coloring and proper item icon update
	var/skin_tone = ""
	var/body_gender = ""
	var/species_id = ""
	var/color_src
	var/base_bp_icon //Overrides the icon being used for this limb. This is mainly for downstreams, implemented and maintained as a favor in return for implementing synths. And also because should_draw_* for icon overrides was pretty messy. You're welcome.
	var/should_draw_gender = FALSE
	var/species_color = ""
	var/mutation_color = ""
	var/no_update = 0
	var/body_markings = ""	//for bodypart markings
	var/body_markings_icon = 'modular_citadel/icons/mob/mam_markings.dmi'
	var/list/markings_color = list()
	var/aux_marking
	var/digitigrade_type

	var/animal_origin = null //for nonhuman bodypart (e.g. monkey)
	var/dismemberable = 1 //whether it can be dismembered with a weapon.

	var/px_x = 0
	var/px_y = 0

	var/species_flags_list = list()
	var/dmg_overlay_type //the type of damage overlay (if any) to use when this bodypart is bruised/burned.

	//Damage messages used by help_shake_act()
	var/light_brute_msg = "bruised"
	var/medium_brute_msg = "battered"
	var/heavy_brute_msg = "mangled"

	var/light_burn_msg = "numb"
	var/medium_burn_msg = "blistered"
	var/heavy_burn_msg = "peeling away"

	//skyrat variables
	var/parent_bodyzone //body zone that is considered a "parent" of this bodypart's zone
	var/dismember_bodyzone //body zone that receives wound when this limb is dismembered
	var/list/starting_children = list() //children that are already "inside" this limb on spawn. could be organs or limbs.
	var/list/children_zones = list() //body zones that are considered "children" of this bodypart's zone
	var/amputation_point //descriptive string used in amputation.
	var/obj/item/cavity_item
	var/cremation_progress = 0 //Gradually increases while burning when at full damage, destroys the limb when at 100
	/// The wounds currently afflicting this body part
	var/list/wounds = list()
	/// The scars currently afflicting this body part
	var/list/scars = list()
	/// Our current stored wound damage multiplier
	var/wound_damage_multiplier = 1
	/// This number is subtracted from all wound rolls on this bodypart, higher numbers mean more defense, negative means easier to wound
	var/wound_resistance = 0
	/// When this bodypart hits max damage, this number is added to all wound rolls. Obviously only relevant for bodyparts that have damage caps.
	var/disabled_wound_penalty = 15

	/// A hat won't cover your face, but a shirt covering your chest will cover your... you know, chest
	var/scars_covered_by_clothes = TRUE
	/// Descriptions for the locations on the limb for scars to be assigned, just cosmetic
	var/list/specific_locations = list("general area")
	/// So we know if we need to scream if this limb hits max damage
	var/last_maxed
	/// How much generic bleedstacks we have on this bodypart
	var/generic_bleedstacks
	/// Does the limb just not bleed at all?
	var/bleedsuppress = FALSE
	/// If we have a gauze wrapping currently applied (not including splints)
	var/obj/item/stack/current_gauze
	//

//skyrat edit
/obj/item/bodypart/Initialize()
	. = ..()
	if(starting_children.len)
		for(var/I in starting_children)
			new I(src)
//
/obj/item/bodypart/examine(mob/user)
	. = ..()
	if(brute_dam > DAMAGE_PRECISION)
		. += "<span class='warning'>This limb has [brute_dam > 30 ? "severe" : "minor"] bruising.</span>"
	if(burn_dam > DAMAGE_PRECISION)
		. += "<span class='warning'>This limb has [burn_dam > 30 ? "severe" : "minor"] burns.</span>"

/obj/item/bodypart/blob_act()
	take_damage(max_damage)

/obj/item/bodypart/Destroy()
	if(owner)
		owner.bodyparts -= src
		owner = null
	return ..()

/obj/item/bodypart/attack(mob/living/carbon/C, mob/user)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(HAS_TRAIT(C, TRAIT_LIMBATTACHMENT))
			if(!H.get_bodypart(body_zone) && !animal_origin)
				if(H == user)
					H.visible_message("<span class='warning'>[H] jams [src] into [H.p_their()] empty socket!</span>",\
					"<span class='notice'>You force [src] into your empty socket, and it locks into place!</span>")
				else
					H.visible_message("<span class='warning'>[user] jams [src] into [H]'s empty socket!</span>",\
					"<span class='notice'>[user] forces [src] into your empty socket, and it locks into place!</span>")
				user.temporarilyRemoveItemFromInventory(src, TRUE)
				attach_limb(C)
				return
	..()

/obj/item/bodypart/attackby(obj/item/W, mob/user, params)
	if(W.sharpness)
		add_fingerprint(user)
		if(!contents.len)
			to_chat(user, "<span class='warning'>There is nothing left inside [src]!</span>")
			return
		playsound(loc, 'sound/weapons/slice.ogg', 50, 1, -1)
		user.visible_message("<span class='warning'>[user] begins to cut open [src].</span>",\
			"<span class='notice'>You begin to cut open [src]...</span>")
		if(do_after(user, 54, target = src))
			drop_organs(user)
	else
		return ..()

/obj/item/bodypart/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(status != BODYPART_ROBOTIC)
		playsound(get_turf(src), 'sound/misc/splort.ogg', 50, 1, -1)
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3)

//empties the bodypart from its organs and other things inside it
/obj/item/bodypart/proc/drop_organs(mob/user, violent_removal)
	var/turf/T = get_turf(src)
	if(status != BODYPART_ROBOTIC)
		playsound(T, 'sound/misc/splort.ogg', 50, 1, -1)
	if(current_gauze)
		QDEL_NULL(current_gauze)
	for(var/X in get_organs())
		var/obj/item/organ/O = X
		O.transfer_to_limb(src, owner)
	for(var/obj/item/I in src)
		I.forceMove(T)

/obj/item/bodypart/proc/get_organs()
	if(!owner)
		return

	var/list/our_organs
	for(var/X in owner.internal_organs) //internal organs inside the dismembered limb are dropped.
		var/obj/item/organ/O = X
		var/org_zone = check_zone(O.zone)
		if(org_zone == body_zone)
			LAZYADD(our_organs, O)

	return our_organs

/obj/item/bodypart/proc/consider_processing()
	if(stamina_dam > DAMAGE_PRECISION)
		. = TRUE
	//else if.. else if.. so on.
	else
		. = FALSE
	needs_processing = .

//Return TRUE to get whatever mob this is in to update health.
/obj/item/bodypart/proc/on_life()
	if(stam_heal_tick && stamina_dam > DAMAGE_PRECISION)					//DO NOT update health here, it'll be done in the carbon's life.
		if(heal_damage(brute = 0, burn = 0, stamina = (stam_heal_tick * (disabled ? 2 : 1)), only_robotic = FALSE, only_organic = FALSE, updating_health = FALSE))
			. |= BODYPART_LIFE_UPDATE_HEALTH

//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
//skyrat editted as a whole
/obj/item/bodypart/proc/receive_damage(brute = 0, burn = 0, stamina = 0, blocked = 0, updating_health = TRUE, required_status = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE) // maybe separate BRUTE_SHARP and BRUTE_OTHER eventually somehow hmm
	var/hit_percent = (100-blocked)/100
	if((!brute && !burn && !stamina) || hit_percent <= 0)
		return FALSE
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode

	if(required_status && (status != required_status))
		return FALSE

	var/dmg_mlt = CONFIG_GET(number/damage_multiplier) * hit_percent
	brute = round(max(brute * dmg_mlt, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_mlt, 0),DAMAGE_PRECISION)
	stamina = round(max(stamina * dmg_mlt, 0),DAMAGE_PRECISION)
	brute = max(0, brute - brute_reduction)
	burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	switch(animal_origin)
		if(ALIEN_BODYPART,LARVA_BODYPART) //aliens take double burn //nothing can burn with so much snowflake code around
			burn *= 2

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	var/mangled_state = get_mangled_state()

	// this following block is for brute damage, to see if we're dealing with blunt, slash, or pierce, and how we're interacting with bones and skin if necessary
	if(wounding_type == WOUND_BLUNT)
		// first we check the sharpness var to see if we're slashing or piercing rather than plain blunt
		if(sharpness == SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if(sharpness == SHARP_POINTY)
			wounding_type = WOUND_PIERCE
		// if we've already mangled the muscle (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
		// So a big sharp weapon is still all you need to destroy a limb
		if((mangled_state & BODYPART_MANGLED_MUSCLE) && sharpness)
			playsound(src, "sound/effects/crackandbleed.ogg", 100)
			wounding_type = WOUND_BLUNT
			if(sharpness == SHARP_EDGED)
				wounding_dmg *= 0.5 // edged weapons pass along 50% of their wounding damage to the bone since the power is spread out over a larger area
			if(sharpness == SHARP_POINTY)
				wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated

		// if both the skin, muscle and the bone are destroyed, and we're doing more than 10 damage, we're ripe to try dismembering
		else if(mangled_state == BODYPART_MANGLED_BOTH && wounding_dmg >= DISMEMBER_MINIMUM_DAMAGE)
			if(try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
				return


	// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
	if(owner && wounding_dmg >= 5 && wound_bonus != CANT_WOUND)
		check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus)

	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE

	brute_dam += brute
	burn_dam += burn

	for(var/i in wounds)
		var/datum/wound/W = i
		W.receive_damage(sharpness, wounding_dmg, wound_bonus)

	//We've dealt the physical damages, if there's room lets apply the stamina damage.
	stamina_dam += round(clamp(stamina, 0, max_stamina_damage - stamina_dam), DAMAGE_PRECISION)

	if(owner && updating_health)
		owner.updatehealth()
		if(stamina > DAMAGE_PRECISION)
			owner.update_stamina()
			. = TRUE
	consider_processing()
	update_disabled()
	return update_bodypart_damage_state() || .

/// Allows us to roll for and apply a wound without actually dealing damage. Used for aggregate wounding power with pellet clouds (note this doesn't let sharp go to bone)
/obj/item/bodypart/proc/painless_wound_roll(wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus)
	if(!owner || phantom_wounding_dmg <= 5 || wound_bonus == CANT_WOUND)
		return

	var/mangled_state = get_mangled_state()
	var/original_type = wounding_type
	// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
	// So a big sharp weapon is still all you need to destroy a limb
	if(mangled_state == BODYPART_MANGLED_SKIN)
		playsound(src, "sound/effects/crackandbleed.ogg", 100)
		wounding_type = WOUND_BLUNT
		if(wounding_type == WOUND_SLASH)
			phantom_wounding_dmg *= 0.5 // edged weapons pass along 50% of their wounding damage to the bone since the power is spread out over a larger area
		if(wounding_type == WOUND_PIERCE)
			phantom_wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated

	// if both the skin and the bone are destroyed, and we're doing more than 10 damage, we're ripe to try dismembering
	else if(mangled_state == BODYPART_MANGLED_BOTH && phantom_wounding_dmg >= DISMEMBER_MINIMUM_DAMAGE)
		if(try_dismember(wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus))
			return

	wounding_type = original_type
	check_wounding(wounding_type, phantom_wounding_dmg, wound_bonus, bare_wound_bonus)
//

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/proc/heal_damage(brute, burn, stamina, required_status, updating_health = TRUE)

	if(required_status && (status != required_status)) //So we can only heal certain kinds of limbs, ie robotic vs organic.
		return

	brute_dam	= round(max(brute_dam - brute, 0), DAMAGE_PRECISION)
	burn_dam	= round(max(burn_dam - burn, 0), DAMAGE_PRECISION)
	stamina_dam = round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION)
	if(owner && updating_health)
		owner.updatehealth()
	consider_processing()
	update_disabled()
	cremation_progress = min(0, cremation_progress - ((brute_dam + burn_dam)*(100/max_damage)))
	return update_bodypart_damage_state()

//Returns total damage.
/obj/item/bodypart/proc/get_damage(include_stamina = FALSE)
	var/total = brute_dam + burn_dam
	if(include_stamina)
		total = max(total, stamina_dam)
	return total

//Checks disabled status thresholds
//skyrat edit
/obj/item/bodypart/proc/update_disabled(var/upparent = TRUE, var/upchildren = TRUE)
	if(!owner)
		return
	set_disabled(is_disabled())
	if(upparent)
		if(parent_bodyzone)
			var/obj/item/bodypart/BP = owner.get_bodypart(parent_bodyzone)
			if(BP)
				BP.update_disabled(TRUE, FALSE)
	if(children_zones)
		for(var/zoner in children_zones)
			var/obj/item/bodypart/CBP = owner.get_bodypart(zoner)
			if(CBP)
				CBP.update_disabled(FALSE, TRUE)
//skyrat edit
/obj/item/bodypart/proc/is_disabled()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS))
		return BODYPART_DISABLED_PARALYSIS
	for(var/i in wounds)
		var/datum/wound/W = i
		if(W.disabling)
			return BODYPART_DISABLED_WOUND
	if(can_dismember() && !HAS_TRAIT(owner, TRAIT_NODISMEMBER))
		. = disabled //inertia, to avoid limbs healing 0.1 damage and being re-enabled
		if((parent_bodyzone != null) && !istype(src, /obj/item/bodypart/groin))
			if(!(owner.get_bodypart(parent_bodyzone)))
				return BODYPART_DISABLED_DAMAGE
			else
				var/obj/item/bodypart/parent = owner.get_bodypart(parent_bodyzone)
				if(parent.is_disabled())
					return parent.is_disabled()
		if(get_damage(TRUE) >= max_damage * (HAS_TRAIT(owner, TRAIT_EASYLIMBDISABLE) ? 0.6 : 1)) //Easy limb disable disables the limb at 40% health instead of 0%
			if(!last_maxed)
				owner.emote("scream")
				last_maxed = TRUE
			if(stamina_dam >= max_damage)
				return BODYPART_DISABLED_DAMAGE
		else if(disabled && (get_damage(TRUE) <= (max_damage * 0.8))) // reenabled at 80% now instead of 50% as of wounds update
			last_maxed = FALSE
		if(stamina_dam >= max_stamina_damage)
			return BODYPART_DISABLED_DAMAGE
		if(disabled && (get_damage(TRUE) <= (max_damage * 0.5)))
			return BODYPART_NOT_DISABLED
	else
		return BODYPART_NOT_DISABLED
//
/obj/item/bodypart/proc/check_disabled() //This might be depreciated and should be safe to remove.
	if(!can_dismember() || HAS_TRAIT(owner, TRAIT_NODISMEMBER))
		return
	if(!disabled && (get_damage(TRUE) >= max_damage))
		set_disabled(TRUE)
	else if(disabled && (get_damage(TRUE) <= (max_damage * 0.5)))
		set_disabled(FALSE)


/obj/item/bodypart/proc/set_disabled(new_disabled)
	if(disabled == new_disabled || !owner) //skyrat edit
		return FALSE
	disabled = new_disabled
	//skyrat edit
	if(disabled && owner.get_item_for_held_index(held_index))
		owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	//
	owner.update_health_hud() //update the healthdoll
	owner.update_body()
	owner.update_mobility()
	if(!disabled)
		incoming_stam_mult = 1
	return TRUE

//Updates an organ's brute/burn states for use by update_damage_overlays()
//Returns 1 if we need to update overlays. 0 otherwise.
/obj/item/bodypart/proc/update_bodypart_damage_state()
	var/tbrute	= round( (brute_dam/max_damage)*3, 1 )
	var/tburn	= round( (burn_dam/max_damage)*3, 1 )
	if((tbrute != brutestate) || (tburn != burnstate))
		brutestate = tbrute
		burnstate = tburn
		return TRUE
	return FALSE

//Change bodypart status
/obj/item/bodypart/proc/change_bodypart_status(new_limb_status, heal_limb, change_icon_to_default)
	status = new_limb_status
	if(heal_limb)
		burn_dam = 0
		brute_dam = 0
		brutestate = 0
		burnstate = 0

	if(change_icon_to_default)
		if(status == BODYPART_ORGANIC)
			icon = base_bp_icon || DEFAULT_BODYPART_ICON_ORGANIC
		else if(status == BODYPART_ROBOTIC)
			icon = DEFAULT_BODYPART_ICON_ROBOTIC

	if(owner)
		owner.updatehealth()
		owner.update_body() //if our head becomes robotic, we remove the lizard horns and human hair.
		owner.update_hair()
		owner.update_damage_overlays()

/obj/item/bodypart/proc/is_organic_limb()
	return (status == BODYPART_ORGANIC)
/* moved to modular_skyrat
//we inform the bodypart of the changes that happened to the owner, or give it the informations from a source mob.
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

		dmg_overlay_type = S.damage_overlay_type

	else if(animal_origin == MONKEY_BODYPART) //currently monkeys are the only non human mob to have damage overlays.
		dmg_overlay_type = animal_origin

	if(status == BODYPART_ROBOTIC)
		dmg_overlay_type = "robotic"
		body_markings = null
		aux_marking = null

	if(dropping_limb)
		no_update = TRUE //when attached, the limb won't be affected by the appearance changes of its mob owner.
*/
//to update the bodypart's icon when not attached to a mob
/obj/item/bodypart/proc/update_icon_dropped()
	cut_overlays()
	var/list/standing = get_limb_icon(1)
	/* skyrat edit
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	*/
	for(var/image/I in standing)
		I.pixel_x = px_x
		I.pixel_y = px_y
	//skyrat edit
	for(var/obj/item/bodypart/BP in src)
		var/list/substanding = BP.get_limb_icon(1)
		for(var/image/I in substanding)
			I.pixel_x = px_x
			I.pixel_y = px_y
		standing |= substanding
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	//
	add_overlay(standing)

/***********moved to modular_skyrat
//Gives you a proper icon appearance for the dismembered limb
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

		if(!isnull(body_markings) && status == BODYPART_ORGANIC)
			if(!use_digitigrade)
				if(body_zone == BODY_ZONE_CHEST)
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
			limb.icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
			if(species_id == "husk")
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'modular_skyrat/icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"
		return

	if((body_zone != BODY_ZONE_HEAD && body_zone != BODY_ZONE_CHEST))
		should_draw_gender = FALSE

	if(is_organic_limb())
		limb.icon = base_bp_icon || 'modular_skyrat/icons/mob/human_parts.dmi'
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
				marking = image('modular_citadel/modular_skyrat/icons/mob/markings_notmammals.dmi', "husk_[body_zone]", -MARKING_LAYER, image_dir)
			else if(species_id == "husk" && use_digitigrade)
				marking = image('modular_citadel/modular_skyrat/icons/mob/markings_notmammals.dmi', "husk_[digitigrade_type]_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)

			else if(!use_digitigrade)
				if(body_zone == BODY_ZONE_CHEST)
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
						auxmarking += image('modular_citadel/modular_skyrat/icons/mob/markings_notmammals.dmi', "husk_[I]", -aux_layer, image_dir)
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
						auxmarking += image('modular_citadel/modular_skyrat/icons/mob/markings_notmammals.dmi', "husk_[I]", -aux_layer, image_dir)
					else
						auxmarking += image(body_markings_icon, "[body_markings]_[I]", -aux_layer, image_dir)
			. += auxmarking
			. += aux

		if(!isnull(body_markings))
			if(species_id == "husk")
				marking = image('modular_citadel/modular_skyrat/icons/mob/markings_notmammals.dmi', "husk_[body_zone]", -MARKING_LAYER, image_dir)
			else if(species_id == "husk" && use_digitigrade)
				marking = image('modular_citadel/modular_skyrat/icons/mob/markings_notmammals.dmi', "husk_digitigrade_[use_digitigrade]_[body_zone]", -MARKING_LAYER, image_dir)

			else if(!use_digitigrade)
				if(body_zone == BODY_ZONE_CHEST)
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
*/


/obj/item/bodypart/deconstruct(disassembled = TRUE)
	drop_organs()
	qdel(src)

/obj/item/bodypart/chest
	name = "chest" //skyrat edit
	desc = "It's impolite to stare at a person's chest."
	icon_state = "default_human_chest"
	max_damage = 200
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 200
	//skyrat variables
	amputation_point = "spine"
	children_zones = list(BODY_ZONE_PRECISE_GROIN)
	dismember_bodyzone = null
	specific_locations = list("upper chest", "lower abdomen", "midsection", "collarbone", "lower back")
	//

/obj/item/bodypart/chest/can_dismember(obj/item/I)
	if(!((owner.stat == DEAD) || owner.InFullCritical()))
		return FALSE
	return ..()

/obj/item/bodypart/chest/Destroy()
	if(cavity_item)
		qdel(cavity_item)
	return ..()

/obj/item/bodypart/chest/drop_organs(mob/user)
	if(cavity_item)
		cavity_item.forceMove(user.loc)
		cavity_item = null
	..()

//skyrat edit
/obj/item/bodypart/groin
	name = "groin"
	desc = "Some say groin came from  Grynde, which is middle-ages speak for depression. Makes sense for the situation."
	icon_state = "default_human_groin"
	max_damage = 100
	body_zone = BODY_ZONE_PRECISE_GROIN
	body_part = GROIN
	px_x = 0
	px_y = -3
	stam_damage_coeff = 1
	max_stamina_damage = 100
	amputation_point = "lumbar"
	parent_bodyzone = BODY_ZONE_CHEST
	dismember_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
	specific_locations = list("left buttock", "right buttock", "inner left thigh", "inner right thigh", "perineum")

/obj/item/bodypart/groin/can_dismember(obj/item/I)
	if(!((owner.stat == DEAD) || owner.InFullCritical()))
		return FALSE
	return ..()

/obj/item/bodypart/groin/Destroy()
	if(cavity_item)
		qdel(cavity_item)
	return ..()

/obj/item/bodypart/groin/drop_organs(mob/user)
	if(cavity_item)
		cavity_item.forceMove(user.loc)
		cavity_item = null
	..()
//

/obj/item/bodypart/chest/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_chest"
	animal_origin = MONKEY_BODYPART

//skyrat edit
/obj/item/bodypart/groin/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_groin"
	animal_origin = MONKEY_BODYPART
//

/obj/item/bodypart/chest/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_chest"
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART

//skyrat edit
/obj/item/bodypart/groin/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_groin"
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART
//

/obj/item/bodypart/chest/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

//skyrat edit
/obj/item/bodypart/chest/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//

/obj/item/bodypart/chest/larva
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "larva_chest"
	dismemberable = 0
	max_damage = 50
	animal_origin = LARVA_BODYPART

//skyrat edit
/obj/item/bodypart/chest/larva
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "larva_chest"
	dismemberable = 0
	max_damage = 50
	animal_origin = LARVA_BODYPART
//

/obj/item/bodypart/l_arm
	name = "left arm" //skyrat edit
	desc = "Did you know that the word 'sinister' stems originally from the \
		Latin 'sinestra' (left hand), because the left hand was supposed to \
		be possessed by the devil? This arm appears to be possessed by no \
		one though."
	icon_state = "default_human_l_arm"
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_L_ARM
	body_part = ARM_LEFT
	//aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER) //skyrat edit
	body_damage_coeff = 0.75
	px_x = -6
	px_y = 0
	stam_heal_tick = 4
	//skyrat variables
	amputation_point = "left shoulder"
	dismember_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_PRECISE_L_HAND)
	specific_locations = list("outer left forearm", "inner left wrist", "outer left wrist", "left elbow", "left bicep", "left shoulder")
	//

//skyrat edit
/obj/item/bodypart/l_hand
	name = "left hand"
	desc = "In old english, left meant weak, guess they were onto something if you're finding this."
	icon_state = "default_human_l_hand"
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_PRECISE_L_HAND
	body_part = HAND_LEFT
	held_index = 1
	px_x = -6
	px_y = -3
	stam_heal_tick = 3
	parent_bodyzone = BODY_ZONE_L_ARM
	dismember_bodyzone = BODY_ZONE_L_ARM
	amputation_point = "left arm"
	children_zones = list()
	specific_locations = list("left palm", "left back palm")

/obj/item/bodypart/l_hand/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/l_hand/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(owner.stat < UNCONSCIOUS)
		switch(disabled)
			if(BODYPART_DISABLED_DAMAGE)
				owner.emote("scream")
				to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
			if(BODYPART_DISABLED_PARALYSIS)
				to_chat(owner, "<span class='userdanger'>You can't feel your [name]!</span>")
	if(held_index)
		owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	if(owner.hud_used)
		var/obj/screen/inventory/hand/L = owner.hud_used.hand_slots["[held_index]"]
		if(L)
			L.update_icon()
//

/obj/item/bodypart/l_arm/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_arm"
	animal_origin = MONKEY_BODYPART
	px_x = -5
	px_y = -3
//skyrat edit
/obj/item/bodypart/l_hand/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_hand"
	animal_origin = MONKEY_BODYPART
	px_x = -7
	px_y = -3
//
/obj/item/bodypart/l_arm/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_l_arm"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//skyrat edit
/obj/item/bodypart/l_hand/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_l_hand"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//
/obj/item/bodypart/l_arm/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//skyrat edit
/obj/item/bodypart/l_hand/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//
/obj/item/bodypart/r_arm
	name = "right arm" //skyrat edit
	desc = "Over 87% of humans are right handed. That figure is much lower \
		among humans missing their right arm."
	icon_state = "default_human_r_hand"
	attack_verb = list("slapped", "punched")
	max_damage = 50
	body_zone = BODY_ZONE_R_ARM
	body_part = ARM_RIGHT
	//aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER) //skyrat edit
	body_damage_coeff = 0.75
	px_x = 6
	px_y = 0
	stam_heal_tick = STAM_RECOVERY_LIMB
	max_stamina_damage = 50
	//skyrat variables
	amputation_point = "right shoulder"
	dismember_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_PRECISE_R_HAND)
	specific_locations = list("outer right forearm", "inner right wrist", "outer right wrist", "right elbow", "right bicep", "right shoulder")
	//

//skyrat edit
/obj/item/bodypart/r_hand
	name = "right hand"
	desc = "It probably wasn't the right hand."
	icon_state = "default_human_r_hand"
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 50
	max_stamina_damage = 50
	body_zone = BODY_ZONE_PRECISE_R_HAND
	body_part = HAND_RIGHT
	held_index = 2
	px_x = 6
	px_y = -3
	stam_heal_tick = 4
	parent_bodyzone = BODY_ZONE_R_ARM
	dismember_bodyzone = BODY_ZONE_R_ARM
	amputation_point = "right arm"
	children_zones = list()
	specific_locations = list("right palm", "right back palm")

/obj/item/bodypart/r_hand/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/r_hand/set_disabled(new_disabled)
	. = ..()
	if(!.)
		return
	if(owner.stat < UNCONSCIOUS)
		switch(disabled)
			if(BODYPART_DISABLED_DAMAGE)
				owner.emote("scream")
				to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
			if(BODYPART_DISABLED_PARALYSIS)
				to_chat(owner, "<span class='userdanger'>You can't feel your [name]!</span>")
	if(held_index)
		owner.dropItemToGround(owner.get_item_for_held_index(held_index))
	if(owner.hud_used)
		var/obj/screen/inventory/hand/L = owner.hud_used.hand_slots["[held_index]"]
		if(L)
			L.update_icon()
//

/obj/item/bodypart/r_arm/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_arm"
	animal_origin = MONKEY_BODYPART
	px_x = 5
	px_y = -3
//skyrat edit
/obj/item/bodypart/r_hand/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_hand"
	animal_origin = MONKEY_BODYPART
	px_x = 5
	px_y = -9
//
/obj/item/bodypart/r_arm/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_r_arm"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//skyrat edit
/obj/item/bodypart/r_hand/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_r_hand"
	animal_origin = ALIEN_BODYPART
	px_x = 5
	px_y = -6
//
/obj/item/bodypart/r_arm/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

//skyrat edit
/obj/item/bodypart/r_hand/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//

/obj/item/bodypart/l_leg
	name = "left leg" //skyrat edit
	desc = "Some athletes prefer to tie their left shoelaces first for good \
		luck. In this instance, it probably would not have helped."
	icon_state = "default_human_l_leg"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_L_LEG
	body_part = LEG_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	stam_heal_tick = STAM_RECOVERY_LIMB
	max_stamina_damage = 50
	//skyrat vars
	dismember_bodyzone = BODY_ZONE_PRECISE_GROIN
	amputation_point = "groin"
	children_zones = list(BODY_ZONE_PRECISE_L_FOOT)
	specific_locations = list("inner left thigh", "outer left calf", "outer left hip", " left kneecap", "lower left shin")
	//
//skyrat edit
/obj/item/bodypart/l_foot
	name = "left foot" //skyrat edit
	desc = "You feel like someones gonna be needing a peg-leg."
	icon_state = "default_human_r_foot"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_PRECISE_L_FOOT
	dismember_bodyzone = BODY_ZONE_L_LEG
	body_part = FOOT_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 9
	stam_heal_tick = 4
	max_stamina_damage = 50
	children_zones = list()
	amputation_point = "right leg"
	parent_bodyzone = BODY_ZONE_L_LEG
	specific_locations = list("left sole", "left ankle", "left heel")
//
/obj/item/bodypart/l_leg/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_LEG))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/l_leg/set_disabled(new_disabled)
	. = ..()
	if(!. || owner.stat >= UNCONSCIOUS)
		return
	switch(disabled)
		if(BODYPART_DISABLED_DAMAGE)
			owner.emote("scream")
			to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		if(BODYPART_DISABLED_PARALYSIS)
			to_chat(owner, "<span class='userdanger'>You can't feel your [name]!</span>")


/obj/item/bodypart/l_leg/digitigrade
	name = "digitigrade left leg" //skyrat edit
	use_digitigrade = FULL_DIGITIGRADE
//skyrat edit
/obj/item/bodypart/l_foot/digitigrade
	name = "digitigrade left foot" //skyrat edit
	use_digitigrade = FULL_DIGITIGRADE
//
/obj/item/bodypart/l_leg/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_leg"
	animal_origin = MONKEY_BODYPART
	px_y = 4
//skyrat edit
/obj/item/bodypart/l_foot/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_foot"
	animal_origin = MONKEY_BODYPART
	px_y = 2
//
/obj/item/bodypart/l_leg/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_l_leg"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//skyrat edit
/obj/item/bodypart/l_foot/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_l_foot"
	px_x = 0
	px_y = -3
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//
/obj/item/bodypart/l_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//skyrat edit
/obj/item/bodypart/l_foot/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//

/obj/item/bodypart/r_leg
	name = "right leg" //skyrat edit
	desc = "You put your right leg in, your right leg out. In, out, in, out, \
		shake it all about. And apparently then it detaches.\n\
		The hokey pokey has certainly changed a lot since space colonisation."
	// alternative spellings of 'pokey' are availible
	icon_state = "default_human_r_leg"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	stam_heal_tick = 4
	//skyrat variables
	amputation_point = "groin"
	dismember_bodyzone = BODY_ZONE_PRECISE_GROIN
	children_zones = list(BODY_ZONE_PRECISE_R_FOOT)
	specific_locations = list("right sole", "right ankle", "right heel")
	//
//skyrat edit
/obj/item/bodypart/r_foot
	name = "right foot" //skyrat edit
	desc = "You feel like someones gonna be needing a peg-leg."
	icon_state = "default_human_r_foot"
	attack_verb = list("kicked", "stomped")
	max_damage = 50
	body_zone = BODY_ZONE_PRECISE_R_FOOT
	body_part = FOOT_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 9
	stam_heal_tick = 4
	max_stamina_damage = 50
	children_zones = list()
	amputation_point = "right leg"
	parent_bodyzone = BODY_ZONE_R_LEG
	dismember_bodyzone = BODY_ZONE_R_LEG
	specific_locations = list("right sole", "right ankle", "right heel")
//

/obj/item/bodypart/r_leg/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_R_LEG))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/r_leg/set_disabled(new_disabled)
	. = ..()
	if(!. || owner.stat >= UNCONSCIOUS)
		return
	switch(disabled)
		if(BODYPART_DISABLED_DAMAGE)
			owner.emote("scream")
			to_chat(owner, "<span class='userdanger'>Your [name] is too damaged to function!</span>")
		if(BODYPART_DISABLED_PARALYSIS)
			to_chat(owner, "<span class='userdanger'>You can't feel your [name]!</span>")

/obj/item/bodypart/r_leg/digitigrade
	name = "right digitigrade leg"
	use_digitigrade = FULL_DIGITIGRADE
//skyrat edit
/obj/item/bodypart/r_foot/digitigrade
	name = "right digitigrade foot"
	use_digitigrade = FULL_DIGITIGRADE
//
/obj/item/bodypart/r_leg/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_leg"
	animal_origin = MONKEY_BODYPART
	px_y = 4
//skyrat edit
/obj/item/bodypart/r_foot/monkey
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_foot"
	animal_origin = MONKEY_BODYPART
	px_y = 2
//
/obj/item/bodypart/r_leg/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_r_leg"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//skyrat edit
/obj/item/bodypart/r_foot/alien
	icon = 'modular_skyrat/icons/mob/animal_parts.dmi'
	icon_state = "alien_r_foot"
	px_x = 0
	px_y = -3
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART
//
/obj/item/bodypart/r_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//skyrat edit
/obj/item/bodypart/r_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART
//

//skyrat edit
/**
  * check_wounding() is where we handle rolling for, selecting, and applying a wound if we meet the criteria
  *
  * We generate a "score" for how woundable the attack was based on the damage and other factors discussed in [check_woundings_mods()], then go down the list from most severe to least severe wounds in that category.
  * We can promote a wound from a lesser to a higher severity this way, but we give up if we have a wound of the given type and fail to roll a higher severity, so no sidegrades/downgrades
  *
  * Arguments:
  * * woundtype- Either WOUND_SLASH, WOUND_PIERCE, WOUND_BLUNT, or WOUND_BURN based on the attack type.
  * * damage- How much damage is tied to this attack, since wounding potential scales with damage in an attack (see: WOUND_DAMAGE_EXPONENT)
  * * wound_bonus- The wound_bonus of an attack
  * * bare_wound_bonus- The bare_wound_bonus of an attack
  */
/obj/item/bodypart/proc/check_wounding(woundtype, damage, wound_bonus, bare_wound_bonus)
	// actually roll wounds if applicable
	var/organic = is_organic_limb()
	if(HAS_TRAIT(owner, TRAIT_EASYLIMBDISABLE))
		damage *= 1.5

	var/base_roll = rand(1, round(damage ** WOUND_DAMAGE_EXPONENT))
	var/injury_roll = base_roll
	injury_roll += check_woundings_mods(woundtype, damage, wound_bonus, bare_wound_bonus)
	var/list/wounds_checking

	switch(woundtype)
		if(WOUND_BLUNT)
			wounds_checking = WOUND_LIST_BLUNT
			if(!organic)
				wounds_checking = WOUND_LIST_BLUNT_MECHANICAL
		if(WOUND_SLASH)
			wounds_checking = WOUND_LIST_SLASH
			if(!organic)
				wounds_checking = WOUND_LIST_SLASH_MECHANICAL
		if(WOUND_PIERCE)
			wounds_checking = WOUND_LIST_PIERCE
			if(!organic)
				wounds_checking = WOUND_LIST_PIERCE_MECHANICAL
		if(WOUND_BURN)
			wounds_checking = WOUND_LIST_BURN
			if(!organic)
				wounds_checking = WOUND_LIST_BURN_MECHANICAL

	// quick re-check to see if bare_wound_bonus applies, for the benefit of log_wound(), see about getting the check from check_woundings_mods() somehow
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		var/list/clothing = H.clothingonpart(src)
		for(var/c in clothing)
			var/obj/item/clothing/clothes_check = c
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			if(clothes_check.armor.getRating("wound"))
				bare_wound_bonus = 0
				break

	//cycle through the wounds of the relevant category from the most severe down
	for(var/PW in wounds_checking)
		//I fucking hate byond, i cannot see the possible zones without creating a fucking new wound datum
		var/datum/wound/possible_wound = new PW()
		if(!(body_zone in possible_wound.viable_zones)) //Applying this wound won't even work, let's try the next one
			qdel(possible_wound)
			continue
		var/datum/wound/replaced_wound
		for(var/i in wounds)
			var/datum/wound/existing_wound = i
			if(existing_wound.type in wounds_checking)
				if(existing_wound.severity >= initial(possible_wound.severity))
					return
				else
					replaced_wound = existing_wound

		if(initial(possible_wound.threshold_minimum) < injury_roll)
			var/datum/wound/new_wound
			if(replaced_wound)
				new_wound = replaced_wound.replace_wound(possible_wound.type)
				log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll)
				qdel(possible_wound)
			else
				new_wound = new possible_wound.type
				new_wound.apply_wound(src)
				log_wound(owner, new_wound, damage, wound_bonus, bare_wound_bonus, base_roll)
				qdel(possible_wound)
			return new_wound

// try forcing a specific wound, but only if there isn't already a wound of that severity or greater for that type on this bodypart
/obj/item/bodypart/proc/force_wound_upwards(specific_woundtype, smited = FALSE)
	var/datum/wound/potential_wound = specific_woundtype
	for(var/i in wounds)
		var/datum/wound/existing_wound = i
		if(existing_wound.type in (initial(potential_wound.wound_type)))
			if(existing_wound.severity < initial(potential_wound.severity)) // we only try if the existing one is inferior to the one we're trying to force
				existing_wound.replace_wound(potential_wound, smited)
			return

	var/datum/wound/new_wound = new potential_wound
	new_wound.apply_wound(src, smited = smited)

/**
  * check_wounding_mods() is where we handle the various modifiers of a wound roll
  *
  * A short list of things we consider: any armor a human target may be wearing, and if they have no wound armor on the limb, if we have a bare_wound_bonus to apply, plus the plain wound_bonus
  * We also flick through all of the wounds we currently have on this limb and add their threshold penalties, so that having lots of bad wounds makes you more liable to get hurt worse
  * Lastly, we add the inherent wound_resistance variable the bodypart has (heads and chests are slightly harder to wound), and a small bonus if the limb is already disabled
  *
  * Arguments:
  * * It's the same ones on [receive_damage()]
  */
/obj/item/bodypart/proc/check_woundings_mods(wounding_type, damage, wound_bonus, bare_wound_bonus)
	var/armor_ablation = 0
	var/injury_mod = 0
	
	if(owner && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		var/list/clothing = H.clothingonpart(src)
		for(var/c in clothing)
			var/obj/item/clothing/C = c
			// unlike normal armor checks, we tabluate these piece-by-piece manually so we can also pass on appropriate damage the clothing's limbs if necessary
			armor_ablation += C.armor.getRating("wound")
			if(wounding_type == WOUND_SLASH)
				C.take_damage_zone(body_zone, damage, BRUTE, armour_penetration)
			else if(wounding_type == WOUND_BURN && damage >= 10) // lazy way to block freezing from shredding clothes without adding another var onto apply_damage()
				C.take_damage_zone(body_zone, damage, BURN, armour_penetration)

		if(!armor_ablation)
			injury_mod += bare_wound_bonus

	injury_mod -= armor_ablation
	injury_mod += wound_bonus

	for(var/thing in wounds)
		var/datum/wound/W = thing
		injury_mod += W.threshold_penalty

	var/part_mod = -wound_resistance
	if(is_disabled())
		part_mod += disabled_wound_penalty

	injury_mod += part_mod

	return injury_mod

/// Get whatever wound of the given type is currently attached to this limb, if any
/obj/item/bodypart/proc/get_wound_type(checking_type)
	if(isnull(wounds))
		return

	for(var/thing in wounds)
		var/datum/wound/W = thing
		if(istype(W, checking_type))
			return W

/**
  * update_wounds() is called whenever a wound is gained or lost on this bodypart, as well as if there's a change of some kind on a bone wound possibly changing disabled status
  *
  * Covers tabulating the damage multipliers we have from wounds (burn specifically), as well as deleting our gauze wrapping if we don't have any wounds that can use bandaging
  *
  * Arguments:
  * * replaced- If true, this is being called from the remove_wound() of a wound that's being replaced, so the bandage that already existed is still relevant, but the new wound hasn't been added yet
  */
/obj/item/bodypart/proc/update_wounds(replaced = FALSE)
	var/dam_mul = 1 //initial(wound_damage_multiplier)

	// we can (normally) only have one wound per type, but remember there's multiple types (smites like :B:loodless can generate multiple cuts on a limb)
	for(var/datum/wound/W in wounds)
		dam_mul *= W.damage_multiplier_penalty
	
	if(!LAZYLEN(wounds) && current_gauze && !replaced)
		owner.visible_message("<span class='notice'>\The [current_gauze] on [owner]'s [name] fall away.</span>", "<span class='notice'>The [current_gauze] on your [name] fall away.</span>")
		QDEL_NULL(current_gauze)

	wound_damage_multiplier = dam_mul
	update_disabled()

/obj/item/bodypart/proc/get_bleed_rate()
	if(status != BODYPART_ORGANIC) // maybe in the future we can bleed oil from aug parts, but not now
		return

	var/bleed_rate = 0
	if(generic_bleedstacks > 0)
		bleed_rate++
	
	//We want an accurate reading of .len
	listclearnulls(embedded_objects)
	for(var/obj/item/embeddies in embedded_objects)
		if(!embeddies.isEmbedHarmless())
			bleed_rate += 0.5

	for(var/thing in wounds)
		var/datum/wound/W = thing
		bleed_rate += W.blood_flow
	
	if(bleedsuppress)
		bleed_rate = 0

	return bleed_rate

/obj/item/bodypart/proc/apply_gauze(obj/item/stack/I)
	if(!istype(I) || !I.absorption_capacity)
		return
	QDEL_NULL(current_gauze)
	current_gauze = new I.type(src)
	current_gauze.amount = 1
	I.use(1)

/**
  * seep_gauze() is for when a gauze wrapping absorbs blood or pus from wounds, lowering its absorption capacity.
  *
  * The passed amount of seepage is deducted from the bandage's absorption capacity, and if we reach a negative absorption capacity, the bandages fall off and we're left with nothing.
  *
  * Arguments:
  * * seep_amt - How much absorption capacity we're removing from our current bandages (think, how much blood or pus are we soaking up this tick?)
  */
/obj/item/bodypart/proc/seep_gauze(seep_amt = 0)
	if(!current_gauze)
		return
	current_gauze.absorption_capacity -= seep_amt
	if(current_gauze.absorption_capacity < 0)
		owner.visible_message("<span class='danger'>\The [current_gauze] on [owner]'s [name] fall away in rags.</span>", "<span class='warning'>\The [current_gauze] on your [name] fall away in rags.</span>", vision_distance=COMBAT_MESSAGE_RANGE)
		QDEL_NULL(current_gauze)
