//Food and Drinks

/datum/design/biomass
	name = "Nutrient Paste (10u)"
	id = "biomass_reagent"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 20)
	make_reagents = list(/datum/reagent/consumable/biomass = 10)
	category = list("initial","Reagents")

/datum/design/milk
	name = "Milk (10u)"
	id = "milk_reagent"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 20)
	make_reagents = list(/datum/reagent/consumable/milk = 10)
	category = list("initial","Reagents")

/datum/design/creamprisoner
	name = "Cream (10u)"
	id = "cream_reagent"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 40)
	make_reagents = list(/datum/reagent/consumable/cream = 10)
	category = list("initial","Reagents")

/datum/design/milk_carton
	name = "Milk Carton (50u)"
	id = "milk_carton"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/reagent_containers/food/condiment/milk
	category = list("initial","Food and Drinks")

/datum/design/soy_carton
	name = "Soy Milk Carton (50u)"
	id = "soy_carton"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 100)
	build_path = /obj/item/reagent_containers/food/condiment/soymilk
	category = list("initial","Food and Drinks")

/datum/design/cream_carton
	name = "Cream Carton (50u)"
	id = "cream_carton"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/reagent_containers/food/drinks/bottle/cream
	category = list("initial","Food and Drinks")

/datum/design/enzyme
	name = "Universal Enzyme (50u)"
	id = "enzyme"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 200)
	build_path = /obj/item/reagent_containers/food/condiment/enzyme
	make_reagents = list()
	category = list("initial","Food and Drinks")

/datum/design/pepper_mill
	name = "Pepper Mill (20u)"
	id = "pepper_mill"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/reagent_containers/food/condiment/peppermill
	make_reagents = list()
	category = list("initial","Food and Drinks")

/datum/design/monkey_cube
	name = "Monkey Cube"
	id = "mcube"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 250)
	build_path = /obj/item/reagent_containers/food/snacks/monkeycube
	category = list("initial", "Food and Drinks")

/datum/design/smeat
	name = "Biomeat"
	id = "smeat"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/food/snacks/meat/slab/bio
	category = list("initial", "Food and Drinks")

//Botany Stuff
/datum/design/ez_nut
	name = "E-Z Nutrient (30u)"
	id = "ez_nut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 30)
	build_path = /obj/item/reagent_containers/glass/bottle/nutrient/ez
	category = list("initial","Botany")

/datum/design/diethylamine
	name = "Diethylamine (30u)"
	id = "diethylamine"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/reagent_containers/glass/bottle/diethylamine
	category = list("initial","Botany")

/datum/design/ammonia
	name = "Ammonia (30u)"
	id = "ammonia"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/reagent_containers/glass/bottle/ammonia
	category = list("initial","Botany")

/datum/design/saltpetre
	name = "Saltpetre (30u)"
	id = "saltpetre"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/reagent_containers/glass/bottle/saltpetre
	category = list("initial","Botany")

/datum/design/rh_nut
	name = "Robust Harvest (30u)"
	id = "rh_nut"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 60)
	build_path = /obj/item/reagent_containers/glass/bottle/nutrient/rh
	category = list("initial","Botany")

/datum/design/weed_killer
	name = "Weed Killer Spray"
	id = "weed_killer"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/glass/bottle/killer/weedkiller
	category = list("initial","Botany")

/datum/design/pest_spray
	name = "Pest Killer Spray"
	id = "pest_spray"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/reagent_containers/glass/bottle/killer/pestkiller
	category = list("initial","Botany")

//Materials
/datum/design/cloth
	name = "Roll of Cloth"
	id = "cloth"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 50)
	build_path = /obj/item/stack/sheet/cloth
	category = list("initial","Materials")

/datum/design/cardboard
	name = "Sheet of Cardboard"
	id = "cardboard"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 25)
	build_path = /obj/item/stack/sheet/cardboard
	category = list("initial","Materials")

/datum/design/leather
	name = "Sheet of Leather"
	id = "leather"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 150)
	build_path = /obj/item/stack/sheet/leather
	category = list("initial","Materials")

//Clothing
/datum/design/secbelt
	name = "Security Belt"
	id = "secbelt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/security
	category = list("initial","Clothing")

/datum/design/medbelt
	name = "Medical Belt"
	id = "medbel"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/medical
	category = list("initial","Clothing")

/datum/design/janibelt
	name = "Janitorial Belt"
	id = "janibelt"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/storage/belt/janitor
	category = list("initial","Clothing")

/datum/design/s_holster
	name = "Shoulder Holster"
	id = "s_holster"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 400)
	build_path = /obj/item/storage/belt/holster
	category = list("initial","Clothing")

/datum/design/rice_hat
	name = "Rice Hat"
	id = "rice_hat"
	build_type = BIOGENERATOR
	materials = list(/datum/material/biomass = 300)
	build_path = /obj/item/clothing/head/rice_hat
	category = list("initial","Clothing")