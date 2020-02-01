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