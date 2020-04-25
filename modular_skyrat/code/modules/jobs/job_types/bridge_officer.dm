/datum/job/bridgeofficer
	title = "Bridge Officer"
	flag = BRIDGE_OFFICER
	department_head = list("Captain", "Head of Security", "Chief Medical Officer", "Head of Personnel", "Research Director", "Quartermaster", "Chief Engineer")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Command team"
	selection_color = "#494999"

	outfit = /datum/outfit/job/bridgeofficer

	access = list(ACCESS_COURT, ACCESS_HEADS, ACCESS_MAINT_TUNNELS, ACCESS_CARGO, ACCESS_RC_ANNOUNCE, ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN,
	)
	minimal_access = list(ACCESS_COURT, ACCESS_HEADS, ACCESS_MAINT_TUNNELS, ACCESS_CARGO, ACCESS_RC_ANNOUNCE,
	)
	display_order = JOB_DISPLAY_ORDER_BRIDGE_OFFICER
	outfit = /datum/outfit/job/bridgeofficer
	custom_spawn_text = "You are here to assist the Command team, you are NOT a head of staff."

/datum/outfit/job/bridgeofficer
	name = "Bridge Officer"
	jobtype = /datum/job/bridgeofficer
	uniform = /obj/item/clothing/under/bridgeofficer
	id = /obj/item/card/id/silver
	suit = /obj/item/clothing/suit/storage/bridgeofficer
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/laceup
	l_hand = /obj/item/storage/secure/briefcase
	ears = /obj/item/radio/headset/heads/BO
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = /obj/item/clipboard
	head = /obj/item/clothing/head/bohat
	belt = /obj/item/pda/lawyer
