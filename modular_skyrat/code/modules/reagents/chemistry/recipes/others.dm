//monkey powder heehoo
/datum/chemical_reaction/monkey_powder
	results = list(/datum/reagent/monkey_powder = 3)
	required_reagents = list(/datum/reagent/consumable/banana = 1, /datum/reagent/consumable/nutriment=2,/datum/reagent/liquidgibs = 1)

/datum/chemical_reaction/monkey
	required_reagents = list(/datum/reagent/monkey_powder = 30, /datum/reagent/water = 1)

/datum/chemical_reaction/monkey/on_reaction(datum/reagents/holder, created_volume)
	var/obj/item/reagent_containers/food/snacks/cube/monkey/cube = holder.my_atom
	if(istype(cube))
		cube.Expand()
	else
		var/location = get_turf(holder.my_atom)
		new /mob/living/carbon/monkey(location)

//water electrolysis
/datum/chemical_reaction/electrolysis
	results = list(/datum/reagent/oxygen = 10, /datum/reagent/hydrogen = 20)
	required_reagents = list(/datum/reagent/consumable/liquidelectricity = 1, /datum/reagent/water = 5)

//plasma stabilization
/datum/chemical_reaction/stable_plasma
	results = list(/datum/reagent/stable_plasma = 1)
	required_reagents = list(/datum/reagent/toxin/plasma = 1, /datum/reagent/stabilizing_agent= 3)

//sulfuric acid from sulfur
/datum/chemical_reaction/sulphuric_acid
	results = list(/datum/reagent/toxin/acid = 2)
	required_reagents = list(/datum/reagent/sulfur = 1, /datum/reagent/oxygen = 4, /datum/reagent/hydrogen = 2)

//butterflium
/datum/chemical_reaction/butterflium
	required_reagents = list(/datum/reagent/colorful_reagent = 1, /datum/reagent/medicine/omnizine = 1, /datum/reagent/medicine/strange_reagent = 1, /datum/reagent/consumable/nutriment = 1)

/datum/chemical_reaction/butterflium/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i = rand(1, created_volume), i <= created_volume, i++)
		new /mob/living/simple_animal/butterfly(location)
	..()

/datum/chemical_reaction/cellulose_carbonization
	results = list(/datum/reagent/ash = 1)
	required_reagents = list(/datum/reagent/cellulose = 1)
	required_temp = 512

//funny doggium
/datum/chemical_reaction/cheem_reaction
	results = list(/datum/reagent/ash = 1)
	required_reagents = list(/datum/reagent/medicine/fibrin = 25, /datum/reagent/medicine/corticosteroids = 25, /datum/reagent/blood = 25, /datum/reagent/medicine/synthflesh = 25, /datum/reagent/colorful_reagent/crayonpowder/yellow = 20)
	required_temp = 420

/datum/chemical_reaction/cheem_reaction/on_reaction(datum/reagents/holder, multiplier, specialreact)
	. = ..()
	var/turf/location = get_turf(holder)
	new /mob/living/simple_animal/pet/dog/cheems(location)
	playsound(location, 'modular_skyrat/sound/effects/dorime.ogg', 100, 0, 7)
