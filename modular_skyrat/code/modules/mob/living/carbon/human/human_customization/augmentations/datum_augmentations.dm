/datum/augmentation
	var/name = "Augmentation."
	var/desc = "Basic augmentation, you are not supposed to see this. Report to admins."
	var/id = 0
	var/cat_id = "cat"
	var/type_id = "none"
	var/cost = 0
	var/affecting_zone = 0
	var/restricted_species = list()

/datum/augmentation/proc/get_cost()
	return cost

/datum/augmentation/proc/apply_to_mob(mob)
	return

/datum/augmentation/limb
	type_id = AUG_TYPE_LIMB
	var/obj/item/bodypart/limb_type

/datum/augmentation/limb/apply_to_mob(mob)
	if(limb_type)
		var/mob/living/carbon/human/H = mob

		var/obj/item/bodypart/old_part = H.get_bodypart(affecting_zone)
		var/obj/item/bodypart/prosthetic = new limb_type

		prosthetic.replace_limb(H)
		qdel(old_part)
		H.regenerate_icons()

/datum/augmentation/implant
	type_id = AUG_TYPE_IMPLANT
	var/obj/item/organ/implant_type

/datum/augmentation/implant/apply_to_mob(mob)
	if(implant_type)
		var/mob/living/carbon/human/H = mob
		var/obj/item/organ/org = new implant_type
		org.Insert(H)

/datum/augmentation/organ
	type_id = AUG_TYPE_ORGAN
	var/obj/item/organ/organ_type

/datum/augmentation/organ/apply_to_mob(mob)
	if(organ_type)
		var/mob/living/carbon/human/H = mob
		var/obj/item/organ/org = new organ_type
		org.Insert(H)