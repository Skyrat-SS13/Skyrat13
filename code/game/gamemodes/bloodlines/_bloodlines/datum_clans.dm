/datum/vampire_clan
	var/name = "Example Clan"
	var/desc = "Is this gonna be used?"
	var/bloodlines = list()
	var/members = list()

/datum/vampire_clan/proc/setup_clan(bloodline_type)
	bloodlines += bloodline_type
	name = pick(list("Vampirus", "Darkbeingus", "Bigchungus", "Blood"))

/datum/vampire_clan/proc/add_member(var/datum/mind/vampire_mind)
	var/datum/antagonist/vampire/vamp_datum = vampire_mind.has_antag_datum(/datum/antagonist/vampire)
	if(vamp_datum)
		members += vampire_mind
		vamp_datum.vampire_clan = src
		vamp_datum.GainBloodlinesFromClan(src)