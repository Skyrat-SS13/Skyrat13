//The head is a bit snowflakey
/obj/item/bodypart/head
	name = "head"
	desc = "Didn't make sense not to live for fun, your brain gets smart but your head gets dumb."
	icon = 'modular_skyrat/icons/mob/human_parts.dmi'
	icon_state = "default_human_head"
	max_damage = 100
	body_zone = BODY_ZONE_HEAD
	body_part = HEAD
	w_class = WEIGHT_CLASS_BULKY
	stam_heal_tick = 2
	stam_damage_coeff = 1
	max_stamina_damage = 100
	throw_range = 5
	px_x = 0
	px_y = -8

	//Limb appearance info:
	var/real_name = "" //Replacement name
	//Hair colour and style
	var/hair_color = "000"
	var/hair_style = "Bald"
	var/hair_alpha = 255
	//Facial hair colour and style
	var/facial_hair_color = "000"
	var/facial_hair_style = "Shaved"
	//Eye Colouring

	var/obj/item/organ/eyes/eyes = null

	var/lip_style = null
	var/lip_color = "white"
	//If the head is a special sprite
	var/custom_head
	//skyrat edit
	wound_resistance = 10
	specific_locations = list("left eyebrow", "right eyebrow", "cheekbone", "neck", "throat", "jawline", "entire face", "forehead")
	scars_covered_by_clothes = FALSE
	max_cavity_size = WEIGHT_CLASS_SMALL
	parent_bodyzone = BODY_ZONE_CHEST
	children_zones = list()
	var/obj/item/stack/sticky_tape/tapered = null
	dismember_mod = 0.7
	disembowel_mod = 0.7

/obj/item/bodypart/head/update_limb(dropping_limb, mob/living/carbon/source)
	var/mob/living/carbon/C
	if(source)
		C = source
	else
		C = owner

	real_name = C.real_name
	if(HAS_TRAIT(C, TRAIT_HUSK))
		real_name = "Unknown"
		hair_style = "Bald"
		facial_hair_style = "Shaved"
		lip_style = null

	else if(!animal_origin)
		var/mob/living/carbon/human/H = C
		var/datum/species/S = H.dna.species

		//Facial hair
		if(H.facial_hair_style && (FACEHAIR in S.species_traits))
			facial_hair_style = H.facial_hair_style
			if(S.hair_color)
				if(S.hair_color == "mutcolor")
					facial_hair_color = H.dna.features["mcolor"]
				else
					facial_hair_color = S.hair_color
			else
				facial_hair_color = H.facial_hair_color
			hair_alpha = S.hair_alpha
		else
			facial_hair_style = "Shaved"
			facial_hair_color = "000"
			hair_alpha = 255
		//Hair
		if(H.hair_style && (HAIR in S.species_traits))
			hair_style = H.hair_style
			if(S.hair_color)
				if(S.hair_color == "mutcolor")
					hair_color = H.dna.features["mcolor"]
				else
					hair_color = S.hair_color
			else
				hair_color = H.hair_color
			hair_alpha = S.hair_alpha
		else
			hair_style = "Bald"
			hair_color = "000"
			hair_alpha = initial(hair_alpha)
		// lipstick
		if(H.lip_style && (LIPS in S.species_traits))
			lip_style = H.lip_style
			lip_color = H.lip_color
		else
			lip_style = null
			lip_color = "white"
	..()

/obj/item/bodypart/head/update_icon_dropped()
	if(custom_head)
		return
	var/list/standing = get_limb_icon(1)
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	for(var/image/I in standing)
		I.pixel_x = px_x
		I.pixel_y = px_y
	add_overlay(standing)

/obj/item/bodypart/head/get_limb_icon(dropped)
	if(custom_head)
		return
	cut_overlays()
	. = ..()
	if(dropped) //certain overlays only appear when the limb is being detached from its owner.

		if(!(status & BODYPART_ROBOTIC)) //having a robotic head hides certain features.
			//facial hair
			if(facial_hair_style)
				var/datum/sprite_accessory/S = GLOB.facial_hair_styles_list[facial_hair_style]
				if(S)
					var/image/facial_overlay = image(S.icon, "[S.icon_state]", -HAIR_LAYER, SOUTH)
					facial_overlay.color = "#" + facial_hair_color
					facial_overlay.alpha = hair_alpha
					. += facial_overlay

			//Applies the debrained overlay if there is no brain
			if(!owner?.getorganslot(ORGAN_SLOT_BRAIN) && !brain)
				var/datum/sprite_accessory/S2 = GLOB.hair_styles_list[hair_style]
				if(S2)
					var/image/hair_overlay = image(S2.icon, "[S2.icon_state]", -HAIR_LAYER, SOUTH)
					hair_overlay.color = "#" + hair_color
					hair_overlay.alpha = hair_alpha
					. += hair_overlay
			else
				var/image/debrain_overlay = image(layer = -HAIR_LAYER, dir = SOUTH)
				if(animal_origin == ALIEN_BODYPART)
					debrain_overlay.icon = 'icons/mob/animal_parts.dmi'
					debrain_overlay.icon_state = "debrained_alien"
				else if(animal_origin == LARVA_BODYPART)
					debrain_overlay.icon = 'icons/mob/animal_parts.dmi'
					debrain_overlay.icon_state = "debrained_larva"
				else if(!(NOBLOOD in species_flags_list))
					debrain_overlay.icon = 'icons/mob/human_face.dmi'
					debrain_overlay.icon_state = "debrained"
				. += debrain_overlay


		// lipstick
		if(lip_style)
			var/image/lips_overlay = image('icons/mob/human_face.dmi', "lips_[lip_style]", -BODY_LAYER, SOUTH)
			lips_overlay.color = lip_color
			. += lips_overlay

		// eyes
		var/image/eyes_overlay = image('icons/mob/human_face.dmi', "eyes", -BODY_LAYER, SOUTH)
		. += eyes_overlay
		if(!eyes)
			eyes_overlay.icon_state = "eyes_missing"

		else if(eyes.eye_color)
			eyes_overlay.color = "#" + eyes.eye_color
	// tape gag
	if(tapered)
		var/mutable_appearance/tape_overlay = mutable_appearance('modular_skyrat/icons/mob/tapegag.dmi', "tapegag", -BODY_LAYER)
		. += tape_overlay

