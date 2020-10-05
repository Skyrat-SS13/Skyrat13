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

/datum/supply_pack/security/dumdum
	name = ".38 DumDum Speedloader"
	desc = "Contains one speedloader of .38 DumDum ammunition, good for embedding in soft targets. Requires Security or Forensics access to open."
	cost = 1200
	access = FALSE
	access_any = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)
	contains = list(/obj/item/ammo_box/c38/dumdum)
	crate_name = ".38 match crate"

/datum/supply_pack/security/match
	name = ".38 Match Grade Speedloader"
	desc = "Contains one speedloader of match grade .38 ammunition, perfect for showing off trickshots. Requires Security or Forensics access to open."
	cost = 1200
	access = FALSE
	access_any = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)
	contains = list(/obj/item/ammo_box/c38/match)
	crate_name = ".38 match crate"

/datum/supply_pack/security/stingpack
	name = "Stingbang Grenade Pack"
	desc = "Contains five \"stingbang\" grenades, perfect for stopping riots and playing morally unthinkable pranks. Requires Security access to open."
	cost = 2500
	contains = list(/obj/item/storage/box/stingbangs)
	crate_name = "stingbang grenade pack crate"

/datum/supply_pack/security/stingpack/single
	name = "Stingbang Single-Pack"
	desc = "Contains one \"stingbang\" grenade, perfect for playing meanhearted pranks. Requires Security access to open."
	cost = 1400
	contains = list(/obj/item/grenade/stingbang)

/datum/supply_pack/vending/pdavendor
	name = "PDA Vending Supply Crate"
	desc = "Let people get their custom PDAs."
	cost = 5000
	contains = list(/obj/item/vending_refill/pdavendor)
	crate_name = "pda vending supply crate"
	crate_type = /obj/structure/closet/crate
