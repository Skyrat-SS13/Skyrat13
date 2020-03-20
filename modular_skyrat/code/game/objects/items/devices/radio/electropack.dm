/obj/item/electropack/shockcollar
	var/random = TRUE
	var/freq_in_name = TRUE

/obj/item/electropack/shockcollar/Initialize()
	if (random)
		code = rand(1,100)
		frequency = rand(MIN_FREE_FREQ, MAX_FREE_FREQ)
		if(ISMULTIPLE(frequency, 2))//signaller frequencies are always uneven!
			frequency++
	if (freq_in_name)
		name = initial(name) + " - freq: [frequency/10] code: [code]"
	. = ..()
