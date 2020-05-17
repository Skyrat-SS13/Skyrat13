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
	name = "Fed uniform, cmd"
	restricted_roles = CMD_ROLES

/datum/gear/trekmedscitos
	name = "Fed uniform, medsci"
	restricted_roles = MEDSCI_ROLES

/datum/gear/trekengtos
	name = "Fed uniform, ops"
	restricted_roles = OPRS_ROLES

/datum/gear/trekfedutil
	name = "Fed uniform, classic"
	restricted_roles = NOCIV_ROLES // Accomodates for modular and forgotten roles.

/datum/gear/trekfedtrainee
	name = "Fed uniform, trainee/assistant"
	path = /obj/item/clothing/under/trek/orvi

/datum/gear/trekfedservice
	name = "Fed uniform, service"
	path = /obj/item/clothing/under/trek/orvi/service
	restricted_roles = CIV_ROLES
	restricted_desc = "Civilian and Service"
