/datum/antagonist/changeling/roundend_report()
	var/list/parts = list()

	parts += printplayer(owner)

	//Removed sanity if(changeling) because we -want- a runtime to inform us that the changelings list is incorrect and needs to be fixed.
	parts += "<b>Changeling ID:</b> [changelingID]."
	parts += "<b>Genomes Extracted:</b> [absorbedcount]"
	parts += " "
	if(objectives.len)
		var/count = 1
		for(var/datum/objective/objective in objectives)
			parts += "<B>Objective #[count]</B>: [objective.explanation_text]"
			count++

	return parts.Join("<br>")