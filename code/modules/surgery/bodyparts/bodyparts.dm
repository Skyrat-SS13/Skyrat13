// Threshold needed to have a chance of hurting internal bits with something sharp (not implemented yet)
#define LIMB_SHARP_THRESH_INT_DMG 5
// Threshold needed to have a chance of hurting internal bits
#define LIMB_THRESH_INT_DMG 10
// Probability of taking internal damage from sufficient force, while otherwise healthy
#define LIMB_DMG_PROB 5
// Probability of restraints falling off if the respective limb is fractured
#define LIMB_FRACTURE_RESTRAINT_OFF 50
// Threshold above which the limb will break with certainty (max_damage * FRACTURE_CONSTANT)
// (Above 1 means it's pretty much guaranteed to not happen)
#define FRACTURE_CONSTANT 2
// Threshold above bleeding has a very high chance to occur
// (Above 1 means it's pretty much guaranteed to not happen)
#define BLEEDING_CHANCEUP_CONSTANT 2
// Chance in percentage for a limb to internally bleed after the previous threshold
#define BLEEDING_CHANCEUP_PROB 20
// Do sharp weapons have a bigger chance to cause internal bledding? (not implemented yet)
#define SHARPNESS_MAKES_A_DIFFERENCE FALSE
/obj/item/bodypart
	name = "limb"
	desc = "Why is it detached..."
	force = 3
	throwforce = 3
	icon = 'icons/mob/human_parts.dmi'
	w_class = WEIGHT_CLASS_BULKY
	icon_state = ""
	layer = BELOW_MOB_LAYER //so it isn't hidden behind objects when on the floor
	var/mob/living/carbon/owner = null
	var/mob/living/carbon/original_owner = null
	var/status = BODYPART_ORGANIC
	var/needs_processing = FALSE
	var/body_zone //BODY_ZONE_CHEST, BODY_ZONE_L_ARM, etc , used for def_zone
	var/list/aux_icons // associative list, was used for hands but it should be (almost) useless now
	var/body_part = null //bitflag used to check which clothes cover this bodypart
	var/use_digitigrade = NOT_DIGITIGRADE //Used for alternate legs, useless elsewhere
	var/list/embedded_objects = list()
	var/held_index = 0 //are we a hand? if so, which one!
	var/is_pseudopart = FALSE //For limbs that don't really exist, eg chainsaws
	//Skymed variables, which may or may not be used.
	var/limb_name
	var/internal_bleeding = FALSE
	var/status_flags = 0
	var/max_damage = 0
	var/min_broken_damage = STANDARD_ORGAN_THRESHOLD * 0.55		//standardminimum damage for the bone to break
	var/can_grasp
	var/can_stand
	var/open = FALSE	//is this limb incised for surgery?
	var/splinted_count = 0 //Time when this bodypart was last splinted
	var/encased		//b o n e that encases the limb. used in surgery, but not actually used in "breaking" limbs.
	var/roboticFunnyVariable //only used by robotic limbs (obviously). basically the threshold at which they get disabled, since they don't break or internally bleed.
							 //also has capitalization because bobalob asked me to on discord.
	var/dismember_at_max_damage = FALSE
	var/cannot_amputate
	var/cannot_break
	var/damage_msg = "<span class='warning'>You feel an intense pain</span>"
	var/broken_description
	var/parent_bodyzone
	var/list/starting_children = list() //children that are already "inside" this limb on spawn. could be organs or limbs.
	var/list/children_zones = list()
	var/amputation_point // Descriptive string used in amputation.
	//
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

/obj/item/bodypart/Initialize()
	. = ..()
	if(starting_children.len)
		for(var/obj/item/I in starting_children)
			new I(src)

/obj/item/bodypart/examine(mob/user)
	. = ..()
	if(brute_dam > DAMAGE_PRECISION)
		. += "<span class='warning'>This limb has [brute_dam > (min_broken_damage * 1.25) ? "severe" : "minor"] bruising.</span>"
	if(burn_dam > DAMAGE_PRECISION)
		. += "<span class='warning'>This limb has [burn_dam > (min_broken_damage * 1.25) ? "severe" : "minor"] burns.</span>"

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
/obj/item/bodypart/proc/drop_organs(mob/user)
	var/turf/T = get_turf(src)
	if(status != BODYPART_ROBOTIC)
		playsound(T, 'sound/misc/splort.ogg', 50, 1, -1)
	for(var/obj/item/I in src)
		I.forceMove(T)

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

