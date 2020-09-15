/datum/supply_pack/critter/triplecrab
	name = "Crab Crate"
	desc = "Clickety Clack goes the Claws. Contains three crabs."
	cost = 1250
	contains = list(/mob/living/simple_animal/crab,
                    /mob/living/simple_animal/crab,
                    /mob/living/simple_animal/crab)
	crate_name = "crab crate"

/datum/supply_pack/critter/spider
    name = "Spider Crate"
    desc = "This is exactly what you think it is. A giant spider. Why the hell would you order this? Contains one very angry spider, and three clutches of delicious spider eggs."
    contraband = TRUE
    cost = 6000
    contains = list(/mob/living/simple_animal/hostile/poison/giant_spider,
                    /obj/item/reagent_containers/food/snacks/spidereggs,
                    /obj/item/reagent_containers/food/snacks/spidereggs,
                    /obj/item/reagent_containers/food/snacks/spidereggs)
    crate_name = "spider crate"