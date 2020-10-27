//Cargo can -technically- get 200 credits back for each goodie bag purchase, but because
//they're bundled, it would be incredibly inefficient and time consuming to do so.

/datum/supply_pack/goody/airsuppliesnitrogen
	name = "Emergency Air Supplies (Nitrogen)"
	desc = "A vox breathing mask and nitrogen tank."
	cost = 125
	contains = list(/obj/item/tank/internals/nitrogen/belt,
                    /obj/item/clothing/mask/breath/vox)

/datum/supply_pack/goody/airsuppliesplasma
	name = "Emergency Air Supplies (Plasma)"
	desc = "A breathing mask and plasmaman plasma tank."
	cost = 125
	contains = list(/obj/item/tank/internals/plasmaman/belt,
                    /obj/item/clothing/mask/breath)

/datum/supply_pack/goody/airsuppliesoxygen
	name = "Emergency Air Supplies (Oxygen)"
	desc = "A breathing mask and emergency oxygen tank."
	cost = 75
	contains = list(/obj/item/tank/internals/emergency_oxygen,
                    /obj/item/clothing/mask/breath)

/datum/supply_pack/goody/medipen
	name = "Epinephrine Medipen"
	desc = "A single-use medipen. Useful for keeping people stable, or from rotting."
	cost = 40
	contains = list(/obj/item/reagent_containers/hypospray/medipen)

/datum/supply_pack/goody/crayons
	name = "Box of Crayons"
	desc = "Colorful!"
	cost = 40
	contains = list(/obj/item/storage/crayons)

/datum/supply_pack/goody/crayons
	name = "Handheld Mirror"
	desc = "Contains one handheld mirror, for style changes on the go!"
	cost = 40
	contains = list(/obj/item/hhmirror)

/datum/supply_pack/goody/shotgun
	name = "12g Hunting Shotgun"
	desc = "Contains one hunting-grade shotgun. Never know when you need it."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/shotgun/lethal)

/datum/supply_pack/goody/double_barreled_shotgun
	name = "12g Revolving Shotgun"
	desc = "Contains one revolving shotgun. Never know when you need it."
	cost = 1500
	contains = list(/obj/item/gun/ballistic/revolver/doublebarrel)

/datum/supply_pack/goody/riot_shotgun
	name = "12g Riot Shotgun"
	desc = "Contains one riot shotgun. Never know when you need it."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/shotgun/riot)

/datum/supply_pack/goody/bulldog_shotgun
	name = "12g Assault Shotgun"
	desc = "Contains one automatic bulldog shotgun. Never know when you need it."
	cost = 10000
	contains = list(/obj/item/gun/ballistic/automatic/shotgun/bulldog/unrestricted)

/datum/supply_pack/goody/shotgun_ammo
	name = "12g Shotgun Slugs"
	desc = "Contains 2 stripper clips of 12g slugs."
	cost = 1500
	contains = list(/obj/item/ammo_box/shotgun/loaded,
					/obj/item/ammo_box/shotgun/loaded)

/datum/supply_pack/goody/buck_shotgun_ammo
	name = "12g Buckshot Slugs"
	desc = "Contains 2 stripper clips of 12g buckshot."
	cost = 1500
	contains = list(/obj/item/ammo_box/shotgun/loaded/buckshot,
					/obj/item/ammo_box/shotgun/loaded/buckshot)

/datum/supply_pack/goody/arg
	name = "5.56 Assault Rifle"
	desc = "Contains one NT ARG Boarder assault rifle, chambered in 5.56mm. Never know when you need it."
	cost = 20000
	contains = list(/obj/item/gun/ballistic/automatic/ar)

/datum/supply_pack/goody/arg_ammo
	name = "5.56 Magazines"
	desc = "Contains 2 high capacity 5.56mm magazines."
	cost = 5000
	contains = list(/obj/item/ammo_box/magazine/m556,
					/obj/item/ammo_box/magazine/m556)

/datum/supply_pack/goody/sniper
	name = ".50 Sniper Rifle"
	desc = "Contains one anti-material sniper rifle, chambered in .50 cal. Never know when you need it."
	cost = 40000
	contains = list(/obj/item/gun/ballistic/automatic/sniper_rifle)

/datum/supply_pack/goody/sniper_ammo
	name = ".50 Magazines"
	desc = "Contains 2 .50 cal magazines."
	cost = 15000
	contains = list(/obj/item/ammo_box/magazine/sniper_rounds,
					/obj/item/ammo_box/magazine/sniper_rounds)

/datum/supply_pack/goody/tactical_smg
	name = "9mm Tactical Submachine Gun"
	desc = "Contains one NT Saber SMG, chambered in 9mm. Never know when you need it."
	cost = 12000
	contains = list(/obj/item/gun/ballistic/automatic/proto)

/datum/supply_pack/goody/tactical_smg_ammo
	name = "9mm Tactical SMG Magazines"
	desc = "Contains 2 high capacity 9mm magazines."
	cost = 4000
	contains = list(/obj/item/ammo_box/magazine/smgm9mm,
					/obj/item/ammo_box/magazine/smgm9mm)

/datum/supply_pack/goody/smg
	name = "9mm Submachine Gun"
	desc = "Contains one mini uzi, chambered in 9mm. Never know when you need it."
	cost = 10000
	contains = list(/obj/item/gun/ballistic/automatic/mini_uzi)

