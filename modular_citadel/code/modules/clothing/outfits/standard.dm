/obj/item/radio/headset/headset_cent/commander/alt/generic
	name = "\improper bowman headset"
	desc = "A headset for emergency response personnel. Protects ears from flashbangs."
	icon_state = "cent_headset_alt"
	item_state = "cent_headset_alt"
	bowman = TRUE
	
/obj/item/gun/energy/taser/debug
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/debug)
	
/obj/item/ammo_casing/energy/electrode/debug
	e_cost = 1

/obj/item/clothing/suit/armor/vest/darkcarapace/debug
	name = "Bluespace Tech"
	desc = "A sleek piece of armour designed for Bluespace agents."
	icon = 'icons/obj/custom.dmi'
	mob_overlay_icon = 'icons/mob/clothing/custom_w.dmi'
	icon_state = "darkcarapace"
	item_state = "darkcarapace"
	blood_overlay_type = "armor"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 80, "energy" = 80, "bomb" = 80, "bio" = 80, "rad" = 80, "fire" = 80, "acid" = 80)

/obj/item/clothing/suit/space/hardsuit/ert/alert/debug
	name = "Bluespace Tech hardsuit"
	desc = "A specialised hardsuit for Bluespace agents."
	armor = list("melee" = 80, "bullet" = 80, "laser" = 80, "energy" = 80, "bomb" = 80, "bio" = 80, "rad" = 80, "fire" = 80, "acid" = 80)

/obj/item/clothing/shoes/combat/debug
	clothing_flags = NOSLIP

/datum/outfit/debug/bst //Debug objs
	name = "Bluespace Tech"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/darkcarapace/debug
	glasses = /obj/item/clothing/glasses/debug
	ears = /obj/item/radio/headset/headset_cent/commander/alt/generic
	mask = /obj/item/clothing/mask/gas/welding/up
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	belt = /obj/item/storage/belt/utility/chief/full
	shoes = /obj/item/clothing/shoes/combat/debug
	id = /obj/item/card/id/debug/bst
	back = /obj/item/storage/backpack/holding
	box = /obj/item/storage/box/debugtools
	suit_store = /obj/item/gun/energy/taser/debug
	backpack_contents = list(
		/obj/item/melee/transforming/energy/axe=1,\
		/obj/item/storage/part_replacer/bluespace/tier4=1,\
		/obj/item/debug/human_spawner=1,\
		)

/datum/outfit/debug/bsthardsuit //Debug objs plus hardsuit
	name = "Bluespace Tech (Hardsuit)"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/space/hardsuit/ert/alert/debug
	glasses = /obj/item/clothing/glasses/debug
	ears = /obj/item/radio/headset/headset_cent/commander/alt/generic
	mask = /obj/item/clothing/mask/gas/welding/up
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	belt = /obj/item/storage/belt/utility/chief/full
	shoes = /obj/item/clothing/shoes/combat/debug
	id = /obj/item/card/id/debug/bst
	back = /obj/item/storage/backpack/holding
	box = /obj/item/storage/box/debugtools
	suit_store = /obj/item/tank/internals/oxygen
	internals_slot = ITEM_SLOT_SUITSTORE
	backpack_contents = list(
		/obj/item/melee/transforming/energy/axe=1,\
		/obj/item/storage/part_replacer/bluespace/tier4=1,\
		/obj/item/debug/human_spawner=1,\
		/obj/item/gun/energy/taser/debug,\
		)
