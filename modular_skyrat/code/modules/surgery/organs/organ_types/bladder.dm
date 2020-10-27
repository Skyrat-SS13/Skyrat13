//Bladder: Help with pissing and stuff
//Most bladder code is done in species.dm
/obj/item/organ/bladder
	name = "bladder"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "bladder"
	desc = "Unlike sharks you don't use this to float."
	gender = PLURAL
	slot = ORGAN_SLOT_BLADDER
	zone = BODY_ZONE_PRECISE_GROIN
	low_threshold = 25
	high_threshold = 40
	maxHealth = 50
	relative_size = 20
	var/extra_hydration_gain = 0
	var/extra_hydration_loss = 0

/obj/item/organ/bladder/on_life()
	. = ..()
	if(!owner)
		return
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(.)
			H.dna.species.handle_hydration(H)

/obj/item/organ/bladder/proc/get_hydration_gain()
	if(damage >= low_threshold)
		return (1 - (1 * damage/maxHealth) + extra_hydration_gain)
	else
		return (1 + extra_hydration_gain)

/obj/item/organ/bladder/proc/get_hydration_loss()
	if(damage >= low_threshold)
		return (1 + (1 * damage/maxHealth) + extra_hydration_loss)
	else
		return (1 + extra_hydration_loss)
