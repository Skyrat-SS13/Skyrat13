/obj/machinery/vending/hydronutrients/prisoner
	name = "\improper Prisoner NutriMax"
	desc = "A plant nutrients vendor that is safe."
	product_slogans = "Aren't you glad you don't have to fertilize the natural way?;Now with 50% less stink!;Plants and Prisoners are people too!"
	product_ads = "We like plants!;Don't you want some?;The greenest thumbs ever.;We like big plants.;Soft soil..."
	icon_state = "nutri"
	icon_deny = "nutri-deny"
	products = list(/obj/item/reagent_containers/glass/bottle/nutrient/rh = 30,
					/obj/item/reagent_containers/glass/bottle/ammonia = 20,
					/obj/item/reagent_containers/spray/pestspray = 20,
					/obj/item/reagent_containers/syringe = 5,
					/obj/item/cultivator = 2,
					/obj/item/shovel/spade = 2,
					/obj/item/plant_analyzer = 4)
	contraband = list(/obj/item/reagent_containers/glass/bottle/diethylamine = 5)
	premium = list(/obj/item/seeds/cotton/durathread = 1,
					/obj/item/seeds/tomato/blood = 1,
					/obj/item/seeds/tomato/blue = 1,
					/obj/item/seeds/cherry/blue	 = 1,
					/obj/item/seeds/replicapod = 1,
					/obj/item/hatchet)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	refill_canister = /obj/item/vending_refill/hydronutrients/prisoner
	resistance_flags = FIRE_PROOF

/obj/item/vending_refill/hydronutrients/prisoner
	icon_state = "refill_hydro"

// Plant bags removed, prisoners must craft them with cotton. Ensure prisoners have access to a loom, or a hatchet to make a loom.
