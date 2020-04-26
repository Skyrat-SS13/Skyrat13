/obj/effect/decal/cleanable/glitter
	var/expirydate = 3000 //5 minutes

/obj/effect/decal/cleanable/glitter/Initialize()
	. = ..()
	QDEL_IN(src, expirydate)
