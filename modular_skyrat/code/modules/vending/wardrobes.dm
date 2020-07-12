/obj/machinery/vending/wardrobe/sec_wardrobe
	contraband = list(/obj/item/clothing/under/rank/security/civilprotection = 3,
					/obj/item/clothing/suit/armor/vest/cparmor = 3,
					/obj/item/clothing/mask/gas/sechailer/cpmask = 3,
					/obj/item/clothing/head/helmet/cphood = 3,
					/obj/item/clothing/mask/gas/sechailer/hecu = 3)

/obj/machinery/vending/wardrobe/robo_wardrobe/New(loc, ...)
	. = ..()
	products[/obj/item/storage/backpack/science/robo] = 3
	products[/obj/item/storage/backpack/satchel/tox/robo] = 3
	products[/obj/item/storage/backpack/duffel/robo] = 3