/datum/supply_pack/goody/smg_ammo
	name = "9mm SMG Magazines"
	desc = "Contains 2 high capacity 9mm magazines."
	cost = 3500
	contains = list(/obj/item/ammo_box/magazine/uzim9mm,
					/obj/item/ammo_box/magazine/uzim9mm)

/datum/supply_pack/goody/wt550
	name = "4.6x30mm Submachine Gun"
	desc = "Contains one NT WT-550 SMG, chambered in 4.6x30mm. Never know when you need it."
	cost = 4000
	contains = list(/obj/item/gun/ballistic/automatic/wt550)

/datum/supply_pack/goody/wt550_ammo
	name = "4.6x30mm Magazines"
	desc = "Contains 2 high capacity 9mm magazines."
	cost = 1000
	contains = list(/obj/item/ammo_box/magazine/wt550m9,
					/obj/item/ammo_box/magazine/wt550m9)

/datum/supply_pack/goody/mosin
	name = "7.62 Bolt Action Rifle"
	desc = "Contains one bolt action rifle, chambered in 7.62. Never know when you need it."
	cost = 8000
	contains = list(/obj/item/gun/ballistic/shotgun/boltaction)

/datum/supply_pack/goody/mosin_ammo
	name = "7.62 Stripper Clips"
	desc = "Contains 2 7.62mm stripper clips. Dink."
	cost = 3000
	contains = list(/obj/item/ammo_box/a762,
					/obj/item/ammo_box/a762)

/datum/supply_pack/goody/revolver
	name = ".357 Revolver"
	desc = "Contains one generic .357 revolver. Never know when you need it."
	cost = 8000
	contains = list(/obj/item/gun/ballistic/revolver)

/datum/supply_pack/goody/revolver_ammo
	name = ".357 Speedloaders"
	desc = "Contains 2 .357 speedloaders. Never know when you need it."
	cost = 3000
	contains = list(/obj/item/ammo_box/a357,
					/obj/item/ammo_box/a357)

/datum/supply_pack/goody/shitty_revolver
	name = ".38 Revolver"
	desc = "Contains one generic .38 revolver. Never know when you need it."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/revolver/detective)

/datum/supply_pack/goody/shitty_revolver_ammo
	name = ".38 Speedloaders"
	desc = "Contains 2 .38 speedloaders. Never know when you need it."
	cost = 1000
	contains = list(/obj/item/ammo_box/c38,
					/obj/item/ammo_box/c38)

/datum/supply_pack/goody/m1911
	name = ".45 Pistol"
	desc = "Contains one M1911 pistol. Never know when you need it."
	cost = 8000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/m1911)

/datum/supply_pack/goody/m1911_ammo
	name = ".45 Pistol Magazines"
	desc = "Contains 2 .45 magazines. Never know when you need it."
	cost = 2500
	contains = list(/obj/item/ammo_box/magazine/m45,
					/obj/item/ammo_box/magazine/m45)

/datum/supply_pack/goody/m10mm_pistol
	name = "10mm Pistol"
	desc = "Contains one generic 10mm pistol. Never know when you need it."
	cost = 8000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/modular)

/datum/supply_pack/goody/m10mm_ammo
	name = "10mm Pistol Magazines"
	desc = "Contains 2 10mm magazines. Never know when you need it."
	cost = 2500
	contains = list(/obj/item/ammo_box/magazine/m10mm,
					/obj/item/ammo_box/magazine/m10mm)

/datum/supply_pack/goody/nangler
	name = "9mm Pistol"
	desc = "Contains one ML Nangler pistol. Never know when you need it."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/nangler)

/datum/supply_pack/goody/nangler_ammo
	name = "9mm Pistol Magazines"
	desc = "Contains 2 ML Nangler magazines. Never know when you need it."
	cost = 1500
	contains = list(/obj/item/ammo_box/magazine/nangler,
					/obj/item/ammo_box/magazine/nangler)

/datum/supply_pack/goody/surplus
	name = "10mm Surplus Rifle"
	desc = "Contains one semi-auto surplus rifle. Never know when you need it."
	cost = 1000
	contains = list(/obj/item/gun/ballistic/automatic/surplus)

/datum/supply_pack/goody/surplus_ammo
	name = "10mm Surplus Magazines"
	desc = "Contains 2 surplus magazines. Never know when you need it."
	cost = 500
	contains = list(/obj/item/ammo_box/magazine/m10mm/rifle,
					/obj/item/ammo_box/magazine/m10mm/rifle)

//fuck you owai
/datum/supply_pack/goody/combatknives_single
	name = "Combat knife single-pack"
	desc = "A knife. For combat. Never know when you need it."
	cost = 800
	contains = list(/obj/item/kitchen/knife/combat)

/datum/supply_pack/goody/blackbaton
	name = "Black Police Baton"
	desc = "A sturdy police baton. Never know when you need it."
	cost = 800
	contains = list(/obj/item/melee/classic_baton/black)

/datum/supply_pack/goody/telescopic_baton
	name = "Telescopic Baton"
	desc = "A sturdy extendable baton. Never know when you need it."
	cost = 1250
	contains = list(/obj/item/melee/classic_baton/telescopic)
