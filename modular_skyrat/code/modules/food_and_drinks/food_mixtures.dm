//Biomeat used for biomass creation
/datum/chemical_reaction/biomeat
	name = "biomeat"
	id = "biomeat"
	required_reagents = list(/datum/reagent/blood = 6, /datum/reagent/medicine/cryoxadone = 10,
							/datum/reagent/medicine/synthflesh = 21, /datum/reagent/consumable/nutriment = 3)
	required_temp = 600
	mob_react = FALSE

/datum/chemical_reaction/biomeat/on_reaction(datum/reagents/holder, multiplier, specialreact)
	var/location = get_turf(holder.my_atom)
	var/use = max(1, multiplier)
	for(var/i = 1, i <= use, i++)
		new /obj/item/reagent_containers/food/snacks/meat/slab/biomeat(location)
