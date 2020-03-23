/obj/structure/closet/secure_closet/armory1/PopulateContents()
	..()
	new /obj/item/clothing/suit/hooded/ablative(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/armor/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/shield/riot(src)

/obj/structure/closet/secure_closet/blueshield
	name = "\the blueshield's locker"
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 140
	material_drop = /obj/item/stack/sheet/mineral/wood
	cutting_tool = /obj/item/screwdriver
	req_access = list(ACCESS_BLUESHIELD)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	new /obj/item/storage/briefcase(src)
	new	/obj/item/storage/firstaid/tactical/blueshield(src)
	new /obj/item/pinpointer/crew(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/melee/baton/loaded(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/clothing/glasses/hud/health/sunglasses(src)
	new /obj/item/clothing/head/beret/blueshield(src)
	new /obj/item/clothing/head/beret/blueshield/navy(src)
	new /obj/item/clothing/suit/armor/vest/blueshield(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/under/rank/security/blueshield(src)
