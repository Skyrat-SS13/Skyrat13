/obj/machinery/wirelesscharger
	name = "parent charger"
	desc = "debug, you shouldn't see this"
	icon = 'modular_skyrat/code/game/machinery/wirelesscharger/wirelesscharger.dmi'
	use_power = IDLE_POWER_USE
	idle_power_usage = 5
	active_power_usage = 60
	power_channel = EQUIP
	circuit = null
	pass_flags = PASSTABLE

/obj/machinery/wirelesscharger/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/machinery/wirelesscharger/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/machinery/wirelesscharger/deconstruct()
	STOP_PROCESSING(SSobj,src)
	return ..()

/obj/machinery/wirelesscharger/attackby(obj/item/W, mob/user, params)
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, W))
		return
	if(default_deconstruction_crowbar(W))
		return
	if(default_unfasten_wrench(user, W))
		return

/obj/machinery/wirelesscharger/cells
	name = "wireless cell charger"
	desc = "charges cells wirelessly, somehow."
	icon_state = "cellcharger"
	circuit = /obj/item/circuitboard/machine/wirelesscharger/cells
	var/charge_rate = 500

/obj/machinery/wirelesscharger/cells/RefreshParts()
	charge_rate = 500
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		charge_rate *= C.rating

/obj/machinery/wirelesscharger/cells/process()
	if(!anchored || (stat & (BROKEN|NOPOWER)))
		return
	for(var/obj/item/stock_parts/cell/charging in get_turf(src))
		if(charging.percent() >= 100)
			continue
		use_power(charge_rate)
		charging.give(charge_rate)
		charging.update_icon()
		charging.update_overlays()

/obj/machinery/wirelesscharger/guns
	name = "wireless gun charger"
	desc = "charges guns wirelessly, somehow."
	icon_state = "guncharger"
	circuit = /obj/item/circuitboard/machine/wirelesscharger/guns
	var/recharge_coeff = 1
	var/static/list/allowed_devices = typecacheof(list(
		/obj/item/gun/energy,
		/obj/item/melee/baton,
		/obj/item/ammo_box/magazine/recharge,
		/obj/item/modular_computer,
		/obj/item/twohanded/electrostaff,
		/obj/item/gun/ballistic/automatic/magrifle,
		/obj/item/gun/ballistic/automatic/railgun,
		/obj/item/clothing/gloves/color/yellow/power))

/obj/machinery/wirelesscharger/guns/RefreshParts()
	for(var/obj/item/stock_parts/capacitor/C in component_parts)
		recharge_coeff = C.rating

/obj/machinery/wirelesscharger/guns/process()
	for(var/obj/item/charging in get_turf(src))
		if(istype(charging, /obj/item/stock_parts/cell))
			continue
		var/obj/item/stock_parts/cell/C = charging.get_cell()
		if(C)
			if(C.charge >= C.maxcharge)
				continue
			C.give(C.chargerate * recharge_coeff)
			use_power(250 * recharge_coeff)
		if(istype(charging, /obj/item/ammo_box/magazine/recharge))
			var/obj/item/ammo_box/magazine/recharge/R = charging
			if(R.stored_ammo.len >= R.max_ammo)
				continue
			R.stored_ammo += new R.ammo_type(R)
			use_power(200 * recharge_coeff)
		if(istype(charging, /obj/item/ammo_casing/mws_batt))
			var/obj/item/ammo_casing/mws_batt/R = charging
			if(R.cell.charge < R.cell.maxcharge)
				R.cell.give(R.cell.chargerate * recharge_coeff)
				use_power(250 * recharge_coeff)
			if(R.BB == null)
				R.chargeshot()
		if(istype(charging, /obj/item/ammo_box/magazine/mws_mag))
			var/obj/item/ammo_box/magazine/mws_mag/R = charging
			for(var/B in R.stored_ammo)
				var/obj/item/ammo_casing/mws_batt/batt = B
				if(batt.cell.charge < batt.cell.maxcharge)
					batt.cell.give(batt.cell.chargerate * recharge_coeff)
					use_power(250 * recharge_coeff)
				if(batt.BB == null)
					batt.chargeshot()
		charging.update_icon()
		charging.update_overlays()
