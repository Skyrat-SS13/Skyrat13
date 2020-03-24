/obj/item/electropack/shockcollar
	var/random = TRUE
	var/freq_in_name = TRUE

/obj/item/electropack/shockcollar/Initialize()
	if (random)
		code = rand(1,100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
	if (freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	. = ..()

/obj/item/electropack/shockcollar/pacify
	name = "pacifying collar"
	desc = "A reinforced metal collar that latches onto the wearer and halts any harmful thoughts."

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
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	random = TRUE
	freq_in_name = TRUE

/obj/item/electropack/shockcollar/pacify/admin/attackby(obj/item/W, mob/living/user, params) //Prevents some cheeky ways of removing it.
	return FALSE

/obj/item/electropack/shockcollar/pacify/admin/dropped(mob/living/carbon/human/user)
	. = ..()
	qdel(src)

/obj/item/electropack/shockcollar/pacify/admin/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "admin-collar")

/obj/item/electropack/shockcollar/pacify/admin/lesser
	desc = "A Central Command branded shock collar that cannot be taken off by most means. This one has it's shocking properties removed."
	random = FALSE
	freq_in_name = FALSE
	frequency = null

/obj/item/electropack/shockcollar/pacify/admin/lesser/set_frequency(new_frequency)
	return FALSE

/mob/living/carbon/human/proc/update_admin_collar()
	if(client)
		if(jobban_isbanned(src, COLLARBAN))
			if(wear_neck && istype(wear_neck, COLLARITEM))
				qdel(wear_neck) //i dont get the logic of this but ok
				return
			if(wear_neck && !istype(wear_neck, COLLARITEM))
				qdel(wear_neck)
			var/obj/item/electropack/shockcollar/pacify/admin/collar = new()
			equip_to_slot(collar, SLOT_NECK)
		if(jobban_isbanned(src, LESSERCOLLARBAN))
			if(wear_neck && istype(wear_neck, LESSERCOLLARITEM))
				qdel(wear_neck)
				return
			if(wear_neck && !istype(wear_neck, LESSERCOLLARITEM))
				qdel(wear_neck)
			var/obj/item/electropack/shockcollar/pacify/admin/lesser/collar = new()
			equip_to_slot(collar, SLOT_NECK)
	else
		return FALSE

/datum/job/after_spawn(mob/living/H, mob/M)
	. = ..()
	if(jobban_isbanned(M, COLLARBAN) && ishuman(H))
		var/mob/living/carbon/human/E = H
		E.update_admin_collar()
	if(jobban_isbanned(M, LESSERCOLLARBAN) && ishuman(H))
		var/mob/living/carbon/human/E = H
		E.update_admin_collar()