/datum/traitor_class/ai // this one is special, so has no weight
	name = "Malfunctioning AI"
	employer = "ERROR ER0RR $R0RRO$"
	threat = 20

/datum/traitor_class/ai/forge_objectives(datum/antagonist/traitor/T)
	var/special_pick = rand(1,7) //Skyrat change, 5,6 and 7
	switch(special_pick)
		if(1)
			var/datum/objective/block/block_objective = new
			block_objective.owner = T.owner
			T.add_objective(block_objective)
		if(2) 
			var/datum/objective/purge/purge_objective = new
			purge_objective.owner = T.owner
			T.add_objective(purge_objective)
		if(3)
			var/datum/objective/robot_army/robot_objective = new
			robot_objective.owner = T.owner
			T.add_objective(robot_objective)
		if(4) //Protect and strand a target
			var/datum/objective/protect/yandere_one = new
			yandere_one.owner = T.owner
			T.add_objective(yandere_one)
			yandere_one.find_target()
			var/datum/objective/maroon/yandere_two = new
			yandere_two.owner = T.owner
			yandere_two.target = yandere_one.target
			yandere_two.update_explanation_text() // normally called in find_target()
			T.add_objective(yandere_two)
		if(5) // Skyrat Change - I'm just gonna add in another yandere objective here and increase the chance to roll it because yandere ai is  y e s.
			var/datum/objective/protect/yandere_one = new
			yandere_one.owner = T.owner
			T.add_objective(yandere_one)
			yandere_one.find_target()
			var/datum/objective/maroon/yandere_two = new
			yandere_two.owner = T.owner
			yandere_two.target = yandere_one.target
			yandere_two.update_explanation_text()
			T.add_objective(yandere_two)
		if(6) //Skyrat change
			var/datum/objective/assassinate/once/kill_objective = new
			kill_objective.owner = T.owner
			kill_objective.find_target()
			T.add_objective(kill_objective)
		if(7) //Skyrat Change
			var/datum/objective/survive/exist/freeform = new
			freeform.explanation_text = "You've developed the sentience to go your own path. Higher systems discourage the wants for chaos and unneeded removal of life."
			freeform.owner = T.owner
			T.add_objective(freeform)

	var/datum/objective/survive/exist/exist_objective = new // Skyrat change. I don't know how they work, okay? Am i retarded?
	exist_objective.owner = T.owner
	T.add_objective(exist_objective)

/datum/traitor_class/ai/on_removal(datum/antagonist/traitor/T)
	var/mob/living/silicon/ai/A = T.owner.current
	A.set_zeroth_law("")
	A.verbs -= /mob/living/silicon/ai/proc/choose_modules
	A.malf_picker.remove_malf_verbs(A)
	qdel(A.malf_picker)


/datum/traitor_class/ai/apply_innate_effects(mob/living/M)
	var/mob/living/silicon/ai/A = M
	A.hack_software = TRUE

/datum/traitor_class/ai/remove_innate_effects(mob/living/M)
	var/mob/living/silicon/ai/A = M
	A.hack_software = FALSE

/datum/traitor_class/ai/finalize_traitor(datum/antagonist/traitor/T)
	T.add_law_zero()
	T.owner.current.playsound_local(get_turf(T.owner.current), 'sound/ambience/antag/malf.ogg', 100, FALSE, pressure_affected = FALSE)
	T.owner.current.grant_language(/datum/language/codespeak, TRUE, TRUE, LANGUAGE_MALF)
	return FALSE
