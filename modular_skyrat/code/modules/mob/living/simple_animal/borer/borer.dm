/mob/living/simple_animal/borer
	name = "cortical borer"
	real_name = "cortical borer"
	desc = "A small, quivering sluglike creature."
	speak_emote = list("chirrups")
	emote_hear = list("chirrups")
	response_help  = "pokes"
	response_disarm = "prods the"
	response_harm   = "stomps on the"
	icon = 'modular_skyrat/icons/mob/borer.dmi'
	icon_state = "brainslug"
	icon_living = "brainslug"
	icon_dead = "brainslug_dead"
	speed = 4
	a_intent = INTENT_HARM
	stop_automated_movement = 1
	status_flags = CANPUSH
	attacktext = "nips"
	friendly = "prods"
	wander = 0
	mob_size = MOB_SIZE_TINY
	density = 0
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	faction = list("creature", "parasite")
	ventcrawler = VENTCRAWLER_ALWAYS
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1000
	var/generation = 1
	var/static/list/borer_names = list(
			"Primary", "Secondary", "Tertiary", "Quaternary", "Quinary", "Senary",
			"Septenary", "Octonary", "Novenary", "Decenary", "Undenary", "Duodenary",
			)
	var/talk_inside_host = FALSE			// So that borers don't accidentally give themselves away on a botched message
	var/used_dominate
	var/attempting_to_dominate = FALSE		// To prevent people from spam opening the Dominate Victim input
	var/chemicals = 10						// Chemicals used for reproduction and chemical injection.
	var/max_chems = 250
	var/mob/living/carbon/human/host		// Human host for the brain worm.
	var/truename							// Name used for brainworm-speak.
	var/mob/living/captive_brain/host_brain	// Used for swapping control of the body back and forth.
	var/controlling							// Used in human death check.
	var/docile = FALSE						// Sugar can stop borers from acting.
	var/bonding = FALSE
	var/leaving = FALSE
	var/hiding = FALSE
	var/datum/action/innate/borer/talk_to_host/talk_to_host_action = new
	var/datum/action/innate/borer/infest_host/infest_host_action = new
	var/datum/action/innate/borer/toggle_hide/toggle_hide_action = new
	var/datum/action/innate/borer/talk_to_borer/talk_to_borer_action = new
	var/datum/action/innate/borer/talk_to_brain/talk_to_brain_action = new
	var/datum/action/innate/borer/take_control/take_control_action = new
	var/datum/action/innate/borer/give_back_control/give_back_control_action = new
	var/datum/action/innate/borer/leave_body/leave_body_action = new
	var/datum/action/innate/borer/make_chems/make_chems_action = new
	var/datum/action/innate/borer/make_larvae/make_larvae_action = new
	var/datum/action/innate/borer/freeze_victim/freeze_victim_action = new
	var/datum/action/innate/borer/torment/torment_action = new
