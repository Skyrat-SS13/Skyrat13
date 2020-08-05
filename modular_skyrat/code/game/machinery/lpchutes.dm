/obj/machinery/plate_chute
	name = "plate delivery chute"
	desc = "If you see this, naughty naughty."
	icon = 'modular_skyrat/icons/obj/machines/dwchute.dmi'
	use_power = NO_POWER_USE

/obj/machinery/plate_chute/inputchute
	name = "export delivery input chute"
	desc = "For your license plate delivery needs. Just insert and watch as it goes!. A sign at the bottom reads: Now accepts other materials like cloth, silk, some glassware, etc."
	icon_state = "inputchute"
	var/obj/machinery/plate_chute/outputchute/OC
	var/list/delivery = list(
								/obj/item/stack/license_plates/filled,
								/obj/item/stack/sheet/mineral/wood,
								/obj/item/stack/sheet/leather,
								/obj/item/stack/sheet/cloth,
								/obj/item/stack/sheet/durathread,
								/obj/item/stack/sheet/cardboard,
								/obj/item/glasswork/glass_base/lens,
								/obj/item/reagent_containers/glass/beaker/glass_dish,
								/obj/item/reagent_containers/glass/beaker/flask/spouty,
								/obj/item/reagent_containers/glass/beaker/flask,
								/obj/item/reagent_containers/glass/beaker/flask/large,
								/obj/item/laser_pointer/blue/handmade, //If they somehow make this let them send it.
								/obj/item/glasswork/glasses, //This is admin only atm but just in case
								/obj/item/tea_plate,
								/obj/item/tea_cup
								)	

/obj/machinery/plate_chute/outputchute
	name = "export delivery output chute"
	desc = "For your delivery needs. Just wait for the credit cows to go!"
	icon_state = "outputchute"

/obj/machinery/plate_chute/inputchute/Initialize()
	. = ..()
	OC = locate()

/obj/machinery/plate_chute/inputchute/attackby(obj/item/I, mob/living/user, params)
	if(istype(delivery) && OC)
		I.forceMove(OC.loc)
		playsound(loc, 'sound/effects/bin_close.ogg', 15, 1, -3)
		playsound(OC.loc, 'sound/effects/bin_open.ogg', 15, 1, -3)
		return
	else
		to_chat(user,"WARNING: UNKNOWN")
		playsound(loc, 'sound/machines/buzz-two.ogg', 15, 1, -3)
		return
