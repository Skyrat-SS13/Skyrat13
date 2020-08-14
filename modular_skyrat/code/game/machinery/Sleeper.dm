/obj/machinery/sleeper/syndie
	icon_state = "sleeper_s"
	desc = "An enclosed machine used to stabilize and heal patients. This one has inward facing controls that allows the patient to self-treat."
	controls_inside = TRUE
	possible_chems = list(
		list( //T1
			/datum/reagent/medicine/epinephrine,
			/datum/reagent/medicine/morphine,
			/datum/reagent/medicine/salbutamol,
			/datum/reagent/medicine/bicaridine,
			/datum/reagent/medicine/kelotane,
			/datum/reagent/medicine/omnizine
		),
		list( //T2
			/datum/reagent/medicine/oculine,
			/datum/reagent/medicine/inacusiate,
			/datum/reagent/medicine/salglu_solution
		),
		list( //T3
			/datum/reagent/medicine/antitoxin,
			/datum/reagent/medicine/mutadone,
			/datum/reagent/medicine/mannitol,
			/datum/reagent/medicine/pen_acid,
			/datum/reagent/medicine/spaceacillin
		),
		list( //T4
			/datum/reagent/medicine/rezadone
		)
	)

/obj/machinery/sleeper/party
	icon = 'modular_skyrat/icons/obj/machines/sleeper.dmi'
	
/obj/machinery/sleeper/centcom/Initialize()
	. = ..()
	component_parts = list()
	component_parts += new /obj/item/circuitboard/machine/sleeper/syndie(null)
	component_parts += new /obj/item/stock_parts/matter_bin/bluespace(null)
	component_parts += new /obj/item/stock_parts/manipulator/femto(null)
	component_parts += new /obj/item/stack/sheet/glass(null)
	component_parts += new /obj/item/stack/sheet/glass(null)
	component_parts += new /obj/item/stack/cable_coil(null)
	RefreshParts()
