/datum/job/mining_foreman
	title = "Mining Foreman"
	flag = MINER
	department_head = list("Quartermaster")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the quartermaster"
	selection_color = "#ca8f55"
	outfit = /datum/outfit/job/mining_foreman
	access = list(ACCESS_CONSTRUCTION, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINING,
				ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_CONSTRUCTION, ACCESS_MAINT_TUNNELS, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM) //Construction for Aux base
	paycheck = PAYCHECK_MEDIUM // You have more responsibilities than a regular miner. Ergo, slightly higher paycheck.
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_MINER_FOREMAN

	threat = 1.5

/datum/outfit/job/mining_foreman
	name = "Mining Foreman (Lavaland)"
	jobtype = /datum/job/mining_foreman

	belt = /obj/item/pda/shaftminer
	ears = /obj/item/radio/headset/headset_cargo/mining
	shoes = /obj/item/clothing/shoes/workboots/mining
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/mining_foreman
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	r_pocket = /obj/item/storage/bag/ore	//causes issues if spawned in backpack
	backpack_contents = list(//kit identical to a miner, add a crew pinpointer, remove mining voucher.
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/suit_voucher=1,\
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/pinpointer/crew=1)

	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival_mining
	chameleon_extras = /obj/item/gun/energy/kinetic_accelerator

/datum/job/mining_foreman/radio_help_message(mob/M)
	to_chat(M, "<span class='userdanger'>You are the foreman of the mining team. You are responsible for the well-being of the other miners and the integrity of the mining facilities (Mining base, Xenoarchology Base, and the Aux Base).</span>")
	to_chat(M, "<span class='userdanger'>You should not ever be hunting megafauna except to recover a dead or injured miner.</span>")
	to_chat(M, "<span class='userdanger'>You are not a head of staff! However every role based on the surface reports to you. Do not risk yourself needlessly!</span>")

/datum/job/mining_engineer
	title = "Mining Technician"
	flag = MINER
	department_head = list("Quartermaster")
	department_flag = CIVILIAN
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster and the mining foreman."
	selection_color = "#ca8f55"
	outfit = /datum/outfit/job/miner_engineer
	access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_CONSTRUCTION, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINING,
				ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_CONSTRUCTION, ACCESS_MAINT_TUNNELS, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM) //Construction for Aux base
	paycheck = PAYCHECK_MEDIUM //This role is an engineer focused around the Aux base and surface.
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_MINER_ENGINEER

	threat = 1

/datum/job/mining_engineer/radio_help_message(mob/M)
	to_chat(M, "<span class='userdanger'>You are a technician based on maintaining and expanding the surface-side facilities. Especially the Auxiliary base. You are not paid to maintain the station.</span>")
	to_chat(M, "<span class='userdanger'>In an emergency you are considered to have the same training as station engineers, but the CE and station engineers have a higher authority than you for anything related to the station proper. </span>")


/datum/outfit/job/miner_engineer
	name = "Mining Technician"
	jobtype = /datum/job/mining_engineer

	belt = /obj/item/storage/belt/utility/full/engi
	ears = /obj/item/radio/headset/headset_mining_engie
	uniform = /obj/item/clothing/under/rank/mining_tech
	shoes = /obj/item/clothing/shoes/workboots
	gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/hardhat
	l_pocket = /obj/item/pda/engineering
	r_pocket = /obj/item/t_scanner
	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/engineer
	pda_slot = SLOT_L_STORE
	backpack_contents = list(
		/obj/item/modular_computer/tablet/preset/advanced=1,\
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,\
		/obj/item/stack/marker_beacon/ten=1)


/obj/item/encryptionkey/headset_cargo/mining_engineer
	name = "mining construction radio encryption key"
	icon_state = "cargo_cypherkey"
	channels = list(RADIO_CHANNEL_SUPPLY = 1, RADIO_CHANNEL_ENGINEERING = 1)

/obj/effect/landmark/start/mining_foreman
	name = "Mining Foreman"
	icon_state = "Shaft Miner"

/obj/effect/landmark/start/mining_engineer
	name = "Mining Technician"
	icon_state = "Station Engineer"

/obj/item/radio/headset/headset_mining_engie
	name = "mining technician radio headset"
	desc = "A headset used by mining technicians."
	icon_state = "cargo_headset"
	keyslot = new /obj/item/encryptionkey/headset_cargo/mining_engineer

