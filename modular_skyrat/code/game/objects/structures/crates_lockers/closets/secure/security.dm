/* not for now
/obj/structure/closet/secure_closet/armory1/PopulateContents()
	..()
	new /obj/item/clothing/suit/hooded/ablative(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/armor/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/riot(src)
	for(var/i in 1 to 3)
		new /obj/item/shield/riot(src)
*/
/obj/structure/closet/secure_closet/brig_phys
	name = "\proper brig physician's locker"
	req_access = list(ACCESS_BRIG)
	icon = 'modular_skyrat/icons/obj/closet.dmi'
	icon_state = "brig_phys"

/obj/structure/closet/secure_closet/brig_phys/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_medsec(src)
	new	/obj/item/storage/firstaid/regular(src)
	new	/obj/item/storage/firstaid/fire(src)
	new	/obj/item/storage/firstaid/toxin(src)
	new	/obj/item/storage/firstaid/o2(src)
	new	/obj/item/storage/firstaid/brute(src)
	new /obj/item/storage/hypospraykit/toxin(src)
	new /obj/item/storage/hypospraykit/o2(src)
	new /obj/item/storage/hypospraykit/brute(src)
	new /obj/item/storage/hypospraykit/fire(src)
	new /obj/item/storage/hypospraykit/regular(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/gloves/color/latex/nitrile(src)

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
	new /obj/item/pinpointer/crew(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/under/rank/security/blueshieldturtleneck(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/clothing/head/beret/blueshield(src)
	new /obj/item/clothing/head/beret/blueshield/navy(src)
	new /obj/item/clothing/suit/armor/vest/blueshield(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/under/rank/security/blueshield(src)

//i unironically gave the HoS an MP5
//note: i should give the mp5 a proper display case
/obj/structure/closet/secure_closet/hos/PopulateContents()
	..()
	new /obj/item/clothing/neck/cloak/hos(src)
	new /obj/item/cartridge/hos(src)
	new /obj/item/radio/headset/heads/hos(src)
	new /obj/item/clothing/under/rank/security/head_of_security/parade/female(src)
	new /obj/item/clothing/under/rank/security/head_of_security/parade(src)
	new /obj/item/clothing/suit/armor/vest/leather(src)
	new /obj/item/clothing/suit/armor/hos(src)
	new /obj/item/clothing/under/rank/security/head_of_security/skirt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/alt(src)
	new /obj/item/clothing/under/rank/security/head_of_security/alt/skirt(src)
	new /obj/item/clothing/head/HoS(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/gars/supergars(src)
	new /obj/item/clothing/under/rank/security/head_of_security/grey(src)
	new /obj/item/storage/lockbox/medal/sec(src)
	new /obj/item/megaphone/sec(src)
	new /obj/item/holosign_creator/security(src)
	new /obj/item/storage/lockbox/loyalty(src)
	new /obj/item/clothing/mask/gas/sechailer/swat(src)
	new /obj/item/storage/box/flashbangs(src)
	new /obj/item/shield/riot/tele(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/gun/energy/e_gun/hos(src)
	new /obj/item/flashlight/seclite(src)
	new /obj/item/pinpointer/nuke(src)
	new /obj/item/circuitboard/machine/techfab/department/security(src)
	new /obj/item/storage/photo_album/HoS(src)
	new /obj/item/clothing/suit/hooded/wintercoat/hos(src)
	new /obj/item/gun/ballistic/automatic/mp5(src)
	new /obj/item/ammo_box/magazine/smgm9mm/rubber(src)
	new /obj/item/ammo_box/magazine/smgm9mm/rubber(src)
