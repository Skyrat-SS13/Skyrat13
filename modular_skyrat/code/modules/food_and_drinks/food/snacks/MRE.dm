/obj/item/reagent_containers/food/snacks/meatcube
	name = "meat cube"
	desc = "A simple cube of meat contained in a self-heated pouch. Actually tastes pretty good, for the most basic kind of processed food."
	icon = 'modular_skyrat/icons/obj/MRE.dmi'
	icon_state = "meatcube"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#B22222"
	tastes = list("meat" = 1, "cube" = 1,)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/no_raisin/healthy/mre
	name = "dried rasins"
	desc = "A packet of rasins. Good and good for you."

/obj/item/reagent_containers/food/snacks/sosjerky/healthy/mre
	name = "beef jerky"
	desc = "A packet of dried meat strips. Good and good for you, albeit a bit tough to chew."

/obj/item/toy/crayon/rainbow/big
	name = "big crayon"
	desc= "Dear God, its huge. It makes your mouth water just looking at it..."
	icon = 'modular_skyrat/icons/obj/MRE.dmi'
	icon_state = "bigcrayon"
	reagent_contents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/colorful_reagent = 0.9)

/obj/item/reagent_containers/food/snacks/soup/mre
	name = "soup"
	desc= "Its... soup. Pure nutrition cooked to be unoffensive to any diet group. Kind of tasteless, though."
	icon = 'modular_skyrat/icons/obj/MRE.dmi'
	icon_state = "thestocksoup"
	tastes = list("water" = 1, "nondescript nutriment" = 1)
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/condiment/pack/frostoil
	name = "frostoil pack"
	originalname = "frostoil"
	list_reagents = list(/datum/reagent/consumable/frostoil = 10)