/datum/antagonist/abductee
	job_rank = ROLE_ABDUCTEE

/datum/antagonist/abductee/proc/give_objective()
	var/mob/living/carbon/human/H = owner.current

	if(istype(H))
		H.gain_trauma_type(BRAIN_TRAUMA_SPECIAL, TRAUMA_RESILIENCE_LOBOTOMY)

	if(prob(50))
		var/datum/objective/breakout/B1 = new()
		B1.find_target_by_role(prob(50) ? ROLE_ABDUCTOR : ROLE_ABDUCTEE)
		B1.update_explanation_text()
		objectives += B1

		var/datum/objective/breakout/B2 = new()
		B2.find_target_by_role(prob(50) ? ROLE_ABDUCTOR : ROLE_ABDUCTEE)
		B2.update_explanation_text()
		objectives += B2

	else
		var/datum/objective/make_abductee/MA = new()
		MA.find_target_by_role(ROLE_ABDUCTOR,invert=TRUE)
		MA.update_explanation_text()
		objectives += MA

	var/datum/objective/escape/E = new()
	objectives += E