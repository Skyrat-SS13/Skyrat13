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

/datum/supply_pack/goody/arg
	name = "Assault Rifle"
	desc = "Contains one NT ARG Boarder assault rifle, chambered in 5.56mm. Never know when you need it."
	cost = 20000
	contains = list(/obj/item/gun/ballistic/automatic/ar)

/datum/supply_pack/goody/arg_ammo
	name = "5.56 Magazine"
	desc = "Contains 2 high capacity 5.56mm magazines."
	cost = 5000
	contains = list(/obj/item/ammo_box/magazine/m556,
					/obj/item/ammo_box/magazine/m556)

/datum/supply_pack/goody/smg
	name = "Saber SMG"
	desc = "Contains one NT Saber SMG, chambered in 9mm. Never know when you need it."
	cost = 10000
	contains = list(/obj/item/gun/ballistic/automatic/proto)

/datum/supply_pack/goody/smg_ammo
	name = "9mm SMG Magazine"
	desc = "Contains 2 high capacity 9mm magazines."
	cost = 3500
	contains = list(/obj/item/ammo_box/magazine/smgm9mm,
					/obj/item/ammo_box/magazine/smgm9mm)

/datum/supply_pack/goody/shotgun
	name = "Hunting Shotgun"
	desc = "Contains one hunting-grade shotgun. Never know when you need it."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/shotgun/lethal)

/datum/supply_pack/goody/riot_shotgun
	name = "Riot Shotgun"
	desc = "Contains one riot shotgun. Never know when you need it."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/shotgun/riot)

/datum/supply_pack/goody/bulldog_shotgun
	name = "Assault Shotgun"
	desc = "Contains one automatic bulldog shotgun. Never know when you need it."
	cost = 10000
	contains = list(/obj/item/gun/ballistic/automatic/shotgun/bulldog/unrestricted)

/datum/supply_pack/goody/shotgun_ammo
	name = "Shotgun Slugs"
	desc = "Contains 2 stripper of 12g slugs."
	cost = 1500
	contains = list(/obj/item/ammo_box/shotgun/loaded,
					/obj/item/ammo_box/shotgun/loaded)

/datum/supply_pack/goody/mosin
	name = "Bolt Action Rifle"
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
	name = ".45 Pistol Magazine"
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
	name = "10mm Pistol Magazine"
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
	name = "9mm Pistol Magazine"
	desc = "Contains 2 ML Nangler magazines. Never know when you need it."
	cost = 1500
	contains = list(/obj/item/ammo_box/magazine/nangler,
					/obj/item/ammo_box/magazine/nangler)

/datum/supply_pack/goody/blackbaton
	name = "Black Police Baton"
	desc = "A sturdy police baton. Never know when you need it."
	cost = 1500
	contains = list(/obj/item/melee/classic_baton/black)

/datum/supply_pack/goody/telescopic_baton
	name = "Telescopic Baton"
	desc = "A sturdy extendable baton. Never know when you need it."
	cost = 5000
	contains = list(/obj/item/melee/classic_baton/telescopic)
