/datum/hud/var/obj/screen/arousal

/obj/screen/arousal
	name = "arousal"
	icon_state = "arousal0"
	icon = 'interactions/icons/heart.dmi'
	screen_loc = ui_arousal

/obj/screen/arousal/Click()
	if(!isliving(usr))
		return FALSE
	var/mob/living/carbon/human/M = usr
	if(M.client.prefs.toggles & VERB_CONSENT)
		if(!M.Adjacent(M.last_partner) || !M.Adjacent(M.last_partner))
			return
		if(M.lust >= M.lust_tolerance)
			M.cum(M.last_partner, M.last_orifice)
		return TRUE

/obj/screen/arousal/update_icon_state()
	if(!hud?.mymob.client)
		return FALSE
	var/mob/living/carbon/human/M = hud?.mymob
	var/value = FLOOR(M.getPercentAroused(), 10)
	if(M.refractory_period)
		var/refract = FLOOR((100/M.refract_total)*M.refractory_period, 10)
		M.hud_used.arousal.icon_state = "arousal[refract]"
		return
	switch(M.client.prefs.toggles & VERB_CONSENT)
		if(FALSE)
			M.hud_used.arousal.icon_state = "arousalx[value]"
			return FALSE
		else
			M.hud_used.arousal.icon_state = "arousal[min(value, 100)]"
	return TRUE

/mob/living/proc/getPercentAroused()
	var/percentage = ((100 / lust_tolerance) * lust)
	return percentage