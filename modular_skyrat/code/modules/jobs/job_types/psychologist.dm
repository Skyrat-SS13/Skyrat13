/datum/job/psychologist
	title = "Psychologist"
	flag = PSYCHOLOGIST
	department_head = list("Chief Medical Officer")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief medical officer"
	selection_color = "#74b5e0"
	exp_type = EXP_TYPE_CREW
	exp_requirements = 360

	outfit = /datum/outfit/job/psychologist

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_SURGERY, ACCESS_MORGUE, ACCESS_CLONING, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_CLONING, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_PSYCHOLOGIST
	threat = 0.35

/datum/outfit/job/psychologist
	name = "Psychologist"
	jobtype = /datum/job/psychologist

	belt = /obj/item/pda/psychologist
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/medical/psychologist
	shoes = /obj/item/clothing/shoes/sneakers/brown
	r_pocket = /obj/item/pen/fountain
	l_pocket = /obj/item/flashlight/pen
	//suit =

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel/leather
	duffelbag = /obj/item/storage/backpack/duffelbag

	backpack_contents = list(/obj/item/toy/plush/slimeplushie)
