/mob/living/simple_animal/hostile/scp/scp106
	name = "SCP 106"
	desc = "Pain. The hunt is on."
	icon = 'modular_skyrat/icons/mob/scp/scp106.dmi'
	icon_state = "scp106"
	icon_living = "scp106"
	
/mob/living/simple_animal/hostile/scp173/movement_delay()
	return -1
	
/mob/living/simple_animal/hostile/scp173/UnarmedAttack(atom/A)
	. = ..()
	if(isliving(A))
		var/mob/living/L = A
		if(L.stat == DEAD)
			return
		var/turf/T = get_turf(locate(/obj/effect/scp106/realmenter))
		L.forceMove(T)
		L.adjustBruteLoss(10)
		playsound(loc, pick('modular_skyrat/sound/scp/NeckSnap1.ogg', 'modular_skyrat/sound/scp/NeckSnap2.ogg'), 50, 1, -1)
		visible_message("<span class='warning'>[src] hunts [L]!</span>")

/obj/effect/scp106

/obj/effect/scp106/realmenter
	var/list/scp106_choices = list()

/obj/effect/scp106/realmenter/Initialize()
	for(var/obj/effect/scp106/choice/C in world)
		if(!C)
			return
		scp106_choices += C
	pick_answer()

/obj/effect/scp106/realmenter/proc/pick_answer()
	for(var/obj/effect/scp106/choice/C in scp106_choices)
		C.real_answer = FALSE
	var/obj/effect/scp106/choice/CC = pick(scp106_choices)
	CC.real_answer = TRUE

/obj/effect/scp106/choice
	var/obj/effect/scp106/realmenter/master
	var/real_answer = FALSE

/obj/effect/scp106/choice/Initialize()
	master = locate(/obj/effect/scp106/realmenter)

/obj/effect/scp106/choice/Crossed(atom/movable/AM, oldloc)
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.stat == DEAD)
			return
		if(!real_answer)
			L.death()
			var/turf/leave = get_turf(locate(/obj/effect/scp106/realmexit))
			L.forceMove(leave)
		var/turf/T = get_turf(locate(/obj/effect/scp106/mazeenter))
		L.forceMove(T)
		master.pick_answer()

/obj/effect/scp106/mazeenter

/obj/effect/scp106/mazeexit

/obj/effect/scp106/mazeexit/Crossed(atom/movable/AM, oldloc)
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.stat == DEAD)
			return
		var/turf/T = get_turf(locate(/obj/effect/scp106/realmexit))
		L.forceMove(T)

/obj/effect/scp106/realmexit
