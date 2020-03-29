/datum/supply_pack/materials/license50
	name = "50 Empty License Plates"
	desc = "Create a bunch of boxes."
	cost = 1000  // 50 * 25 + 700 - 1000 = 950 credits profit
	contains = list(/obj/item/stack/license_plates/empty/fifty)
	crate_name = "empty license plate crate"

/datum/supply_pack/costumes_toys/randomised/toys/generate()
	. = ..()
	var/the_toy
	for(var/i in 1 to num_contained)
		if(prob(50))
			the_toy = pickweight(GLOB.arcade_prize_pool)
		else
			the_toy = pick(subtypesof(/obj/item/toy/plush) - typesof(/obj/item/toy/plush/goatplushie)) //these goats are cursed man
		new the_toy(.)
