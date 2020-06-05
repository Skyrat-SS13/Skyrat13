/obj/machinery/atm
	name = "Automatic Teller Machine"
	desc = "A terminal that will allow you to access your bank account."
	icon = 'modular_skyrat/icons/obj/machines/terminals.dmi'
	icon_state = "atm"

	var/obj/item/card/id/CID = null

/obj/machinery/paystand/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id))
		CID = W
		