// QUALITY COPYPASTA
/turf/closed/wall/supermatter
	name = "Supermatter Sea"
	desc = "THE END IS right now actually."
	icon= 'modular_skyrat/code/game/gamemodes/endgame/smblob.dmi'
	icon_state = "bluespacecrystal"
	opacity = 0
	explosion_block = INFINITY
	layer = ABOVE_LIGHTING_PLANE

	var/next_check=0
	var/list/avail_dirs = list(NORTH,SOUTH,EAST,WEST)
	var/list/card_dirs = list(NORTH,SOUTH,EAST,WEST)

	dynamic_lighting = 0

/turf/closed/wall/supermatter/Initialize()
	icon_state = "bluespacecrystal[rand(1,6)]"
	START_PROCESSING(SSobj, src)
	var/turf/T = get_turf(src)
	for(var/atom/movable/A in T)
		if(A)
			if(istype(A,/mob/living))
				QDEL_NULL(A)
			else if(istype(A,/mob)) // Observers, AI cameras.
				continue
			QDEL_NULL(A)
	..()

/turf/closed/wall/supermatter/Destroy()
	for(var/step_direction in GLOB.cardinals)
		var/turf/neighbor_turf = get_step(src, step_direction)
		if(istype(neighbor_turf, /turf/closed/wall/supermatter))
			var/turf/closed/wall/supermatter/issupermatter = neighbor_turf
			issupermatter.avail_dirs = list(NORTH,SOUTH,EAST,WEST)
			START_PROCESSING(SSobj, issupermatter)
	STOP_PROCESSING(SSobj, src)
	return ..()

/turf/closed/wall/supermatter/process()

	// Only check infrequently.
	if(next_check>world.time)
		return

	// No more available directions? Shut down process().
	if(avail_dirs.len==0)
		STOP_PROCESSING(SSobj,src)
		return 1

	// We're checking, reset the timer.
	next_check = world.time+5 SECONDS

	// Choose a direction.
	var/pdir = pick(avail_dirs)
	avail_dirs -= pdir
	var/turf/T=get_step(src,pdir)
	if(istype(T, /turf/closed/wall/supermatter/))
		avail_dirs -= pdir
		return

	// EXPAND DONG
	if(isturf(T))
		// This is normally where a growth animation would occur
		spawn(10)
			// Nom.
			for(var/atom/movable/A in T)
				if(A)
					if(istype(A,/mob/living))
						QDEL_NULL(A)
					else if(istype(A,/mob)) // Observers, AI cameras.
						continue
					QDEL_NULL(A)
				CHECK_TICK
			T.ChangeTurf(type)
			var/turf/closed/wall/supermatter/SM = T
			if(SM.avail_dirs)
				SM.avail_dirs -= get_dir(T, src)

