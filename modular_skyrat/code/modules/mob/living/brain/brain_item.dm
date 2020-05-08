/obj/item/organ/brain/ipc_positron
	name = "ipc positronic brain"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_HEAD
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	desc = "A cube of shining metal, four inches to a side and covered in shallow grooves. It has an IPC serial number engraved on the top. It is usually slotted into the head of synthetic crewmembers."
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "posibrain-ipc"

/obj/item/organ/brain/ipc_positron/synth
	name = "synth positronic brain"
	zone = BODY_ZONE_HEAD
	desc = "Damn the institute!"

/obj/item/organ/brain/positron/Insert(mob/living/carbon/C, special = 0, drop_if_replaced = TRUE)
	owner = C
	C.internal_organs |= src
	C.internal_organs_slot[slot] = src
	loc = null

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(H.dna && H.dna.species && (REVIVESBYHEALING in H.dna.species.species_traits))
			if(H.health > H.dna.species.revivesbyhealreq && !H.hellbound)
				H.revive(0)

/obj/item/organ/brain/positron/emp_act(severity)
	switch(severity)
		if(1)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 75, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain heavily damaged.</span>")
		if(2)
			owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25, 150)
			to_chat(owner, "<span class='warning'>Alert: Posibrain damaged.</span>")
