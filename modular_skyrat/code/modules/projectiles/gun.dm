/obj/item/gun
	grabtext = "user grabs the src!"

/obj/item/gun/getinaccuracy(mob/living/user)
	if(!iscarbon(user))
		return FALSE
	else
		var/mob/living/carbon/holdingdude = user
		if(istype(holdingdude) && HAS_TRAIT(holdingdude, TRAIT_VATS)) // better than the texas ranger
			return 0
		else if(istype(holdingdude) && (holdingdude.combat_flags & COMBAT_FLAG_COMBAT_ACTIVE))
			return 0
		else
			return ((weapon_weight * 25) * inaccuracy_modifier)

/obj/item/gun/process_afterattack(atom/target, mob/living/user, flag, params)
	if(!target)
		return
	if(firing)
		return
	if(flag) //It's adjacent, is the user, or is on the user's person
		if(target in user.contents) //can't shoot stuff inside us.
			return
		if(!ismob(target) || user.a_intent == INTENT_HARM) //melee attack
			return
		if(target == user && user.zone_selected != BODY_ZONE_PRECISE_MOUTH) //so we can't shoot ourselves (unless mouth selected)
			return

	if(istype(user))//Check if the user can use the gun, if the user isn't alive(turrets) assume it can.
		var/mob/living/L = user
		if(!can_trigger_gun(L))
			return

	if(!can_shoot()) //Just because you can pull the trigger doesn't mean it can shoot.
		shoot_with_empty_chamber(user)
		return

	if(flag)
		if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			handle_suicide(user, target, params)
			return

	//Exclude lasertag guns from the TRAIT_CLUMSY check.
	if(clumsy_check)
		if(istype(user))
			if (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(40))
				to_chat(user, "<span class='userdanger'>You shoot yourself in the foot with [src]!</span>")
				var/shot_leg = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
				process_fire(user, user, FALSE, params, shot_leg)
				user.dropItemToGround(src, TRUE)
				return

	if(weapon_weight == WEAPON_HEAVY && user.get_inactive_held_item())
		to_chat(user, "<span class='userdanger'>You need both hands free to fire \the [src]!</span>")
		return

	//DUAL (or more!) WIELDING
	var/bonus_spread = 0
	var/loop_counter = 0

	bonus_spread += getinaccuracy(user) //CIT CHANGE - adds bonus spread while not aiming
	if(ishuman(user) && user.a_intent == INTENT_HARM)
		var/mob/living/carbon/human/H = user
		for(var/obj/item/gun/G in H.held_items)
			if(G == src || G.weapon_weight >= WEAPON_MEDIUM)
				continue
			else if(G.can_trigger_gun(user) && !HAS_TRAIT(H, TRAIT_VATS))
				bonus_spread += 24 * G.weapon_weight * G.dualwield_spread_mult
				loop_counter++
				addtimer(CALLBACK(G, /obj/item/gun.proc/process_fire, target, user, TRUE, params, null, bonus_spread), loop_counter)
			else if(G.can_trigger_gun(user) && HAS_TRAIT(H, TRAIT_VATS))
				bonus_spread += 6 * G.weapon_weight * G.dualwield_spread_mult //NOT EVEN DUAL WIELDING BIG IRONS HAMPERS YOU THAT MUCH
				loop_counter++
				addtimer(CALLBACK(G, /obj/item/gun.proc/process_fire, target, user, TRUE, params, null, bonus_spread), loop_counter)

	process_fire(target, user, TRUE, params, null, bonus_spread)

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_VATS) && slot == ITEM_SLOT_HANDS)
		playsound(user.loc, 'modular_skyrat/sound/fallput/vats1.ogg', 50)
	if(zoomed && user.get_active_held_item() != src)
		zoom(user, FALSE) //we can only stay zoomed in if it's in our hands	//yeah and we only unzoom if we're actually zoomed using the gun!!
