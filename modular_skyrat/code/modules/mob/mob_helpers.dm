/proc/bloodtype_to_color(var/type)
	. = BLOOD_COLOR_HUMAN
	switch(type)
		if("U")//Universal blood; a bit orange
			. = BLOOD_COLOR_UNIVERSAL
		if("SY")//Synthetics blood; blue
			. = BLOOD_COLOR_SYNTHETIC
		if("L")//lizard, a bit pink/purple
			. = BLOOD_COLOR_LIZARD
		if("X*")//xeno blood; greenish yellow
			. = BLOOD_COLOR_XENO
		if("HF")// Oil/Hydraulic blood. something something why not. reee //skyrat change moved to modular_skyrat
			. = BLOOD_COLOR_SYNTHETIC
		if("GEL")// slimepeople blood, rgb 0, 255, 144
			. = BLOOD_COLOR_SLIME
		if("BUG")// yellowish, like, y'know bug guts I guess.
			. = BLOOD_COLOR_BUG
		//add more stuff to the switch if you have more blood colors for different types
		// the defines are in _DEFINES/misc.dm
