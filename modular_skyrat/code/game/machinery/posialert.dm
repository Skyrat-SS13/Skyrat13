/obj/machinery/posialert
	name = "automated positronic alert console"
	desc = "A console that will ping when a positronic personality is available for download."
	icon = 'modular_skyrat/icons/obj/machines/terminals.dmi'
	icon_state = "posialert"
	var/inuse = FALSE

/obj/machinery/posialert/attack_ghost(mob/user)
	. = ..()
	if(inuse)
		return
	inuse = TRUE
	flick("posialertflash",src)
	visible_message("<span notice='notice'>There are positronic personalities available!</span>", runechat_popup = TRUE)
	playsound(loc, 'sound/machines/ping.ogg', 50)
	addtimer(CALLBACK(src, /obj/machinery/posialert.proc/liftcooldown), 30 SECONDS)

/obj/machinery/posialert/proc/liftcooldown()
	inuse = FALSE
