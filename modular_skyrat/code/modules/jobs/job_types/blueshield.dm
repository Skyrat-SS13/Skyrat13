/datum/job/blueshield
	title = "Blueshield"
	flag = OFFICER
	department_head = list("Captain")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain"
	selection_color = "#ddddff"
	minimal_player_age = 7
	exp_requirements = 2160 /// You literally gotta play security for a total of 1.5 days in hours
	exp_type = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/blueshield

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_FORENSICS_LOCKERS, \
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_EVA, ACCESS_HEADS, \
			            ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE, \
			            ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_LAWYER, \
			            ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, \
			            ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_WEAPONS, ACCESS_BLUESHIELD)
	minimal_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH,
			            ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_HEADS, ACCESS_BLUESHIELD, ACCESS_WEAPONS)
	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	outfit = /datum/outfit/job/blueshield
	mind_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)
	blacklisted_quirks = list(/datum/quirk/mute, /datum/quirk/nonviolent, /datum/quirk/paraplegic)
	custom_spawn_text = "Remember, you are NOT security. Your only duty is to protect heads. Do not go around arresting criminals or doing justice, the only security matters in which you may be involved are those related to the heads you protect."

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	uniform = /obj/item/clothing/under/rank/security/blueshield
	id = /obj/item/card/id/silver
	suit = /obj/item/clothing/suit/armor/vest/blueshield
	gloves = /obj/item/clothing/gloves/combat
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/heads/blueshield/alt
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	belt = /obj/item/storage/belt/security/full
	backpack_contents = list(/obj/item/gun/energy/gun/blueshield = 1, /obj/item/melee/baton/electricprod = 1)
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffel/blueshield
	head = /obj/item/clothing/head/beret/blueshield
	box = /obj/item/storage/box/security
	r_pocket = /obj/item/pda/security

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield