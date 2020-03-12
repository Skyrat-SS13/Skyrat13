/datum/status_effect/crusher_mark/harm
	id = "crusher_mark_harm"
	duration = 100

/datum/status_effect/crusher_mark/harm/on_apply()
	marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
	marked_underlay.pixel_x = -owner.pixel_x
	marked_underlay.pixel_y = -owner.pixel_y
	owner.underlays += marked_underlay
	return TRUE

/datum/status_effect/saw_bleed/bloodletting
	id = "bloodletting"
	bleed_buildup = 5
	bleed_damage = 125
	delay_before_decay = 20