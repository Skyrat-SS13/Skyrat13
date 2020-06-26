//proc used to create perfect copies of dna and species.
/proc/copify_dna(var/datum/tocopy)
	if(!tocopy)
		return FALSE
	var/datum/D = new tocopy.type()
	for(var/V in (tocopy.vars - GLOB.duplicate_forbidden_vars - GLOB.duplicate_forbidden_vars_by_type[tocopy.type]))
		if(islist(tocopy.vars[V]))
			var/list/L = tocopy.vars[V]
			D.vars[V] = L.Copy()
		else if(istype(tocopy.vars[V], /datum/species) || istype(tocopy.vars[V], /datum/dna))
			D.vars[V] = copify_dna(tocopy.vars[V])
		else
			if(!istype(tocopy.vars[V], /datum))
				D.vars[V] = tocopy.vars[V]
			else if(istype(tocopy.vars[V], /atom))
				D.vars[V] = tocopy.vars[V]
	return D

//proc to copy a human's general appearance etc
/proc/copify_features(var/mob/living/carbon/human/H, var/copy_hairs = FALSE, var/copy_wings = FALSE)
	var/list/features = list()
	if(!H || !istype(H))
		return FALSE
	features["gender"] = H.gender
	features["real_name"] = H.real_name
	features["name"] = H.name
	features["underwear"] = H.underwear
	features["undie_color"] = H.undie_color 
	features["undershirt"] = H.undershirt
	features["shirt_color"] = H.shirt_color
	features["skin_tone_override"] = H.dna.skin_tone_override
	features["skin_tone"] = H.skin_tone
	if(copy_hairs)
		features["hair_style"] = H.hair_style
		features["facial_hair_style"] = H.facial_hair_style
		features["hair_color"] = H.hair_color
		features["facial_hair_color"] = H.facial_hair_color
	else
		features["hair_style"] = "Bald"
		features["facial_hair_style"] = "Shaved"
		features["hair_color"] = "000"
		features["facial_hair_color"] = "000"
	features["eye_color"] = H.eye_color
	features["blood_type"] = H.dna.blood_type
	features["saved_underwear"] = H.underwear
	features["saved_undershirt"] = H.undershirt
	features["saved_socks"] = H.socks
	if(copy_wings)
		features["insect_wings"] = H.dna.features["insect_wings"]
		features["deco_wings"] = H.dna.features["deco_wings"]
	else
		features["insect_wings"] = "None"
		features["deco_wings"] = "None"
	return features

//proc to change a human's features based on a list made by the copify_features() proc
/proc/featurize_human(var/mob/living/carbon/human/H, var/list/features)
	if(!H || !istype(H) || !features.len)
		return FALSE
	H.gender = features["gender"]
	H.real_name = features["real_name"]
	H.name = features["name"]
	H.underwear = features["underwear"]
	H.undie_color = features["undie_color"]
	H.undershirt = features["undershirt"]
	H.shirt_color = features["shirt_color"]
	H.dna.skin_tone_override = features["skin_tone_override"]
	H.dna.features["insect_wings"] = features["insect_wings"]
	H.dna.features["deco_wings"] = features["deco_wings"]
	H.skin_tone = features["skin_tone"]
	H.hair_style = features["hair_style"]
	H.facial_hair_style = features["facial_hair_style"]
	H.hair_color = features["hair_color"]
	H.facial_hair_color = features["facial_hair_color"]
	H.eye_color = features["eye_color"]
	H.dna.blood_type = features["blood_type"]
	H.underwear = features["saved_underwear"]
	H.undershirt = features["saved_undershirt"]
	H.socks = features["saved_socks"]
	return features

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
	disguise_features = copify_features(idiot, FALSE, FALSE)
	qdel(idiot)

/obj/item/clothing/mask/infiltrator/ghostface/equipped(mob/M, slot)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/user = M
		if(slot == SLOT_WEAR_MASK)
			stored = copify_dna(user.dna)
			stored_features = copify_features(user, TRUE, TRUE)
			user.dna = copify_dna(disguise)
			featurize_human(user, disguise_features)
			user.regenerate_icons()

/obj/item/clothing/mask/infiltrator/ghostface/dropped(mob/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/user = M
		if(user && istype(user) && (user.get_item_by_slot(SLOT_WEAR_MASK) == src))
			user.dna = copify_dna(stored)
			featurize_human(user, stored_features)
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
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 20, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 100)

/obj/item/clothing/suit/hooded/cultrobes/ghostface
	name = "black robes"
	desc = "Many people would kill to have these."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/traitorclothes.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/traitorclothes_anthro.dmi'
	icon_state = "ghostrobes"
	hoodtype = /obj/item/clothing/head/hooded/cult_hoodie/ghostface
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 20, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 100)
