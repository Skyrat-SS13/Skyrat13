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

/datum/gear/polyunder
	name = "Polychromic Under"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/suit/polychromic
	cost = 3

/datum/gear/polypleat
	name = "Polychromic Pleated Skirt"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/dress/skirt/polychromic/pleated
	cost = 3

/datum/gear/polyfemtank
	name = "Polychromic Feminine Tanktop"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/misc/poly_tanktop/female
	cost = 3

/datum/gear/polytshirt
	name = "Polychromic Shirt"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/misc/poly_shirt
	cost = 3

/datum/gear/skirtleneck
	name = "Tacticool Skirtleneck"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/syndicate/tacticool/skirt

/datum/gear/trekcmdtos
	name = "EntCorp uniform, cmd"
	restricted_roles = CMD_ROLES

/datum/gear/trekmedscitos
	name = "EntCorp uniform, medsci"
	restricted_roles = MEDSCI_ROLES

/datum/gear/trekengtos
	name = "EntCorp uniform, ops"
	restricted_roles = OPRS_ROLES

/datum/gear/trekfedutil
	name = "Fed uniform, classic"
	restricted_roles = NOCIV_ROLES // Accomodates for modular and forgotten roles.

/datum/gear/orvass
	name = "EntCorp uniform, assistant/trainee"

/datum/gear/orvsrv
	name = "EntCorp uniform, service"
	restricted_roles = CIV_ROLES
	restricted_desc = "Civilian and Service"

// Yes, it was in non-modular code. Yes, I'm retarded --Nopeman
/datum/gear/orvcmd_capt
	name = "EntCorp uniform, capt"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/trek/command/orv/captain
	restricted_roles = list("Captain")

/datum/gear/orvcmd_medsci
	name = "EntCorp uniform, medsci, cmd"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/trek/command/orv/medsci
	restricted_roles = MEDSCI_ROLES

/datum/gear/orvcmd_ops
	name = "EntCorp uniform, ops, cmd"
	category = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/trek/command/orv/engsec
	restricted_roles = OPRS_ROLES
