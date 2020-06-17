//Biomeat used for biomass creation
/datum/chemical_reaction/biomeat
	name = "biomeat"
	id = "biomeat"
	required_reagents = list(/datum/reagent/blood = 5, /datum/reagent/medicine/cryoxadone = 5, /datum/reagent/medicine/synthflesh = 20)
	required_catalysts = list(/datum/reagent/consumable/nutriment = 10)
	required_temp = 600
	mob_react = FALSE

/datum/chemical_reaction/biomeat/on_reaction(datum/reagents/holder, multiplier)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= multiplier, i++)
		new /obj/item/reagent_containers/food/snacks/meat/slab/biomeat(location)
