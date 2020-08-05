/datum/supply_pack/medical/firstaidmixed
	name = "Mixed Medical Kits"
	desc = "Contains one of each medical kits for dealing with a variety of injured crewmembers."
	cost = 2000
	contains = list(/obj/item/storage/firstaid/toxin,
					/obj/item/storage/firstaid/o2,
					/obj/item/storage/firstaid/brute,
					/obj/item/storage/firstaid/fire,
					/obj/item/storage/firstaid/regular)
	crate_name = "medical kit crate"

/datum/supply_pack/medical/medipens
	name = "Epinephrine Medipens"
	desc = "Contains two boxes of epinephrine medipens. Each box contains seven pens."
	cost = 1300
	contains = list(/obj/item/storage/box/medipens,
                    /obj/item/storage/box/medipens)
	crate_name = "medipen crate"

/datum/supply_pack/medical/anesthetics
	name = "Anesthetics Crate"
	desc = "Contains two of the following: Morphine bottles, syringes, breath masks, anesthetic tanks, miners salve patches (40u). Requires Medical Access to open."
	access = ACCESS_MEDICAL
	cost = 3500
	contains = list(/obj/item/reagent_containers/glass/bottle/morphine,
                    /obj/item/reagent_containers/glass/bottle/morphine,
                    /obj/item/reagent_containers/syringe,
                    /obj/item/reagent_containers/syringe,
                    /obj/item/clothing/mask/breath,
                    /obj/item/clothing/mask/breath,
                    /obj/item/tank/internals/anesthetic,
                    /obj/item/tank/internals/anesthetic,
                    /obj/item/reagent_containers/pill/patch/salve,
                    /obj/item/reagent_containers/pill/patch/salve)
	crate_name = "anesthetics crate"
	crate_type = /obj/structure/closet/crate/secure/medical