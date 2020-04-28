/obj/machinery/cryopod/MouseDrop_T(mob/living/target, mob/user)
	if(!istype(target) || user.incapacitated() || !target.Adjacent(user) || !Adjacent(user) || !ismob(target) || (!ishuman(user) && !iscyborg(user)) || !istype(user.loc, /turf) || target.buckled)
		return

	if(occupant)
		to_chat(user, "<span class='boldnotice'>The cryo pod is already occupied!</span>")
		return

	if(target.stat == DEAD)
		to_chat(user, "<span class='notice'>Dead people can not be put into cryo.</span>")
		return

	if(target.client && user != target)
		if(iscyborg(target))
			to_chat(user, "<span class='danger'>You can't put [target] into [src]. They're online.</span>")
		else
			to_chat(user, "<span class='danger'>You can't put [target] into [src]. They're conscious.</span>")
		return
	else if(target.client)
		if(alert(target,"Would you like to enter cryosleep?",,"Yes","No") == "No")
			return

	if (user != target && round(((world.time - target.lastclienttime) / (1 MINUTES)),1) <= CONFIG_GET(number/cryo_min_ssd_time))
		to_chat(user, "<span class='danger'>You can't put [target] into [src]. They might wake up soon.</span>")
		return

	var/generic_plsnoleave_message = " Please adminhelp before leaving the round, even if there are no administrators online!"

	if(target == user && world.time - target.client.cryo_warned > 5 MINUTES)//if we haven't warned them in the last 5 minutes
		var/list/caught_string
		var/addendum = ""
		if(target.mind.assigned_role in GLOB.command_positions)
			LAZYADD(caught_string, "Head of Staff")
			addendum = " Be sure to put your locker items back into your locker!"
		if(iscultist(target) || is_servant_of_ratvar(target))
			LAZYADD(caught_string, "Cultist")
		if(is_devil(target))
			LAZYADD(caught_string, "Devil")
		if(target.mind.has_antag_datum(/datum/antagonist/gang))
			LAZYADD(caught_string, "Gangster")
		if(target.mind.has_antag_datum(/datum/antagonist/rev/head))
			LAZYADD(caught_string, "Head Revolutionary")
		if(target.mind.has_antag_datum(/datum/antagonist/rev))
			LAZYADD(caught_string, "Revolutionary")

		if(caught_string)
			alert(target, "You're a [english_list(caught_string)]![generic_plsnoleave_message][addendum]")
			target.client.cryo_warned = world.time
			return

	if(!target || user.incapacitated() || !target.Adjacent(user) || !Adjacent(user) || (!ishuman(user) && !iscyborg(user)) || !istype(user.loc, /turf) || target.buckled)
		return
		//rerun the checks in case of shenanigans

	if(target == user)
		visible_message("[user] starts climbing into the cryo pod.")
	else
		visible_message("[user] starts putting [target] into the cryo pod.")

	if(occupant)
		to_chat(user, "<span class='boldnotice'>\The [src] is in use.</span>")
		return
	close_machine(target)

	to_chat(target, "<span class='boldnotice'>If you ghost, log out or close your client now, your character will shortly be permanently removed from the round.</span>")
	name = "[name] ([occupant.name])"
	log_admin("<span class='notice'>[key_name(target)] entered a stasis pod.</span>")
	message_admins("[key_name_admin(target)] entered a stasis pod. (<A HREF='?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)")
	add_fingerprint(target)