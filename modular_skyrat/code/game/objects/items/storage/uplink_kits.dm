/obj/item/storage/box/strange_seeds_25pack

/obj/item/storage/box/strange_seeds_25pack/PopulateContents()
	new /obj/item/storage/box/strange_seeds_10pack(src)
	new /obj/item/storage/box/strange_seeds_10pack(src)
	new /obj/item/storage/box/strange_seeds_5pack(src)

/obj/item/storage/box/strange_seeds_5pack/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/seeds/random(src)
