/obj/machinery/vending/clothing/Initialize()
	. = ..()
	products[/obj/item/clothing/shoes/heels/poly] = 5
	products[/obj/item/clothing/head/wig] = 3
	products[/obj/item/skin_kit] = 30
	for(var/i in typesof(/datum/gear/underwear))
		var/datum/gear/G = i
		if(istype(G))
			products[G.path] = 5
	for(var/i in typesof(/datum/gear/shirt))
		var/datum/gear/G = i
		if(istype(G))
			products[G.path] = 5
	for(var/i in typesof(/datum/gear/socks))
		var/datum/gear/G = i
		if(istype(G))
			products[G.path] = 5
