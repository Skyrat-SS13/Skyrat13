/mob/living/verb/g2g()
	set category = "OOC"
	set name = "G2G"
	set desc = "Offer your body to be possessed by spooky ghosts."

	var/penalty = CONFIG_GET(number/suicide_reenter_round_timer) MINUTES
	var/roundstart_quit_limit = CONFIG_GET(number/roundstart_suicide_time_limit) MINUTES
	if(world.time < roundstart_quit_limit)
		penalty += roundstart_quit_limit - world.time
	if(SSautotransfer.can_fire && SSautotransfer.maxvotes)
		var/maximumRoundEnd = SSautotransfer.starttime + SSautotransfer.voteinterval * SSautotransfer.maxvotes
		if(penalty - SSshuttle.realtimeofstart > maximumRoundEnd + SSshuttle.emergencyCallTime + SSshuttle.emergencyDockTime + SSshuttle.emergencyEscapeTime)
			penalty = CANT_REENTER_ROUND

	var/sig_flags = SEND_SIGNAL(src, COMSIG_MOB_GHOSTIZE, (stat == DEAD) ? TRUE : FALSE, FALSE, (stat == DEAD)? penalty : 0, (stat == DEAD)? TRUE : FALSE)

	if(sig_flags & COMPONENT_BLOCK_GHOSTING)
		return

	if(sig_flags & COMPONENT_DO_NOT_PENALIZE_GHOSTING)
		penalty = 0

	if(stat != DEAD)
		succumb()

	else
		var/response = alert(src, "Are you -sure- you want to G2G (got to go), offering your body for current ghosts?\n(You are alive. If you G2G whilst alive you won't be able to re-enter this round [penalty ? "or play ghost roles [penalty == CANT_REENTER_ROUND ? "until the round is over" : "for the next [DisplayTimeText(penalty)]"]" : ""]! You can't change your mind so choose wisely!!)","Are you sure you want to G2G?","Offer your body","Stay in body")
		if(response != "Offer your body")
			return FALSE	//i don't want to be possesseeeeeeeeeeeeeed noooooooooo
		else
			var/response2 = alert(src, "Are you completely, positively sure you want to offer yourself to ghosts?","Are you REALLY sure?","Yes","No")
			if(response2 == "Yes")
				if(offer_control(src))
					return TRUE
				else
					return FALSE
			else
				return FALSE

offer_control(mob/M) //slightly changes the proc to indicate if the mob offered is alive or dead.
	to_chat(M, "Control of your mob has been offered to dead players.")
	if(usr)
		log_admin("[key_name(usr)] has offered control of ([key_name(M)]) to ghosts.")
		message_admins("[key_name_admin(usr)] has offered control of ([ADMIN_LOOKUPFLW(M)]) to ghosts")
	var/poll_message = "Do you want to play as [M.real_name]?"
	if(M.mind && M.mind.assigned_role)
		poll_message = "[poll_message] Job:[M.mind.assigned_role]."
	if(M.mind && M.mind.special_role)
		poll_message = "[poll_message] Status:[M.mind.special_role]."
	else if(M.mind)
		var/datum/antagonist/A = M.mind.has_antag_datum(/datum/antagonist/)
		if(A)
			poll_message = "[poll_message] Status:[A.name]."
	poll_message = "[poll_message] Deceased status: [M.stat != DEAD ? "Alive":"Dead"]"
	var/list/mob/candidates = pollCandidatesForMob(poll_message, ROLE_PAI, null, FALSE, 100, M)

	if(LAZYLEN(candidates))
		var/mob/C = pick(candidates)
		to_chat(M, "Your mob has been taken over by a ghost!")
		message_admins("[key_name_admin(C)] has taken control of ([key_name_admin(M)])")
		M.ghostize(FALSE, TRUE)
		C.transfer_ckey(M, FALSE)
		return TRUE
	else
		to_chat(M, "There were no ghosts willing to take control.")
		message_admins("No ghosts were willing to take control of [ADMIN_LOOKUPFLW(M)])")
		return FALSE