/obj/item/bodypart/proc/unsplint()
	status_flags &= ~BODYPART_SPLINTED

//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
/obj/item/bodypart/proc/receive_damage(brute = 0, burn = 0, stamina = 0, updating_health = TRUE, list/forbidden_limbs = list(), ignore_resists = FALSE)
	if(owner && (owner.status_flags & GODMODE))
		return FALSE	//godmode
	var/dmg_mlt = CONFIG_GET(number/damage_multiplier)
	brute = round(max(brute * dmg_mlt, 0),DAMAGE_PRECISION)
	burn = round(max(burn * dmg_mlt, 0),DAMAGE_PRECISION)
	stamina = round(max((stamina * dmg_mlt) * incoming_stam_mult, 0),DAMAGE_PRECISION)
	if(!ignore_resists)
		brute = max(0, brute - brute_reduction)
		burn = max(0, burn - burn_reduction)
	//No stamina scaling.. for now..

	if(!brute && !burn && !stamina)
		return FALSE

	switch(animal_origin)
		if(ALIEN_BODYPART,LARVA_BODYPART) //aliens take some additional burn //nothing can burn with so much snowflake code around
			burn *= 1.2

	//Internal organ damage
	if(LAZYLEN(owner.getorganszone(body_zone))) //Runtime in bodyparts.dm,209: pick() from empty list
		var/obj/item/organ/todamage = pick(owner.getorganszone(body_zone))
		if(((brute_dam >= max_damage) || (brute >= LIMB_THRESH_INT_DMG)) && prob(LIMB_DMG_PROB))
			todamage.applyOrganDamage(brute * 0.5) //Burn and stamina don't count toward organ damage.
	if(status_flags & BODYPART_BROKEN && prob(40) && brute)
		owner.emote("scream")	//getting hit on broken limb hurts
	//taking damage to splinted limbs may remove the splints
	if(status_flags & BODYPART_SPLINTED && prob((brute + burn)*2))
		status_flags &= ~BODYPART_SPLINTED
		owner.visible_message("<span class='danger'>The splint on [owner]'s [name] unravels from [owner.p_their()] [name]!</span>","<span class='userdanger'>The splint on your [name] unravels!</span>")
		owner.handle_splints()

	var/can_inflict = max_damage - get_damage()

	var/total_damage = brute + burn

	// Make sure we don't exceed the maximum damage a limb can take
	if(can_inflict)
		if(total_damage <= can_inflict)
			brute_dam += brute
			burn_dam += burn
			// See if we apply for internal bleeding
			check_for_internal_bleeding(brute)
			// See if bones need to break
			check_fracture(brute_dam)
			//We've dealt the physical damages, if there's room lets apply the stamina damage.
			var/current_damage = get_damage(TRUE)		//This time around, count stamina loss too.
			var/available_damage = max_damage - current_damage
			stamina_dam += round(clamp(stamina, 0, min(max_stamina_damage - stamina_dam, available_damage)), DAMAGE_PRECISION)

			if(disabled && stamina > 10)
				incoming_stam_mult = max(0.01, incoming_stam_mult/(stamina*0.1))

			if(owner && updating_health)
				owner.updatehealth()
				if(stamina > DAMAGE_PRECISION)
					owner.update_stamina()
			consider_processing()
			update_disabled()
			return update_bodypart_damage_state()
		else
			if(brute > 0)
				//Inflict all brute damage we can
				brute_dam = min(brute_dam + brute, brute_dam + can_inflict)
				var/temp = can_inflict
				//How much more damage can we inflict
				can_inflict = max(0, can_inflict - brute)
				//How much brute damage is left to inflict
				brute = max(0, brute - temp)
				// See if we apply for internal bleeding
				check_for_internal_bleeding(brute)
				// See if bones need to break
				check_fracture(brute)
			if(burn > 0 && can_inflict)
				//Inflict all burn damage we can
				burn_dam = min(burn_dam + burn, burn_dam + can_inflict)
				//How much burn damage is left to inflict
				burn = max(0, burn - can_inflict)
			if(stamina > 0)
				var/current_damage = get_damage(TRUE)
				var/available_damage = max_damage - current_damage
				stamina_dam += round(clamp(stamina, 0, min(max_stamina_damage - stamina_dam, available_damage)), DAMAGE_PRECISION)
				if(disabled && stamina > 10)
					incoming_stam_mult = max(0.01, incoming_stam_mult/(stamina*0.1))

				if(owner && updating_health)
					owner.updatehealth()
					if(stamina > DAMAGE_PRECISION)
						owner.update_stamina()
				consider_processing()
				update_disabled()
			if(burn || brute || stamina)
				//List limbs we can pass it to
				var/list/obj/item/bodypart/possible_points = list()
				if(parent_bodyzone)
					if(owner.get_bodypart(parent_bodyzone))
						possible_points += owner.get_bodypart(parent_bodyzone)
				if(children_zones)
					for(var/BP in children_zones)
						if(owner.get_bodypart(BP))
							possible_points += owner.get_bodypart(BP)
				if(forbidden_limbs.len)
					possible_points -= forbidden_limbs
				if(possible_points.len)
					//And pass the pain around
					if(possible_points.len)
						var/obj/item/bodypart/target = pick(possible_points)
						if(target)
							target.receive_damage(brute, burn, stamina, updating_health, forbidden_limbs + src, ignore_resists = TRUE) //If the damage was reduced before, don't reduce it again

				if(dismember_at_max_damage && body_zone != BODY_ZONE_CHEST && body_zone != BODY_ZONE_PRECISE_GROIN && body_zone != BODY_ZONE_HEAD) // We've ensured all damage to the mob is retained, now let's drop it, if necessary.
					src.dismember() //Gruesome!

	var/mob/living/carbon/owner_old = owner //Need to update health, but need a reference in case the below check cuts off a limb.
	//If limb took enough damage, try to cut or tear it off
	if(owner && loc == owner)
		if(can_dismember() && !HAS_TRAIT(owner, TRAIT_NODISMEMBER) && (brute_dam >= max_damage))
			if(prob(brute/2))
				src.dismember()
	if(owner_old)
		owner_old.updatehealth()

	return update_bodypart_damage_state()

