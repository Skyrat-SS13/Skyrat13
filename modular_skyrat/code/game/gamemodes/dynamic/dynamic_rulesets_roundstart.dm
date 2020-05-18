/datum/dynamic_ruleset/roundstart/traitor/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"

	scaling_cost = CONFIG_GET(number/traitor_scale_cost)
	. = ..()

/datum/dynamic_ruleset/roundstart/traitorbro/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"

	scaling_cost = CONFIG_GET(number/bro_scale_cost)
	. = ..()

/datum/dynamic_ruleset/roundstart/bloodsucker/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"

	scaling_cost = CONFIG_GET(number/bloodsucker_scale_cost)
	. = ..()

/datum/dynamic_ruleset/roundstart/changeling/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/bloodcult/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/revs/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/devil/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/roundstart/monkey/New()
	restricted_roles += "Prisoner"
	restricted_roles += "Brig Physician"
	restricted_roles += "Blueshield"
	. = ..()
