/obj/machinery/chem_dispenser/upgradeablemutagen
	name = "botanical chemical dispenser"
	desc = "Creates and dispenses chemicals useful for botany."
	circuit = /obj/item/circuitboard/machine/chem_dispenser/upgradeablemutagen

	dispensable_reagents = list(
		/datum/reagent/plantnutriment/eznutriment,
		/datum/reagent/plantnutriment/left4zednutriment,
		/datum/reagent/plantnutriment/robustharvestnutriment)
	upgrade_reagents = list(
		/datum/reagent/ammonia,
		/datum/reagent/saltpetre,
		/datum/reagent/radium)
	upgrade_reagents2 = list(
		/datum/reagent/toxin/plantbgone,
		/datum/reagent/toxin/plantbgone/weedkiller,
		/datum/reagent/toxin/pestkiller)
	upgrade_reagents3 = list(
		/datum/reagent/toxin/mutagen,
		/datum/reagent/consumable/sodawater,
		/datum/reagent/diethylamine)