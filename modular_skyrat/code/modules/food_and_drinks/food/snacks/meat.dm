/obj/item/reagent_containers/food/snacks/meat/slab/meatwheat
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/cooking_oil = 1)

/obj/item/reagent_containers/food/snacks/cube/monkey
	name = "monkey cube"
	desc = "Just add water!"
	list_reagents = list(/datum/reagent/monkey_powder = 30)
	tastes = list("the jungle" = 1, "bananas" = 1)
	dried_being = /mob/living/carbon/monkey

/obj/item/reagent_containers/food/snacks/meatcube
	name = "meat cube"
	desc = "A simple cube of meat contained in a self-heated pouch. Actually tastes pretty good, for the most basic kind of processed food."
	icon_state = "spidereggsham"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#B22222"
	tastes = list("meat" = 1, "cube" = 1,)
	foodtype = MEAT