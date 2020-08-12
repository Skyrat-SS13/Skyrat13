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
		to_chat(src, "<span class='warning'>You have nothing to wield!span>")

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
