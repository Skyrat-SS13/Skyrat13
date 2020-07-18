/obj/item/reagent_containers/food/snacks/meat/slab/meatwheat
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/cooking_oil = 1)

/obj/item/reagent_containers/food/snacks/cube/monkey
	name = "monkey cube"
	desc = "Just add water!"
	list_reagents = list(/datum/reagent/monkey_powder = 30)
	tastes = list("the jungle" = 1, "bananas" = 1)
	dried_being = /mob/living/carbon/monkey

/obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/demon
	name = "demonic meat"
	desc = "<span class='danger'>Ultra-violence.</span>"
	list_reagents = list(/datum/reagent/blood = 10, /datum/reagent/consumable/nutriment = 5, /datum/reagent/fuel/unholywater = 5)
	tastes = list("maggots" = 1, "the inside of a reactor" = 1)
	foodtype = MEAT | RAW
