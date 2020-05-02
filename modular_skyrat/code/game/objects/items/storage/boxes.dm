/obj/item/storage/box/botany_bottles
	name = "box of botany supplies"
	illustration = "syringe"

/obj/item/storage/box/botany_bottles/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/glass/bottle/mutagen( src )
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/glass/bottle/saltpetre( src )