/datum/species/synthliz
	name = "Synthetic Lizardperson"
	id = "synthliz"
	say_mod = "beeps"
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,NOTRANSSTING,EYECOLOR,LIPS,HAIR,NOTRANSSTING,NOZOMBIE,REVIVESBYHEALING,NOHUSK,ROBOTIC_LIMBS,NO_DNA_COPY)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc
	gib_types = list(/obj/effect/gibspawner/ipc, /obj/effect/gibspawner/ipc/bodypartless)
	coldmod = 0.5
	burnmod = 1.1
	heatmod = 1.2
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
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutant_heart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	//exotic_blood = /datum/reagent/oil
	exotic_bloodtype = "HF"
	inherent_traits = list(TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH, TRAIT_LIMBATTACHMENT, TRAIT_TOXIMMUNE)

/datum/species/synthliz/on_species_gain(mob/living/carbon/C) // Let's make that IPC actually robotic.
	. = ..()
	C.grant_language(/datum/language/machine)
	var/obj/item/organ/appendix/appendix = C.getorganslot("appendix") // Easiest way to remove it.
	appendix.Remove(C)
	QDEL_NULL(appendix)
	for(var/obj/item/bodypart/O in C.bodyparts)
		O.synthetic = TRUE

/datum/species/synthliz/on_species_loss(mob/living/carbon/human/C)
	..()
	C.remove_language(/datum/language/machine)

/datum/species/synthliz/spec_revival(mob/living/carbon/human/H)
	H.say("Reactivating [pick("core systems", "central subroutines", "key functions")]...")
	sleep(3 SECONDS)
	H.say("Reinitializing [pick("personality matrix", "behavior logic", "morality subsystems")]...")
	sleep(3 SECONDS)
	H.say("Finalizing setup...")
	sleep(3 SECONDS)
	H.say("Unit [H.real_name] is fully functional. Have a nice day.")
	return 