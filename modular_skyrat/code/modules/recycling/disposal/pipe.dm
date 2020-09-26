#define IFFY 2
/*
/obj/structure/disposalpipe/transfer_to_dir(obj/structure/disposalholder/H, nextdir)
	. = ..()
	var/turf/T = H.nextloc()
	var/obj/structure/disposalpipe/P = H.findpipe(T)
	if (P && P.canclank)
		if(H.hasmob)
			for(var/mob/living/carbon/C in H.contents)
				C.take_bodypart_damage(brute=1)
*/
/obj/structure/disposalpipe/proc/transfer_to_dir(obj/structure/disposalholder/H, nextdir)
	H.setDir(nextdir)
	var/turf/T = H.nextloc()
	var/obj/structure/disposalpipe/P = H.findpipe(T)

	if(P)
		// find other holder in next loc, if inactive merge it with current
		var/obj/structure/disposalholder/H2 = locate() in P
		if(H2 && !H2.active)
			H.merge(H2)

		H.forceMove(P)
		if(P.canclank == TRUE || (P.canclank == IFFY && P.dpdir != 3 && P.dpdir != 12))
			playsound(P, H.hasmob ? "clang" : "clangsmall", H.hasmob ? 50 : 25, 1)
			if(H.hasmob)
				for(var/mob/living/carbon/C in H.contents)
					if(prob(33))
						C.take_bodypart_damage(brute=1)
		return P
	else			// if wasn't a pipe, then they're now in our turf
		H.forceMove(get_turf(src))
		return null

#undef IFFY
