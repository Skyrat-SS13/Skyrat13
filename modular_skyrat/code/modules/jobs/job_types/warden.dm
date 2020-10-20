/datum/job/warden
	title = "Lieutenant"
	supervisors = "the chief enforcer"

/datum/outfit/job/warden
	backpack_contents = list(/obj/item/melee/classic_baton/black=1,
					/obj/item/ammo_box/magazine/nangler=1,
					/obj/item/ammo_box/shotgun/loaded/rubbershot=1,
					/obj/item/choice_beacon/warden=1)
	suit_store = /obj/item/gun/ballistic/automatic/pistol/nangler

/obj/item/choice_beacon/warden
	name = "lieutenant's shotgun beacon"
	desc = "A beacon, allowing the lieutenant to select between two available models of personal shotguns."

/obj/item/choice_beacon/warden/generate_display_names()
	var/static/list/shotties
	if(!shotties)
		shotties = list()
		shotties["Compact Combat Shotgun"] = /obj/item/gun/ballistic/shotgun/automatic/combat/compact/warden
		shotties["Particle Defender"] = /obj/item/gun/energy/pumpaction/defender
	return shotties
