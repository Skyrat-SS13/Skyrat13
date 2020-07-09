/obj/machinery/wish_granter
	var/sound/wishsound = sound(file = 'modular_skyrat/sound/ambience/wishgranter.ogg', repeat = 0, wait = 0, volume = 100, channel = CHANNEL_AMBIENCE)
	var/soundlength = 800
	var/soundend

/obj/machinery/wish_granter/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/machinery/wish_granter/process()
	..()
	for(var/mob/living/M in view(12))
		if((wishsound && soundlength && !soundend && (M.client.prefs.toggles & SOUND_AMBIENCE)) || (wishsound && soundlength && world.time > soundend && (M.client.prefs.toggles & SOUND_AMBIENCE)))
			M.stop_sound_channel(CHANNEL_AMBIENCE)
			soundend = soundlength + world.time
			SEND_SOUND(M, wishsound) // so silence ambience will mute the weird russian chanting asmr for anyone who doesn't enjoy that
