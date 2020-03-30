//fuck you citadel maintainers for removing all this cool shit _|_ (this is still a middle finger)
/datum/supply_pack/security/armory/riotshotguns
	name = "Riot Shotgun Crate"
	desc = "For when the greytide gets really uppity. Contains three riot shotguns, seven rubber shot and beanbag shells. Requires Armory access to open."
	cost = 6500
	contains = list(/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/gun/ballistic/shotgun/riot,
					/obj/item/storage/box/rubbershot,
					/obj/item/storage/box/beanbag)
	crate_name = "riot shotgun crate"

/datum/supply_pack/security/armory/swattasers //Lesser AEG tbh
	name = "SWAT tactical tasers Crate"
	desc = "Contains two tactical energy gun, these guns are able to tase, disable and lethal as well as hold a seclight. Requires Armory access to open."
	cost = 7000
	contains = list(/obj/item/gun/energy/e_gun/stun,
					/obj/item/gun/energy/e_gun/stun)
	crate_name = "swat taser crate"

/datum/supply_pack/security/armory/woodstock
	name = "WoodStock Classic Shotguns Crate"
	desc = "Contains three rustic, pumpaction shotguns. Requires Armory access to open."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/shotgun,
					/obj/item/gun/ballistic/shotgun,
					/obj/item/gun/ballistic/shotgun)
	crate_name = "woodstock shotguns crate"

/datum/supply_pack/security/armory/wt550ammo_special
	name = "WT-550 Semi-Auto SMG Special Ammo Crate"
	desc = "Contains 2 20-round Armour Piercing and Incendiary magazines for the WT-550 Semi-Auto SMG. Each magazine is designed to facilitate rapid tactical reloads. Requires Armory access to open."
	cost = 3000
	contains = list(/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtic,
					/obj/item/ammo_box/magazine/wt550m9/wtic)
	crate_name = "auto rifle ammo crate"

/datum/supply_pack/science/nuke_b_gone
	name = "Nuke Defusal Kit"
	desc = "Contains set of tools to defuse a nuke."
	cost = 7500 //Useful for traitors/nukies that fucked up
	dangerous = TRUE
	hidden = TRUE
	contains = list(/obj/item/nuke_core_container/nt,
					/obj/item/screwdriver/nuke/nt,
					/obj/item/paper/guides/nt/nuke_instructions)
	crate_name = "safe defusal kit storage"

/datum/supply_pack/science/supermater
	name = "Supermatter Extraction Tools Crate"
	desc = "Contains a set of tools to extract a sliver of supermatter. Consult your CE today!"
	cost = 7500 //Useful for traitors that fucked up
	hidden = TRUE
	contains = list(/obj/item/nuke_core_container/supermatter,
					/obj/item/scalpel/supermatter,
					/obj/item/hemostat/supermatter,
					/obj/item/paper/guides/antag/supermatter_sliver)
	crate_name = "supermatter extraction kit crate"

/datum/supply_pack/science/tech_slugs
	name = "Tech Slug Ammo Shells"
	desc = "A new type of shell that is able to be made into a few different dangerous types. Contains two boxes of tech slugs, 14 shells in all."
	cost = 1700
	contains = list(/obj/item/storage/box/techsslug,
					/obj/item/storage/box/techsslug)
	crate_name = "tech slug crate"

