/obj/item/clothing/head/helmet/graycowl
	name = "gray cowl"
	desc = "Just a normal, everyday cowl. Nothing to see here."
	icon = 'modular_skyrat/icons/obj/clothing/traitorclothes.dmi'
	icon_state = "graycowl"
	mob_overlay_icon = null
	anthro_mob_worn_overlay = null
	item_state = null
	var/datum/dna/disguise
	var/datum/dna/stored

/obj/item/clothing/head/helmet/graycowl/Initialize()
	. = ..()
	disguise = new /datum/dna()
	stored = new /datum/dna()

/obj/item/clothing/head/helmet/graycowl/equipped(mob/M, slot)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/human/idiot = new(src)
		disguised.unique_enzymes = idiot.dna.unique_enzymes
		disguised.uni_identity = idiot.dna.uni_identity
		disguised.blood_type = idiot.dna.blood_type
		disguised.species = new idiot.dna.species.type()
		disguised.features = idiot.dna.features.Copy()
		disguised.real_name = idiot.dna.real_name
		disguised.nameless = idiot.dna.nameless
		disguised.custom_species = idiot.dna.custom_species
		disguised.mutations = idiot.dna.mutations.Copy()
		disguised.temporary_mutations = idiot.dna.temporary_mutations.Copy()
		disguised.delete_species = idiot.dna.delete_species
		disguised.mutation_index = idiot.dna.mutation_index.Copy()
		disguised.stability = idiot.dna.stability
		disguised.scrambled = idiot.dna.scrambled
		disguised.skin_tone_override = idiot.dna.skin_tone_override
		qdel(idiot)
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
