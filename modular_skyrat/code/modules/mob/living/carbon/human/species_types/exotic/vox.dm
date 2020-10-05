/datum/species/vox
	// Bird-like humanoids
	name = "Vox"
	id = "vox"
	icon_eyes = 'modular_skyrat/icons/mob/vox_eyes.dmi'
	icon_limbs = 'modular_skyrat/icons/mob/vox_parts_greyscale.dmi'
	say_mod = "shrieks"
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,EYECOLOR,HAIR,FACEHAIR,LIPS,EYECOLOR,CAN_SCAR,HAS_SKIN,HAS_FLESH,HAS_BONE) //skyrat edit
	inherent_traits = list(TRAIT_RESISTCOLD)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutantlungs = /obj/item/organ/lungs/vox
	dangerous_existence = 1
	breathid = "n2"
	mutant_bodyparts = list("mcolor" = "0F0", "mcolor2" = "0F0", "mcolor3" = "0F0", "legs" = "Vox", "mam_body_markings" = "Vox", "mam_tail" = "Vox", "mam_snouts" = "Vox", "spines" = "Vox Bands")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	exotic_bloodtype = "SY" //synthetic, oxygenless blood
	rainbowblood = TRUE
	liked_food = MEAT | FRIED
	brutemod = 1.2
	languagewhitelist = list("Vox-pidgin")
	descriptors = list(
		/datum/mob_descriptor/height = "default",
		/datum/mob_descriptor/build = "default",
		/datum/mob_descriptor/vox_markings = "default",
	)

/datum/species/vox/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/datum/outfit/vox/O = new /datum/outfit/vox
	H.equipOutfit(O, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)
	return 0
/*
/datum/species/vox/after_equip_job(datum/job/J, mob/living/carbon/human/H)
	H.grant_language(/datum/language/vox)
*/
/datum/species/vox/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_vox_name()

	var/randname = vox_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/vox/qualifies_for_rank(rank, list/features)
	return TRUE

//I wag in death
/datum/species/vox/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/vox/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/vox/can_wag_tail(mob/living/carbon/human/H)
	return ("mam_tail" in mutant_bodyparts) || ("mam_waggingtail" in mutant_bodyparts)

/datum/species/vox/is_wagging_tail(mob/living/carbon/human/H)
	return ("mam_waggingtail" in mutant_bodyparts)

/datum/species/vox/start_wagging_tail(mob/living/carbon/human/H)
	if("mam_tail" in mutant_bodyparts)
		mutant_bodyparts -= "mam_tail"
		mutant_bodyparts -= "spines"
		mutant_bodyparts |= "mam_waggingtail"
		mutant_bodyparts |= "waggingspines"
	H.update_body()

/datum/species/vox/stop_wagging_tail(mob/living/carbon/human/H)
	if("mam_waggingtail" in mutant_bodyparts)
		mutant_bodyparts -= "mam_waggingtail"
		mutant_bodyparts -= "waggingspines"
		mutant_bodyparts |= "mam_tail"
		mutant_bodyparts |= "spines"
	H.update_body()
