/datum/plant_gene/trait/proc/after_harvest(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	return

/datum/plant_gene/trait/proc/on_flora_grow(/obj/structure/flora/botany/G)
	return

/datum/plant_gene/trait/proc/on_flora_harvest(/obj/structure/flora/botany/G, atom/target)
	return

/datum/plant_gene/trait/proc/on_flora_agitated(/obj/structure/flora/botany/G, atom/target)
	return

/datum/plant_gene/trait/glow/shadow
	//makes plant emit slightly purple shadows
	//adds -potency*(rate*0.2) light power to products
	name = "Shadow Emission"
	rate = 0.04
	glow_color = "#AAD84B"

/datum/plant_gene/trait/glow/shadow/glow_power(obj/item/seeds/S)
	return -max(S.potency*(rate*0.2), 0.2)

/datum/plant_gene/trait/foam
	// Makes plant spill a foam that carries reagents when squashed.
	name = "Expansive Decomposition"

/datum/plant_gene/trait/foam/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	var/datum/effect_system/foam_spread/S = new
	var/splat_location = get_turf(G)
	if(isturf(splat_location))
		var/foam_amount = round(sqrt(G.seed.potency * 0.1), 1)
		S.set_up(foam_amount, splat_location, G.reagents)
		S.start()
		G.reagents.clear_reagents()

/datum/plant_gene/trait/thorns
	// Adds glass-like caltrops to a plant
	name = "Thorny"

/datum/plant_gene/trait/thorns/on_new(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	. = ..()
	// min dmg 3, max dmg 6, prob(70)
	G.AddComponent(/datum/component/caltrop, 3, 6, 70)

/datum/plant_gene/trait/fragile
	// Adds a chance for the plant to squash on harvest
	name = "Fragile"

/datum/plant_gene/trait/fragile/after_harvest(obj/item/reagent_containers/food/snacks/grown/G, newloc)
	..()
	if(prob(35))
		G.squash()

/datum/plant_gene/trait/territorial
	// This will agitate botany flora, causing special effects when someone gets close
	name = "Territorial"

/datum/plant_gene/trait/anomaly
	// Fun???
	name = "Anomalous"

//Jungle glows down below
/datum/plant_gene/trait/glow/teal
	name = "Teal Bioluminescence"
	glow_color = "#00FFEE"

/datum/plant_gene/trait/glow/vivid_green
	name = "Vivid Green Bioluminescence"
	glow_color = "#6AFF00"

/datum/plant_gene/trait/glow/vivid_yellow
	name = "Vivid Yellow Bioluminescence"
	glow_color = "#D9FF00"

/datum/plant_gene/trait/glow/amber
	name = "Amber Bioluminescence"
	glow_color = "#FFC800"

/****Some extra modifiers to already existing traits****/

/datum/plant_gene/trait/cell_charge/on_slip(obj/item/reagent_containers/food/snacks/grown/G, mob/living/carbon/C)
	. = ..()
	do_sparks(3, FALSE, G)
	playsound(src, "sparks", 50, 1)

/datum/plant_gene/trait/cell_charge/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	. = ..()
	do_sparks(3, FALSE, G)
	playsound(src, "sparks", 50, 1)

/datum/plant_gene/trait/smoke/on_squash(obj/item/reagent_containers/food/snacks/grown/G, atom/target)
	var/datum/effect_system/smoke_spread/chem/S = new
	var/splat_location = get_turf(G)
	if(isturf(splat_location))
		var/smoke_amount = round(sqrt(G.seed.potency * 0.1), 1)
		S.attach(splat_location)
		S.set_up(G.reagents, smoke_amount, splat_location, 0)
		S.start()
		G.reagents.clear_reagents()

//Testing stuff

/obj/item/seeds/test
	name = "pack of test seeds"
	desc = "These seeds grow into poppies."
	icon_state = "seed-poppy"
	species = "poppy"
	plantname = "Poppy Plants"
	product = /obj/item/reagent_containers/food/snacks/grown/poppy
	endurance = 100
	maturation = 1
	production = 1
	yield = 10
	potency = 50
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_flowers.dmi'
	icon_grow = "poppy-grow"
	icon_dead = "poppy-dead"
	mutatelist = list(/obj/item/seeds/poppy/geranium, /obj/item/seeds/poppy/lily)
	reagents_add = list(/datum/reagent/medicine/bicaridine = 0.2, /datum/reagent/toxin/plasma = 0.05)
	genes = list(/datum/plant_gene/trait/plant_type/weed_hardy, /datum/plant_gene/trait/fragile, /datum/plant_gene/trait/foam, /datum/plant_gene/trait/thorns, /datum/plant_gene/trait/squash)