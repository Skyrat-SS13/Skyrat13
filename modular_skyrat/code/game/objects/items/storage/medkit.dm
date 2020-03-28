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
	new /obj/item/reagent_containers/hypospray/combat/omnizine(src)
	new /obj/item/reagent_containers/medspray/synthflesh(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/pinpointer/crew(src)