/turf/closed/wall/supermatter/attack_tk(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		log_game("[key_name(C)] has been disintegrated by a telekenetic grab on a supermatter crystal.</span>")
		to_chat(C, "<span class='userdanger'>That was a really dense idea.</span>")
		C.visible_message("<span class='userdanger'>A bright flare of radiation is seen from [C]'s head, shortly before you hear a sickening sizzling!</span>")
		var/obj/item/organ/brain/rip_u = locate(/obj/item/organ/brain) in C.internal_organs
		rip_u.Remove()
		qdel(rip_u)
		return
	return ..()

/turf/closed/wall/supermatter/attack_paw(mob/user)
	dust_mob(user, cause = "monkey attack")

/turf/closed/wall/supermatter/attack_alien(mob/user)
	dust_mob(user, cause = "alien attack")

/turf/closed/wall/supermatter/attack_animal(mob/living/simple_animal/S)
	var/murder
	if(!S.melee_damage_upper && !S.melee_damage_lower)
		murder = S.friendly_verb_continuous
	else
		murder = S.attack_verb_continuous
	dust_mob(S, \
	"<span class='danger'>[S] unwisely [murder] [src], and [S.p_their()] body burns brilliantly before flashing into ash!</span>", \
	"<span class='userdanger'>You unwisely touch [src], and your vision glows brightly as your body crumbles to dust. Oops.</span>", \
	"simple animal attack")

/turf/closed/wall/supermatter/attack_robot(mob/user)
	if(Adjacent(user))
		dust_mob(user, cause = "cyborg attack")

/turf/closed/wall/supermatter/attack_ai(mob/user)
	return

/turf/closed/wall/supermatter/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	dust_mob(user, cause = "hand")

/turf/closed/wall/supermatter/proc/dust_mob(mob/living/nom, vis_msg, mob_msg, cause)
	if(nom.incorporeal_move || nom.status_flags & GODMODE)
		return
	if(!vis_msg)
		vis_msg = "<span class='danger'>[nom] reaches out and touches [src], inducing a resonance... [nom.p_their()] body starts to glow and bursts into flames before flashing into ash"
	if(!mob_msg)
		mob_msg = "<span class='userdanger'>You reach out and touch [src]. Everything starts burning and all you can hear is ringing. Your last thought is \"That was not a wise decision.\"</span>"
	if(!cause)
		cause = "contact"
	nom.visible_message(vis_msg, mob_msg, "<span class='italics'>You hear an unearthly noise as a wave of heat washes over you.</span>")
	investigate_log("has been attacked ([cause]) by [key_name(nom)]", INVESTIGATE_SUPERMATTER)
	playsound(get_turf(src), 'sound/effects/supermatter.ogg', 50, 1)
	Consume(nom)

/turf/closed/wall/supermatter/attack_hand(mob/user as mob)
	user.visible_message("<span class=\"warning\">\The [user] reaches out and touches \the [src]... And then blinks out of existance.</span>",\
		"<span class=\"danger\">You reach out and touch \the [src]. Everything immediately goes quiet. Your last thought is \"That was not a wise decision.\"</span>",\
		"<span class=\"warning\">You hear an unearthly noise.</span>")

	playsound(src, 'sound/effects/supermatter.ogg', 50, 1)

	Consume(user)

/turf/closed/wall/supermatter/attackby(obj/item/W, mob/living/user, params)
	if(!istype(W) || (W.item_flags & ABSTRACT) || !istype(user))
		return
	if (istype(W, /obj/item/melee/roastingstick))
		return ..()
	else if(user.dropItemToGround(W))
		user.visible_message("<span class='danger'>As [user] touches \the [src] with \a [W], silence fills the room...</span>",\
			"<span class='userdanger'>You touch \the [src] with \the [W], and everything suddenly goes silent.</span>\n<span class='notice'>\The [W] flashes into dust as you flinch away from \the [src].</span>",\
			"<span class='italics'>Everything suddenly goes silent.</span>")
		investigate_log("has been attacked ([W]) by [key_name(user)]", INVESTIGATE_SUPERMATTER)
		Consume(W)
		playsound(get_turf(src), 'sound/effects/supermatter.ogg', 50, 1)

		radiation_pulse(src, 150, 4)

/turf/closed/wall/supermatter/Bumped(atom/AM)
	if(istype(AM, /mob/living))
		AM.visible_message("<span class=\"warning\">\The [AM] slams into \the [src] inducing a resonance... \his body starts to glow and catch flame before flashing into ash.</span>",\
		"<span class=\"danger\">You slam into \the [src] as your ears are filled with unearthly ringing. Your last thought is \"Oh, fuck.\"</span>",\
		"<span class=\"warning\">You hear an unearthly noise as a wave of heat washes over you.</span>")
	else
		AM.visible_message("<span class=\"warning\">\The [AM] smacks into \the [src] and rapidly flashes to ash.</span>",\
		"<span class=\"warning\">You hear a loud crack as you are washed with a wave of heat.</span>")

	playsound(src, 'sound/effects/supermatter.ogg', 50, 1)

	Consume(AM)


/turf/closed/wall/supermatter/proc/Consume(atom/AM)
	if(isliving(AM))
		var/mob/living/user = AM
		if(user.status_flags & GODMODE)
			return
		message_admins("[src] has consumed [key_name_admin(user)] [ADMIN_JMP(src)].")
		investigate_log("has consumed [key_name(user)].", INVESTIGATE_SUPERMATTER)
		user.dust(force = TRUE)
	else if(istype(AM, /obj/singularity))
		return
	else if(isobj(AM))
		if(!iseffect(AM))
			var/suspicion = ""
			if(AM.fingerprintslast)
				suspicion = "last touched by [AM.fingerprintslast]"
				message_admins("[src] has consumed [AM], [suspicion] [ADMIN_JMP(src)].")
			investigate_log("has consumed [AM] - [suspicion].", INVESTIGATE_SUPERMATTER)
		qdel(AM)

	//Some poor sod got eaten, go ahead and irradiate people nearby.
	radiation_pulse(src, 3000, 2, TRUE)
	for(var/mob/living/L in range(10))
		investigate_log("has irradiated [key_name(L)] after consuming [AM].", INVESTIGATE_SUPERMATTER)
		if(L in view())
			L.show_message("<span class='danger'>As \the [src] slowly stops resonating, you find your skin covered in new radiation burns.</span>", MSG_VISUAL,\
				"<span class='danger'>The unearthly ringing subsides and you notice you have new radiation burns.</span>", MSG_AUDIBLE)
		else
			L.show_message("<span class='italics'>You hear an unearthly ringing and notice your skin is covered in fresh radiation burns.</span>", MSG_AUDIBLE)


/turf/closed/wall/supermatter/singularity_act()
	return

/turf/closed/wall/supermatter/no_spread
	avail_dirs = list()