/obj/item/bodypart/head/proc/get_stickied(obj/item/stack/sticky_tape/tape, mob/user)
	if(!tape || tapered)
		return
	if(tape.use(1))
		if(user && owner)
			owner.visible_message(message = "<span class='danger'>[user] tapes [owner]'s mouth closed with \the [tape]!</span>", self_message = "<span class='userdanger'>[user] tapes your mouth closed with \the [tape]!</span>", ignored_mobs = list(user))
			to_chat(user, "<span class='warning'>You successfully gag [owner] with \the [src]!</span>")
		else if(user)
			user.visible_message("<span class='notice'>[user] tapes off [src]'s mouth.</span>")
		tapered = new tape.type(owner)
		tapered.amount = 1
		if(owner)
			ADD_TRAIT(owner, TRAIT_MUTE, "tape")
	update_limb(!owner, owner)

/obj/item/bodypart/head/Topic(href, href_list)
	. = ..()
	if(href_list["tape"])
		var/mob/living/carbon/C = usr
		if(!istype(C) || !C.canUseTopic(owner, TRUE, FALSE, FALSE) || owner?.wear_mask)
			return
		if(C == owner)
			owner.visible_message("<span class='warning'>[owner] desperately tries to rip \the [tapered] from their mouth!</span>",
								"<span class='warning'>You desperately try to rip \the [tapered] from your mouth!</span>")
			if(do_mob(owner, owner, 3 SECONDS))
				tapered.forceMove(get_turf(owner))
				tapered = null
				owner.visible_message("<span class='warning'>[owner] rips \the [tapered] from their mouth!</span>",
									"<span class='warning'>You successfully remove \the [tapered] from your mouth!</span>")
				playsound(owner, 'modular_skyrat/sound/effects/clothripping.ogg', 40, 0, -4)
				owner.emote("scream")
				REMOVE_TRAIT(owner, TRAIT_MUTE, "tape")
			else
				to_chat(owner, "<span class='warning'>You fail to take \the [tapered] off.</span>")
		else
			if(do_mob(usr, owner, 1.5 SECONDS))
				owner.UnregisterSignal(tapered, COMSIG_MOB_SAY)
				tapered.forceMove(get_turf(owner))
				tapered = null
				usr.visible_message("<span class='warning'>[usr] rips \the [tapered] from [owner]'s mouth!</span>",
								"<span class='warning'>You rip \the [tapered] out of [owner]'s mouth!</span>")
				playsound(owner, 'modular_skyrat/sound/effects/clothripping.ogg', 40, 0, -4)
				if(owner)
					owner.emote("scream")
					REMOVE_TRAIT(owner, TRAIT_MUTE, "tape")
			else
				to_chat(usr, "<span class='warning'>You fail to take \the [tapered] off.</span>")
		update_limb(!owner, owner)

/obj/item/bodypart/head/examine(mob/user)
	. = ..()
	if(tapered)
		. += "<span class='notice'>The mouth on [src] is taped shut with [tapered].</span>"

/obj/item/bodypart/head/attach_limb(mob/living/carbon/C, special)
	. = ..()
	if(. && tapered && owner)
		ADD_TRAIT(owner, TRAIT_MUTE, "tape")

/obj/item/bodypart/head/drop_limb(special, ignore_children, dismembered, destroyed)
	. = ..()
	var/mob/living/og_owner = owner
	if(.)
		REMOVE_TRAIT(og_owner, TRAIT_MUTE, "tape")

/obj/item/bodypart/head/replace_limb(mob/living/carbon/C, special)
	if(!istype(C))
		return
	var/obj/item/bodypart/head/O = C.get_bodypart(body_zone)
	if(O)
		if(!special)
			return
		else
			O.drop_limb(special, TRUE, FALSE, FALSE)
	attach_limb(C, special)
