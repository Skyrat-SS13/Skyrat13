//ghostface memery
/obj/item/clothing/mask/infiltrator/ghostface
	name =  "screaming mask"
	desc = "Sometimes, it's more important to ask where they are, rather than who they are."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/traitorclothes.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/traitorclothes_anthro.dmi'
	icon_state = "ghostmask"
	voice_unknown = FALSE
	var/datum/dna/disguise
	var/list/disguise_features
	var/datum/dna/stored
	var/list/stored_features

/obj/item/clothing/mask/infiltrator/ghostface/Initialize()
	. = ..()
	var/mob/living/carbon/human/idiot = new(src)
	scramble_dna(idiot, TRUE, FALSE, 100)
	randomize_human(idiot)
	idiot.name = "Screamer"
	idiot.real_name = "Screamer"
	idiot.dna.real_name = "Screamer"
	disguise = copify_dna(idiot.dna)
	disguise_features = copify_features(idiot, TRUE, TRUE)
	qdel(idiot)

/obj/item/clothing/mask/infiltrator/ghostface/equipped(mob/M, slot)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/user = M
		if(slot == SLOT_WEAR_MASK)
			stored = copify_dna(user.dna)
			stored_features = copify_features(user, TRUE, TRUE)
			user.dna = copify_dna(disguise)
			featurize_human(user, disguise_features, TRUE, TRUE)
			user.regenerate_icons()

/obj/item/clothing/mask/infiltrator/ghostface/dropped(mob/M)
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

/obj/item/clothing/head/hooded/cult_hoodie/ghostface
	name = "black hood"
	desc = "Smells faintly of blood."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/traitorclothes.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/traitorclothes_anthro.dmi'
	icon_state = "ghosthood"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 20, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 100, "wound" = 25)

/obj/item/clothing/suit/hooded/cultrobes/ghostface
	name = "black robes"
	desc = "Many people would kill to have these."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/traitorclothes.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/traitorclothes_anthro.dmi'
	icon_state = "ghostrobes"
	hoodtype = /obj/item/clothing/head/hooded/cult_hoodie/ghostface
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 20, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 100, "wound" = 25)
