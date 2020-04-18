/datum/objective/make_abductee
	name = "abduct"
	martyr_compatible = 1
	var/target_real_name // Has to be stored because the target's real_name can change over the course of the round

/datum/objective/make_abductee/check_completion()

	if(!target)
		return TRUE

	if(!considered_alive(target))
		return FALSE

	if(target.special_role == ROLE_ABDUCTEE || target.special_role == ROLE_ABDUCTOR)
		return TRUE

	if(target.assigned_role == ROLE_ABDUCTEE || target.assigned_role == ROLE_ABDUCTOR)
		return TRUE

	return FALSE

/datum/objective/make_abductee/update_explanation_text()
	if(target && target.current)
		target_real_name = target.current.real_name
		explanation_text = "You think you were kidnapped by aliens! Ensure that [target_real_name], the [target.assigned_role], is also experimented on by an Abductor so they believe you!"
	else
		explanation_text = pick(world.file2list("strings/abductee_objectives.txt"))


/datum/objective/breakout/abductee/update_explanation_text()

	. = ..()

	if(!target || !target.current)
		explanation_text = pick(world.file2list("strings/abductee_objectives.txt"))

