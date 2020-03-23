/datum/game_mode/revolution/New()
	restricted_jobs += "Prisoner"
	restricted_jobs += "Brig Physician"
	protected_jobs += "Blueshield"
	. = ..()