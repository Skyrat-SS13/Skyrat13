/datum/status_effect/crusher_mark/harm
	id = "crusher_mark_harm"
	duration = 100

/datum/status_effect/crusher_mark/harm/on_apply()
	. = ..()
	marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
	marked_underlay.pixel_x = -owner.pixel_x
	marked_underlay.pixel_y = -owner.pixel_y
	owner.underlays += marked_underlay
	return TRUE

/datum/status_effect/ebony_damage //tracks the damage dealt to this mob by the ebony blade, based on crusher damage tracking
	id = "ebony_damage"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	var/total_damage = 0

/datum/status_effect/holoburn
	id = "holoburn"
	status_type = STATUS_EFFECT_REFRESH
	tick_interval = 10
	duration = 100
	alert_type = null
	var/icon/burn

/datum/status_effect/holoburn/on_apply()
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/C = owner
		burn = icon('modular_skyrat/icons/mob/onfire.dmi', "holoburn")
		C.add_overlay(burn)
	else
		burn = icon('modular_skyrat/icons/mob/onfire.dmi', "generic_holoburn")
		owner.add_overlay(burn)

/datum/status_effect/holoburn/tick()
	. = ..()
	owner.adjustCloneLoss(1)

/datum/status_effect/holoburn/on_remove()
	. = ..()
	owner.cut_overlay(burn)

//STASIS
/datum/status_effect/grouped/stasis
	id = "stasis"
	duration = -1
	tick_interval = 10
	alert_type = /obj/screen/alert/status_effect/stasis
	var/last_dead_time

/datum/status_effect/grouped/stasis/proc/update_time_of_death()
	if(last_dead_time)
		var/delta = world.time - last_dead_time
		var/new_timeofdeath = owner.timeofdeath + delta
		owner.timeofdeath = new_timeofdeath
		owner.tod = STATION_TIME_TIMESTAMP("hh:mm:ss", world.time)
		last_dead_time = null
	if(owner.stat == DEAD)
		last_dead_time = world.time

/datum/status_effect/grouped/stasis/on_creation(mob/living/new_owner, set_duration, updating_canmove)
	. = ..()
	if(.)
		update_time_of_death()
		owner.reagents?.end_metabolization(owner, FALSE)
		owner.update_mobility()

/datum/status_effect/grouped/stasis/tick()
	update_time_of_death()

/datum/status_effect/grouped/stasis/on_remove()
	owner.update_mobility()
	update_time_of_death()
	return ..()

/obj/screen/alert/status_effect/stasis
	name = "Stasis"
	desc = "Your biological functions have halted. You could live forever this way, but it's pretty boring."
	icon = 'modular_skyrat/icons/mob/screen_alert.dmi'
	icon_state = "stasis"
