/obj/machinery/computer/cargo/ui_static_data(mob/user)
	var/list/data = list()
	data["requestonly"] = requestonly
	data["supplies"] = list()
	for(var/pack in SSshuttle.supply_packs)
		var/datum/supply_pack/P = SSshuttle.supply_packs[pack]
		if(!data["supplies"][P.group])
			data["supplies"][P.group] = list(
				"name" = P.group,
				"packs" = list()
			)
		var/obj/item/card/id/id_card = user.get_idcard(hand_first = FALSE)
		var/list/useraccess
		if(id_card)
			useraccess = id_card.access
		var/crateaccess = P.access
		if(!(obj_flags & EMAGGED))
			if(!crateaccess)
				if((P.hidden && !(obj_flags & EMAGGED)) || (P.contraband && !contraband) || (P.special && !P.special_enabled) || P.DropPodOnly)
					continue
			else
				if((P.hidden && !(obj_flags & EMAGGED)) || (P.contraband && !contraband) || (P.special && !P.special_enabled) || P.DropPodOnly || !(P.access in useraccess))
					continue
		data["supplies"][P.group]["packs"] += list(list(
			"name" = P.name,
			"cost" = P.cost,
			"id" = pack,
			"desc" = P.desc || P.name, // If there is a description, use it. Otherwise use the pack's name.
			"access" = P.access
		))
	return data
