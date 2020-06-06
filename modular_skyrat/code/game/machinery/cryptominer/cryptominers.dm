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
	var/miningtime = 3000
	var/miningpoints = 50
	var/mintemp = TCRYO // 225K equals approximately -55F or -48C
	var/midtemp = T0C // 273K equals 32F or 0C
	var/maxtemp = 500 // 500K equals approximately 440F or 226C
	var/heatingPower = 40000

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
	START_PROCESSING(SSmachines,src)

/obj/machinery/cryptominer/Destroy()
	STOP_PROCESSING(SSmachines,src)
	return ..()

/obj/machinery/cryptominer/deconstruct()
	STOP_PROCESSING(SSmachines,src)
	return ..()

/obj/machinery/cryptominer/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
		return
	if(default_deconstruction_crowbar(W))
		return
	if(default_unfasten_wrench(user, W))
		return

/obj/machinery/cryptominer/process()
	var/turf/L = get_turf(src)
	if(!L)
		return
	var/datum/gas_mixture/env = L.return_air()
	if(!env)
		return
	var/heat_capacity = env.heat_capacity()
	if(!heat_capacity)
		return
	var/requiredPower = abs(env.temperature - maxtemp) * heat_capacity
	requiredPower = min(requiredPower, heatingPower)
	if(requiredPower < 1)
		return
	var/deltaTemperature = requiredPower / heat_capacity
	if(env.temperature >= maxtemp)
		if(mining)
			playsound(loc, 'sound/machines/beep.ogg', 50, 1, -1)
		mining = FALSE
		update_icon()
		return
	if(env.temperature <= maxtemp && env.temperature >= midtemp)
		if(mining)
			playsound(loc, 'sound/machines/ping.ogg', 50, 1, -1)
			var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(D)
				D.adjust_money((miningpoints / 5))
			env.temperature += deltaTemperature
			air_update_turf()
	if(env.temperature <= midtemp && env.temperature >= mintemp)
		if(mining)
			playsound(loc, 'sound/machines/ping.ogg', 50, 1, -1)
			var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(D)
				D.adjust_money((miningpoints))
			env.temperature += deltaTemperature
			air_update_turf()
	if(env.temperature <= mintemp)
		if(mining)
			playsound(loc, 'sound/machines/ping.ogg', 50, 1, -1)
			var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(D)
				D.adjust_money((miningpoints * 3))
			env.temperature += deltaTemperature
			air_update_turf()

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
	name = "syndicate cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. It lasts a little longer."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/syndie.dmi'
	icon_state = "off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 100
	circuit = /obj/item/circuitboard/machine/cryptominer/syndie
	miningtime = 6000
	miningpoints = 100

/obj/machinery/cryptominer/nanotrasen
	name = "nanotrasen cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. This doesn't turn off easily."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/nanotrasen.dmi'
	icon_state = "off"
	density = TRUE
	use_power = IDLE_POWER_USE
	idle_power_usage = 1
	active_power_usage = 1
	miningtime = 600000
	miningpoints = 1000
