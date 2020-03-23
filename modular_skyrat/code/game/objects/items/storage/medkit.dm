/obj/item/storage/firstaid/tactical/blueshield
	name = "blueshield combat medical kit"
	desc = "Blue boy to the rescue!"
	icon_state = "tactical"
	possible_icons = null

/obj/item/storage/firstaid/tactical/blueshield/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/defibrillator/compact/combat/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat/omnizine(src)
	new /obj/item/reagent_containers/medspray/styptic(src)
	new /obj/item/reagent_containers/medspray/silver_sulf(src)
	new /obj/item/reagent_containers/medspray/synthflesh(src)
	new /obj/item/reagent_containers/medspray/synthflesh(src)
	new /obj/item/healthanalyzer/advanced(src)