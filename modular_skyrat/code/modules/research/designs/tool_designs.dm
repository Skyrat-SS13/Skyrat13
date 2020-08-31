/////////////////////////////////////////
/////////////////Tools///////////////////
/////////////////////////////////////////

/datum/design/bsrpd
	name = "Bluespace Rapid Pipe Dispenser"
	desc = "A tool that can construct and deconstruct pipes on the fly."
	id = "bsrpd"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 75000, /datum/material/glass = 37500, /datum/material/bluespace = 1000)
	build_path = /obj/item/pipe_dispenser/bluespace // Skyrat edit
	category = list("Tool Designs")
	departmental_flags =  DEPARTMENTAL_FLAG_ENGINEERING

/datum/design/alienpowercell
	name = "Alien Power Cell"
	desc = "An advanced power cell obtained through Abductor technology."
	id = "alien_powercell"
	build_path = /obj/item/stock_parts/cell/infinite/abductor
	build_type = PROTOLATHE
	materials = list(/datum/material/bluespace = 2500, /datum/material/silver = 2500, /datum/material/plasma = 5000, /datum/material/titanium = 2000, /datum/material/diamond = 2000)
	category = list("Power Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/computermath
	name = "Problem Computer"
	desc = "Solve math problems. Get them correct, get credits."
	id = "computermath"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/glass = 250, /datum/material/plastic = 250)
	build_path = /obj/item/computermath/default
	category = list("Tool Designs")
	departmental_flags =  DEPARTMENTAL_FLAG_CARGO | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/ranged_analyzer
	name = "Long-range Analyzer"
	desc = "A new advanced atmospheric analyzer design, capable of performing scans at long range."
	id = "ranged_analyzer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 400, /datum/material/glass = 1000, /datum/material/uranium = 800, /datum/material/gold = 200, /datum/material/plastic = 200)
	build_path = /obj/item/analyzer/ranged
	category = list("Tool Designs")
	departmental_flags =  DEPARTMENTAL_FLAG_ENGINEERING

/// Alt Power Tools ///

/datum/design/electricjaws
	name = "Electric Cutter"
	desc = "A powered prying and cutting tool with interchangeable heads."
	id = "electricjaws"
	build_path = /obj/item/crowbar/electric
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3500, /datum/material/silver = 1500, /datum/material/titanium = 2500)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/greendrill
	name = "Hand Drill"
	desc = "A green power drill with an interchangeable screw and bolt bit."
	id = "greendrill"
	build_path = /obj/item/screwdriver/power/green
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 3500, /datum/material/silver = 1500, /datum/material/titanium = 2500)
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
