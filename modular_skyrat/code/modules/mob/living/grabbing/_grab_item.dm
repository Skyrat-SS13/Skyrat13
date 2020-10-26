/// An abstract item representing you grabbing a mob
/obj/item/grab
	name = "grasp"
	desc = "Used to hold hands and to strangle throats. Maybe both at once, even."
	icon = 'modular_skyrat/icons/mob/combat_intents.dmi'
	icon_state = GM_SELF
	item_state = "nothing"
	force = 0
	throwforce = 0
	slowdown = 1
	item_flags = DROPDEL | ABSTRACT | NOBLUDGEON | SLOWS_WHILE_IN_HAND
	/// Our current "mode"
	var/grab_mode = GM_SELF
	/// The body zone we're grabbing - not necessarily equal to the grasped bodypart (e.g. throat)
	var/grasped_zone
	/// The bodypart we're grabbing
	var/obj/item/bodypart/grasped_part
	/// The mob being grabbed
	var/mob/living/grasped_mob
	/// The carbon who owns all of this mess
	var/mob/living/carbon/grasping_mob
	/// How much we've twisted a limb. Used for stuff, trust me.
	var/actions_done = 0
	/// Boolean sed for strangling
	var/strangling = FALSE

/obj/item/grab/on_examined_check()
	return FALSE //nope

