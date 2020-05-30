//This subsystem is entirely a skyrat change
SUBSYSTEM_DEF(antagonist)
	name = "Antagonist"
	init_order = INIT_ORDER_LANGUAGE
	flags = SS_NO_FIRE
	var/list/employer_employerdescs = list()
	var/list/employer_typepaths = list()

/datum/controller/subsystem/antagonist/Initialize(timeofday)
	for(var/traitor in subtypesof(/datum/traitor_employer))
		var/datum/traitor_employer/T = traitor
		employer_employerdescs |= list([T.name] = [T.desc])
		employer_typepaths |= list([T.name] = [T.type])
		
	return ..()
