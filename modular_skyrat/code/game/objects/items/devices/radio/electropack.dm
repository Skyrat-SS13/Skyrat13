/obj/item/electropack/shockcollar/pacify/
	name = "pacifying collar"
	desc = "A reinforced metal collar that latches onto the wearer and halts any harmful thoughts."
	frequency = 1337
	code = 30

/obj/item/electropack/shockcollar/pacify/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_NECK)
		ADD_TRAIT(user, TRAIT_PACIFISM, "pacifying-collar")

/obj/item/electropack/shockcollar/pacify/dropped(mob/living/carbon/human/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_PACIFISM, "pacifying-collar")

/obj/item/electropack/shockcollar/pacify/admin/
	name = "cent-comm pacifying collar"
	desc = "A Central Command branded shock collar that cannot be taken off by most means."

/obj/item/electropack/shockcollar/pacify/admin/dropped(mob/living/carbon/human/user)
	. = ..()
	qdel(src)

/obj/item/electropack/shockcollar/pacify/admin/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "admin-collar")

/mob/living/carbon/human/proc/update_admin_collar()
	if(wear_neck && istype(wear_neck, COLLARITEM))
		qdel(wear_neck)
		return
	if(wear_neck && !istype(wear_neck, COLLARITEM))
		qdel(wear_neck)
	var/obj/item/electropack/shockcollar/pacify/admin/collar = new()
	equip_to_slot(collar, SLOT_NECK)
	
/datum/job/after_spawn(mob/living/H, mob/M)
	. = ..()
	if(jobban_isbanned(M, COLLARBAN) && ishuman(H))
		var/mob/living/carbon/human/E = H
		E.update_admin_collar()
