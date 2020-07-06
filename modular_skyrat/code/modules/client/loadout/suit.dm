
/datum/gear/neetsuit
	name = "Desperate Assistance Battleforce suit"

/datum/gear/trekds9_coat
	name = "DS9 Overcoat (use reskin of EntCorp uniform)"
	restricted_roles = NOCIV_ROLES

/datum/gear/trekmedscimov
	restricted_roles = MEDSCI_ROLES

/datum/gear/trekcmdmov
	restricted_roles = list("Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Research Director", "Chief Medical Officer", "Quartermaster", "Blueshield", "Brig Physician", "Warden", "Detective", "Security Officer")

/datum/gear/trekmedscimod
	name = "EntCorp uniform, Blue"
	restricted_roles = MEDSCI_ROLES

/datum/gear/trekcmdmod
	name = "EntCorp uniform, Red"
	restricted_roles = list("Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Research Director", "Chief Medical Officer", "Quartermaster", "Blueshield", "Brig Physician", "Warden", "Detective", "Security Officer")

/datum/gear/trekcmdcapmod
	name = "EntCorp uniform, White"

/datum/gear/trekengmod
	name = "EntCorp uniform, Yellow"

/datum/gear/trekcmdcap
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield")

/datum/gear/ianshirt
	name = "worn/baggy shirt"
	path = /obj/item/clothing/suit/wornshirt

/datum/gear/ianshirt_polychromic
	name = "Polychromic worn/baggy shirt"
	category = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/wornshirt/polychromic
