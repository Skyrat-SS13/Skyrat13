/obj/machinery/mineral/mint/RefreshParts()
	var/T = 0
	for(var/obj/item/stock_parts/matter_bin/MB in component_parts)
		T += MB.rating * MINERAL_MATERIAL_AMOUNT * 50
	var/datum/component/material_container/materialss = GetComponent(/datum/component/material_container)
	if (materialss)
		materialss.max_amount = T
	var/manip = 0
	for(var/obj/item/stock_parts/manipulator/MB in component_parts)
		manip = manip + MB.rating
	coinsToMakePerProcess = manip
