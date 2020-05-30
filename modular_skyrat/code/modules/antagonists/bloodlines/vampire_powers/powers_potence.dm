/datum/action/vampire/earthshock
	name = "Earthshock"
	desc = "Violently slam your fists down to the ground, damaging and knocking nearby enemies down."
	button_icon_state = "power_earthshock"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	must_be_capacitated = TRUE

/datum/action/vampire/earthshock/ActivatePower()
	var/mob/living/carbon/user = owner
	user.visible_message("<span class='warning'>[user] violently slams [user.p_their()] fist into the floor, leaving it quaking!</span>", \
						 "<span class='notice'>You slam your fists into the floor, leaving it quaking.</span>")
	playsound(src, 'sound/effects/meteorimpact.ogg', 40, 1)
	var/list/affected = viewers(2, user)
	for(var/mob/living/l in affected)
		if(l != user)
			l.DefaultCombatKnockdown(200)
			l.adjustBruteLoss(15)
		shake_camera(l, 3, 1)
	user.log_message("used Earthshock, knocking [LAZYLEN(affected)] people down", LOG_ATTACK)

/datum/action/vampire/fists
	name = "Fists of Caine"
	desc = "Indulge yourself into a combatative trance, dodging projectiles and resisting the hardest blows, all while delivering devastating punches to the enemies. You'll also gain a couple new moves for the duration."
	button_icon_state = "power_fists"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1

	purchasable = TRUE 
	must_be_capacitated = TRUE

/datum/action/vampire/fists/ActivatePower()
	var/mob/living/carbon/user = owner
	user.apply_status_effect(STATUS_EFFECT_FISTS_OF_CAINE)

/datum/action/vampire/overwhelming_power
	name = "Overwhelming Power"
	desc = "Burst of power surges through you and breaks all restraints, including handcuffs legcuffs and straight jackets!"
	button_icon_state = "power_overpower"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 		
	amToggle = FALSE
	level_max = 1
	purchasable = TRUE

/datum/action/vampire/overwhelming_power/CheckCanUse(display_error)
	. = ..()
	var/mob/living/carbon/user = owner
	if(!user.handcuffed || !user.legcuffed || !(user.wear_suit && user.wear_suit.breakouttime))
		return FALSE

/datum/action/vampire/overwhelming_power/ActivatePower()
	var/mob/living/carbon/user = owner
	user.visible_message("<span class='warning'>[user] tenses up, his muscles throbbing and straining against his restraints!</span>", \
						 "<span class='warning'>You tense up and press against the restraints, you feel them ready to break at any moment!</span>")
	sleep(20)
	if(user.handcuffed)
		var/obj/O = user.handcuffed
		user.visible_message("<span class='warning'>[user] breaks the [O.name] with sheer force!</span>", \
						 "<span class='notice'>You break [O.name] with sheer force.</span>")
		user.dropItemToGround(O)
	if(user.legcuffed)
		var/obj/O = user.legcuffed
		user.visible_message("<span class='warning'>[user] breaks the [O.name] with sheer force!</span>", \
						 "<span class='notice'>You break [O.name] with sheer force.</span>")
		user.dropItemToGround(O)
	if(user.wear_suit && user.wear_suit.breakouttime)
		var/obj/item/clothing/suit/S = user.get_item_by_slot(SLOT_WEAR_SUIT)
		user.visible_message("<span class='warning'>[user] breaks the [S.name] with sheer force!</span>", \
						 "<span class='notice'>You break [S.name] with sheer force.</span>")
		user.dropItemToGround(S)
	user.log_message("has freed themselves from restraints", LOG_ATTACK)

/datum/action/vampire/targeted/predatory_leap
	name = "Predatory Leap"
	desc = "Leap at a target after a short delay, if you reach them you'll pin them down and aggressively grab them."
	button_icon_state = "power_predleap"

	required_discipline = /datum/discipline/potence
	bloodcost = 40
	powercost = 20
	cooldown = 200 
	level_max = 1
	target_range = 5

	purchasable = TRUE 
	must_be_capacitated = TRUE
	var/runintent

/datum/action/vampire/targeted/predatory_leap/CheckValidTarget(atom/A)
	return iscarbon(A)

/datum/action/vampire/targeted/predatory_leap/CheckCanTarget(atom/A,display_error)
	// Check: Self
	if(A == owner)
		return FALSE
	var/mob/living/carbon/target = A // We already know it's carbon due to CheckValidTarget()

	// Dead/Unconscious
	if(target.stat > CONSCIOUS)
		if (display_error)
			to_chat(owner, "<span class='warning'>Your victim is not [(target.stat == DEAD || HAS_TRAIT(target, TRAIT_FAKEDEATH))?"alive":"conscious"].</span>")
		return FALSE
	// Check: Target standing
	if (!CHECK_MOBILITY(target, MOBILITY_STAND))
		if(display_error)
			to_chat(owner, "<span class='warning'>Your victim must be standing.</span>")
		return FALSE
	return TRUE

/datum/action/vampire/targeted/predatory_leap/FireTargetedPower(atom/A)
	var/mob/living/carbon/target = A
	var/mob/living/carbon/human/user = owner
	user.face_atom(target)
	if(!istype(target))
		return
	user.visible_message("<span class='warning'>[user] hunches and ominously locks his gaze on [target]!</span>", \
						 "<span class='notice'>You lock your gaze on [target] and get ready to leap!</span>")
	runintent = (user.m_intent == MOVE_INTENT_RUN)
	if(runintent)
		user.toggle_move_intent()
	ADD_TRAIT(user, TRAIT_NORUNNING, "predatory leap")
	sleep(40) //2 seconds
	if(!user) //Were we not deleted during the wait time?
		return
	REMOVE_TRAIT(user, TRAIT_NORUNNING, "predatory leap")
	if(runintent)
		user.toggle_move_intent()
	if(!target) //Was our target deleted during the wait time?
		return
	if(!(target in viewers(9, user)))
		to_chat(user, "<span class='warning'>Your target is out of sight!</span>")
		return
	user.visible_message("<span class='warning'>[user] leaps!</span>", \
						 "<span class='warning'>You leap!</span>")
	var/steps = 10
	var/mob/living/carbon/caught_person
	var/turf/self_turf
	var/dir
	var/turf/next_turf
	while(steps)
		if(!user || !target)
			break
		steps -= 1
		self_turf = get_turf(user)
		dir = get_dir(self_turf, get_turf(target))
		next_turf = get_step(self_turf, dir)
		for(var/mob/living/carbon/C in next_turf)
			if(C != user && CHECK_MOBILITY(target, MOBILITY_STAND))
				caught_person = C
				break
		if(caught_person)
			break
		if(!next_turf.density)
			step(user, dir)
		sleep(1)

	if(!user)
		return

	if(caught_person)
		user.log_message("used Predatory Leap, knocking [caught_person] down", LOG_ATTACK)
		playsound(get_turf(user), 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
		caught_person.DefaultCombatKnockdown(300, override_hardstun = 1, override_stamdmg = 50)
		user.forceMove(get_turf(caught_person))
		user.start_pulling(caught_person, 1)
		if(user.pulling)
			caught_person.drop_all_held_items()
			caught_person.stop_pulling()
			user.setGrabState(GRAB_AGGRESSIVE)
		caught_person.visible_message("<span class='warning'>[user] tackles and pins [caught_person] down!</span>", \
						 "<span class='boldwarning'>[user] tackles and pins you down!</span>")
	else
		to_chat(user, "<span class='warning'>You fail to reach your target!</span>")