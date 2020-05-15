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
	var/require_user_feet

	var/require_target_penis
	var/require_target_anus
	var/require_target_vagina
	var/require_target_breasts
	var/require_target_feet
	//"just fucking kill me" variables
	var/extreme = FALSE //Boolean. Used to hide extreme shit from those who do not want it.
	var/require_target_ears
	var/require_target_earsockets
	var/require_target_eyes
	var/require_target_eyesockets
	//

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
		
		if(require_user_feet && (user.get_num_legs() < require_user_feet))
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have enough feet.</span>")
			return FALSE

		if(extreme)
			var/client/cli = user.client
			if(cli)
				if(cli.prefs.extremepref == "No")
					if(!silent)
						to_chat(user, "<span class = 'warning'>That's way too much for you.</span>")
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
		//weird disgusting shit goes here
		if(require_target_ears && (!target.has_ears() || target.get_item_by_slot(ITEM_SLOT_EARS)))
			if(!silent)
				if(!target.has_ears())
					to_chat(user, "<span class = 'warning'>They have no ears.</span>")
				else
					to_chat(user, "<span class = 'warning'>Their ears are covered.</span>")
			return FALSE
		
		if(require_target_eyes && (!target.has_eyes() || target.get_item_by_slot(ITEM_SLOT_EYES)))
			if(!silent)
				if(!target.has_eyes())
					to_chat(user, "<span class = 'warning'>They have no eyes.</span>")
				else
					to_chat(user, "<span class = 'warning'>Their eyes are covered.</span>")
			return FALSE
		
		if(require_target_earsockets && (target.has_ears() || target.get_item_by_slot(ITEM_SLOT_EARS)))
			if(!silent)
				if(target.has_ears())
					to_chat(user, "<span class = 'warning'>They still have ears.</span>")
				else
					to_chat(user, "<span class = 'warning'>Their earsockets are covered.</span>")
			return FALSE
		
		if(require_target_eyesockets && (target.has_eyes() || target.get_item_by_slot(ITEM_SLOT_EYES)))
			if(!silent)
				if(target.has_eyes())
					to_chat(user, "<span class = 'warning'>They still have eyes.</span>")
				else
					to_chat(user, "<span class = 'warning'>Their eyesockets are covered.</span>")
			return FALSE

		if(extreme)
			var/client/cli = target.client
			if(cli)
				if(target.client.prefs.extremepref == "No")
					if(!silent)
						to_chat(user, "<span class = 'warning'>For some reason, you don't want to do this to [target].</span>")
					return FALSE
		// honestly coding CBT mechanics would have given me less of a terrible time
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
		
		if(require_target_feet && (target.has_feet() < require_target_feet))
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have enough feet.</span>")
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
	if(user.stat == DEAD)
		to_chat(user, "<span class='warning'>You cannot while deceased!</span>")
		return
	if(extreme)
		return "<font color='#FF0000'><b>EXTREME:</b></font> [..()]"
	return "<font color='#FF0000'><b>LEWD:</b></font> [..()]"

/mob/living/carbon/human/list_interaction_attributes(var/mob/living/LM)
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
	//Here comes the fucking weird shit.
	if(client)
		var/client/cli = client
		var/client/ucli = LM.client
		if(cli.prefs.extremepref != "No")
			if(!ucli || (ucli.prefs.extremepref != "No"))
				if(!get_item_by_slot(ITEM_SLOT_EARS))
					if(has_ears())
						dat += "<br>...have unprotected ears."
					else
						dat += "<br>...have a hole where their ears should be."
				else
					dat += "<br>...have covered ears."
				if(!get_item_by_slot(ITEM_SLOT_EYES))
					if(has_eyes())
						dat += "<br>...have exposed eyes."
					else
						dat += "<br>...have exposed eyesockets."
				else
					dat += "<br>...have covered eyes."
	//
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