/obj/item/grab/Destroy()
	if(grasping_mob)
		if(grasped_mob)
			playsound(get_turf(grasping_mob), 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
			if(grasped_mob == grasping_mob)
				grasped_mob.visible_message("<span class='warning'>[grasping_mob] stops grabbing [grasping_mob.p_themselves()][grasped_part ? " by [grasping_mob.p_their()] [grasped_part.name]" : ""]!</span>",\
											"<span class='notice'>You stop grabbing yourself[grasped_part ? " by your [grasped_part.name]" : ""]!</span>")
			else
				grasped_mob.visible_message("<span class='danger'>[grasping_mob] stops grabbing [grasped_mob][grasped_part ? " by [grasped_mob.p_their()] [grasped_part.name]": ""]!</span>",\
										"<span class='userdanger'>[grasping_mob] stops grabbing you[grasped_part ? " by your [grasped_part.name]" : ""]!</span>",\
										ignored_mobs = grasping_mob)
				to_chat(grasping_mob, "<span class='danger'>You stop grabbing [grasped_mob][grasped_part ? " by [grasped_mob.p_their()] [grasped_part.name]" : ""]!</span>")
		if(grasping_mob.pulling == grasped_mob)
			grasping_mob.stop_pulling()
		grasping_mob.setGrabState(GRAB_NOTGRABBING)
		UnregisterSignal(grasping_mob, COMSIG_PARENT_QDELETING)
		UnregisterSignal(grasping_mob, COMSIG_LIVING_STOP_GRABBING)
	if(grasped_mob)
		UnregisterSignal(grasped_mob, COMSIG_PARENT_QDELETING)
		UnregisterSignal(grasped_mob, COMSIG_CARBON_REMOVE_LIMB)
	if(grasped_part)
		UnregisterSignal(grasped_part, COMSIG_PARENT_QDELETING)
		grasped_part.grasped_by = null
	grasped_mob = null
	grasped_part = null
	grasping_mob = null
	return ..()

/// The victim escaped or got deleted, or the bodypart we're grasping got deleted
/obj/item/grab/proc/qdel_void()
	if(!QDELETED(src))
		return qdel(src)

/// Icon updating
/obj/item/grab/update_icon()
	..()
	switch(grasped_zone)
		if(BODY_ZONE_PRECISE_THROAT)
			icon_state = GM_STRANGLE
		if(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
			icon_state = GM_TAKEDOWN
			if(grasped_mob == grasping_mob)
				icon_state = GM_SELF
		else
			icon_state = GM_WRENCH
	update_grab_mode()

/// Desc and name updating
/obj/item/grab/proc/update_grab_mode()
	grab_mode = icon_state
	if(grasped_part)
		name = "grasped [grasped_part.name]"
		if(grasped_mob)
			desc = "Grabbing [grasped_mob] by [grasped_mob.p_their()] [grasped_part.name]."
		else
			desc = "Grabbing [grasped_part.name]."
	else if(grasped_mob)
		name = "grasped [grasped_mob]"
		desc = "Grabbing [grasped_mob]."
	else
		name = initial(name)
		desc = initial(desc)

/// Performing a move
/obj/item/grab/attack_self(mob/user)
	..()
	if(iscarbon(grasped_mob) && (grasping_mob.next_move < world.time))
		switch(grab_mode)
			if(GM_WRENCH)
				if(grasped_part)
					if(grasped_part.get_wrenched(grasping_mob, grasped_mob))
						actions_done++
			if(GM_TAKEDOWN)
				var/obj/item/grab/friend = grasping_mob.get_inactive_held_item()
				if(istype(friend) && (friend.grasped_mob == grasped_mob) && (friend.actions_done > 0))
					do_takedown(grasped_mob, grasped_part, grasping_mob)
				else
					to_chat(grasping_mob, "<span class='warning'>You need to grip and wrench [grasped_mob] with another hand to take [grasped_mob.p_them()] down!</span>")
			if(GM_STRANGLE)
				if((grasping_mob.a_intent != INTENT_HARM) || strangling)
					do_strangle(grasped_mob, grasped_part, grasping_mob)
				else if(!strangling)
					if(grasped_part.get_wrenched(grasping_mob, grasped_mob))
						actions_done++

/// Examining
/obj/item/grab/examine(mob/user)
	. = ..()
	switch(grab_mode)
		if(GM_SELF)
			. += "<span class='info'>Keep holding to staunch the bleeding on [grasped_mob][grasped_part ? "'s [grasped_part.name]" : ""].</span>"
		if(GM_WRENCH)
			. += "<span class='info'>Use to wrench [grasped_mob][grasped_part ? "'s [grasped_part.name]" : ""].</span>"
		if(GM_STRANGLE)
			. += "<span class='info'>Use to strangle [grasped_mob].</span>"
		if(GM_TAKEDOWN)
			. += "<span class='info'>Use to perform a takedown on [grasped_mob].</span>"

/// Trying to grasp
/obj/item/grab/proc/try_grasp(mob/living/attempted_grasped, obj/item/bodypart/attempted_part, mob/living/carbon/attempted_grasper)
	. = FALSE
	if(!attempted_grasper || !attempted_grasped)
		return
	
	grasping_mob = attempted_grasper
	grasped_mob = attempted_grasped
	if(attempted_part)
		attempted_part.grasped_by = src
		grasped_part = attempted_part
	else
		if(iscarbon(attempted_grasped) || iscarbon(attempted_grasper))
			return
	grasped_zone = attempted_grasper.zone_selected

	//Bodypart checks
	if(grasped_part && (grasped_part.body_zone in TORSO_BODYPARTS))
		var/obj/item/grab/inactive_grab = attempted_grasper.get_inactive_held_item()
		if(!istype(inactive_grab) || !((inactive_grab.grab_state == GM_WRENCH) || (inactive_grab.grab_state == GM_STRANGLE) || (inactive_grab.grasped_mob == grasped_mob) || (inactive_grab.actions_done <= 0)))
			to_chat(attempted_grasper, "<span class='warning'>You can't grab [src] by [p_their()] [parse_zone(attempted_grasper.zone_selected)] without grabbing and twisting another limb!</span>")
			return

	RegisterSignal(grasping_mob, COMSIG_PARENT_QDELETING, .proc/qdel_void)
	RegisterSignal(grasped_mob, COMSIG_PARENT_QDELETING, .proc/qdel_void)
	if(grasped_part)
		RegisterSignal(grasped_part, COMSIG_PARENT_QDELETING, .proc/qdel_void)
		RegisterSignal(grasped_mob, COMSIG_CARBON_REMOVE_LIMB, .proc/check_delimb)
	
	RegisterSignal(grasping_mob, COMSIG_LIVING_STOP_PULLING, .proc/qdel_void)
	RegisterSignal(grasping_mob, COMSIG_LIVING_STOP_GRABBING, .proc/qdel_void)

	if(grasping_mob == grasped_mob)
		grasped_mob.visible_message("<span class='danger'>[attempted_grasper] grasps at [attempted_grasper.p_their()] [grasped_part.name].</span>", "<span class='notice'>You grab hold of your [grasped_part.name] tightly.</span>", vision_distance=COMBAT_MESSAGE_RANGE)
	else
		grasped_mob.visible_message("<span class='danger'>[attempted_grasper] grasps [grasped_mob][grasped_part ? " by [grasped_mob.p_their()] [grasped_part.name]" : ""]!</span>",\
								"<span class='userdanger'>You are grasped [grasped_part ? "on your [grasped_part.name] " : ""]by [attempted_grasper]!</span>", "<span class='warning'>You hear a shuffling sound.</span>",\
								ignored_mobs = grasping_mob)
		to_chat(grasping_mob, "<span class='danger'>You grab [grasped_mob][grasped_part ? "by [grasped_mob.p_their()] [grasped_part.name]" : ""]!</span>")
	if(grasping_mob != grasped_mob)
		grasping_mob.setGrabState(GRAB_AGGRESSIVE)
		grasping_mob.set_pull_offsets(grasped_mob, grasping_mob.grab_state)
	update_icon()
	return TRUE

/// Limb loss check
/obj/item/grab/proc/check_delimb(mob/living/carbon/human/victim, obj/item/bodypart/limbed, dismembered)
	if(!istype(limbed))
		return
	if((limbed == grasped_part) || (limbed.body_zone == check_zone(grasped_zone)))
		qdel_void(src)
		return TRUE

/// Takedown move
/obj/item/grab/proc/do_takedown(mob/living/carbon/victim, obj/item/bodypart/grasped_part, mob/living/carbon/user)
	var/user_str = 10
	if(grasping_mob.mind)
		user_str = GET_STAT_LEVEL(grasping_mob, str)
	var/victim_str = 10
	if(grasped_mob.mind)
		victim_str = GET_STAT_LEVEL(grasped_mob, str)
	var/str_diff = user_str - victim_str
	if(!grasped_mob.lying)
		if(grasping_mob.mind?.diceroll(GET_STAT_LEVEL(grasping_mob, str)*0.75, GET_SKILL_LEVEL(grasping_mob, melee)*0.25, mod = 5*str_diff) >= DICE_SUCCESS)
			grasped_mob.visible_message("<span class='danger'>[grasping_mob] takes [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										"<span class='userdanger'>[grasping_mob] takes you down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										ignored_mobs = grasping_mob)
			to_chat(grasping_mob, "<span class='danger'>You take [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>")
			grasped_mob.DefaultCombatKnockdown(clamp(str_diff, 1, 5) SECONDS)
			grasped_mob.Stun(clamp(str_diff, 1, 5) SECONDS)
		else
			grasped_mob.visible_message("<span class='danger'>[grasping_mob] fails to take [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										"<span class='userdanger'>[grasping_mob] fails to take you down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										ignored_mobs = grasping_mob)
			to_chat(grasping_mob, "<span class='danger'>You fail to take [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>")
	else
		if(grasping_mob.mind?.diceroll(GET_STAT_LEVEL(grasping_mob, str)*0.25, GET_SKILL_LEVEL(grasping_mob, melee)*0.75, mod = 5*str_diff) >= DICE_SUCCESS)
			grasped_mob.visible_message("<span class='danger'>[grasping_mob] pins [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										"<span class='userdanger'>[grasping_mob] pins you down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										ignored_mobs = grasping_mob)
			to_chat(grasping_mob, "<span class='danger'>You pin [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>")
			grasped_mob.Stun(clamp(str_diff, 1, 5) SECONDS)
		else
			grasped_mob.visible_message("<span class='danger'>[grasping_mob] fails to pin [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										"<span class='userdanger'>[grasping_mob] fails to pin you down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>",\
										ignored_mobs = grasping_mob)
			to_chat(grasping_mob, "<span class='danger'>You fail to pin [grasped_mob] down[grasped_part ? " by the [grasped_part.name]" : ""]!</span>")
	grasping_mob.changeNext_move(CLICK_CD_GRABBING)
	return TRUE

/// Strangling
/obj/item/grab/proc/do_strangle(mob/living/carbon/victim, obj/item/bodypart/grasped_part, mob/living/carbon/user)
	if(strangling)
		strangling = FALSE
		grasping_mob.setGrabState(GRAB_AGGRESSIVE)
		grasping_mob.set_pull_offsets(grasped_mob, grasping_mob.grab_state)
		grasped_mob.visible_message("<span class='danger'>[user] stops strangling [src]!</span>", \
						"<span class='userdanger'>[user] stops strangling you!</span>", ignored_mobs = grasping_mob)
		to_chat(grasping_mob, "<span class='danger'>You stop strangling [src]!</span>")
		grasped_mob.update_mobility()
	else
		log_combat(user, src, "strangled", addition="kill grab")
		strangling = TRUE
		grasping_mob.setGrabState(GRAB_KILL)
		grasping_mob.set_pull_offsets(grasped_mob, grasping_mob.grab_state)
		grasped_mob.visible_message("<span class='danger'>[user] starts strangling [src]!</span>", \
						"<span class='userdanger'>[user] starts strangling you!</span>", ignored_mobs = grasping_mob)
		to_chat(grasping_mob, "<span class='danger'>You start strangling [src]!</span>")
		grasped_mob.update_mobility()
	grasping_mob.changeNext_move(CLICK_CD_GRABBING)
	return TRUE
