/obj/mecha
	var/shouldberestricted = FALSE //you get the point by now
	var/securitylevelrestriction = null 
	var/savedrestriction = null

/obj/mecha/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/card/id) && (user.a_intent == INTENT_HARM))
		var/obj/item/card/id/id = W 
		if(ACCESS_ARMORY in id.access)
			to_chat(user, securitylevelrestriction ? "<span class='notice'>You lock \the [src] for security level based use.</span>" : "<span class='notice'>You unlock \the [src] from security level based use.</span>")
			if(securitylevelrestriction)
				savedrestriction = securitylevelrestriction
				securitylevelrestriction = null
			else 
				securitylevelrestriction = savedrestriction
				savedrestriction = null

/obj/mecha/examine(mob/user)
	. = ..()
	var/integrity = obj_integrity*100/max_integrity
	switch(integrity)
		if(85 to 100)
			. += "It's fully intact."
		if(65 to 85)
			. += "It's slightly damaged."
		if(45 to 65)
			. += "It's badly damaged."
		if(25 to 45)
			. += "It's heavily damaged."
		else
			. += "It's falling apart."
	if(equipment && equipment.len)
		. += "It's equipped with:"
		for(var/obj/item/mecha_parts/mecha_equipment/ME in equipment)
			. += "[icon2html(ME, user)] \A [ME]."
	if(shouldberestricted)
		. +=  "It's full usage is locked to [securitylevelrestriction ? NUM2SECLEVEL(securitylevelrestriction) : "no"] security level."

/obj/mecha/proc/click_action(atom/target,mob/user,params)
	if(!occupant || occupant != user )
		return
	if(!locate(/turf) in list(target,target.loc)) // Prevents inventory from being drilled
		return
	if(completely_disabled)
		return
	if(phasing)
		occupant_message("Unable to interact with objects while phasing")
		return
	if(user.incapacitated())
		return
	if(state)
		occupant_message("<span class='warning'>Maintenance protocols in effect.</span>")
		return
	if(!get_charge())
		return
	if(src == target)
		return
	var/dir_to_target = get_dir(src,target)
	if(dir_to_target && !(dir_to_target & dir))//wrong direction
		return
	if(internal_damage & MECHA_INT_CONTROL_LOST)
		target = safepick(view(3,target))
		if(!target)
			return

	var/mob/living/L = user
	if(!Adjacent(target))
		if(selected && selected.is_ranged())
			if(HAS_TRAIT(L, TRAIT_PACIFISM) && selected.harmful)
				to_chat(user, "<span class='warning'>You don't want to harm other living beings!</span>")
				return
			if(selected.action(target,params))
				selected.start_cooldown()
	else if(selected && selected.is_melee())
		if(isliving(target) && selected.harmful && HAS_TRAIT(L, TRAIT_PACIFISM))
			to_chat(user, "<span class='warning'>You don't want to harm other living beings!</span>")
			return
		if(selected.action(target,params))
			selected.start_cooldown()
	else
		if(internal_damage & MECHA_INT_CONTROL_LOST)
			target = safepick(oview(1,src))
		if(!melee_can_hit || !istype(target, /atom))
			return
		if(shouldberestricted)
			if(!(GLOB.security_level >= securitylevelrestriction))
				return FALSE
		target.mech_melee_attack(src)
		melee_can_hit = 0
		spawn(melee_cooldown)
			melee_can_hit = 1

/obj/mecha/Bump(var/atom/obstacle)
	if(phasing && get_charge() >= phasing_energy_drain && !throwing)
		spawn()
			if(can_move)
				can_move = 0
				if(phase_state)
					flick(phase_state, src)
				forceMove(get_step(src,dir))
				use_power(phasing_energy_drain)
				sleep(step_in*3)
				can_move = 1
	else
		if(..()) //mech was thrown
			return
		if(bumpsmash && occupant) //Need a pilot to push the PUNCH button.
			if(nextsmash < world.time)
				if(shouldberestricted)
					if(!(GLOB.security_level >= securitylevelrestriction))
						return FALSE
				obstacle.mech_melee_attack(src)
				nextsmash = world.time + smashcooldown
				if(!obstacle || obstacle.CanPass(src,get_step(src,dir)))
					step(src,dir)
		if(isobj(obstacle))
			var/obj/O = obstacle
			if(!O.anchored)
				step(obstacle, dir)
		else if(ismob(obstacle))
			var/mob/M = obstacle
			if(!M.anchored)
				step(obstacle, dir)
