//Clarke
/datum/design/board/clarke_main
	name = "\"Clarke\" Central Control module"
	desc = "Allows for the construction of a \"Clarke\" Central Control module."
	id = "clarke_main"
	build_path = /obj/item/circuitboard/mecha/clarke/main
	category = list("Exosuit Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/clarke_peri
	name = "\"Clarke\" Peripherals Control module"
	desc = "Allows for the construction of a  \"Clarke\" Peripheral Control module."
	id = "clarke_peri"
	build_path = /obj/item/circuitboard/mecha/clarke/peripherals
	category = list("Exosuit Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

//Buzz
/datum/design/board/buzz_main
	name = "\"Buzz\" Central Control module"
	desc = "Allows for the construction of a \"Buzz\" Central Control module."
	id = "buzz_main"
	build_path = /obj/item/circuitboard/mecha/buzz/main
	category = list("Exosuit Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/buzz_peri
	name = "\"Buzz\" Peripherals Control module"
	desc = "Allows for the construction of a  \"Buzz\" Peripheral Control module."
	id = "buzz_peri"
	build_path = /obj/item/circuitboard/mecha/buzz/peripherals
	category = list("Exosuit Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/handdrill_robotics
	name = "Hand Drill"
	desc = "A small electric hand drill with an interchangeable screwdriver and bolt bit."
	id = "robotics_handdrill"
	build_type = MECHFAB
	materials = list(/datum/material/iron = 3500, /datum/material/silver = 1500, /datum/material/titanium = 2500)
	build_path = /obj/item/screwdriver/power/robotics
	category = list("Misc")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/jawsoflife
	name = "Claws of Life"
	desc = "A small, compact Claws of Life with an interchangeable pry claws and cutting claws."
	id = "clawsoflife"
	build_path = /obj/item/crowbar/robopower
	build_type = MECHFAB
	materials = list(/datum/material/iron = 4500, /datum/material/silver = 2500, /datum/material/titanium = 3500)
	category = list("Misc")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE