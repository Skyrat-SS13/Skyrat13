/datum/species/synthliz
	name = "Synthetic Lizardperson"
	id = "synthliz"
	icon_limbs = 'modular_skyrat/icons/mob/synthliz/synthliz_parts_greyscale.dmi'
	say_mod = "beeps"
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,NOTRANSSTING,EYECOLOR,LIPS,HAIR,NOTRANSSTING,NOZOMBIE,REVIVESBYHEALING,NOHUSK,ROBOTIC_LIMBS,NO_DNA_COPY)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	mutant_bodyparts = list("ipc_antenna","mam_tail", "mam_snouts","legs", "mam_body_markings")
	default_features = list("ipc_antenna" = "None","mam_tail" = "Synthetic Lizard", "mam_snouts" = "Synthetic Lizard Snout", "legs" = "Digitigrade", "mam_body_markings" = "Synthetic Lizard Plates")
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc
	gib_types = list(/obj/effect/gibspawner/ipc, /obj/effect/gibspawner/ipc/bodypartless)
	coldmod = 0.5
	burnmod = 1.1
	heatmod = 1.5
	brutemod = 1.1
	toxmod = 0
	clonemod = 0
	siemens_coeff = 1.2 //Not more because some shocks will outright crit you, which is very unfun
	revivesbyhealreq = 50
	reagent_flags = PROCESS_SYNTHETIC
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutant_brain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc //except robotic chests don't have livers or hearts, probably something to look into later
	mutant_heart = /obj/item/organ/heart/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	exotic_blood = /datum/reagent/oil
	exotic_bloodtype = ""
	inherent_traits = list(TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH, TRAIT_LIMBATTACHMENT)


/datum/species/synthliz/qualifies_for_rank(rank, list/features)
	return TRUE

//I wag in death
/datum/species/synthliz/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/synthliz/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/synthliz/can_wag_tail(mob/living/carbon/human/H)
	return ("mam_tail" in mutant_bodyparts) || ("mam_waggingtail" in mutant_bodyparts)

/datum/species/synthliz/is_wagging_tail(mob/living/carbon/human/H)
	return ("mam_waggingtail" in mutant_bodyparts)

/datum/species/synthliz/start_wagging_tail(mob/living/carbon/human/H)
	if("mam_tail" in mutant_bodyparts)
		mutant_bodyparts -= "mam_tail"
		mutant_bodyparts |= "mam_waggingtail"
	H.update_body()

/datum/species/synthliz/stop_wagging_tail(mob/living/carbon/human/H)
	if("mam_waggingtail" in mutant_bodyparts)
		mutant_bodyparts -= "mam_waggingtail"
		mutant_bodyparts |= "mam_tail"
	H.update_body()

/datum/species/synthliz/on_species_gain(mob/living/carbon/C) // Let's make that IPC actually robotic.
	. = ..()
	var/obj/item/organ/appendix/appendix = C.getorganslot("appendix") // Easiest way to remove it.
	appendix.Remove(C)
	QDEL_NULL(appendix)
	for(var/obj/item/bodypart/O in C.bodyparts)
		O.render_like_organic = TRUE
		O.synthetic = TRUE

/datum/species/synthliz/spec_revival(mob/living/carbon/human/H)
	H.say("Reactivating [pick("core systems", "central subroutines", "key functions")]...")
	sleep(3 SECONDS)
	H.say("Reinitializing [pick("personality matrix", "behavior logic", "morality subsystems")]...")
	sleep(3 SECONDS)
	H.say("Finalizing setup...")
	sleep(3 SECONDS)
	H.say("Unit [H.real_name] is fully functional. Have a nice day.")
	return