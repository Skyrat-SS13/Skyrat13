/obj/item/storage/box/botany_bottles
	name = "box of botany supplies"
	icon = 'modular_skyrat/icons/obj/storage.dmi'
	illustration = "botany_mutagen"

/obj/item/storage/box/botany_bottles/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/glass/bottle/mutagen( src )
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/glass/bottle/saltpetre( src )

/obj/item/storage/box/medipens
	icon = 'modular_skyrat/icons/obj/storage.dmi'
	illustration = "epipen"