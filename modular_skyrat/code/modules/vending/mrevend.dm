/obj/machinery/vending/mre
	name = "\improper Nanotrasen Ready-Made Meals"
	desc = "A machine to vend Meals Ready to Eat, for when the Chef is either out or not doing their job. Usually both."
	product_ads = "Nanotrasen MREs are proven to be 88% less toxic than maintenance food!;Hungry? Why wait for the Chef to cook something. Nanotrasen MREs are sure to satisfy that hunger in minutes!"
	icon = 'modular_skyrat/icons/obj/mrevend.dmi'
	icon_state = "mre_vend"
	products = list(/obj/item/storage/mre = 10,
					/obj/item/storage/mre/protein = 10,
					/obj/item/storage/mre/vegie = 10,
					/obj/item/reagent_containers/food/condiment/pack/ketchup = 5,
					/obj/item/reagent_containers/food/condiment/pack/mustard = 5,
					/obj/item/reagent_containers/food/condiment/pack/hotsauce = 5,
					/obj/item/reagent_containers/food/condiment/pack/astrotame = 5,
					/obj/item/reagent_containers/food/condiment/pack/bbqsauce = 5,
					/obj/item/reagent_containers/food/condiment/pack/soysauce = 5)
	contraband = list(/obj/item/storage/mre/unusual)
	refill_canister = /obj/item/vending_refill/mre
	resistance_flags = FIRE_PROOF

/obj/item/vending_refill/mre
	name = "Nanotrasen MRE Refill"
	icon = 'modular_skyrat/icons/obj/mrevend.dmi'
	icon_state = "refill_mre"