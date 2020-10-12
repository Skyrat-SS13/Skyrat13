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

/datum/supply_pack/goody/nangler
	name = "9mm Pistol"
	desc = "Contains one ML Nangler pistol. Never know when you need it."
	cost = 2000
	contains = list(/obj/item/gun/ballistic/automatic/pistol/nangler)

/datum/supply_pack/goody/nangler_ammo
	name = "9mm Magazine"
	desc = "Contains 3 ML Nangler magazines. Never know when you need it."
	cost = 1000
	contains = list(/obj/item/ammo_box/magazine/nangler)

/datum/supply_pack/goody/blackbaton
	name = "Black Police Baton"
	desc = "A sturdy police baton. Never know when you need it."
	cost = 1500
	contains = list(/obj/item/melee/classic_baton/black)

/datum/supply_pack/goody/telescopic_baton
	name = "Telescopic Baton"
	desc = "A sturdy extendable baton. Never know when you need it."
	cost = 5000
	contains = list(/obj/item/melee/classic_baton/extendable)
