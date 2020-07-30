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
