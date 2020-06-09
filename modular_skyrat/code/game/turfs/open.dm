/turf/open/floor/Entered(atom/obj, atom/oldloc)
	. = ..()
	CitDirtify(obj, oldloc)

/turf/open/floor/proc/CitDirtify(atom/obj, atom/oldloc)
	var/cleanprob = 50
	var/cleanamount = 0.05
	if(ishuman(obj))
		var/mob/living/carbon/human/H = obj
		if(HAS_TRAIT(H, TRAIT_CLEANFOOT) && !HAS_TRAIT(H, TRAIT_DIRTYFOOT))
			if(oldloc && istype(oldloc, /turf/open/floor))
				var/obj/effect/decal/cleanable/cleanable = locate(/obj/effect/decal/cleanable, oldloc)
				if(cleanable)
					qdel(cleanable)
			return
		if(HAS_TRAIT(H, TRAIT_CLEANFOOT) || HAS_TRAIT(H, TRAIT_LIGHT_STEP))
			return
		if(HAS_TRAIT(H, TRAIT_DIRTYFOOT))
			cleanprob = 100
			cleanamount = 0.5
	if(prob(cleanprob))
		if(has_gravity(src) && !isobserver(obj))
			var/dirtamount
			var/obj/effect/decal/cleanable/dirt/dirt = locate(/obj/effect/decal/cleanable/dirt, src)
			if(!dirt)
				dirt = new/obj/effect/decal/cleanable/dirt(src)
				dirt.alpha = 0
				dirtamount = 0
			dirtamount = dirt.alpha + 1
			if(oldloc && istype(oldloc, /turf/open/floor))
				var/obj/effect/decal/cleanable/dirt/spreadindirt = locate(/obj/effect/decal/cleanable/dirt, oldloc)
				if(spreadindirt && spreadindirt.alpha)
					dirtamount += round(spreadindirt.alpha * cleanamount)
			dirt.alpha = min(dirtamount,255)
	return TRUE
