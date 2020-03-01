/obj/item/stack/sheet/plasteel/cyborg
	custom_materials = null
	//var/datum/robot_energy_storage/metsource
	//var/datum/robot_energy_storage/plasource
	//var/metcost = 250
	//var/placost = 250
	cost = 500
	is_cyborg = 1
/* Commented out to pick up shit
/obj/item/stack/sheet/plasteel/cyborg/get_amount()
	return min(round(source.energy / metcost), round(plasource.energy / placost))

/obj/item/stack/sheet/plasteel/cyborg/use(used, transfer = FALSE) // Requires special checks, because it uses two storages
	source.use_charge(used * metcost)
	plasource.use_charge(used * placost)

/obj/item/stack/sheet/plasteel/cyborg/add(amount)
	source.add_charge(amount * metcost)
	plasource.add_charge(amount * placost)
*/