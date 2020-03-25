/datum/crafting_recipe/buttbot
	name = "Butt Bot"
	result = /mob/living/simple_animal/bot/buttbot
	reqs = list(/obj/item/stack/cable_coil = 30, //see below
				/obj/item/stack/sheet/metal = 10, //for... internal components?
				/datum/reagent/blood = 5, //to give it... LIFE.
				/obj/item/stock_parts/cell = 1, //to give it... POWER
				/obj/item/reagent_containers/food/snacks/meat = 2, //for the carcass
				/obj/item/reagent_containers/food/snacks/faggot = 2, //for wheels
				/obj/item/bodypart/l_arm = 1) //for... arm
	tools = list(/obj/item/screwdriver, /obj/item/wirecutters)
	time = 50
	category = CAT_ROBOT

/datum/crafting_recipe/buttbot/xeno
	name = "Xenomorph Butt Bot"
	result = /mob/living/simple_animal/bot/buttbot/xeno
	reqs = list(/obj/item/stack/cable_coil = 30, //see below
				/obj/item/stack/sheet/metal = 10, //for... internal components?
				/datum/reagent/blood = 5, //to give it... LIFE.
				/obj/item/stock_parts/cell = 1, //to give it... POWER
				/obj/item/reagent_containers/food/snacks/meat = 2, //for the carcass
				/obj/item/reagent_containers/food/snacks/faggot = 2, //for wheels
				/obj/item/bodypart/l_arm = 1, //for... arm
				/obj/item/stack/sheet/animalhide/xeno = 1) //for... AYYLIEN