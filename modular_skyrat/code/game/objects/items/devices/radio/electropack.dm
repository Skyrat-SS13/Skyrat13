/obj/item/electropack/shockcollar
	var/random = TRUE

/obj/item/electropack/shockcollar/Initialize()
	if (random)
		code = rand(1,100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
	. = ..()