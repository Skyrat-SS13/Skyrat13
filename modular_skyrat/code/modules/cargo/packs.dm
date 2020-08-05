/datum/supply_pack/materials/license50
	name = "50 Empty License Plates"
	desc = "Create a bunch of boxes."
	cost = 1000  // 50 * 25 + 700 - 1000 = 950 credits profit
	contains = list(/obj/item/stack/license_plates/empty/fifty)
	crate_name = "empty license plate crate"

/datum/supply_pack/vending/dinner/prisoner
	name = "Prisoner Dinnerware Supply Crate"
	desc = "Use a plate and have some utensils! Contains a dinnerware and sustenance vending machine refill."
	cost = 2500
	contains = list(/obj/item/vending_refill/sustenance,
					/obj/item/vending_refill/dinnerware/prisoner)
	crate_name = "prisoner dinnerware supply crate"
	crate_type = /obj/structure/closet/crate


/datum/supply_pack/vending/hydro/prisoner
	name = "Prisoner Hydroponics Supply Crate"
	desc = "Arnt you glad you dont have to do it the natural way? Contains a megaseed and nutrimax vending machine refill."
	cost = 5000
	contains = list(/obj/item/vending_refill/hydroseeds,
					/obj/item/vending_refill/hydronutrients/prisoner)
	crate_name = "prisoner hydroponics supply crate"
	crate_type = /obj/structure/closet/crate

/datum/supply_pack/vending/pdavendor
	name = "PDA Vending Supply Crate"
	desc = "Let people get their custom PDAs."
	cost = 5000
	contains = list(/obj/item/vending_refill/pdavendor)
	crate_name = "pda vending supply crate"
	crate_type = /obj/structure/closet/crate
