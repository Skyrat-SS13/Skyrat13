//Hey there. The intention for the adv_marking datum is to allow for markings with more nuanced functions
//such as examine text fluff. That's about it really, should be pretty self-explanatory.

/datum/adv_marking
	var/name = "marking"
	var/desc = "coderman bad"
	var/examine_text = "a badly coded tattoo"
	var/obj/item/bodypart/limb
	var/mob/living/carbon/owner
	var/body_zone = BODY_ZONE_CHEST
	var/color = "#FFFFFF"
	var/has_colors = TRUE
	var/datum/sprite_accessory/attached_accessory

/datum/adv_marking/proc/is_visible(mob/viewer)
	if(!owner || !viewer || !examine_text)
		return FALSE

	if(!ishuman(owner) || isobserver(viewer) || owner == viewer)
		return TRUE

	var/mob/living/carbon/human/H = owner
	for(var/obj/item/clothing/C in H)
		if(body_zone in C.body_parts_covered)
			return FALSE

	return TRUE

/datum/adv_marking/proc/apply_on_mob(mob/living/carbon/C, zone)	
	var/obj/item/bodypart/BP = C.get_bodypart(zone)
	var/mob/living/carbon/human/H = C
	if(!istype(H)
		H = TRUE
	if(istype(BP) && (body_zone == zone) && ((H == TRUE) || H?.dna?.species?.allow_adv_markings))
		owner = C
		limb = BP
		BP.adv_markings |= src
		C.all_markings |= src
		return TRUE
	else
		return qdel(src)

/datum/adv_marking/proc/remove_on_mob(mob/living/carbon/C, zone)
	var/obj/item/bodypart/BP = C.get_bodypart(zone)
	if(istype(BP))
		owner = null
		limb = null
		BP.adv_markings -= src
		C.all_markings -= src
	return qdel(src)
