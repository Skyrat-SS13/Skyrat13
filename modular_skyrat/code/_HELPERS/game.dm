/proc/get_hearers_in_view(R, atom/source, need_client = TRUE, mobs = TRUE, objects = FALSE)
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
		var/list/cached_view
		if(objects)
			cached_view = view(R, T)
		else
			cached_view = viewers(R, T)
		if(mobs)
			for(var/mob/M in cached_view)
				if(M.client || !need_client)
					processing += M
		if(objects)
			for(var/obj/O in cached_view)
				processing += O
		T.luminosity = lum
	var/i = 0
	while(i < length(processing))
		var/atom/A = processing[++i]
		if(A.flags_1 & HEAR_1)
			. += A
			SEND_SIGNAL(A, COMSIG_ATOM_HEARER_IN_VIEW, processing, .)
		processing += A.contents