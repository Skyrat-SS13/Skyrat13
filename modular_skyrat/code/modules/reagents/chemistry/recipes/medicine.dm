//Synthetic medicines
/datum/chemical_reaction/system_cleaner
	name = "System Cleaner"
	id = /datum/reagent/medicine/system_cleaner
	results = list(/datum/reagent/medicine/system_cleaner = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/chlorine = 1, /datum/reagent/phenol = 2, /datum/reagent/potassium = 1)

/datum/chemical_reaction/liquid_solder
	name = "Liquid Solder"
	id = /datum/reagent/medicine/liquid_solder
	results = list(/datum/reagent/medicine/liquid_solder = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/copper = 1, /datum/reagent/silver = 1)
	required_temp = 370
	mix_message = "The mixture becomes a metallic slurry."

/datum/chemical_reaction/nanite_slurry
	name = "Nanite Slurry"
	id = /datum/reagent/medicine/nanite_slurry
	results = list(/datum/reagent/medicine/nanite_slurry = 3)
	required_reagents = list(/datum/reagent/foaming_agent = 1, /datum/reagent/gold = 1, /datum/reagent/iron = 1)
	mix_message = "The mixture becomes a metallic slurry."

/datum/chemical_reaction/kerosene
	name = "Kerosene"
	id = /datum/reagent/medicine/kerosene
	results = list(/datum/reagent/medicine/kerosene = 3)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/hydrogen = 1, /datum/reagent/ash = 1)
	required_temp = 600
	mix_message = "The mixture becomes a metallic slurry."

//Repathed preservahyde
/datum/chemical_reaction/preservahyde
	name = "Preservahyde"
	id = "preservahyde"
	results = list(/datum/reagent/medicine/preservahyde = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/toxin/formaldehyde = 1, /datum/reagent/bromine = 1)

//Bobmed medicine reagents
/datum/chemical_reaction/corticosteroids
	name = "Corticosteroids"
	id = /datum/reagent/medicine/corticosteroids
	results = list(/datum/reagent/medicine/corticosteroids = 12.5)
	required_reagents = list(/datum/reagent/medicine/synthflesh = 10, /datum/reagent/medicine/ephedrine = 5, /datum/reagent/medicine/kelotane = 5, /datum/reagent/medicine/bicaridine = 5)
	mix_message = "The mixture bubbles into a pinkish color."

/datum/chemical_reaction/fibrin
	name = "Fibrin"
	id = /datum/reagent/medicine/fibrin
	results = list(/datum/reagent/medicine/fibrin = 20)
	required_reagents = list(/datum/reagent/blood = 10, /datum/reagent/oxygen = 10, /datum/reagent/water = 10, /datum/reagent/medicine/bicaridine = 10)
	mix_message = "The mixture bubbles into a browned color."

/datum/chemical_reaction/fibrin2
	name = "Fibrin"
	id = "fibrin_2"
	results = list(/datum/reagent/medicine/fibrin = 20)
	required_reagents = list(/datum/reagent/blood/synthetics = 10, /datum/reagent/oxygen = 10, /datum/reagent/water = 10, /datum/reagent/medicine/bicaridine = 10)
	mix_message = "The mixture bubbles into a browned color."
