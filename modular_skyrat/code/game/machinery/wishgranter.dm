/obj/machinery/wish_granter
	var/sound/wishsound = sound('modular_skyrat/sound/ambience/wishgranter.ogg', 100)
	var/soundlength = 800
	var/soundend

/obj/machinery/wish_granter/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/machinery/wish_granter/process()
	..()
	for(var/mob/living/M in view(12))
		if((wishsound && soundlength && !soundend) || (wishsound && soundlength && world.time > soundend))
			M.stop_sound_channel(CHANNEL_AMBIENCE)
			soundend = soundlength + world.time
			M.playsound_local(null, null, 30, channel = CHANNEL_AMBIENCE, S = wishsound) // so silence ambience will mute the weird russian chanting asmr for anyone who doesn't enjoy that