/obj/item/bodypart/proc/check_fracture(var/damage)
	if(prob(100 * (damage/max_damage)) || (damage >= (max_damage * FRACTURE_CONSTANT)))
		if(status != BODYPART_ROBOTIC)
			fracture()

/obj/item/bodypart/proc/rejuvenate()
	brute_dam = 0
	burn_dam = 0
	open = 0 //Closing all wounds.
	internal_bleeding = FALSE
	// handle internal organs
	for(var/obj/item/organ/O in owner.getorganszone(body_zone))
		O.setOrganDamage(0)
		O.organ_flags &= ~ORGAN_FAILING
	if(owner)
		owner.updatehealth()
	if(!owner)
		START_PROCESSING(SSobj, src)

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/proc/heal_damage(brute, burn, stamina, only_robotic = FALSE, only_organic = TRUE, updating_health = TRUE, heal_internal_organs = FALSE)

	if(only_robotic && status != BODYPART_ROBOTIC) //This makes organic limbs not heal when the proc is in Robotic mode.
		return

	if(only_organic && status != BODYPART_ORGANIC) //This makes robolimbs not healable by chems.
		return

	brute_dam	= round(max(brute_dam - brute, 0), DAMAGE_PRECISION)
	burn_dam	= round(max(burn_dam - burn, 0), DAMAGE_PRECISION)
	stamina_dam = round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION)
	if(heal_internal_organs)
		for(var/obj/item/organ/O in owner.getorganszone(body_zone))
			O.applyOrganDamage(-brute)
	if(owner && updating_health)
		owner.updatehealth()
	consider_processing()
	update_disabled()
	return update_bodypart_damage_state()

//Returns total damage.
/obj/item/bodypart/proc/get_damage(include_stamina = FALSE)
	var/total = brute_dam + burn_dam
	if(include_stamina)
		total = max(total, stamina_dam)
	return total

