//basically allows for more snowflakey, dumb and fantasy colored humans, without carrying the burden of being classified as anthropomorph base race when analyzed.
/datum/species/human/humanoid
	name = "Humanoid"
	id = "humanoid"
	icon_limbs = DEFAULT_BODYPART_ICON_CITADEL
	limbs_id = "human"
	use_skintones = 0
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAIR,FACEHAIR,HORNCOLOR,WINGCOLOR)
	mutant_bodyparts = list("mam_tail", "mam_ears", "mam_body_markings", "mam_snouts", "deco_wings", "taur", "horns", "legs")

//Dunmer (Yeah, those guys that call you fetcher).
/datum/species/human/humanoid/dunmer
	name = "Dunmer"
	id = "dunmer"
	limbs_id = "human"
	default_color = "#888888"
	fixed_mut_color = "#888888"
	hair_color = "#202020"
	disliked_food = null
	liked_food = GROSS | RAW
	brutemod = 1.2
	burnmod = 0.8
	coldmod = 2
	heatmod = 0.5
	species_traits = list(LIPS,HAIR,FACEHAIR)
	default_features = list("mcolor" = "#888888", "mcolor2" = "None","mcolor3" = "None","tail_human" = "None", "ears" = "Elf", "wings" = "None", "taur" = "None", "deco_wings" = "None")
	mutantlungs = /obj/item/organ/lungs/dunmer //they breath both on lavaland and on-station. Will this be powergamed? Not really, man - brutemod makes mining not very good.
	mutanteyes = /obj/item/organ/eyes/dunmer



/obj/item/organ/lungs/dunmer
	name = "adapted ash lungs"
	desc = "The lungs of a dark elf, which can breathe in both normal circumstances and in a lack of oxygen."
	icon_state = "lungs-ll"
	safe_oxygen_min = 3
	cold_level_1_threshold = 280 // They're more similar to lizards than they might want to think.
	cold_level_2_threshold = 240
	cold_level_3_threshold = 200
	heat_level_1_threshold = 400
	heat_level_2_threshold = 600

/obj/item/organ/eyes/dunmer
	name = "blood red eyes"
	desc = "Eyes of a cursed race."
	icon_state = "burning_eyes"
	eye_color = "#ff0000"