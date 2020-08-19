/datum/species/anthro
	name = "Anthropomorph"
	id = "anthro"
	limbs_id = "mammal"
	default_color = "4B4B4B"
	icon_limbs = DEFAULT_BODYPART_ICON_CITADEL
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,HAS_BONE,HAS_FLESH,HAS_SKIN)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST
	mutant_bodyparts = list("mcolor" = "FFF","mcolor2" = "FFF","mcolor3" = "FFF", "mam_snouts" = "Husky", "mam_tail" = "Husky", "mam_ears" = "Husky", "deco_wings" = "None",
						 "mam_body_markings" = "Husky", "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "anthroian")
	attack_verb = "claw"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human
	liked_food = MEAT | FRIED
	disliked_food = TOXIC
	//Skyrat change - blood
	bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")
	//

//Curiosity killed the cat's wagging tail.
/datum/species/anthro/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/anthro/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/anthro/can_wag_tail(mob/living/carbon/human/H)
	return mutant_bodyparts["mam_tail"] || mutant_bodyparts["mam_waggingtail"]

/datum/species/anthro/is_wagging_tail(mob/living/carbon/human/H)
	return mutant_bodyparts["mam_waggingtail"]

/datum/species/anthro/start_wagging_tail(mob/living/carbon/human/H)
	if(mutant_bodyparts["mam_tail"])
		mutant_bodyparts["mam_waggingtail"] = mutant_bodyparts["mam_tail"]
		mutant_bodyparts -= "mam_tail"
	H.update_body()

/datum/species/anthro/stop_wagging_tail(mob/living/carbon/human/H)
	if(mutant_bodyparts["mam_waggingtail"])
		mutant_bodyparts["mam_tail"] = mutant_bodyparts["mam_waggingtail"]
		mutant_bodyparts -= "mam_waggingtail"
	H.update_body()

/datum/species/anthro/qualifies_for_rank(rank, list/features)
	return TRUE