//Checks disabled status thresholds
/obj/item/bodypart/proc/update_disabled()
	set_disabled(is_disabled())

/obj/item/bodypart/proc/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS))
		return BODYPART_DISABLED_PARALYSIS
	if(can_dismember() && !HAS_TRAIT(owner, TRAIT_NODISMEMBER))
		. = disabled //inertia, to avoid limbs healing 0.1 damage and being re-enabled
		if(parent_bodyzone)
			if(!(owner.get_bodypart(parent_bodyzone)))
				return BODYPART_DISABLED_DAMAGE
			else
				var/obj/item/bodypart/parent = owner.get_bodypart(parent_bodyzone)
				if(parent.is_disabled() == BODYPART_DISABLED_DAMAGE)
					return	parent.is_disabled()
		if(status_flags & BODYPART_BROKEN)
			if(!(status_flags & BODYPART_SPLINTED))
				return BODYPART_DISABLED_DAMAGE
		if((get_damage(TRUE) >= max_damage) || (HAS_TRAIT(owner, TRAIT_EASYLIMBDISABLE) && (get_damage(TRUE) >= (max_damage * 0.8))) || (status == BODYPART_ROBOTIC && (get_damage(TRUE) >= (max_damage * roboticFunnyVariable)))) //Easy limb disable or being robotic disables the limb earlier
			return BODYPART_DISABLED_DAMAGE
		if(disabled && (get_damage(TRUE) <= (max_damage * 0.5)) && status_flags & ~BODYPART_BROKEN)
			return BODYPART_NOT_DISABLED
	else
		return BODYPART_NOT_DISABLED

/obj/item/bodypart/proc/check_disabled() //This might be depreciated and should be safe to remove.
	if(!can_dismember() || HAS_TRAIT(owner, TRAIT_NODISMEMBER))
		return
	if(!disabled && (get_damage(TRUE) >= max_damage))
		set_disabled(TRUE)
	else if(disabled && (get_damage(TRUE) <= (max_damage * 0.5)))
		set_disabled(FALSE)

/obj/item/bodypart/proc/set_disabled(new_disabled)
	if(disabled == new_disabled)
		return FALSE
	disabled = new_disabled
	owner.update_health_hud() //update the healthdoll
	owner.update_body()
	owner.update_mobility()
	if(!disabled)
		incoming_stam_mult = 1
	return TRUE

/obj/item/bodypart/proc/fracture()
	if((status & BODYPART_BROKEN) || cannot_break)
		return
	if(owner)
		owner.visible_message(\
			"<span class='warning'>You hear a loud cracking sound coming from \the [owner].</span>",\
			"<span class='danger'>Something feels like it shattered in your [name]!</span>",\
			"You hear a sickening crack.")
		playsound(get_turf(owner), pick("sound/effects/bonebreak1.ogg", "sound/effects/bonebreak2.ogg", "sound/effects/bonebreak3.ogg",\
								"sound/effects/bonebreak4.ogg", "sound/effects/bonebreak5.ogg", "sound/effects/bonebreak6.ogg"), 100, 0)
		owner.emote("scream")

	status_flags &= BODYPART_BROKEN
	broken_description = pick("broken", "fracture", "hairline fracture")

	// Fractures have a chance of getting you out of the respective restraints
	if(prob(LIMB_FRACTURE_RESTRAINT_OFF) && ((name = BODY_ZONE_L_ARM) || (name = BODY_ZONE_R_ARM) || (name = BODY_ZONE_PRECISE_R_HAND) || (name = BODY_ZONE_PRECISE_L_HAND)))
		if(owner.handcuffed)
			owner.handcuffed.Destroy()
	if(prob(LIMB_FRACTURE_RESTRAINT_OFF) && ((name = BODY_ZONE_L_LEG) || (name = BODY_ZONE_R_LEG) || (name = BODY_ZONE_PRECISE_R_FOOT) || (name = BODY_ZONE_PRECISE_L_FOOT)))
		if(owner.legcuffed)
			owner.legcuffed.Destroy()

