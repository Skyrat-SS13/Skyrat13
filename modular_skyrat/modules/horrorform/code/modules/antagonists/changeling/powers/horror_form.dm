/obj/effect/proc_holder/changeling/horror_form //Horror Form: turns the changeling into a terrifying abomination
	name = "Horror Form"
	desc = "We tear apart our human disguise, revealing our true form."
	helptext = "We will become an unstoppable force of destruction. We will be able to turn back into a human after some time. We require the absorption of at least one other human, and 15 extracts of DNA."
	action_icon = 'modular_skyrat/modules/horrorform/icons/mob/actions/actions_changeling.dmi'
	action_icon_state = "horror_form"
	action_background_icon_state = "bg_changeling"
	chemical_cost = 50
	dna_cost = 4
	req_dna = 10
	req_absorbs = 1
	req_human = 1
	req_stat = UNCONSCIOUS
	loudness = 4

/obj/effect/proc_holder/changeling/horror_form/sting_action(mob/living/carbon/human/user)
	if(!user)
		return 0
	user.visible_message("<span class='warning'>[user] writhes and contorts, their body expanding to inhuman proportions!</span>", \
						"<span class='danger'>We begin our transformation to our true form!</span>")
	if(!do_after(user, 30, target = user, required_mobility_flags = MOBILITY_MOVE))
		user.visible_message("<span class='warning'>[user]'s transformation abruptly reverts itself!</span>", \
							"<span class='warning'>Our transformation has been interrupted!</span>")
		return 0
	user.visible_message("<span class='warning'>[user] grows into an abomination and lets out an awful scream!</span>", \
						"<span class='userdanger'>We cast off our petty shell and enter our true form!</span>")
	if(user.handcuffed)
		var/obj/O = user.get_item_by_slot(SLOT_HANDCUFFED)
		if(istype(O))
			qdel(O)
	if(istype(user.loc, /obj/structure/closet))
		var/obj/structure/closet/C = user.loc
		if(istype(C))
			if(C && user.loc == C)
				C.visible_message("<span class='warning'>[C]'s door breaks and opens!</span>")
				new /obj/effect/decal/cleanable/greenglow(C.drop_location())
				C.welded = FALSE
				C.locked = FALSE
				C.broken = TRUE
				C.open()
	if(user.wear_suit && user.wear_suit.breakouttime)
		var/obj/item/clothing/suit/S = user.get_item_by_slot(SLOT_WEAR_SUIT)
		if(istype(S))
			qdel(S)
	var/datum/antagonist/changeling/changeling = user.mind.has_antag_datum(/datum/antagonist/changeling)
	var/mob/living/simple_animal/hostile/true_changeling/new_mob = new(get_turf(user))

	new_mob.real_name = changeling.changelingID
	new_mob.name = new_mob.real_name
	new_mob.stored_changeling = user
	user.loc = new_mob
	user.status_flags |= GODMODE
	user.mind.transfer_to(new_mob)
	user.spawn_gibs()
	//feedback_add_details("changeling_powers","HF")
	return 1
