//Stun people trying to pick secbots up
/mob/living/simple_animal/bot/secbot/pickup_react(mob/living/user)
	. = ..()
	if(!istype(user))
		return
	if(!(bot_core.allowed(usr) || !locked) && iscarbon(user))
		stun_attack(user)
