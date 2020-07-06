/*
/obj/machinery/vending/kink
	name = "KinkMate"
	desc = "A vending machine for all your unmentionable desires."
	icon_state = "kink"
	circuit = /obj/item/circuitboard/machine/kinkmate
	product_slogans = "Kinky!;Sexy!;Check me out, big boy!"
	vend_reply = "Have fun, you shameless pervert!"

	products = list( //Relatively normal to have, I GUESS
		/obj/item/clothing/under/costume/maid = 8,
		/obj/item/clothing/under/rank/civilian/janitor/maid = 8,
		/obj/item/clothing/under/misc/stripper = 4,
		/obj/item/clothing/under/misc/stripper/green = 4,
		/obj/item/clothing/under/misc/gear_harness = 4,
		/obj/item/clothing/under/shorts/polychromic/pantsu = 4,
		/obj/item/clothing/under/misc/poly_bottomless = 4,
		/obj/item/clothing/under/misc/poly_tanktop = 4,
		/obj/item/clothing/under/misc/poly_tanktop/female = 4,
		/obj/item/clothing/neck/petcollar = 8,
		/obj/item/clothing/neck/petcollar/choker = 4,
		/obj/item/clothing/neck/petcollar/leather = 4,
		/obj/item/restraints/handcuffs/fake/kinky = 8,
		/obj/item/clothing/glasses/sunglasses/blindfold = 8,
		/obj/item/clothing/mask/muzzle = 8,
		/obj/item/clothing/head/kitty = 4,
		/obj/item/clothing/head/rabbitears = 4,
		/obj/item/dildo/custom = 10,
		/obj/item/reagent_containers/pill/crocin = 20,
		/obj/item/reagent_containers/pill/camphor = 20
	)

	contraband = list( //Actually dangerous or exploitable shit.
		/obj/item/clothing/under/costume/jabroni = 4,
		/obj/item/clothing/neck/petcollar/locked = 2,
		/obj/item/key/collar = 2,
		/obj/item/clothing/under/misc/stripper/mankini = 4,
		/obj/item/electropack/shockcollar = 4,
		/obj/item/assembly/signaler = 4,
		/obj/item/dildo/flared/huge = 4,
		/obj/item/reagent_containers/pill/hexacrocin = 10
	)

	premium = list(
		/obj/item/bdsm_whip = 4,
		/obj/item/clothing/under/dress/corset = 4,
		/obj/item/clothing/under/pants/chaps = 4,
		/obj/item/clothing/accessory/skullcodpiece/fake = 4,
		/obj/item/reagent_containers/pill/penis_enlargement = 8,
		/obj/item/reagent_containers/pill/breast_enlargement = 8
	)

	refill_canister = /obj/item/vending_refill/kink

/obj/item/vending_refill/kink
	machine_name 	= "KinkMate"
	icon_state 		= "refill_kink"
*/
