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
