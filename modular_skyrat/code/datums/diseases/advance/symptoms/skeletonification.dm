//Slowly transforms the infected into a boney madman
/datum/symptom/skeletonification
	name = "Flesh Melting"
	desc = "The virus slowly melts away the flesh of the infected."
	threshold_desc = list(
		"Resistance 0 or below" = "Patient's flesh just sloughs away endlessly.",
		"Resistance 1" = "Patient turns into a non-infectious zombie.",
		"Resistance 2" = "Patient turns into a plasmaman.",
		"Resistance 3" = "Patient turns into a skeleton.",
		"Resistance 4" = "Patient turns into a spaceproof skeleton.",
	)
	stealth = -2
	resistance = -2
	stage_speed = 3
	transmittable = -4
	level = 8
	severity = 3
	power = 1
	var/datum/dna/original_dna = null
	var/transformed = FALSE

/datum/symptom/skeletonification/Start(datum/disease/advance/A)
	. = ..()
	if(ishuman(A.affected_mob))
		var/mob/living/carbon/human/H = A.affected_mob
		if(isskeleton(H) || isplasmaman(H) || iszombie(H))
			return qdel(src)
		original_dna = copify_dna(H.dna)
	else
		return qdel(src)

/datum/symptom/skeletonification/End(datum/disease/advance/A)
	. = ..()
	var/mob/living/carbon/human/H = A.affected_mob
	if(. && original_dna)
		H.dna = copify_dna(original_dna)
		REMOVE_TRAIT(H, TRAIT_HUSK, "disease")
		H.regenerate_icons()

/datum/symptom/skeletonification/Activate(datum/disease/advance/A)
	. = ..()
	var/mob/living/carbon/human/H = A.affected_mob
	if(.)
		switch(A.stage)
			if(1)
				if(prob(15))
					to_chat(H, "<span class='danger'>You feel your flesh slowly slodge away...</span>")
					H.adjustBruteLoss(rand(1,10))
				else if(prob(5))
					to_chat(H, "<span class='danger'>You can feel your bones slowly separating from your muscles...</span>")
			if(2)
				if(prob(20))
					to_chat(H, "<span class='danger'>Your ribcage feels like it wants to jump out of you!</span>")
					if(prob(20))
						H.adjustOrganLoss(ORGAN_SLOT_LUNGS, rand(1, 10))
				else if(prob(10))
					to_chat(H, "<span class='danger'>Your skulls seems to fight with your eyes!</span>")
					H.adjust_blurriness(rand(1,20))
			if(3)
				if(prob(15))
					var/bodypart = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
					if(H.get_bodypart(bodypart))
						var/obj/item/bodypart/BP = H.get_bodypart(bodypart)
						BP.set_disabled(TRUE)
						to_chat(H, "<span class='userdanger'>Your [parse_zone(bodypart)] is filled with excruciating pain!</span>")
				else if(prob(5))
					to_chat(H, "<span class='danger'>Your tongue feels way sharper and harder!</span>")
					if(H.getorganslot(ORGAN_SLOT_TONGUE))
						var/obj/item/organ/O = H.getorganslot(ORGAN_SLOT_TONGUE)
						O.Remove()
						qdel(O)
					var/obj/item/organ/tongue/bone/tongue = new()
					tongue.Insert(H)
			if(4)
				if(prob(10))
					to_chat(H, "<span class='danger'>Your flesh just falls apart at the seams!</span>")
					ADD_TRAIT(H, TRAIT_HUSK, "disease")
					H.adjustBruteLoss(rand(10, 25))
					H.bleed(5)
			if(5)
				if(!transformed)
					switch(A.properties["resistance"])
						if(-12 to 0)
							if(prob(25))
								to_chat(H, "<span class='userdanger'>Your flesh painfully falls off in clumps!</span>")
								H.bleed(20)
								H.adjustBruteLoss(rand(1,10))
						if(1)
							transformed = TRUE
							H.set_species(/datum/species/zombie/notspaceproof)
						if(2)
							transformed = TRUE
							H.set_species(/datum/species/plasmaman)
						if(3)
							transformed = TRUE
							H.set_species(/datum/species/skeleton)
						if(4)
							transformed = TRUE
							H.set_species(/datum/species/skeleton/space)
					if(transformed)
						to_chat(H, "<span class='danger'>Your flesh completely falls away, revealing you a new horrifying self!</span>")
