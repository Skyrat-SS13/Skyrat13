/datum/dynamic_ruleset/midround/autotraitor/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"
	. = ..()

/datum/dynamic_ruleset/midround/from_ghosts/blob
	required_enemies = list(3,3,3,3,3,3,3,2,2,2)
	repeatable = FALSE
	property_weights = list("story_potential" = -1, "chaos" = 1, "extended" = -2, "valid" = 1)
