/obj/item/seeds/surik
	name = "pack of surik seeds"
	desc = "These seeds grow into surik plants."
	icon = 'modular_skyrat/code/modules/research/xenoarch/xenobotany/icons/seeds.dmi'
	icon_state = "surik"
	species = "surik"
	plantname = "Surik Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/surik
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/code/modules/research/xenoarch/xenobotany/icons/growing.dmi'
	icon_grow = "surik-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/frostoil = 0.1)

/obj/item/reagent_containers/food/snacks/grown/surik
	seed = /obj/item/seeds/surik
	name = "surik"
	desc = "It's a little piece of surik."
	icon = 'modular_skyrat/code/modules/research/xenoarch/xenobotany/icons/harvests.dmi'
	icon_state = "surik"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/frostoil = 0)
	tastes = list("snow" = 1)
