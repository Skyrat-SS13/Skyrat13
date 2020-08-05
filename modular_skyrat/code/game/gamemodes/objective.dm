/datum/objective/assassinate/update_explanation_text()
	..()
	if(target && target.current)
		explanation_text = "Teach [target.name], the [!target_role_type ? target.assigned_role : target.special_role] a lesson."
	else
		explanation_text = "Free Objective"

/datum/objective/assassinate/internal/update_explanation_text()
	..()
	if(target && !target.current)
		explanation_text = "Teach [target.name] a lesson, who was obliterated"

/datum/objective/assassinate/once/find_target(dupe_search_range, blacklist)
	var/list/datum/mind/owners = get_owners()
	if(!dupe_search_range)
		dupe_search_range = get_owners()
	var/list/possible_targets = list()
	var/try_target_late_joiners = FALSE
	for(var/I in owners)
		var/datum/mind/O = I
		if(O.late_joiner)
			try_target_late_joiners = TRUE
	for(var/datum/mind/possible_target in get_crewmember_minds())
		if(!(possible_target in owners) && ishuman(possible_target.current) && (possible_target.current.stat != DEAD) && is_unique_objective(possible_target))
			if(!(possible_target in blacklist) && (possible_target.assigned_role in GLOB.command_positions))
				possible_targets += possible_target
	if(try_target_late_joiners)
		var/list/all_possible_targets = possible_targets.Copy()
		for(var/I in all_possible_targets)
			var/datum/mind/PT = I
			if(!PT.late_joiner)
				possible_targets -= PT
		if(!possible_targets.len)
			possible_targets = all_possible_targets
	if(possible_targets.len > 0)
		target = pick(possible_targets)
	else
		target = null//we'd rather have no target than an invalid one // CITADEL EDIT
	update_explanation_text()
	return target

/datum/objective/blackmail_implant
	name = "blackmail implant"
	var/target_role_type=0
	martyr_compatible = 1
	var/special_equipment = list(/obj/item/implanter/blackmail)

/datum/objective/blackmail_implant/find_target_by_role(role, role_type=0, invert=0)
	if(!invert)
		target_role_type = role_type
	..()
	give_special_equipment(special_equipment)
	return target

/datum/objective/blackmail_implant/check_completion()
	if(target && considered_alive(target))
		for(var/obj/item/implant/blackmail/bm in target.current.implants)
			return TRUE
	else
		return FALSE

/datum/objective/blackmail_implant/update_explanation_text()
	..()
	if(target && target.current)
		explanation_text = "Your employer needs to blackmail [target.name], the [!target_role_type ? target.assigned_role : target.special_role], inject them with the provided implant."
	else
		explanation_text = "Free Objective"

/datum/objective/blackmail_implant/admin_edit(mob/admin)
	admin_simple_target_pick(admin)
	give_special_equipment(special_equipment)
