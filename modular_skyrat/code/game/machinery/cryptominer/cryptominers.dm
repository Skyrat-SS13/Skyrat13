/obj/machinery/cryptominer
	name = "cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/cargo.dmi'
	icon_state = "off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 20
	active_power_usage = 200
	circuit = /obj/item/circuitboard/machine/cryptominer
	var/mining = FALSE
	var/miningtime = 600
	var/miningpoints = 10

/obj/machinery/cryptominer/update_icon()
	. = ..()
	if(!is_operational())
		icon_state = "off"
	else if(mining)
		icon_state = "loop"
	else
		icon_state = "on"

/obj/machinery/cryptominer/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)

/obj/machinery/cryptominer/Destroy()
	return ..()

/obj/machinery/cryptominer/process()
	if(mining)
		playsound(loc, 'sound/machines/beep.ogg', 50, 1, -1)
		playsound(loc, 'sound/machines/ping.ogg', 50, 1, -1)
		SSshuttle.points += miningpoints

/obj/machinery/cryptominer/attack_hand(mob/living/user)
	. = ..()
	if(!is_operational())
		to_chat(user, "<span class='warning'>[src] has to be on to do this!</span>")
		return FALSE
	if(mining)
		to_chat(user, "<span class='warning'>[src] is already mining!</span>")
		return FALSE
	startmining(user)

/obj/machinery/cryptominer/proc/startmining(mob/living/user)
	if(!mining)
		addtimer(CALLBACK(src, .proc/stopmining, user),miningtime)
		mining = TRUE
		update_icon()

/obj/machinery/cryptominer/proc/stopmining(mob/living/user)
	mining = FALSE
	update_icon()

/obj/machinery/cryptominer/syndie
	name = "cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. It lasts a little longer."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/syndie.dmi'
	icon_state = "off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 100
	circuit = /obj/item/circuitboard/machine/cryptominer/syndie
	miningtime = 6000
	miningpoints = 20

/obj/machinery/cryptominer/nanotrasen
	name = "cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. This doesn't turn off easily."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/nanotrasen.dmi'
	icon_state = "off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 1
	active_power_usage = 1
	miningtime = 600000
	miningpoints = 100