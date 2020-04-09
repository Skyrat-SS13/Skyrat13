/obj/machinery/recharger/New()
  . = ..()
  allowed_devices += typecacheof(list(
	  /obj/item/gun/ballistic/charged))
