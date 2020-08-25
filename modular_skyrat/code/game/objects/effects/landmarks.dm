/obj/effect/landmark/start/prisoner
	name = "Prisoner"
	icon = 'modular_skyrat/icons/mob/landmarks.dmi'
	icon_state = "Prisoner"

/obj/effect/landmark/start/prisoner/prilate
	name = "Prisoner"
	icon = 'modular_skyrat/icons/mob/landmarks.dmi'
	icon_state = "Prisoner"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/brig_physician
	name = "Brig Physician"
	icon_state = "Medical Doctor"

/obj/effect/landmark/start/blueshield
	name = "Blueshield"
	icon_state = "Security Officer"

/obj/effect/landmark/start/psychologist
	name = "Psychologist"
	icon_state = "Medical Doctor"

// EORG //
/obj/effect/landmark/eorg
	name = "Transport Interchange"
	icon_state = "holding_facility"
GLOBAL_DATUM_INIT(eorg_teleport, /obj/effect/landmark/eorg, null)
/obj/effect/landmark/eorg/Initialize(loc, ...)
	. = ..()
	GLOB.eorg_teleport = src
// EORG //