/obj/item/bodypart/proc/mend_fracture()
	if(!(status_flags & BODYPART_BROKEN))
		return FALSE

	status_flags &= ~BODYPART_BROKEN
	status_flags &= ~BODYPART_SPLINTED
	if(owner)
		owner.handle_splints()
	return TRUE

/obj/item/bodypart/proc/is_usable()
	return !(status_flags & (BODYPART_MUTATED|BODYPART_DEAD))

/obj/item/bodypart/proc/is_malfunctioning()
	return ((brute_dam + burn_dam) >= 10 && prob(brute_dam + burn_dam))

/obj/item/bodypart/proc/check_for_internal_bleeding(damage)
	if(owner && (NOBLOOD in owner.dna.species.species_traits))
		return
	if(status == BODYPART_ROBOTIC)
		return
	var/local_damage = brute_dam + damage
	if((damage >= (min_broken_damage * 0.70) && local_damage >= min_broken_damage && prob(damage)))
		internal_bleeding = TRUE
		if(owner)
			to_chat(owner, "<span class='userdanger'>You can feel something rip apart in your [name]!</span>")
	else if(status_flags & BODYPART_BROKEN && (local_damage >= max_damage) && prob(damage * 1.25))
		internal_bleeding = TRUE
		if(owner)
			to_chat(owner, "<span class='userdanger'>You can feel something rip apart in your [name]!</span>")

//Updates a bodypart's brute/burn states for use by update_damage_overlays()
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
			icon = base_bp_icon || DEFAULT_BODYPART_ICON_ROBOTIC

	if(owner)
		owner.updatehealth()
		owner.update_body() //if our head becomes robotic, we remove the lizard horns and human hair.
		owner.update_hair()
		owner.update_damage_overlays()

/obj/item/bodypart/proc/is_organic_limb()
	return (status == BODYPART_ORGANIC)

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
			if(body_zone == BODY_ZONE_L_LEG || body_zone == BODY_ZONE_R_LEG || BODY_ZONE_PRECISE_R_FOOT || BODY_ZONE_PRECISE_L_FOOT)
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

//to update the bodypart's icon when not attached to a mob
/obj/item/bodypart/proc/update_icon_dropped()
	cut_overlays()
	var/list/standing = get_limb_icon(1)
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	for(var/image/I in standing)
		I.pixel_x = px_x
		I.pixel_y = px_y
	for(var/obj/item/bodypart/BP in src)
		var/list/substanding = BP.get_limb_icon(1)
		if(!substanding.len)
			BP.icon_state = initial(icon_state)
			return
		for(var/image/I in substanding)
			I.pixel_x = BP.px_x
			I.pixel_y = px_y
		standing += substanding
	add_overlay(standing)

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
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
			if(burnstate)
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

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
			limb.icon = 'icons/mob/animal_parts.dmi'
			if(species_id == "husk")
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"
		return

	if((body_zone != BODY_ZONE_HEAD && body_zone != BODY_ZONE_CHEST && body_zone != BODY_ZONE_PRECISE_GROIN))
		should_draw_gender = FALSE

	if(is_organic_limb())
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


/obj/item/bodypart/deconstruct(disassembled = TRUE)
	drop_organs()
	qdel(src)

/obj/item/bodypart/chest
	name = BODY_ZONE_CHEST
	limb_name = "chest"
	desc = "It's impolite to stare at a person's chest."
	icon_state = "default_human_chest"
	max_damage = 100
	min_broken_damage = 35
	body_zone = BODY_ZONE_CHEST
	body_part = CHEST
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 200
	var/obj/item/cavity_item
	encased = "ribcage"
	amputation_point = "spine"
	children_zones = list(BODY_ZONE_PRECISE_GROIN)

/obj/item/bodypart/chest/groin
	name = BODY_ZONE_PRECISE_GROIN
	limb_name = "groin"
	desc = "Some say groin came from  Grynde, which is middle-ages speak for depression. Makes sense for the situation."
	icon_state = "default_human_groin"
	max_damage = 75
	min_broken_damage = 30
	body_zone = BODY_ZONE_PRECISE_GROIN
	body_part = GROIN
	px_x = 0
	px_y = 0
	stam_damage_coeff = 1
	max_stamina_damage = 75
	encased = "pelvic bone"
	amputation_point = "lumbar"
	parent_bodyzone = BODY_ZONE_CHEST
	children_zones = list(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)

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

