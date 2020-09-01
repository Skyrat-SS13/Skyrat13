/obj/machinery/vending/clothing/New(loc, ...)
	. = ..()
	products[/obj/item/clothing/shoes/heels/poly] = 5
	products[/obj/item/clothing/head/wig] = 5
	for(var/datum/gear/G in typesof(/datum/gear/underwear))
		products[initial(G.path)] = 5
	for(var/datum/gear/G in typesof(/datum/gear/shirt))
		products[initial(G.path)] = 5
	for(var/datum/gear/G in typesof(/datum/gear/socks))
		products[initial(G.path)] = 5
	products[/obj/item/skin_kit] = 30
