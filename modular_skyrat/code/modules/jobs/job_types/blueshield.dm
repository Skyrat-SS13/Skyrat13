/datum/job/blueshield
	title = "Defender"
	flag = OFFICER
	department_head = list("Chief Enforcer")
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	supervisors = "the Chief Enforcer"
	selection_color = "#ddddff"
	minimal_player_age = 7
	exp_requirements = 2400
	exp_type = EXP_TYPE_SECURITY

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	outfit = /datum/outfit/job/blueshield

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_FORENSICS_LOCKERS, \
			            ACCESS_MEDICAL, ACCESS_ENGINE, ACCESS_HEADS, \
			            ACCESS_MAINT_TUNNELS, ACCESS_CONSTRUCTION, ACCESS_MORGUE, \
			            ACCESS_RESEARCH, ACCESS_CARGO, \
			            ACCESS_RC_ANNOUNCE, ACCESS_GATEWAY, ACCESS_WEAPONS, ACCESS_BLUESHIELD)
	minimal_access = list(ACCESS_FORENSICS_LOCKERS, ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINE, ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH,
			            ACCESS_RC_ANNOUNCE, ACCESS_HEADS, ACCESS_BLUESHIELD, ACCESS_WEAPONS)
	display_order = JOB_DISPLAY_ORDER_BLUESHIELD
	outfit = /datum/outfit/job/blueshield
	blacklisted_quirks = list(/datum/quirk/mute, /datum/quirk/nonviolent, /datum/quirk/paraplegic)
	custom_spawn_text = "Your priority is to protect the heads of staff - Although you do have the power to arrest criminals, do not resort to such unless no one else is capable."

/datum/outfit/job/blueshield
	name = "Blueshield"
	jobtype = /datum/job/blueshield
	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/heads/blueshield
	uniform = /obj/item/clothing/under/rank/security/officer
	gloves = /obj/item/clothing/gloves/color/black
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	suit = /obj/item/clothing/suit/space/hardsuit/security_armor
	shoes = /obj/item/clothing/shoes/jackboots
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(/obj/item/melee/classic_baton/black=1)
	suit_store = /obj/item/gun/ballistic/automatic/pistol/nangler
	backpack = /obj/item/storage/backpack/blueshield
	satchel = /obj/item/storage/backpack/satchel/blueshield
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/security

	implants = list(/obj/item/implant/mindshield)

	chameleon_extras = list(/obj/item/gun/energy/disabler, /obj/item/clothing/glasses/hud/security/sunglasses, /obj/item/clothing/head/helmet)

/datum/outfit/plasmaman/blueshield
	name = "Blueshield Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/blueshield
	uniform = /obj/item/clothing/under/plasmaman/blueshield

/obj/item/choice_beacon/blueshield
	name = "defender's weapon beacon"
	desc = "A beacon, allowing the defender to select their preferred firearm."

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/bshield
	if(!bshield)
		bshield = list()
		bshield["M1911"] = /obj/item/gun/ballistic/automatic/pistol/m1911
	return bshield
