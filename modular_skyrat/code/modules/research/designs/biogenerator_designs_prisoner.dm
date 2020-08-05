///////////////////////////////////
///////Biogenerator Designs ///////
///////////////////////////////////

/datum/design/milkprisoner
	name = "10u Milk"
	id = "milkprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 20)
	make_reagents = list(/datum/reagent/consumable/milk = 10)
	category = list("initial","Food")

/datum/design/creamprisoner
	name = "10u Cream"
	id = "creamprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	make_reagents = list(/datum/reagent/consumable/cream = 10)
	category = list("initial","Food")

/datum/design/milk_cartonprisoner
	name = "Milk Carton"
	id = "milk_cartonprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/reagent_containers/food/condiment/milk
	category = list("initial","Food")

/datum/design/cream_cartonprisoner
	name = "Cream Carton"
	id = "cream_cartonprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/reagent_containers/food/drinks/bottle/cream
	category = list("initial","Food")

/datum/design/black_pepperprisoner
	name = "10u Black Pepper"
	id = "black_pepperprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/consumable/blackpepper = 10)
	category = list("initial","Food")

/datum/design/pepper_millprisoner
	name = "Pepper Mill"
	id = "pepper_millprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/food/condiment/peppermill
	make_reagents = list()
	category = list("initial","Food")

/datum/design/enzymeprisoner
	name = "10u Universal Enzyme"
	id = "enzymeprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	make_reagents = list(/datum/reagent/consumable/enzyme = 10)
	category = list("initial","Food")

/datum/design/flour_sackprisoner
	name = "Flour Sack"
	id = "flour_sackprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/reagent_containers/food/condiment/flour
	category = list("initial","Food")

/datum/design/monkey_cubeprisoner
	name = "Monkey Cube"
	id = "monkey_cubeprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/food/snacks/cube/monkey
	category = list("initial", "Food")

/datum/design/smeatprisoner
	name = "Biomass Meat Slab"
	id = "smeatprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 175)
	build_path = /obj/item/reagent_containers/food/snacks/meat/slab/synthmeat
	category = list("initial", "Food")

/datum/design/rh_nutprisoner
	name = "Robust Harvest"
	id = "rh_nutprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/reagent_containers/glass/bottle/nutrient/rh
	category = list("initial","Botany Chemicals")

/datum/design/weed_killerprisoner
	name = "Weed Killer"
	id = "weed_killerprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/glass/bottle/killer/weedkiller
	category = list("initial","Botany Chemicals")

/datum/design/pest_sprayprisoner
	name = "Pest Killer"
	id = "pest_sprayprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/glass/bottle/killer/pestkiller
	category = list("initial","Botany Chemicals")

/datum/design/ammoniaprisoner
	name = "10u Ammonia"
	id = "ammoniaprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	make_reagents = list(/datum/reagent/ammonia = 10)
	category = list("initial","Botany Chemicals")

/datum/design/saltpetreprisoner
	name = "10u Saltpetre"
	id = "saltpetreprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 75)
	make_reagents = list(/datum/reagent/saltpetre = 10)
	category = list("initial","Botany Chemicals")

/datum/design/botany_bottleprisoner
	name = "Empty Bottle"
	id = "botany_bottleprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 5)
	build_path = /obj/item/reagent_containers/glass/bottle/nutrient/empty
	category = list("initial", "Botany Chemicals")

/datum/design/clothprisoner
	name = "Roll of Cloth"
	id = "clothprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/sheet/cloth
	category = list("initial","Organic Materials")

/datum/design/cardboardprisoner
	name = "Sheet of Cardboard"
	id = "cardboardprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/sheet/cardboard
	category = list("initial","Organic Materials")

/datum/design/leatherprisoner
	name = "Sheet of Leather"
	id = "leatherprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/sheet/leather
	category = list("initial","Organic Materials")

/datum/design/secbeltprisoner
	name = "Security Belt"
	id = "secbeltprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/security
	category = list("initial","Organic Materials")

/datum/design/medbeltprisoner
	name = "Medical Belt"
	id = "medbeltprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/medical
	category = list("initial","Organic Materials")

/datum/design/janibeltprisoner
	name = "Janitorial Belt"
	id = "janibeltprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/janitor
	category = list("initial","Organic Materials")

/datum/design/s_holsterprisoner
	name = "Shoulder Holster"
	id = "s_holsterprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 400)
	build_path = /obj/item/storage/belt/holster
	category = list("initial","Organic Materials")

/datum/design/rice_hatprisoner
	name = "Rice Hat"
	id = "rice_hatprisoner"
	build_type = PRISBIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/clothing/head/rice_hat
	category = list("initial","Organic Materials")
