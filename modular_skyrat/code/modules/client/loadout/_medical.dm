/datum/gear/sterilemask
	name = "sterile mask"
	category = SLOT_WEAR_MASK
	description = "A sterile mask designed to help prevent the spread of diseases."
	path = /obj/item/clothing/mask/surgical
	restricted_roles = MED_ROLES
	restricted_desc = "Medical, including Brig Physician"

/datum/gear/medhud
	name = "Medical Hud"
	category = SLOT_GLASSES
	path = /obj/item/clothing/glasses/hud/health
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Paramedic", "Brig Physician")
	restricted_desc = "Medical"

/datum/gear/medhud_nearsighted
	name = "Prescription Medical Hud"
	category = SLOT_GLASSES
	path = /obj/item/clothing/glasses/hud/health/prescription
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Paramedic", "Brig Physician")
	restricted_desc = "Medical"
