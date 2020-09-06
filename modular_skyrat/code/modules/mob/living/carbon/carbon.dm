//skyrat meme
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

/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(gunpointing)
		var/dir = get_dir(get_turf(gunpointing.source),get_turf(gunpointing.target))
		if(dir)
			setDir(dir)

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
