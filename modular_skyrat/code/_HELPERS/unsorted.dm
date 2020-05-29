//i have no idea what the difference is between this and get_turf()
/proc/get_turf_global(atom/A, recursion_limit = 5)
	var/turf/T = get_turf(A)
	if(!T)
		return
	if(recursion_limit <= 0)
		return T
	if(T.loc)
		var/area/R = T.loc
		if(R.global_turf_object)
			return get_turf_global(R.global_turf_object, recursion_limit - 1)
	return T
