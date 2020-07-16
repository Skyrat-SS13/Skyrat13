/datum/gear/redberet
	name = "Beret"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/beret

/datum/gear/purpleberet
	name = "Purple Beret"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/beret/purple

/datum/gear/blueberet
	name = "Blue Beret"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/beret/blue

/datum/gear/wig
	name = "Wig"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/wig

/datum/gear/wignatural
	name = "Natural Wig"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/wig/natural

/datum/gear/neethelm
	name = "Desperate Assistance Battleforce helmet"

/datum/gear/papersack
	name = "Paper Sack"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/papersack
	cost = 2

/datum/gear/cardboard
	name = "Cardboard Helmet"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/cardborg
	cost = 2

/datum/gear/baseballcap
	name = "Red Cap"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/soft/red

/datum/gear/baseballcap/blue
	name = "Blue Cap"
	path = /obj/item/clothing/head/soft/blue

/datum/gear/baseballcap/green
	name = "Green Cap"
	path = /obj/item/clothing/head/soft/green

/datum/gear/baseballcap/yellow
	name = "Yellow Cap"
	path = /obj/item/clothing/head/soft/yellow

/datum/gear/baseballcap/grey
	name = "Grey Cap"
	path = /obj/item/clothing/head/soft/grey

/datum/gear/baseballcap/orange
	name = "Orange Cap"
	path = /obj/item/clothing/head/soft/orange

/datum/gear/baseballcap/white
	name = "White Cap"
	path = /obj/item/clothing/head/soft/mime

/datum/gear/baseballcap/purple
	name = "Purple Cap"
	path = /obj/item/clothing/head/soft/purple

/datum/gear/baseballcap/black
	name = "Black Cap"
	path = /obj/item/clothing/head/soft/black

/datum/gear/baseballcap/rainbow
	name = "Rainbow Cap"
	path = /obj/item/clothing/head/soft/rainbow
	cost = 3

/datum/gear/baseballcap/security
	name = "Security Cap"
	path = /obj/item/clothing/head/soft/sec
	restricted_roles = SEC_ROLES
	restricted_desc = "Security"

/datum/gear/baseballcap/emt
	name = "EMT Cap"
	path = /obj/item/clothing/head/soft/emt
	restricted_roles = list("Paramedic")

/datum/gear/beanie/black
	name = "Black Beanie"
	path = /obj/item/clothing/head/beanie/black

/datum/gear/beanie/red
	name = "Red Beanie"
	path = /obj/item/clothing/head/beanie/red

/datum/gear/beanie/green
	name = "Green Beanie"
	path = /obj/item/clothing/head/beanie/green

/datum/gear/beanie/darkblue
	name = "Dark Blue Beanie"
	path = /obj/item/clothing/head/beanie/darkblue

/datum/gear/beanie/purple
	name = "Purple Beanie"
	path = /obj/item/clothing/head/beanie/purple

/datum/gear/beanie/yellow
	name = "Yellow Beanie"
	path = /obj/item/clothing/head/beanie/yellow

/datum/gear/beanie/orange
	name = "Orange Beanie"
	path = /obj/item/clothing/head/beanie/orange

/datum/gear/beanie/cyan
	name = "Cyan Beanie"
	path = /obj/item/clothing/head/beanie/cyan

/datum/gear/trekcap
	name = "EntCorp Officer's Cap (White)"

/datum/gear/trekcapmedisci
	name = "EntCorp Officer's Cap (Blue)"
	restricted_roles = MEDSCI_ROLES

/datum/gear/trekcapsec
	name = "EntCorp Officer's Cap (Red)"
	restricted_roles = list("Head of Security", "Captain", "Head of Personnel", "Chief Engineer", "Research Director", "Chief Medical Officer", "Quartermaster", "Blueshield", "Brig Physician", "Warden", "Detective", "Security Officer")

/datum/gear/trekcapeng
	name = "EntCorp Officer's Cap (Yellow)"

/datum/gear/trekcapcap
	name = "EntCorp Officer's Cap (Black)"
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield")

// orvilike "original" kepi
/datum/gear/orvkepicom
	name = "EntCorp Kepi, command"
	description = "A visored cap. Intended to be used with Orvlike reskin of EntCorp uniform."
	restricted_roles = CMD_ROLES

/datum/gear/orvkepiops
	name = "EntCorp Kepi, ops/sec"
	description = "A visored cap. Intended to be used with Orvlike reskin of EntCorp uniform."
	restricted_roles = OPRS_ROLES

/datum/gear/orvkepimedsci
	name = "EntCorp Kepi, medsci"
	description = "A visored cap. Intended to be used with Orvlike reskin of EntCorp uniform."
	restricted_roles = MEDSCI_ROLES

/datum/gear/orvkepisrv
	name = "EntCorp Kepi, service"
	description = "A visored cap. Intended to be used with Orvlike reskin of EntCorp uniform."
	restricted_desc = "Service and Civilian"
	restricted_roles = CIV_ROLES

/datum/gear/orvkepiass
	name = "EntCorp Kepi, assistant"
	description = "A visored cap. Intended to be used with Orvlike reskin of EntCorp uniform."
	restricted_roles = list("Assistant")
