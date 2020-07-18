/datum/chemical_reaction/synthanol
	name = "Synthanol"
	id = /datum/reagent/consumable/ethanol/synthanol
	results = list(/datum/reagent/consumable/ethanol/synthanol = 3)
	required_reagents = list(/datum/reagent/lube = 1, /datum/reagent/toxin/plasma = 1, /datum/reagent/fuel = 1)
	mix_message = "The chemicals mix to create shiny, blue substance."

/datum/chemical_reaction/robottears
	name = "Robot Tears"
	id = /datum/reagent/consumable/ethanol/synthanol/robottears
	results = list(/datum/reagent/consumable/ethanol/synthanol/robottears = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/oil = 1, /datum/reagent/consumable/sodawater = 1)
	mix_message = "The ingredients combine into a stiff, dark goo."

/datum/chemical_reaction/trinary
	name = "Trinary"
	id = /datum/reagent/consumable/ethanol/synthanol/trinary
	results = list(/datum/reagent/consumable/ethanol/synthanol/trinary = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/orangejuice = 1)
	mix_message = "The ingredients mix into a colorful substance."

/datum/chemical_reaction/servo
	name = "Servo"
	id = /datum/reagent/consumable/ethanol/synthanol/servo
	results = list(/datum/reagent/consumable/ethanol/synthanol/servo = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 2, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/hot_coco = 1)
	mix_message = "The ingredients mix into a dark brown substance."

/datum/chemical_reaction/uplink
	name = "Uplink"
	id = /datum/reagent/consumable/ethanol/synthanol/uplink
	results = list(/datum/reagent/consumable/ethanol/synthanol/uplink = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/ethanol/whiskey = 1)
	mix_message = "The chemicals mix to create a shiny, orange substance."

/datum/chemical_reaction/synthncoke
	name = "Synth n' Coke"
	id = /datum/reagent/consumable/ethanol/synthanol/synthncoke
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthncoke = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/space_cola = 1)
	mix_message = "The chemicals mix to create a smooth, fizzy substance."

/datum/chemical_reaction/synthignon
	name = "Synthignon"
	id = /datum/reagent/consumable/ethanol/synthanol/synthignon
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthignon = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/wine = 1)
	mix_message = "The chemicals mix to create a fine, red substance." 

/datum/chemical_reaction/ethanol
	name = "ethanol"
	id = /datum/reagent/consumable/ethanol
	results = list(/datum/reagent/consumable/ethanol = 1)
	required_reagents = list(/datum/reagent/consumable/nutriment = 2)
	required_catalysts = list(/datum/reagent/consumable/enzyme = 1,/datum/reagent/water = 1)
	mix_message = "The diluted nutriment quickly turns into a foul smelling liquid"
