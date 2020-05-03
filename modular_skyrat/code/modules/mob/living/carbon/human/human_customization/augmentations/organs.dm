/************STOMACH*************/
/********************************/

/datum/augmentation/organ/stomach
	affecting_zone = BODY_ZONE_L_ARM
	cat_id = ORGAN_AUG_STOMACH

/datum/augmentation/organ/stomach/default
	name = "Default"
	desc = "Default stomach."
	id = "default"

/************LUNGS*************/
/********************************/

/datum/augmentation/organ/lungs
	affecting_zone = BODY_ZONE_CHEST
	cat_id = ORGAN_AUG_LUNGS

/datum/augmentation/organ/lungs/default
	name = "Default"
	desc = "Default lungs."
	id = "default"

/datum/augmentation/organ/lungs/cybernetic
	name = "Cybernetic lungs"
	desc = "A cybernetic version of the lungs, functioning almost exactly as the organic ones."
	id = "cyber"
	restricted_species = list("vox")

/************EYES*************/
/********************************/

/datum/augmentation/organ/eyes
	affecting_zone = BODY_ZONE_PRECISE_EYES
	cat_id = ORGAN_AUG_EYES

/datum/augmentation/organ/eyes/default
	name = "Default"
	desc = "Disable augmentations for eyes."
	id = "default"

/datum/augmentation/organ/eyes/cybernetic
	name = "Cybernetic eyes"
	desc = "A cybernetic replacement to your first sense, augmenting your vision."
	id = "cyber"
	organ_type = /obj/item/organ/eyes/robotic

/datum/augmentation/organ/eyes/high_luminosity
	name = "High-luminosity eyes"
	desc = "Special glowing eyes, capable of projecting a ray of colored light."
	id = "high_lumi"
	organ_type = /obj/item/organ/eyes/robotic/glow

/************HEART*************/
/********************************/

/datum/augmentation/organ/heart
	affecting_zone = BODY_ZONE_HEAD
	cat_id = ORGAN_AUG_HEART

/datum/augmentation/organ/heart/default
	name = "Default"
	desc = "Default heart."
	id = "default"

/datum/augmentation/organ/heart/cybernetic
	name = "Cybernetic heart"
	desc = "An electronic device that serves like an organic heart, due to EMP's, relying on it may prove to be dangerous."
	id = "cyber"
	organ_type = /obj/item/organ/heart/cybernetic

/************LIVER*************/
/********************************/

/datum/augmentation/organ/liver
	affecting_zone = BODY_ZONE_CHEST
	cat_id = ORGAN_AUG_LIVER

/datum/augmentation/organ/liver/default
	name = "Default"
	desc = "Default liver."
	id = "default"

/datum/augmentation/organ/liver/cybernetic
	name = "Cybernetic liver"
	desc = "A device that mimicks the functions of an organic liver."
	id = "cyber"
	organ_type = /obj/item/organ/liver/cybernetic

/************TONGUE*************/
/********************************/

/datum/augmentation/organ/tongue
	affecting_zone = BODY_ZONE_PRECISE_MOUTH
	cat_id = ORGAN_AUG_TONGUE

/datum/augmentation/organ/tongue/default
	name = "Default"
	desc = "Default tongue."
	id = "default"

/datum/augmentation/organ/tongue/robo
	name = "Positronic Voicebox"
	desc = "Robotic device integrated with your vocal cords, will not help if you're mute."
	id = "robo"
	organ_type = /obj/item/organ/tongue/robot/ipc

/datum/augmentation/organ/tongue/forked
	name = "Forked Tongue"
	desc = "A forked tongue, alike to those of reptilians, will give you a hissing accent."
	id = "forked"
	organ_type = /obj/item/organ/tongue/lizard