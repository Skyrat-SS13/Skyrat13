/obj/machinery/cryptominer
	name = "cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/cargo.dmi'
	icon_state = "off"
	density = TRUE

	use_power = ACTIVE_POWER_USE
	idle_power_usage = 20
	active_power_usage = 2000

	circuit = /obj/item/circuitboard/machine/cryptominer

	var/mining = FALSE
	var/miningtime = 1 MINUTES

	var/mintemp = TCMB // 2.7K equals -454.81F or -270.3C
	var/midtemp = T0C // 273K equals 32F or 0C
	var/maxtemp = 500 // 500K equals approximately 440F or 226C

	var/efficiency

/obj/machinery/cryptominer/update_icon()
	. = ..()
	if(!is_operational())
		icon_state = "off"
	else if(mining)
		icon_state = "loop"
	else
		icon_state = "on"

//okay, "detailed" understanding of this.
//cryptominers have 2 of each of these items: scanning, manipul, laser, and bin
//so in total, 8 objects. easy math
//then, each part has 4 tiers, which means multiples of 8. (8, 16, 24, 32)
//we will use this as the means for creating credits... EASY
/obj/machinery/cryptominer/RefreshParts()
	efficiency = 0
	for(var/obj/item/stock_parts/scanning_module/S in component_parts)
		efficiency += S.rating
	for(var/obj/item/stock_parts/manipulator/P in component_parts)
		efficiency += P.rating
	for(var/obj/item/stock_parts/micro_laser/L in component_parts)
		efficiency += L.rating
	for(var/obj/item/stock_parts/matter_bin/M in component_parts)
		efficiency += M.rating

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
	var/turf/T = get_turf(src)
	if(!T)
		return
	var/datum/gas_mixture/env = T.return_air()
	if(!env)
		return
	if(!mining)
		return
	if(env.temperature >= maxtemp)
		if(mining)
			playsound(loc, 'sound/machines/beep.ogg', 50, TRUE, -1)
		set_mining(FALSE)
		return
	if(env.temperature <= maxtemp && env.temperature >= midtemp)
		if(mining)
			produce_points(0.20)
			produce_heat()
		return
	if(env.temperature <= midtemp && env.temperature >= mintemp)
		if(mining)
			produce_points(1)
			produce_heat()
		return
	if(env.temperature <= mintemp)
		if(mining)
			produce_points(3)
			produce_heat()
		return

/obj/machinery/cryptominer/proc/produce_points(number)
	playsound(loc, 'sound/machines/ping.ogg', 50, TRUE, -1)
	var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(D)
		var/printedmoney = round(efficiency * number)
		D.adjust_money(printedmoney)

/obj/machinery/cryptominer/proc/produce_heat()
	atmos_spawn_air("co2=100;TEMP=2000")

/obj/machinery/cryptominer/attack_hand(mob/living/user)
	. = ..()
	if(!is_operational())
		to_chat(user, "<span class='warning'>[src] has to be on to do this!</span>")
		return FALSE
	if(mining)
		set_mining(FALSE)
		visible_message("<span class='warning'>[src] slowly comes to a halt.</span>",
						"<span class='warning'>You turn off [src].</span>",
						runechat_popup = TRUE)
		return
	set_mining(TRUE)

/obj/machinery/cryptominer/proc/set_mining(new_value)
	if(new_value == mining)
		return //No changes
	mining = new_value
	if(mining)
		START_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()

/*
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
*/
/obj/machinery/cryptominer/nanotrasen
	name = "nanotrasen cryptocurrency miner"
	desc = "This handy-dandy machine will produce credits for your enjoyment. This doesn't turn off easily."
	icon = 'modular_skyrat/code/game/machinery/cryptominer/nanotrasen.dmi'

	use_power = IDLE_POWER_USE
	idle_power_usage = 1
	active_power_usage = 1

	miningtime = 3 HOURS

