/datum/augmentation
	var/name = "Augmentation."
	var/desc = "Basic augmentation, you are not supposed to see this. Report to admins."
	var/id = 0
	var/cat_id = "cat"
	var/type_id = "none"
	var/cost = 0
	var/affecting_zone = 0
	var/organic_compatible = TRUE
	var/robotic_compatible = TRUE
	var/restricted_species // = list("vox", "human") etc. If not specified then available to everyone
	var/ckey_whitelist // = list("ckey1", "ckey2") etc. If not specified then available to everyone

/datum/augmentation/proc/get_cost()
	return cost

/datum/augmentation/proc/apply_to_mob(mob/living/carbon/human/H)
	return

/datum/augmentation/limb
	type_id = AUG_TYPE_LIMB
	var/obj/item/bodypart/limb_type

/datum/augmentation/limb/apply_to_mob(mob/living/carbon/human/H)
	if(limb_type)
		var/obj/item/bodypart/old_part = H.get_bodypart(affecting_zone)
		var/obj/item/bodypart/prosthetic = new limb_type

		prosthetic.replace_limb(H)
		qdel(old_part)
		H.regenerate_icons()

/datum/augmentation/implant
	type_id = AUG_TYPE_IMPLANT
	var/obj/item/organ/implant_type

/datum/augmentation/implant/apply_to_mob(mob/living/carbon/human/H)
	if(implant_type)
		var/obj/item/organ/org = new implant_type
		org.Insert(H)

/datum/augmentation/organ
	type_id = AUG_TYPE_ORGAN
	var/obj/item/organ/organ_type

/datum/augmentation/organ/apply_to_mob(mob/living/carbon/human/H)
	if(organ_type)
		var/obj/item/organ/org = new organ_type
		org.Insert(H) 

/datum/aug_type
	var/name = "Augmentation Type"
	var/id = 0
	var/cat_list

/datum/aug_type/limb
	name = "Limb Augmentations"
	id = AUG_TYPE_LIMB

/datum/aug_type/organ
	name = "Organ Replacements"
	id = AUG_TYPE_ORGAN

/datum/aug_type/implant
	name = "Implant Enhancements"
	id = AUG_TYPE_IMPLANT 
