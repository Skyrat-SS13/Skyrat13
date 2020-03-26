/proc/get_hearers_in_view(R, atom/source)
	var/turf/T = get_turf(source)
	. = list()
	if(!T)
		return
	var/list/processing = list()
	if(R == 0)
		processing += T.contents
	else
		var/lum = T.luminosity
		T.luminosity = 6
		var/list/cached_turfs = RANGE_TURFS(R, T)
		for(var/turf/Tur in cached_turfs)
			for(var/mob/M in Tur)
				processing += M
			for(var/obj/O in Tur)
				processing += O
		T.luminosity = lum
	var/i = 0
	var/list/sightedturfs = list()
	var/list/contentlist = list()
	for(var/atom/A in processing)
		var/passed = FALSE
		var/turf/AT = get_turf(A)
		if(AT in sightedturfs)
			passed = TRUE
		else if(isInSight(A,T))
			sightedturfs += AT
			passed = TRUE
		if(passed)
			if(A.flags_1 & HEAR_1)
				. += A
				SEND_SIGNAL(A, COMSIG_ATOM_HEARER_IN_VIEW, processing, .)
			contentlist += A.contents

	//Another loop because we dont need to check sight for the contents of sighted things
	i = 0
	while(i < length(contentlist))
		var/atom/A = contentlist[++i]
		if(A.flags_1 & HEAR_1)
			. += A
			SEND_SIGNAL(A, COMSIG_ATOM_HEARER_IN_VIEW, processing, .)
		contentlist += A.contents