/datum/species/anthro/avian
	name = "Avian"
	id = "avian"
	say_mod = "chirps"
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
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/avian
	liked_food = MEAT | FRIED
	disliked_food = TOXIC
	//Skyrat change - blood
	bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")
	//
