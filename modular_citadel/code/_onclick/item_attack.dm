/obj/item/proc/rightclick_melee_attack_chain(mob/user, atom/target, params)
	//Combat intents change right click functionality
	var/c_intent = CI_DEFAULT
	if(iscarbon(user))
		var/mob/living/carbon/carbon_mob = user
		c_intent = carbon_mob.combat_intent
	
	switch(c_intent)
		if(CI_DUAL)
			var/obj/item/W = user.get_inactive_held_item()
			if(W)
				W.melee_attack_chain(user, target, params, flags = ATTACKCHAIN_RIGHTCLICK)
			else
				user.UnarmedAttack(target, attackchain_flags = ATTACKCHAIN_RIGHTCLICK)
			return
		if(CI_WEAK)
			melee_attack_chain(user, target, params, flags = ATTACKCHAIN_RIGHTCLICK, damage_multiplier = 0.25) //1/4th of the normal damage
			return
		if(CI_STRONG)
			melee_attack_chain(user, target, params, flags = ATTACKCHAIN_RIGHTCLICK, damage_multiplier = 1.5) //1.5x melee damage
			return

	//Otherwise, try alt attacking
	if(!alt_pre_attack(target, user, params)) //Hey, does this item have special behavior that should override all normal right-click functionality?
		if(!target.altattackby(src, user, params)) //Does the target do anything special when we right-click on it?
			melee_attack_chain(user, target, params, flags = ATTACKCHAIN_RIGHTCLICK) //Ugh. Lame! I'm filing a legal complaint about the discrimination against the right mouse button!
		else
			altafterattack(target, user, TRUE, params)
	return

/obj/item/proc/alt_pre_attack(atom/A, mob/living/user, params)
	return FALSE //return something other than false if you wanna override attacking completely

/atom/proc/altattackby(obj/item/W, mob/user, params)
	return FALSE //return something other than false if you wanna add special right-click behavior to objects.

/obj/item/proc/rightclick_attack_self(mob/user)
	return FALSE

/obj/item/proc/altafterattack(atom/target, mob/user, proximity_flag, click_parameters)
	SEND_SIGNAL(src, COMSIG_ITEM_ALT_AFTERATTACK, target, user, proximity_flag, click_parameters)
	return FALSE
