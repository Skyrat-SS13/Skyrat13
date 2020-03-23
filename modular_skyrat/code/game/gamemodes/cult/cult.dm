/datum/game_mode/cult/New()
	restricted_jobs += "Prisoner"
	restricted_jobs += "Brig Physician"
	protected_jobs += "Blueshield"
	. = ..()