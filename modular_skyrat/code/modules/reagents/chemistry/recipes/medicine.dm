// TIER 2

/datum/chemical_reaction/bicaridineplus
	name = "megaBicaridine"
	id = /datum/reagent/medicine/bicaridineplus
	results = list(/datum/reagent/medicine/bicaridineplus = 2)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/kelotaneplus
	name = "megaKelotane"
	id = /datum/reagent/medicine/kelotaneplus
	results = list(/datum/reagent/medicine/kelotaneplus = 2)
	required_reagents = list(/datum/reagent/medicine/kelotane = 1, /datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/antitoxinplus
	name = "megaAnti-Toxin"
	id = /datum/reagent/medicine/antitoxinplus
	results = list(/datum/reagent/medicine/antitoxinplus = 2)
	required_reagents = list(/datum/reagent/medicine/antitoxin = 1, /datum/reagent/toxin/plasma = 1)

/datum/chemical_reaction/tricordrazineplus
	name = "megaTricordrazine"
	id = /datum/reagent/medicine/tricordrazineplus
	results = list(/datum/reagent/medicine/tricordrazineplus = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridineplus = 1, /datum/reagent/medicine/kelotaneplus = 1, /datum/reagent/medicine/antitoxinplus = 1)

// TRANSITIONING MEDICINE

/datum/chemical_reaction/tbasic
	name = "TBasic"
	id = /datum/reagent/medicine/tbasic
	results = list(/datum/reagent/medicine/tbasic = 3)
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/stable_plasma = 1, /datum/reagent/toxin/acid = 1)

/datum/chemical_reaction/tbrute
	name = "TBrute"
	id = /datum/reagent/medicine/tbrute
	results = list(/datum/reagent/medicine/tbrute = 1)
	required_reagents = list(/datum/reagent/medicine/bicaridineplus = 1)
	required_temp = 450

/datum/chemical_reaction/tburn
	name = "TBurn"
	id = /datum/reagent/medicine/tburn
	results = list(/datum/reagent/medicine/tburn = 1)
	required_reagents = list(/datum/reagent/medicine/kelotaneplus = 1)
	required_temp = 450

/datum/chemical_reaction/ttoxic
	name = "TToxic"
	id = /datum/reagent/medicine/ttoxic
	results = list(/datum/reagent/medicine/ttoxic = 1)
	required_reagents = list(/datum/reagent/medicine/antitoxinplus = 1)
	required_temp = 450

// TIER 3

/datum/chemical_reaction/bicaridineplusplus
	name = "ultiBicaridine"
	id = /datum/reagent/medicine/bicaridineplusplus
	results = list(/datum/reagent/medicine/bicaridineplusplus = 2)
	required_reagents = list(/datum/reagent/medicine/tbasic = 1, /datum/reagent/medicine/tbrute = 1)

/datum/chemical_reaction/kelotaneplusplus
	name = "ultiKelotane"
	id = /datum/reagent/medicine/kelotaneplusplus
	results = list(/datum/reagent/medicine/kelotaneplusplus = 2)
	required_reagents = list(/datum/reagent/medicine/tbasic = 1, /datum/reagent/medicine/tburn = 1)

/datum/chemical_reaction/antitoxinplusplus
	name = "ultiAnti-Toxin"
	id = /datum/reagent/medicine/antitoxinplusplus
	results = list(/datum/reagent/medicine/antitoxinplusplus = 2)
	required_reagents = list(/datum/reagent/medicine/tbasic = 1, /datum/reagent/medicine/ttoxic = 1)

/datum/chemical_reaction/tricordrazineplusplus
	name = "ultiTricordrazine"
	id = /datum/reagent/medicine/tricordrazineplusplus
	results = list(/datum/reagent/medicine/tricordrazineplusplus = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridineplusplus = 1, /datum/reagent/medicine/kelotaneplusplus = 1, /datum/reagent/medicine/antitoxinplusplus = 1)

// ADDITIONAL CHEMS (OXYGEN AND ORGANS)

// --OXYGEN
/datum/chemical_reaction/toxygen
	name = "TOxygen"
	id = /datum/reagent/medicine/toxygen
	results = list(/datum/reagent/medicine/toxygen = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/stable_plasma = 1, /datum/reagent/medicine/tbasic = 1)
	required_temp = 450

// --ORGANS
/datum/chemical_reaction/relung
	name = "reLung"
	id = /datum/reagent/medicine/relung
	results = list(/datum/reagent/medicine/relung = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/carbon = 1, /datum/reagent/medicine/tbrute = 1)
	required_temp = 900

/datum/chemical_reaction/reheart
	name = "reHeart"
	id = /datum/reagent/medicine/reheart
	results = list(/datum/reagent/medicine/reheart = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/oxygen = 1, /datum/reagent/medicine/tbrute = 1)
	required_temp = 900

/datum/chemical_reaction/reliver
	name = "reLiver"
	id = /datum/reagent/medicine/reliver
	results = list(/datum/reagent/medicine/reliver = 3)
	required_reagents = list(/datum/reagent/blood = 1, /datum/reagent/silicon = 1, /datum/reagent/medicine/tbrute = 1)
	required_temp = 900