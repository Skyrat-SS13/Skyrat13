//basically allows for more snowflakey, dumb and fantasy colored humans, without carrying the burden of being classified as anthropomorph base race when analyzed.
/datum/species/human/humanoid
	name = "Humanoid"
	id = "humanoid"
	icon_limbs = 'modular_skyrat/icons/mob/human_parts_greyscale.dmi'
	limbs_id = "humang"
	use_skintones = 0
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS,HAIR,HORNCOLOR,WINGCOLOR,CAN_SCAR)
	mutant_bodyparts = list("mcolor" = "FFF","mcolor2" = "FFF","mcolor3" = "FFF", "mam_snouts" = "Husky", "mam_tail" = "Husky", "mam_ears" = "Husky", "deco_wings" = "None",
						 "mam_body_markings" = "Husky", "taur" = "None", "horns" = "None", "legs" = "Plantigrade", "meat_type" = "Mammalian")
	//Skyrat change - blood
	bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-","O+", "O-")
	//

//Dunmer (Yeah, those guys that call you fetcher).
/datum/species/human/humanoid/dunmer
	name = "Ashlander"
	id = "dunmer"
	icon_limbs = 'modular_skyrat/icons/mob/dunmer_parts.dmi'
	limbs_id = "dunmer"
	hair_color = "202020"
	fixed_mut_color = "A0A0A0"
	disliked_food = null
	liked_food = GROSS | RAW
	brutemod = 1.2
	burnmod = 0.8
	coldmod = 2
	heatmod = 0.5
	species_traits = list(LIPS,HAIR,FACEHAIR)
	mutant_bodyparts = list("mcolor" = "A0A0A0") //bodypart bad, this is pure dunmer
	mutantlungs = /obj/item/organ/lungs/dunmer //they breath both on lavaland and on-station. Will this be powergamed? Not really, man - brutemod makes mining not very good.
	mutanteyes = /obj/item/organ/eyes/dunmer
	mutantears = /obj/item/organ/ears/dunmer
	icon_eyes = 'modular_skyrat/icons/mob/dunmer_face.dmi'
	//Skyrat change - blood
	bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "DRK")
	exotic_bloodtype = "DRK"
	languagewhitelist = list("Dunmeri")
	//

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

/obj/item/organ/ears/dunmer
	name = "dunmer ears"
	desc = "Have you heard of the dark elves?"
	icon = 'modular_citadel/icons/mob/mam_ears.dmi'
	icon_state = "m_ears_elf_ADJ"

/obj/item/organ/ears/dunmer/Insert(mob/living/carbon/human/H, special = 0, drop_if_replaced = TRUE)
	..()
	if(istype(H))
		color = "A0A0A0"
		H.dna.species.mutant_bodyparts |= "ears"
		H.dna.features["ears"] = "Elf, Grey"
		H.update_body()
