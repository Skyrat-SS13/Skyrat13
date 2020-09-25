/datum/design/cybernetic_intestines
	name = "Cybernetic Intestines"
	desc = "Intestines for taking very hard dookeys."
	id = "cybernetic_intestines"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 1500, /datum/material/plasma = 500)
	build_path = /obj/item/organ/intestines/cybernetic
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/cybernetic_kidneys
	name = "Cybernetic Kidneys"
	desc = "A pair of cybernetic kidneys."
	id = "cybernetic_kidneys"
	build_type = PROTOLATHE
	materials = list(/datum/material/titanium = 500, /datum/material/uranium = 1500)
	build_path = /obj/item/organ/kidneys/cybernetic
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL

/datum/design/automender
	name = "Auto-mender"
	desc = "A topical chemical application device."
	id = "automender"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 500, /datum/material/gold = 500, /datum/material/plasma = 500, /datum/material/titanium = 500, /datum/material/plastic = 2000)
	build_path = /obj/item/reagent_containers/mender
	category = list("Medical Designs")
	departmental_flags = DEPARTMENTAL_FLAG_MEDICAL
