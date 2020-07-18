/datum/species/imp
	name = "Imp Hybrid"
	id = "imp"
	limbs_id = "imp"
	icon_limbs = 'modular_skyrat/icons/mob/demon_parts.dmi'
	default_color = "#a81212"
	sexes = 1
	exotic_blood_color = BLOOD_COLOR_HUMAN
	liked_food = MEAT | RAW | GROSS
	disliked_food = SUGAR | VEGETABLES | FRUIT | DAIRY
	brutemod = 1.1 //something something glory kills
	burnmod = 0.666 //haha funny
	stunmod = 0.9
	heatmod = 0.666
	coldmod = 2.5
	punchdamagelow = 5 //clawy
	punchdamagehigh = 10
	punchstunthreshold = 10
	siemens_coeff = 1.2 //GAUSS CANNON
	breathid = "co2"
	mutanteyes = /obj/item/organ/eyes/fakedemon
	mutant_brain = /obj/item/organ/brain/fakedemon
	mutant_heart = /obj/item/organ/heart/fakedemon
	mutantlungs = /obj/item/organ/lungs/fakedemon
	mutanttongue = /obj/item/organ/tongue/lizard
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST|MOB_UNDEAD
	species_traits = list(DIGITIGRADE, DRINKSBLOOD, HORNCOLOR, WINGCOLOR, EYECOLOR)
	inherent_traits = list(TRAIT_HIGH_BLOOD, TRAIT_HEMOPHILIA, TRAIT_KI_VAMPIRE, TRAIT_UNSTABLE) //We bleed more but we also regenerate blood more lol
	mutant_bodyparts = list("deco_wings" = "None", "taur" = "None", "horns" = "None", "legs" = "Digitigrade", "meat_type" = "Demonic")
	say_mod = "curses"
	languagewhitelist = list("Urdakian")

/datum/species/imp/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/datum/outfit/imp/O = new /datum/outfit/imp
	H.equipOutfit(O, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)
	return 0
