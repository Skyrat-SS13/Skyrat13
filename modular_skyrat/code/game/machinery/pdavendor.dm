/obj/machinery/vending/pdavendor
	icon = 'modular_skyrat/icons/obj/machines/computer.dmi'
	icon_state = "pdaterm"
	icon_vend = "pdaterm-purchase"
	icon_deny = "pdaterm-problem"
	products = list(/obj/item/pda = 20)
	contraband = list(/obj/item/pda/neko = 1)
	premium = list(/obj/item/pda/clear = 1)
	product_ads = "PDAs here!;Slick and informative!;Grab another?;Got a penpal?"
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	refill_canister = /obj/item/vending_refill/pdavendor
	resistance_flags = FIRE_PROOF
	default_price = 500
	extra_price = 1000
	payment_department = NO_FREEBIES

/obj/item/vending_refill/pdavendor
	icon_state = "refill_engi"
