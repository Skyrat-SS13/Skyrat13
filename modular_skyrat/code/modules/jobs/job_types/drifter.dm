/datum/job/drifter
	title = "Drifter"
	flag = DRIFTER
	department_head = list("")
	department_flag =
	faction = ""
	total_positions = ?
	spawn_positions = ?
	supervisors = ""

	outfit = /datum/outfit/job/drifter

	display_order = JOB_DISPLAY_ORDER_DRIFTER

	access = list(ACCESS_MAINT_TUNNELS)

/datum/outfit/job/drifter
	name = "drifter"
	jobtype = /datum/job/drifter

	uniform = /obj/item/clothing/under/costume/soviet
	shoes = /obj/item/clothing/shoes/jackboots
	head = /obj/item/clothing/head/bearpelt
	gloves = /obj/item/clothing/gloves/color/black
	mask = /obj/item/clothing/mask/gas
	id = /obj/item/card/id
	headset = /obj/item/radio/headset/headset_drifter