/obj/item/bodypart/chest/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_chest"
	animal_origin = MONKEY_BODYPART

/obj/item/bodypart/chest/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_chest"
	dismemberable = 0
	max_damage = 500
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/chest/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/chest/larva
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "larva_chest"
	dismemberable = 0
	max_damage = 50
	animal_origin = LARVA_BODYPART

/obj/item/bodypart/l_arm
	name = "left arm"
	limb_name = "left arm"
	desc = "Did you know that the word 'sinister' stems originally from the \
		Latin 'sinestra' (left hand), because the left hand was supposed to \
		be possessed by the devil? This arm appears to be possessed by no \
		one though."
	icon_state = "default_human_l_arm"
	attack_verb = list("slapped")
	max_damage = 50
	max_stamina_damage = 50
	min_broken_damage = 25
	body_zone = BODY_ZONE_L_ARM
	body_part = ARM_LEFT
	body_damage_coeff = 0.75
	px_x = -6
	px_y = 0
	stam_heal_tick = 4
	children_zones = list(BODY_ZONE_PRECISE_L_HAND)
	amputation_point = "left shoulder"

/obj/item/bodypart/l_arm/l_hand
	name = "left hand"
	limb_name = "left hand"
	desc = "In old english, left meant weak, guess they were onto something if you're finding this."
	icon_state = "default_human_l_hand"
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 30
	max_stamina_damage = 30
	min_broken_damage = 15
	body_zone = BODY_ZONE_PRECISE_L_HAND
	body_part = HAND_LEFT
	body_damage_coeff = 0.8 //hands receive a biiit more damage than an arm
	held_index = 1
	px_x = -6
	px_y = 0
	stam_heal_tick = 3
	parent_bodyzone = BODY_ZONE_L_ARM
	amputation_point = "left arm"
	children_zones = list()

/obj/item/bodypart/l_arm/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_L_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/l_arm/set_disabled(new_disabled)
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

/obj/item/bodypart/l_arm/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_arm"
	held_index = 1
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)
	animal_origin = MONKEY_BODYPART
	px_x = -5
	px_y = -3

/obj/item/bodypart/l_arm/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_l_arm"
	held_index = 1
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/l_arm/devil
	held_index = 1
	aux_icons = list(BODY_ZONE_PRECISE_L_HAND = HANDS_PART_LAYER, "l_hand_behind" = BODY_BEHIND_LAYER)
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/r_arm
	name = "right arm"
	limb_name = "right arm"
	desc = "Over 87% of humans are right handed. That figure is much lower \
		among humans missing their right arm."
	icon_state = "default_human_r_arm"
	attack_verb = list("slapped")
	max_damage = 50
	body_zone = BODY_ZONE_R_ARM
	body_part = ARM_RIGHT
	body_damage_coeff = 0.75
	px_x = 6
	px_y = 0
	stam_heal_tick = 4
	max_stamina_damage = 50
	children_zones = list(BODY_ZONE_PRECISE_R_HAND)
	amputation_point = "right shoulder"

/obj/item/bodypart/r_arm/r_hand
	name = "right hand"
	limb_name = "right hand"
	desc = "It probably wasn't the right hand."
	icon_state = "default_human_r_hand"
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	attack_verb = list("slapped", "punched")
	max_damage = 30
	max_stamina_damage = 30
	body_zone = BODY_ZONE_PRECISE_R_HAND
	body_part = HAND_RIGHT
	body_damage_coeff = 0.8
	held_index = 2
	px_x = 6
	px_y = 0
	stam_heal_tick = 3
	children_zones = list()
	amputation_point = "right arm"
	parent_bodyzone = BODY_ZONE_R_ARM

/obj/item/bodypart/r_arm/is_disabled()
	if(HAS_TRAIT(owner, TRAIT_PARALYSIS_R_ARM))
		return BODYPART_DISABLED_PARALYSIS
	return ..()

/obj/item/bodypart/r_arm/set_disabled(new_disabled)
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
		var/obj/screen/inventory/hand/R = owner.hud_used.hand_slots["[held_index]"]
		if(R)
			R.update_icon()


