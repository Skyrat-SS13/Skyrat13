/datum/gear/polyskirt
	name = "Polychromic Skirt"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/dress/skirt/polychromic
	cost = 3

/datum/gear/polyshirt
	name = "Polychromic Jumpsuit"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/misc/polyjumpsuit
	cost = 3

/datum/gear/skirtleneck
	name = "Tacticool Skirtleneck"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/syndicate/tacticool/skirt

/datum/gear/trekcmdtos
	name = "EntCorp uniform, cmd"

/datum/gear/trekmedscitos
	name = "EntCorp uniform, medsci"
	restricted_roles = list("Chief Medical Officer", "Medical Doctor", "Chemist", "Virologist", "Paramedic", "Geneticist", "Research Director", "Scientist", "Roboticist")

/datum/gear/trekengtos
	name = "EntCorp uniform, ops"
	restricted_roles = list("Chief Engineer", "Atmospheric Technician", "Station Engineer", "Warden", "Detective", "Security Officer", "Head of Security", "Brig Physician", "Blueshield", "Cargo Technician", "Shaft Miner", "Quartermaster")

/datum/gear/trekfedutil
	name = "Fed uniform, classic"
	restricted_roles = NOCIV_ROLES // Accomodates for modular and forgotten roles.

/datum/gear/trekfedtrainee
	name = "EntCorp uniform, trainee/assistant"
	path = /obj/item/clothing/under/trek/orvi

/datum/gear/trekfedservice
	name = "EntCorp uniform, service"
	path = /obj/item/clothing/under/trek/orvi/service
	restricted_roles = CIV_ROLES
	restricted_desc = "Civilian and Service"
