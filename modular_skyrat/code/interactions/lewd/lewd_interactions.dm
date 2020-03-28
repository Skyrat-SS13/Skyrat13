// If I could have gotten away with using a tilde in the type path, I would have.
/datum/interaction/lewd
	command = "assslap"
	description = "Slap their ass."
	simple_message = "USER slaps TARGET right on the ass!"
	simple_style = "danger"
	interaction_sound = 'sound/weapons/slap.ogg'
	needs_physical_contact = TRUE
	require_ooc_consent = TRUE
	max_distance = 1

	write_log_user = "ass-slapped"
	write_log_target = "was ass-slapped by"

	var/user_not_tired
	var/target_not_tired

	var/require_user_topless
	var/require_target_topless
	var/require_user_bottomless
	var/require_target_bottomless

	var/require_user_penis
	var/require_user_anus
	var/require_user_vagina
	var/require_user_breasts

	var/require_target_penis
	var/require_target_anus
	var/require_target_vagina
	var/require_target_breasts

	var/user_refractory_cost
	var/target_refractory_cost

/datum/interaction/lewd/evaluate_user(mob/living/carbon/human/user, silent = TRUE)
	if(..(user, silent))
		if(user_not_tired && user.get_refraction_dif())
			if(!silent) //bye spam
				to_chat(user, "<span class='warning'>You're still exhausted from the last time. You need to wait [DisplayTimeText(user.get_refraction_dif(), TRUE)] until you can do that!</span>")
			return FALSE

		if(require_user_bottomless && !user.is_bottomless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your pants are in the way.</span>")
			return FALSE

		if(require_user_topless && !user.is_topless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your top is in the way.</span>")
			return FALSE

		if(require_user_penis && !user.has_penis())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a penis.</span>")
			return FALSE

		if(require_user_anus && !user.has_anus())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have an anus.</span>")
			return FALSE

		if(require_user_vagina && !user.has_vagina())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a vagina.</span>")
			return FALSE

		if(require_user_breasts && !user.has_breasts())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have breasts.</span>")
			return FALSE

		if(require_ooc_consent)
			if(user.client && user.client.prefs.toggles & VERB_CONSENT)
				return TRUE
		return FALSE
	return FALSE

/datum/interaction/lewd/evaluate_target(mob/living/carbon/human/user, mob/living/carbon/human/target, silent = TRUE)
	if(..(user, target, silent))
		if(target_not_tired && target.get_refraction_dif())
			if(!silent) //same with this
				to_chat(user, "<span class='warning'>They're still exhausted from the last time. They need to wait [DisplayTimeText(target.get_refraction_dif(), TRUE)] until you can do that!</span>")
			return FALSE

		if(require_target_bottomless && !target.is_bottomless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their pants are in the way.</span>")
			return FALSE

		if(require_target_bottomless && !target.is_bottomless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their pants are in the way.</span>")
			return FALSE

		if(require_target_topless && !target.is_topless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their top is in the way.</span>")
			return FALSE

		if(require_target_penis && !target.has_penis())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a penis.</span>")
			return FALSE

		if(require_target_anus && !target.has_anus())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have an anus.</span>")
			return FALSE

		if(require_target_vagina && !target.has_vagina())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a vagina.</span>")
			return FALSE

		if(require_target_breasts && !target.has_breasts())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have breasts.</span>")
			return FALSE

		if(require_ooc_consent)
			if(target.client && target.client.prefs.toggles & VERB_CONSENT)
				return TRUE
		return FALSE
	return FALSE

/datum/interaction/lewd/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user_refractory_cost)
		user.refractory_period = world.time + user_refractory_cost*10
	if(target_refractory_cost)
		target.refractory_period = world.time + target_refractory_cost*10
	return ..()

/datum/interaction/lewd/get_action_link_for(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return "<font color='#FF0000'><b>LEWD:</b></font> [..()]"
	if(user.stat == DEAD)
		to_chat(user, "<span class='warning'>You cannot erp as ghost!</span>")
		return

/mob/living/carbon/human/list_interaction_attributes()
	var/dat = ..()
	if(get_refraction_dif())
		dat += "<br>...are sexually exhausted for the time being."
	if(a_intent == INTENT_HELP)
		dat += "<br>...are acting gentle."
	else if (a_intent == INTENT_DISARM)
		dat += "<br>...are acting playful."
	else if (a_intent == INTENT_GRAB)
		dat += "<br>...are acting rough."
	else if(a_intent == INTENT_HARM)
		dat += "<br>...are fighting anyone who comes near."
	if(is_topless())
		if(has_breasts())
			dat += "<br>...have breasts."
	if(is_bottomless())
		dat += "<br>...are naked."
		if(has_penis())
			dat += "<br>...have a penis."
		if(has_vagina())
			dat += "<br>...have a vagina."
		if(has_anus())
			dat += "<br>...have an anus."
	else
		dat += "<br>...are clothed."
	return dat