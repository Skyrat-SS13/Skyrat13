/datum/chemical_reaction/brutaline
	name = "Brutaline"
	id = /datum/reagent/medicine/brutaline
	results = list(/datum/reagent/medicine/brutaline = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/blood = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/feuerane
	name = "Feuerane"
	id = /datum/reagent/medicine/feuerane
	results = list(/datum/reagent/medicine/feuerane = 3)
	required_reagents = list(/datum/reagent/medicine/kelotane = 1, /datum/reagent/blood = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/giftignicht
	name = "Giftignicht"
	id = /datum/reagent/medicine/giftignicht
	results = list(/datum/reagent/medicine/giftignicht = 3)
	required_reagents = list(/datum/reagent/medicine/antitoxin = 1, /datum/reagent/blood = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/wundermittelone
	name = "Wundermittelone"
	id = /datum/reagent/medicine/wundermittelone
	results = list(/datum/reagent/medicine/wundermittelone = 3)
	required_reagents = list(/datum/reagent/medicine/brutaline = 1, /datum/reagent/medicine/feuerane = 1, /datum/reagent/medicine/giftignicht = 1)

/datum/chemical_reaction/linguaggiomedio
	name = "Linguaggiomedio"
	id = /datum/reagent/medicine/linguaggiomedio
	results = list(/datum/reagent/medicine/linguaggiomedio = 3)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/blood = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/obligerine
	name = "Obligerine"
	id = /datum/reagent/medicine/obligerine
	results = list(/datum/reagent/medicine/obligerine = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/medicine/brutaline = 1, /datum/reagent/medicine/linguaggiomedio = 1)

/datum/chemical_reaction/croustillantane
	name = "Croustillantane"
	id = /datum/reagent/medicine/croustillantane
	results = list(/datum/reagent/medicine/croustillantane = 3)
	required_reagents = list(/datum/reagent/medicine/kelotane = 1, /datum/reagent/medicine/feuerane = 1, /datum/reagent/medicine/linguaggiomedio = 1)

/datum/chemical_reaction/nontoxique
	name = "Nontoxique"
	id = /datum/reagent/medicine/nontoxique
	results = list(/datum/reagent/medicine/nontoxique = 3)
	required_reagents = list(/datum/reagent/medicine/antitoxin = 1, /datum/reagent/medicine/giftignicht = 1, /datum/reagent/medicine/linguaggiomedio = 1)

/datum/chemical_reaction/guerirone
	name = "Guerirone"
	id = /datum/reagent/medicine/guerirone
	results = list(/datum/reagent/medicine/guerirone = 3)
	required_reagents = list(/datum/reagent/medicine/obligerine = 1, /datum/reagent/medicine/croustillantane = 1, /datum/reagent/medicine/nontoxique = 1)