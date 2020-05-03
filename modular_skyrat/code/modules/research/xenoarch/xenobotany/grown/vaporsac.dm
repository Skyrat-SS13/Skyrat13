/obj/item/seeds/vaporsac
	name = "pack of vaporsac seeds"
	desc = "These seeds grow into vaporsac plants."
	icon_state = "vaporsac"
	species = "vaporsac"
	plantname = "Vaporsac Plant"
	product = /obj/item/reagent_containers/food/snacks/grown/vaporsac
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/code/modules/research/xenoarch/xenobotany/icons/growing.dmi'
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/nitrous_oxide = 0.1)

/obj/item/reagent_containers/food/snacks/grown/vaporsac
	seed = /obj/item/seeds/vaporsac
	name = "vaporsac"
	desc = "It's a little piece of vaporsac."
	icon_state = "vaporsac"
	filling_color = "#FF4500"
	bitesize = 100
	foodtype = FRUIT
	juice_results = list(/datum/reagent/nitrous_oxide = 0)
	tastes = list("sleep" = 1)
