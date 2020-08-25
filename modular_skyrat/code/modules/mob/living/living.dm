/mob/living
	var/datum/gunpoint/gunpointing
	var/list/gunpointed = list()
	var/obj/effect/overlay/gunpoint_effect/gp_effect
	var/list/recent_embeds = list()
	var/embed_timer
	var/last_pain_message = ""
	var/next_pain_time = 0
	var/list/chem_effects = list()
