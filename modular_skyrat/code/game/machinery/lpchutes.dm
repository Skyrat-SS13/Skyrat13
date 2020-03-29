/obj/machinery/plate_chute
	name = "plate delivery chute"
	desc = "If you see this, naughty naughty."
	icon = 'modular_skyrat/icons/obj/machines/dwchute.dmi'
	use_power = NO_POWER_USE

/obj/machinery/plate_chute/inputchute
	name = "plate delivery input chute"
	desc = "For your license plate delivery needs. Just insert and watch as it goes!"
	icon_state = "inputchute"
	var/obj/machinery/plate_chute/outputchute/OC

/obj/machinery/plate_chute/outputchute
	name = "plate delivery output chute"
	desc = "For your license plate delivery needs. Just wait for the credit cows to go!"
	icon_state = "outputchute"

/obj/machinery/plate_chute/inputchute/Initialize()
	. = ..()
	OC = locate()

/obj/machinery/plate_chute/inputchute/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/license_plates/filled) && OC)
		I.forceMove(OC.loc)
		playsound(loc, 'sound/effects/bin_close.ogg', 15, 1, -3)
		playsound(OC.loc, 'sound/effects/bin_open.ogg', 15, 1, -3)
		return
	else
		to_chat(user,"WARNING: UNKNOWN")
		playsound(loc, 'sound/machines/buzz-two.ogg', 15, 1, -3)
		return
	. = ..()