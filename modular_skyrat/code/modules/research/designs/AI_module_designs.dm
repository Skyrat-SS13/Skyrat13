/datum/design/board/father_module
	name = "Module Design (Father)"
	desc = "Allows for the construction of a Father AI Module."
	id = "father_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000)
	build_path = /obj/item/aiModule/core/full/father
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/ranger_module
	name = "Module Design (Texas Ranger)"
	desc = "Allows for the construction of a 'Texas Ranger' AI Module."
	id = "ranger_module"
	materials = list(/datum/material/iron = 25000) //big iron get it haha
	build_path = /obj/item/aiModule/core/full/texasranger
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/mallcop_module
	name = "Module Design (Paul Blart)"
	desc = "Allows for the construction of a 'Paul Blart' AI Module."
	id = "mallcop_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 4000, /datum/material/silver = 4000)
	build_path = /obj/item/aiModule/core/full/mallcop
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/board/dagoth_module
	name = "Module Design (Dagoth Ur)"
	desc = "Allows for the construction of a 'Dagoth Ur' AI Module."
	id = "dagoth_module"
	materials = list(/datum/material/glass = 1000, /datum/material/gold = 2000, /datum/material/uranium = 3000)
	build_path = /obj/item/aiModule/core/full/dagoth
	category = list("AI Modules")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
