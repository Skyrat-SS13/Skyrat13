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
	duration = 200
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
