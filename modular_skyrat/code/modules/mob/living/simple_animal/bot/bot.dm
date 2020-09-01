//You can pick up bots!
/mob/living/simple_animal/bot/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/mob_holder, null, null, )
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/pickup_react)

//Proc for a bot to react upon someone trying to pick them up
/mob/living/simple_animal/bot/proc/pickup_react(mob/living/user)
	if(!(bot_core.allowed(usr) || !locked) && iscarbon(user))
		emote("scream")
		emote("shiver")
	return

//Kill the signal
/mob/living/simple_animal/bot/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_CLICK_ALT)
