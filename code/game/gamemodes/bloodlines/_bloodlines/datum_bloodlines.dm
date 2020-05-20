/datum/bloodline
	var/name = "Example Bloodline"
	var/desc = "Lots of power and stuff, it's a vampire blood afterall."
	var/disciplines = list()

/datum/bloodline/brujah
	name = "Brujah Bloodline"
	desc = "Lots of power and stuff, it's a vampire blood afterall."
	disciplines = list(/datum/discipline/celerity, /datum/discipline/potence)

/datum/bloodline/tremere
	name = "Tremere Bloodline"
	desc = "Lots of power and stuff, it's a vampire blood afterall."

/datum/bloodline/ventrue
	name = "Ventrue Bloodline"
	desc = "Lots of power and stuff, it's a vampire blood afterall."

/datum/discipline
	var/name = "Example Discipline"
	var/desc = "This is a discipline which is accessed by a bloodline. It has access to several abilities."
	var/skills = list()

/datum/discipline/celerity
	name = "Celerity Discipline"
	desc = "This is a discipline which is accessed by a bloodline. It has access to several abilities."

/datum/discipline/potence
	name = "Potence Discipline"
	desc = "This is a discipline which is accessed by a bloodline. It has access to several abilities."

/datum/discipline/thaumaturgy
	name = "Thaumaturgy Discipline"
	desc = "This is a discipline which is accessed by a bloodline. It has access to several abilities."