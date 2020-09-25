//skyrat meme
/mob/living/carbon
	var/immunity 		= 100		//current immune system strength
	var/immunity_norm 	= 100		//it will regenerate to this value

/mob/living/carbon/proc/create_bodyparts()
	var/l_hand_index_next = -1
	var/r_hand_index_next = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/O = new X()
		O.owner = src
		bodyparts.Remove(X)
		bodyparts.Add(O)
		if(O.body_part == HAND_LEFT)
			l_hand_index_next += 2
			O.held_index = l_hand_index_next //1, 3, 5, 7...
			hand_bodyparts += O
		else if(O.body_part == HAND_RIGHT)
			r_hand_index_next += 2
			O.held_index = r_hand_index_next //2, 4, 6, 8...
			hand_bodyparts += O

/mob/living/carbon/handle_diseases()
	. = ..()
	if(immunity > 0.2 * immunity_norm && immunity < immunity_norm)
		immunity = min(immunity + 0.25, immunity_norm)

/mob/living/carbon/proc/virus_immunity()
	. = 0
	var/antibiotic_boost = reagents.get_reagent_amount(/datum/reagent/medicine/spaceacillin) / 20
	return max(immunity/100 * (1+antibiotic_boost), antibiotic_boost)

/mob/living/carbon/proc/immunity_weakness()
	return max(2-virus_immunity(), 0)

/mob/living/carbon/proc/get_antibiotics()
	. = 0
	. += chem_effects[CE_ANTIBIOTIC]

/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(gunpointing)
		var/dir = get_dir(get_turf(gunpointing.source),get_turf(gunpointing.target))
		if(dir)
			setDir(dir)
	// Moving around increases germ_level faster
	if(germ_level < GERM_LEVEL_MOVE_CAP && prob(8))
		germ_level++

/mob/living/carbon/wield_active_hand()
	var/obj/item/active = get_active_held_item()
	if(istype(active))
		active.wield_act(src)
	else
		to_chat(src, "<span class='warning'>You have nothing to wield!</span>")

/mob/living/carbon/proc/wield_ui_on()
	if(hud_used)
		hud_used.wielded.active = TRUE
		hud_used.wielded.update_overlays()
		return TRUE

/mob/living/carbon/proc/wield_ui_off()
	if(hud_used)
		hud_used.wielded.active = FALSE
		hud_used.wielded.update_overlays()
		return TRUE

/mob/living/carbon/fully_heal(admin_revive)
	. = ..()
	remove_all_embedded_objects()

//TGUI info menu
/mob/living/carbon/proc/item_info()
	var/obj/item/holding = get_active_held_item()
	if(istype(holding))
		SEND_SIGNAL(holding, COMSIG_ITEM_ITEMINFO, src)
	else
		to_chat(src, "<span class='warning'>You need to hold an item in your active hand to open it's information menu!</span>")

/mob/living/carbon/revive(full_heal, admin_revive)
	. = ..()
	//Regardless of full heal or not, we cap brain damage to 150 max
	if(getOrganLoss(ORGAN_SLOT_BRAIN) > 150)
		setOrganLoss(ORGAN_SLOT_BRAIN, 150)

/mob/living/carbon/succumb()
	set name = "Succumb"
	set category = "IC"
	if(src.has_status_effect(/datum/status_effect/chem/enthrall))
		var/datum/status_effect/chem/enthrall/E = src.has_status_effect(/datum/status_effect/chem/enthrall)
		if(E.phase < 3)
			if(HAS_TRAIT(src, TRAIT_MINDSHIELD))
				to_chat(src, "<span class='notice'>Your mindshield prevents your mind from giving in!</span>")
			else if(src.mind.assigned_role in GLOB.command_positions)
				to_chat(src, "<span class='notice'>Your dedication to your department prevents you from giving in!</span>")
			else
				E.enthrallTally += 20
				to_chat(src, "<span class='notice'>You give into [E.master]'s influence.</span>")
	if(InShock())
		log_message("Has succumbed to death while in [InFullShock() ? "hard":"soft"] shock with [round(health, 0.1)] points of health!", LOG_ATTACK)
		adjustOxyLoss(health - HEALTH_THRESHOLD_DEAD)
		updatehealth()
		to_chat(src, "<span class='notice'>You have given up life and succumbed to death.</span>")
		death()

/mob/living/carbon/verb/check_pulse()
	set category = "Object"
	set name = "Check pulse"
	set desc = "Approximately count somebody's pulse. Requires you to stand still at least 6 seconds."
	set src in view(1)

	var/self = FALSE
	if(usr == src)
		self = TRUE
	
	if(!usr.canUseTopic(src, TRUE) || INTERACTING_WITH(usr, src))
		to_chat(usr, "<span class='warning'>You're unable to check [self ? "your" : "[src]'s"] pulse.</</span>")
		return FALSE
	
	if(!self)
		usr.visible_message("<span class='notice'>[usr] puts \his hand on [src]'s wrist and begins counting their pulse.</span>",\
		"<span class='notice'>You begin counting [src]'s pulse...</span>")
	else
		usr.visible_message("<span class='notice'>[usr] begins counting their own pulse.</span>",\
		"<span class='notice'>You begin counting your pulse...</span>")

	if(!do_mob(usr, src, 1 SECONDS))
		to_chat(usr, "<span class='warning'>You failed to check [self ? "your" : "[src]'s"] pulse.</span>")
		return FALSE

	if(pulse())
		to_chat(usr, "<span class='notice'>[self ? "You have a" : "[src] has a"] pulse! Counting...</span>")
	else
		to_chat(usr, "<span class='danger'>[self ? "You have no" : "[src] has no"] pulse!</span>")
		return FALSE
	
	if(do_mob(usr, src, 5 SECONDS))
		to_chat(usr, "<span class='notice'>[self ? "Your" : "[src]'s"] pulse is approximately <b>[src.get_pulse(GETPULSE_BASIC)] BPM</b>.</span>")
	else
		to_chat(usr, "<span class='warning'>You failed to check [self ? "your" : "[src]'s"] pulse.</span>")
