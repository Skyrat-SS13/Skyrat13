/datum/map_template/shuttle/emergency/meteor
	description = "(Emag only) A hollowed out asteroid with engines strapped to it. Due to its size and difficulty in steering it, this shuttle may damage the docking area."

/datum/map_template/shuttle/emergency/meteor/prerequisites_met()
	if("emagged" in SSshuttle.shuttle_purchase_requirements_met)
		return TRUE
	return FALSE