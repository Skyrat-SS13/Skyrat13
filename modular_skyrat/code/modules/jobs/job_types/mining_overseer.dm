//Mining overseer.
//TLDR miner who doesn't go on the field,
//just provides support to fellow miners on the base.
//This support may include:
//Impeding smuggling of illegal stuff to the station
//Healing injured miners
//Rescuing lost and/or injured miners
//Repairing and generally maintaining the lavaland base
//Impeding miners from doing dumb shit
//Being a mall cop for lavaland but even less cool
/datum/job/mining/overseer
	title = "Mining Overseer"
	alt_titles = list("Mining Overseer", "Head Miner", "Lavaland Inspector")
	supervisors = "the quartermaster"
	custom_spawn_text = "Remember, your job is to provide assistance to fellow miners - do not go out on the field to mine unless the situation calls for it. Although you have access to the security radio channel, you are not a security member in any official capacity - just warn actual security when bad stuff happens with miners on lavaland."
	outfit = /datum/outfit/job/miner/overseer
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_CARGO_BOT, ACCESS_MINING,
				ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_MINE_OVERSEER)
	minimal_access = list(ACCESS_MINE_OVERSEER, ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_MEDIUM
	selection_color = "#d48b1e"
	total_positions = 1
	spawn_positions = 1
	threat = 2

/datum/outfit/job/miner/overseer
	name = "Shaft Miner (Overseer)"
	jobtype = /datum/job/mining/overseer
	ears = /obj/item/radio/headset/headset_cargo/mining/overseer
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/stack/marker_beacon/thirty=1,\
		/obj/item/storage/firstaid/regular=1,\
		/obj/item/reagent_containers/medspray/styptic=1,\
		/obj/item/reagent_containers/hypospray=1)
	uniform = /obj/item/clothing/under/rank/cargo/miner
	head = /obj/item/clothing/head/beret/qm/overseer
