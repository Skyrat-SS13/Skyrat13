/obj/item/cagekey
	name = "Cage Key"
	desc = "This is a key, used to open cage doors."
	icon = 'modular_skyrat/icons/obj/cageitems.dmi'
	icon_state = "key"
	w_class = WEIGHT_CLASS_SMALL
	var/keyout = null

/obj/item/cagekey/Initialize()
	. = ..()
	if(!keyout)
		keyout = rand(1,9999)

/obj/item/hammerhook
	name = "Hammer and Hook"
	desc = "This is used to lockpick cage doors."
	icon = 'modular_skyrat/icons/obj/cageitems.dmi'
	icon_state = "hammerhook"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/hammerhook/Initialize()
	. = ..()