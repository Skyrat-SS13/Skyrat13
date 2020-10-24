// Unsorted, miscellaneous bodypart interactions

// Wrenching a limb
/obj/item/bodypart/proc/get_wrenched(mob/living/carbon/user, mob/living/carbon/victim, silent = FALSE)
	. = FALSE
	if(!owner || !user)
		return
	if(!victim)
		victim = owner
	
	if(user.a_intent == INTENT_HARM)
		if(get_ripped_off(user, victim, silent))
			return TRUE
	
	var/bio_state = victim.get_biological_state()

	if(!(bio_state & BIO_BONE) && !(bio_state & BIO_FLESH))
		return

	if(INTERACTING_WITH(user, victim))
		return

	var/dice = DICE_SUCCESS
	if(user.mind)
		dice = user.mind.diceroll(GET_STAT_LEVEL(user, str)*0.5, GET_SKILL_LEVEL(user, melee)*0.5)
	
	if(!is_dislocated() && dice >= DICE_SUCCESS)
		var/datum/wound/W
		if(bio_state & BIO_BONE)
			if(status & BODYPART_ORGANIC)
				if(body_zone == BODY_ZONE_HEAD)
					W = new /datum/wound/blunt/moderate/jaw()
				else if(body_zone == BODY_ZONE_CHEST)
					W = new /datum/wound/blunt/moderate/ribcage()
				else if(body_zone == BODY_ZONE_PRECISE_GROIN)
					W = new /datum/wound/blunt/moderate/hips()
				else
					W = new /datum/wound/blunt/moderate()
			else
				W = new /datum/wound/mechanical/blunt/moderate()
		else
			if(status & BODYPART_ORGANIC)
				W = new /datum/wound/slash/moderate()
			else
				W = new /datum/wound/mechanical/slash/moderate()
		//Critical success means we cause a hairline fracture, straight up
		if(dice >= DICE_CRIT_SUCCESS)
			if(bio_state & BIO_BONE)
				if(status & BODYPART_ORGANIC)
					W = new /datum/wound/blunt/severe
				else
					W = new /datum/wound/mechanical/blunt/severe
			else
				if(status & BODYPART_ORGANIC)
					W = new /datum/wound/slash/critical()
				else
					W = new /datum/wound/mechanical/slash/critical()
		if(istype(W))
			W.apply_wound(src, FALSE)
		var/str = GET_STAT_LEVEL(user, str)
		if(str)
			receive_damage(str*0.75, wound_bonus=CANT_WOUND)
		user.changeNext_move(CLICK_CD_GRABBING)
		if(user != victim)
			user.visible_message("<span class='danger'>[user] dislocates [victim]'s [name] with a sickening crack![victim.wound_message]</span>", "<span class='danger'>You dislocate [victim]'s [name] with a sickening crack!</span>", ignored_mobs=victim)
			to_chat(victim, "<span class='userdanger'>[user] dislocates your [name] with a sickening crack![victim.wound_message]</span>")
		else
			user.visible_message("<span class='danger'>[user] dislocates [user.p_their()] own [src.name] with a sickening crack![victim.wound_message]</span>",
					"<span class='userdanger'>You dislocate your own [src.name]![victim.wound_message]</span>")
		//Clean the wound string too
		victim.wound_message = ""
	else
		for(var/datum/wound/blunt/moderate/W in wounds)
			return W.malpractice(user)
		for(var/datum/wound/mechanical/blunt/moderate/W in wounds)
			return W.malpractice(user)
		var/str = GET_STAT_LEVEL(user, str)
		if(str)
			receive_damage(str*0.5, wound_bonus=CANT_WOUND)
		user.changeNext_move(CLICK_CD_GRABBING)
		if(user != victim)
			user.visible_message("<span class='danger'>[user] wrenches [victim]'s [name] around painfully![victim.wound_message]</span>", "<span class='danger'>You wrench [victim]'s [name] around painfully![victim.wound_message]</span>", ignored_mobs=victim)
			to_chat(victim, "<span class='userdanger'>[user] wrenches your [name] around painfully![victim.wound_message]</span>")
		else
			user.visible_message("<span class='danger'>[user] wrenches [user.p_their()] own [src.name] around painfully![victim.wound_message]</span>",
								"<span class='userdanger'>You wrench your own [src.name] around painfully![victim.wound_message]</span>")
		//Clean the wound string too
		victim.wound_message = ""
	return TRUE

// Trying to rip a limb off
/obj/item/bodypart/proc/get_ripped_off(mob/living/carbon/user, mob/living/carbon/victim, silent = FALSE)
	. = FALSE
	if(!owner || !user)
		return
	if(!victim)
		victim = owner
	
	var/bio_state = victim.get_biological_state()

	if(!(bio_state & BIO_BONE) && !(bio_state & BIO_FLESH))
		return
	
	var/melee_armor = victim.getarmor(body_zone, "melee")
	
	if(INTERACTING_WITH(user, victim))
		return

	var/user_str = 10
	if(user.mind)
		user_str = GET_STAT_LEVEL(user, str)
	var/victim_str = 10
	if(victim.mind)
		victim_str = GET_STAT_LEVEL(victim, str)
	
	var/str_diff = user_str - victim_str
	if(user.mind.diceroll(STAT_DATUM(str), mod = -melee_armor/2) >= DICE_SUCCESS)
		if((str_diff >= 6) || ((user == victim) && (user_str >= 14)))
			for(var/datum/wound/blunt/moderate/W in wounds)
				return W.malpractice(user)
			for(var/datum/wound/mechanical/blunt/moderate/W in wounds)
				return W.malpractice(user)
			if(user != victim)
				user.visible_message("<span class='danger'>[user] rips [victim]'s [name] off!</span>", "<span class='danger'>You rip [victim]'s [name] off!</span>", ignored_mobs=victim)
				to_chat(victim, "<span class='userdanger'>[user] rips your [name] off!</span>")
			else
				user.visible_message("<span class='danger'>[user] rips [user.p_their()] own [src.name] off!</span>",
									"<span class='userdanger'>You rip your own [src.name] off!</span>")
			var/str = GET_STAT_LEVEL(user, str)
			if(str)
				receive_damage(str*0.5, wound_bonus=CANT_WOUND)
			var/kaplosh_sound = pick(
					'modular_skyrat/sound/gore/chop1.ogg',
					'modular_skyrat/sound/gore/chop2.ogg',
					'modular_skyrat/sound/gore/chop3.ogg',
					'modular_skyrat/sound/gore/chop4.ogg',
					'modular_skyrat/sound/gore/chop5.ogg',
					'modular_skyrat/sound/gore/chop6.ogg',
				)
			playsound(victim, kaplosh_sound, 75, 1)
			drop_limb(dismembered = TRUE)
			victim.bleed(12)
			victim.agony_scream()
			user.put_in_hands(src)
			user.changeNext_move(CLICK_CD_GRABBING)
			//Clean the wound string too
			victim.wound_message = ""
			return TRUE
