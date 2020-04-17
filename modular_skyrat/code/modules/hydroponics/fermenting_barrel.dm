//BARREL DUNKING!
/obj/structure/fermenting_barrel
	var/mob/living/storedmob
	var/maxstoredmobs = 3
	var/storedmobs = 0
	var/fractionofvolume = 0.1
	can_buckle = TRUE
	climb_time = 20

/obj/structure/fermenting_barrel/process()
	. = ..()
	for(var/mob/living/carbon/C in src)
		reagents.reaction(A = C, method = TOUCH, volume_modifier = reagents.maximum_volume * fractionofvolume)
		reagents.trans_to(C, reagents.maximum_volume * fractionofvolume)

/obj/structure/fermenting_barrel/attack_hand(mob/user)
	if(open && user.pulling && user.a_intent == "grab" && iscarbon(user.pulling))
		if(storedmobs >= maxstoredmobs)
			to_chat(user, "<span class='warning'>The barrel is already full!</span>")
			return
		if(user.grab_state < GRAB_AGGRESSIVE)
			to_chat(user, "<span class='warning'>You need a better grip to do that!</span>")
			return
		var/mob/living/carbon/C = user.pulling
		user.visible_message("<span class = 'danger'>[user] shoves [C] inside [src]!</span>")
		C.DefaultCombatKnockdown(60)
		user.changeNext_move(CLICK_CD_MELEE)
		sleep(5)
		C.forceMove(src)
		storedmobs++
		buckle_mob(C, force=1)
		if(desc == initial(desc) && storedmobs > 0)
			desc += "<b>Something lies inside the barrel...</b>"
		return
	open = !open
	if(open)
		DISABLE_BITFIELD(reagents.reagents_holder_flags, DRAINABLE)
		ENABLE_BITFIELD(reagents.reagents_holder_flags, REFILLABLE)
		to_chat(user, "<span class='notice'>You open [src], letting you fill it.</span>")
	else
		DISABLE_BITFIELD(reagents.reagents_holder_flags, REFILLABLE)
		ENABLE_BITFIELD(reagents.reagents_holder_flags, DRAINABLE)
		to_chat(user, "<span class='notice'>You close [src], letting you draw from its tap.</span>")
	update_icon()

/obj/structure/fermenting_barrel/user_unbuckle_mob(mob/living/carbon/buckled_mob, mob/living/carbon/user)
	if(buckled_mob == user)
		if(open)
			unbuckle_mob(buckled_mob,force=1)
			storedmobs--
			if(storedmobs <= 0)
				desc = initial(desc)
		else
			buckled_mob.visible_message(\
			"<span class='warning'>[buckled_mob] struggles to break free from [src]!</span>",\
			"<span class='notice'>You struggle to break free from [src]! (Stay still for 30 seconds.)</span>",\
			"<span class='italics'>You hear something woody being punched...</span>")
			if(!do_after(buckled_mob, 300, target = src))
				if(buckled_mob && buckled_mob.buckled)
					to_chat(buckled_mob, "<span class='warning'>You fail to free yourself!</span>")
					return
			src.visible_message(text("<span class='danger'>[buckled_mob] tumbles out of [src]!</span>"))
			storedmobs--
			unbuckle_mob(buckled_mob,force=1)
			buckled_mob.forceMove(src.loc)
			if(storedmobs <= 0)
				desc = initial(desc)

/obj/structure/fermenting_barrel/MouseDrop_T(mob/living/target, mob/living/user)
	if(target == user && open)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.visible_message("<span class='notice'>[C] is trying to climb inside [src].</span>")
			if(!do_after(C, 40, target = src))
				to_chat(C, "<span class='notice'>You fail to climb on the [src].</span>")
				return
			C.forceMove(src)
			storedmobs++
			buckle_mob(C, force=1)
			if(desc == initial(desc) && storedmobs > 0)
				desc += "<b>Something lies inside the barrel...</b>"
	else if(target == user && !open)
		to_chat(user, "<span class='notice'>You can't climb on [src], it is closed!</span>")