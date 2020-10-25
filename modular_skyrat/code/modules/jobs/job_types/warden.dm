/datum/job/warden
	title = "Lieutenant"
	supervisors = "the Chief Enforcer"
	department_head = list("Chief Enforcer")
	total_positions = 0
	spawn_positions = 0

/datum/outfit/job/warden
	backpack_contents = list(
					/obj/item/ammo_box/magazine/nangler=1,
					/obj/item/melee/classic_baton/black=1,
					/obj/item/choice_beacon/warden=1)
	suit_store = /obj/item/gun/ballistic/automatic/pistol/nangler

/obj/item/choice_beacon/warden
	name = "lieutenant's weapon beacon"
	desc = "A beacon, allowing the lieutenant to select between two available models of personal firearms."

/obj/item/choice_beacon/warden/generate_display_names()
	var/static/list/shotties
	if(!shotties)
		shotties = list()
		shotties["M1911"] = /obj/item/gun/ballistic/automatic/pistol/m1911
		shotties["Lawman-17"] = /obj/item/gun/ballistic/automatic/pistol/APS/glock
	return shotties
