/obj/machinery/vending/dinnerware/prisoner
	name = "\improper Plasteel Chef's Dinnerware Vendor"
	desc = "A kitchen and restaurant equipment vendor."
	product_ads = "Mm, food stuffs!;Food and food accessories.;Get your plates!;You like forks?;I like forks.;Woo, utensils.;You don't really need these..."
	icon_state = "dinnerware"
	products = list(/obj/item/reagent_containers/glass/bowl = 30,
					/obj/item/storage/bag/tray = 1,
					/obj/item/kitchen/knife = 1,
					/obj/item/kitchen/rollingpin = 1,
					/obj/item/reagent_containers/food/drinks/drinkingglass = 8,
					/obj/item/clothing/suit/apron/chef = 2,
					/obj/item/storage/box/cups = 2,
					/obj/item/reagent_containers/food/condiment/pack/ketchup = 5,
					/obj/item/reagent_containers/food/condiment/pack/mustard = 5,
					/obj/item/reagent_containers/food/condiment/pack/hotsauce = 5,
					/obj/item/reagent_containers/food/condiment/pack/astrotame = 5,
					/obj/item/reagent_containers/food/condiment/pack/bbqsauce = 5,
					/obj/item/reagent_containers/food/condiment/pack/soysauce = 5,
					/obj/item/reagent_containers/food/condiment/saltshaker = 5,
					/obj/item/reagent_containers/food/condiment/peppermill = 5)
	contraband = list(
					/obj/item/reagent_containers/food/snacks/monkeycube = 1,
					/obj/item/kitchen/knife/butcher = 2,
					/obj/item/reagent_containers/syringe = 3)
	premium = list(
					/obj/item/reagent_containers/food/condiment/enzyme = 1,
					/obj/item/reagent_containers/glass/bottle/cryoxadone = 2) // Bartender can literally make this with upgraded parts, or it gets stolen from medical.
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	refill_canister = /obj/item/vending_refill/dinnerware/prisoner
	resistance_flags = FIRE_PROOF

/obj/item/vending_refill/dinnerware/prisoner
	icon_state = "refill_cook"

/datum/supply_pack/vending/dinner/prisoner
	name = "Dinnerware Supply Crate"
	desc = "Use a plate and have some utensils! Contains a dinnerware and sustenance vending machine refill."
	cost = 2500
	contains = list(/obj/item/vending_refill/sustenance,
					/obj/item/vending_refill/dinnerware/prisoner)
	crate_name = "prisoner dinnerware supply crate"
	crate_type = /obj/structure/closet/crate