/obj/item/bodypart/r_arm/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_arm"
	held_index = 2
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	animal_origin = MONKEY_BODYPART
	px_x = 5
	px_y = -3

/obj/item/bodypart/r_arm/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_r_arm"
	held_index = 2
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/r_arm/devil
	held_index = 2
	aux_icons = list(BODY_ZONE_PRECISE_R_HAND = HANDS_PART_LAYER, "r_hand_behind" = BODY_BEHIND_LAYER)
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/l_leg
	name = "left leg"
	limb_name = "left leg"
	desc = "Some athletes prefer to tie their left shoelaces first for good \
		luck. In this instance, it probably would not have helped."
	icon_state = "default_human_l_leg"
	attack_verb = list("slapped")
	max_damage = 50
	body_zone = BODY_ZONE_L_LEG
	body_part = LEG_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	stam_heal_tick = 4
	max_stamina_damage = 50
	can_stand = 1
	parent_bodyzone = BODY_ZONE_PRECISE_GROIN
	children_zones = list(BODY_ZONE_PRECISE_L_FOOT)
	amputation_point = "pelvis"

/obj/item/bodypart/l_leg/l_foot
	name = "left foot"
	limb_name = "left foot"
	desc = "The devils ha- oh, wait, this is a foot, huh."
	icon_state = "default_human_l_foot"
	attack_verb = list("kicked", "stomped")
	max_damage = 30
	body_zone = BODY_ZONE_PRECISE_L_FOOT
	body_part = FOOT_LEFT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	stam_heal_tick = 3
	max_stamina_damage = 30
	children_zones = list()
	amputation_point = "right leg"
	parent_bodyzone = BODY_ZONE_L_LEG

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
	name = "left digitigrade leg"
	use_digitigrade = FULL_DIGITIGRADE

/obj/item/bodypart/l_leg/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_l_leg"
	animal_origin = MONKEY_BODYPART
	px_y = 4

/obj/item/bodypart/l_leg/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_l_leg"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/l_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART

/obj/item/bodypart/r_leg
	name = "right leg"
	limb_name = "right leg"
	desc = "You put your right leg in, your right leg out. In, out, in, out, \
		shake it all about. And apparently then it detaches.\n\
		The hokey pokey has certainly changed a lot since space colonisation."
	// alternative spellings of 'pokey' are availible
	icon_state = "default_human_r_leg"
	attack_verb = list("slapped")
	max_damage = 50
	body_zone = BODY_ZONE_R_LEG
	body_part = LEG_RIGHT
	body_damage_coeff = 0.75
	px_x = 2
	px_y = 12
	max_stamina_damage = 50
	stam_heal_tick = 4
	can_stand = 1
	parent_bodyzone = BODY_ZONE_PRECISE_GROIN
	children_zones = list(BODY_ZONE_PRECISE_R_FOOT)
	amputation_point = "pelvis"

/obj/item/bodypart/r_leg/r_foot
	name = "right foot"
	limb_name = "right foot"
	desc = "You feel like someones gonna be needing a peg-leg."
	icon_state = "default_human_r_foot"
	attack_verb = list("kicked", "stomped")
	max_damage = 30
	body_zone = BODY_ZONE_PRECISE_R_FOOT
	body_part = FOOT_RIGHT
	body_damage_coeff = 0.75
	px_x = -2
	px_y = 12
	stam_heal_tick = 3
	max_stamina_damage = 30
	children_zones = list()
	amputation_point = "right leg"
	parent_bodyzone = BODY_ZONE_R_LEG

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

/obj/item/bodypart/r_leg/monkey
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "default_monkey_r_leg"
	animal_origin = MONKEY_BODYPART
	px_y = 4

/obj/item/bodypart/r_leg/alien
	icon = 'icons/mob/animal_parts.dmi'
	icon_state = "alien_r_leg"
	px_x = 0
	px_y = 0
	dismemberable = 0
	max_damage = 100
	animal_origin = ALIEN_BODYPART

/obj/item/bodypart/r_leg/devil
	dismemberable = 0
	max_damage = 5000
	animal_origin = DEVIL_BODYPART