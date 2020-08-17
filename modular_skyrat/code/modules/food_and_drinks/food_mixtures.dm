//Biomeat used for biomass creation
/datum/chemical_reaction/biomeat
	name = "biomeat"
	id = "biomeat"
	required_reagents = list(/datum/reagent/blood = 8, /datum/reagent/medicine/mutadone = 5,
							/datum/reagent/medicine/salglu_solution = 5,
							/datum/reagent/medicine/synthflesh = 10, /datum/reagent/consumable/nutriment = 2)
	required_temp = 600
	mob_react = FALSE

/datum/chemical_reaction/biomeat/on_reaction(datum/reagents/holder, multiplier, specialreact)
	multiplier *= 2
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= multiplier, i++)
		new /obj/item/reagent_containers/food/snacks/meat/slab/synthmeat(location)
