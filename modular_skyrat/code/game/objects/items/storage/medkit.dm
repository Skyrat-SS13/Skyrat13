/obj/item/storage/firstaid/tactical/blueshield
	name = "blueshield combat medical kit"
	desc = "Blue boy to the rescue!"
	icon_state = "tactical"
	possible_icons = null

/obj/item/storage/firstaid/tactical/blueshield/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/bruise_pack(src)
	new /obj/item/stack/medical/ointment(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/pinpointer/crew(src)