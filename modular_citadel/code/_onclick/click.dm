/mob/proc/RightClickOn(atom/A, params) //mostly a copy-paste from ClickOn()
	var/list/modifiers = params2list(params)
	if(incapacitated(ignore_restraints = 1))
		return

	face_atom(A)

	if(next_move > world.time) // in the year 2000...
		return

	if(!modifiers["catcher"] && A.IsObscured())
		return

	if(ismecha(loc))
		var/obj/mecha/M = loc
		return M.click_action(A,src,params)

	if(restrained())
		changeNext_move(CLICK_CD_HANDCUFFED)   //Doing shit in cuffs shall be vey slow
		RestrainedClickOn(A)
		return

	if(in_throw_mode)
		throw_item(A)//todo: make it plausible to lightly toss items via right-click
		return

	var/obj/item/W = get_active_held_item()

	if(W == A)
		if(!W.rightclick_attack_self(src))
			W.attack_self(src)
		update_inv_hands()
		return

	//These are always reachable.
	//User itself, current loc, and user inventory
	if(A in DirectAccess())
		if(W)
			W.rightclick_melee_attack_chain(src, A, params)
		else
			if(ismob(A))
				changeNext_move(CLICK_CD_MELEE)
			var/c_intent = CI_DEFAULT
			if(iscarbon(src))
				var/mob/living/carbon/carbon_mob = src
				c_intent = carbon_mob.combat_intent
			switch(c_intent)
				if(CI_DUAL)
					var/obj/item/wap = get_inactive_held_item()
					visible_message("<span class='warning'><b>\The [src]</b> attacks with their offhand!</span>")
					if(wap)
						wap.melee_attack_chain(src, A, params, flags = ATTACKCHAIN_RIGHTCLICK)
					else
						UnarmedAttack(A, TRUE, attackchain_flags = ATTACKCHAIN_RIGHTCLICK)
					return
			if(!AltUnarmedAttack(A, TRUE))
				UnarmedAttack(A, TRUE, attackchain_flags = ATTACKCHAIN_RIGHTCLICK)
		return

	//Can't reach anything else in lockers or other weirdness
	if(!loc.AllowClick())
		return

	//Standard reach turf to turf or reaching inside storage
	if(CanReach(A,W))
		if(W)
			W.rightclick_melee_attack_chain(src, A, params)
		else
			if(ismob(A))
				changeNext_move(CLICK_CD_MELEE)
			var/c_intent = CI_DEFAULT
			if(iscarbon(src))
				var/mob/living/carbon/carbon_mob = src
				c_intent = carbon_mob.combat_intent
			switch(c_intent)
				if(CI_DUAL)
					var/obj/item/wap = get_inactive_held_item()
					visible_message("<span class='warning'><b>\The [src]</b> attacks with their offhand!</span>")
					if(wap)
						wap.melee_attack_chain(src, A, params, flags = ATTACKCHAIN_RIGHTCLICK)
					else
						UnarmedAttack(A, TRUE, attackchain_flags = ATTACKCHAIN_RIGHTCLICK)
					return
			if(!AltUnarmedAttack(A, TRUE))
				UnarmedAttack(A, TRUE, attackchain_flags = ATTACKCHAIN_RIGHTCLICK)
	else
		if(W)
			if(!W.altafterattack(A, src, FALSE, params))
				W.afterattack(A, src, FALSE, params)
		else
			if(!AltRangedAttack(A,params))
				RangedAttack(A,params)

/mob/proc/AltUnarmedAttack(atom/A, proximity_flag)
	if(ismob(A))
		changeNext_move(CLICK_CD_MELEE)
	return FALSE

/mob/proc/AltRangedAttack(atom/A, params)
	return FALSE
