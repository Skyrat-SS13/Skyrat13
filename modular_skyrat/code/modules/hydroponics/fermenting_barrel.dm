//BARREL DUNKING!
/obj/structure/fermenting_barrel
	var/maxstoredmobs = 3
	var/storedmobs = 0
	var/volumeperprocess = 2.5
	can_buckle = TRUE
	climb_time = 20

/obj/structure/fermenting_barrel/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/fermenting_barrel/Destroy()
	for(var/atom/movable/AM in contents)
		AM.forceMove(loc)
	return ..()

/obj/structure/fermenting_barrel/process()
	for(var/mob/living/carbon/C in src.contents)
		src.reagents.trans_to(C, volumeperprocess)
		src.reagents.reaction(C, TOUCH)

/obj/structure/fermenting_barrel/attack_hand(mob/user)
	if(src.contents.Find(user))
		user_unbuckle_mob(user, user)
		return
	if(open && user.pulling && user.a_intent == "grab" && iscarbon(user.pulling))
		if(storedmobs >= maxstoredmobs)
			to_chat(user, "<span class='warning'>The barrel is already full!</span>")
			return
		if(user.grab_state < GRAB_AGGRESSIVE)
			to_chat(user, "<span class='warning'>You need a better grip to do that!</span>")
			return
		var/mob/living/carbon/C = user.pulling
		user.visible_message("<span class = 'danger'>[user] starts to shove [C] inside [src]!</span>")
		if(!do_after(user, 30, target = src))
			to_chat(user, "<span class='warning'>You fail to shove [C] into [src]!</span>")
		user.visible_message("<span class = 'danger'>[user] shoves [C] inside [src]!</span>")
		C.DefaultCombatKnockdown(60)
		user.changeNext_move(CLICK_CD_MELEE)
		C.forceMove(src)
		storedmobs++
		buckle_mob(C, force=1)
		if(desc == initial(desc) && storedmobs > 0)
			desc += "<b> Something lies inside the barrel...</b>"
		return
	open = !open
	if(open && !src.contents.Find(user))
		DISABLE_BITFIELD(reagents.reagents_holder_flags, DRAINABLE)
		ENABLE_BITFIELD(reagents.reagents_holder_flags, REFILLABLE)
		to_chat(user, "<span class='notice'>You open [src], letting you fill it.</span>")
	else if(!open && !src.contents.Find(user))
		DISABLE_BITFIELD(reagents.reagents_holder_flags, REFILLABLE)
		ENABLE_BITFIELD(reagents.reagents_holder_flags, DRAINABLE)
		to_chat(user, "<span class='notice'>You close [src], letting you draw from its tap.</span>")
	update_icon()

/obj/structure/fermenting_barrel/user_unbuckle_mob(mob/living/buckled_mob, mob/living/carbon/human/user)
	if(buckled_mob == user)
		if(open)
			buckled_mob.visible_message(\
			"<span class='warning'>[buckled_mob] struggles to break free from [src]!</span>",\
			"<span class='warning'>You struggle to break free from [src]! (Stay still for about 3 seconds.)</span>")
			if(!do_after(buckled_mob, 25, target = src))
				to_chat(buckled_mob, "<span class='warning'>You fail to free yourself!</span>")
			buckled_mob.visible_message(\
			"<span class='warning'>[buckled_mob] breaks free from [src]!</span>",\
			"<span class='warning'>You break free from [src]!</span>")
			unbuckle_mob(buckled_mob,force=1)
			buckled_mob.forceMove(src.loc)
			storedmobs--
			if(storedmobs <= 0)
				desc = initial(desc)
		else
			buckled_mob.visible_message(\
			"<span class='warning'>[buckled_mob] struggles to break free from [src]!</span>",\
			"<span class='warning'>You struggle to break free from [src]! (Stay still for 30 seconds.)</span>",\
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
	else
		if(open)
			src.visible_message(text("<span class='danger'>[user] pulls [buckled_mob] out of [src]!</span>"))
			storedmobs--
			unbuckle_mob(buckled_mob,force=1)
			buckled_mob.forceMove(src.loc)
			if(storedmobs <= 0)
				desc = initial(desc)

/obj/structure/fermenting_barrel/MouseDrop_T(mob/living/target, mob/living/user)
	if(target == user && open)
		if(iscarbon(user) && storedmobs < maxstoredmobs)
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

/obj/structure/fermenting_barrel/AltClick(mob/living/user)
	if(open)
		if(storedmobs)
			if(!do_after(user, 25, target = src))
				to_chat(user, "<span class='notice'>You fail to pull out anyone from the [src].</span>")
				return
			for(var/mob/living/carbon/C in src)
				storedmobs--
				unbuckle_mob(C,force=1)
				C.forceMove(src.loc)
				if(storedmobs <= 0)
					desc = initial(desc)
			user.visible_message("<span class='notice'>[user] pulled out everyone that was in [src].</span>")
	else
		to_chat(user, "<span class='notice'>You can't pull people out of a closed barrel.</span>")
