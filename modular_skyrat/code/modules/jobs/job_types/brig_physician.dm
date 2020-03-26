/datum/job/brig_physician
	title = "Brig Physician"
	flag = DOCTOR
	department_head = list("Head of Security", "Chief Medical Officer")
	department_flag = MEDSCI
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security and chief medical officer"
	selection_color = "#c02f2f"
	minimal_player_age = 7
	exp_requirements = 120 //SKYRAT CHANGE - lowers security exp requirement
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/brig_phys

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_LEAVE_GENPOP, ACCESS_ENTER_GENPOP, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_GENETICS, ACCESS_CLONING, ACCESS_VIROLOGY, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_LEAVE_GENPOP, ACCESS_ENTER_GENPOP, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CLONING, ACCESS_MINERAL_STOREROOM)

	display_order = JOB_DISPLAY_ORDER_BRIG_PHYSICIAN

/datum/outfit/job/brig_phys
	name = "Brig Physician"
	jobtype = /datum/job/brig_physician

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_medsec
	uniform = /obj/item/clothing/under/rank/brig_phys
	shoes = /obj/item/clothing/shoes/sneakers/white
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/hazardvest/brig_phys
	suit_store = /obj/item/flashlight/seclite
	l_hand = /obj/item/storage/firstaid/regular
	head = /obj/item/clothing/head/soft/sec/brig_phys
	implants = list(/obj/item/implant/mindshield)
