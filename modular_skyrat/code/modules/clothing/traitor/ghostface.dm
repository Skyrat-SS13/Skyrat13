/obj/item/clothing/mask/infiltrator/ghostface
	name =  "screaming mask"
	desc = "A very suspicious mask. Reminds you of an old painting..."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/traitorclothes.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/traitorclothes_anthro.dmi'
	icon_state = "ghostmask"
	voice_unknown = FALSE
	var/datum/dna/disguise
	var/datum/dna/stored

/obj/item/clothing/mask/infiltrator/ghostface/Initialize()
	. = ..()
	disguise = new /datum/dna()
	disguise.real_name = "Ghostface"
	stored = new /datum/dna()

/obj/item/clothing/mask/infiltrator/ghostface/equipped(mob/M, slot)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/user = M
		if(slot == SLOT_WEAR_MASK)
			stored.unique_enzymes = user.dna.unique_enzymes
			stored.uni_identity = user.dna.uni_identity
			stored.blood_type = user.dna.blood_type
			stored.species = new user.dna.species.type()
			stored.features = user.dna.features.Copy()
			stored.real_name = user.dna.real_name
			stored.nameless = user.dna.nameless
			stored.custom_species = user.dna.custom_species
			stored.mutations = user.dna.mutations.Copy()
			stored.temporary_mutations = user.dna.temporary_mutations.Copy()
			stored.delete_species = user.dna.delete_species
			stored.mutation_index = user.dna.mutation_index.Copy()
			stored.stability = user.dna.stability
			stored.scrambled = user.dna.scrambled
			stored.skin_tone_override = user.dna.skin_tone_override
			user.dna.unique_enzymes = disguise.unique_enzymes
			user.dna.uni_identity = disguise.uni_identity
			user.dna.blood_type = disguise.blood_type
			user.dna.species = new disguise.species.type()
			user.dna.features = disguise.features.Copy()
			user.dna.real_name = disguise.real_name
			user.name = disguise.real_name
			user.real_name = disguise.real_name
			user.dna.nameless = disguise.nameless
			user.dna.custom_species = disguise.custom_species
			user.dna.mutations = disguise.mutations.Copy()
			user.dna.temporary_mutations = disguise.temporary_mutations.Copy()
			user.dna.delete_species = disguise.delete_species
			user.dna.mutation_index = disguise.mutation_index.Copy()
			user.dna.stability = disguise.stability
			user.dna.scrambled = disguise.scrambled
			user.dna.skin_tone_override = disguise.skin_tone_override
			user.regenerate_icons()

/obj/item/clothing/mask/infiltrator/ghostface/dropped(mob/M)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/user = M
		user.dna.unique_enzymes = stored.unique_enzymes
		user.dna.uni_identity = stored.uni_identity
		user.dna.blood_type = stored.blood_type
		user.dna.species = stored.species
		user.dna.features = stored.features.Copy()
		user.dna.real_name = stored.real_name
		user.name = stored.real_name
		user.real_name = stored.real_name
		user.dna.nameless = stored.nameless
		user.dna.custom_species = stored.custom_species
		user.dna.mutations = stored.mutations.Copy()
		user.dna.temporary_mutations = stored.temporary_mutations.Copy()
		user.dna.delete_species = stored.delete_species
		user.dna.mutation_index = stored.mutation_index.Copy()
		user.dna.stability = stored.stability
		user.dna.scrambled = stored.scrambled
		user.dna.skin_tone_override = stored.skin_tone_override
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
	desc = "Many people would kill to have this."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/traitorclothes.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/traitorclothes_anthro.dmi'
	icon_state = "ghostrobes"
	hoodtype = /obj/item/clothing/head/hooded/cult_hoodie/ghostface
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 20, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 25, "acid" = 100)
