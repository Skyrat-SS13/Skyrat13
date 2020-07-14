//"gray cowl"
/obj/item/clothing/mask/infiltrator/graycowl
	name = "Mask-querade"
	desc = "Sometimes, it's better to be someone else."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	flags_inv = 0
	visor_flags_inv = 0
	flags_cover = 0
	icon_state = "graycowl"
	mob_overlay_icon = null
	anthro_mob_worn_overlay = null
	item_state = null
	voice_unknown = FALSE
	var/new_disguise_cooldown = 0
	var/new_disguise_cooldown_time = 50
	var/datum/dna/disguise
	var/list/disguise_features
	var/datum/dna/stored
	var/list/stored_features

/obj/item/clothing/mask/infiltrator/graycowl/Initialize()
	. = ..()
	NewDisguise()

/obj/item/clothing/mask/infiltrator/graycowl/proc/NewDisguise()
	var/mob/living/carbon/human/idiot = new(src)
	scramble_dna(idiot, TRUE, FALSE, 100)
	randomize_human(idiot)
	disguise = copify_dna(idiot.dna)
	disguise_features = copify_features(idiot, TRUE, TRUE)
	qdel(idiot)

/obj/item/clothing/mask/infiltrator/graycowl/AltClick(mob/user)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(H && istype(H) && (H.get_item_by_slot(SLOT_WEAR_MASK) != src))
		if(world.time < new_disguise_cooldown)
			return
		new_disguise_cooldown = world.time + new_disguise_cooldown_time
		to_chat(H, "<span class='notice'>You rub some dust off \the [src]. It seems to glow for a moment.</span>")
		NewDisguise()

/obj/item/clothing/mask/infiltrator/graycowl/equipped(mob/M, slot)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/user = M
		if(slot == SLOT_WEAR_MASK)
			stored = copify_dna(user.dna)
			stored_features = copify_features(user, TRUE, TRUE)
			user.dna = copify_dna(disguise)
			featurize_human(user, disguise_features, TRUE, TRUE)
			user.regenerate_icons()

/obj/item/clothing/mask/infiltrator/graycowl/dropped(mob/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/user = M
		if(user && istype(user) && (user.get_item_by_slot(SLOT_WEAR_MASK) == src))
			user.dna = copify_dna(stored)
			featurize_human(user, stored_features, TRUE, TRUE)
			qdel(stored)
			stored = null
			stored_features = list()
			user.regenerate_icons()
