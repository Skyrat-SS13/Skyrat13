/obj/effect/proc_holder/spell/self/return_back // Admin only spell, teleports and deletes the body, ghosting the user. 
	name = "Return"
	desc = "Activates your return beacon."
	mobs_whitelist = list(/mob/living/carbon/human)
	clothes_req = NONE
	charge_max = 1
	cooldown_min = 1

	invocation = "Return on!" // pls someone get reference <3
	invocation_type = "whisper"
	school = "evocation"
	action_icon_state = "exitstate"

/obj/effect/proc_holder/spell/self/return_back/cast(mob/living/carbon/human/user)
	user.mind.RemoveSpell(src)

	playsound(get_turf(user.loc), 'sound/magic/Repulse.ogg', 100, 1)

	var/mob/dead/observer/ghost = user.ghostize(1, voluntary = TRUE)

	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, user)
	sparks.attach(user.loc)
	sparks.start()

	qdel(user)

	// Get them back to their regular name.
	ghost.set_ghost_appearance()
	if(ghost.client && ghost.client.prefs)
		ghost.deadchat_name = ghost.client.prefs.real_name
