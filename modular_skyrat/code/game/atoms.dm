// Trash that should not exist
/atom
	var/abandoned_code = FALSE

/atom/Initialize(mapload, ...)
	..()
	if(abandoned_code)
		QDEL_IN(src, 1 SECONDS)

// Germ / infection stuff
/atom
	var/germ_level = GERM_LEVEL_AMBIENT

// Used to add or reduce germ level on an atom
/atom/proc/janitize(add_germs, minimum_germs = 0, maximum_germs = MAXIMUM_GERM_LEVEL)
	germ_level = clamp(germ_level + add_germs, minimum_germs, maximum_germs)
