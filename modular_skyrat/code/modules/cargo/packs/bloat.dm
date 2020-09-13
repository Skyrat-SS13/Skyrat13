//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.

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
	desc = "Contains two tactical energy guns, these guns are able to tase, disable and lethal. They are also able to hold a seclight. Requires Armory access to open."
	cost = 7000
	contains = list(/obj/item/gun/energy/e_gun/stun,
					/obj/item/gun/energy/e_gun/stun)
	crate_name = "swat taser crate"

/datum/supply_pack/security/armory/swat_tactical
	name = "SWAT Tactical Operations crate"
	desc = "Contains two sets of lightweight equipment for tactical operations. Each set contains a vest, night vision helmet, mask, combat belt, and combat gloves. Requires Armory access to open."
	cost = 6000
	contains = list(/obj/item/clothing/head/helmet/advanced,
					/obj/item/clothing/head/helmet/advanced,
					/obj/item/clothing/suit/armor/vest/advanced,
					/obj/item/clothing/suit/armor/vest/advanced,
					/obj/item/clothing/mask/gas/sechailer/swat,
					/obj/item/clothing/mask/gas/sechailer/swat,
					/obj/item/storage/belt/military/assault,
					/obj/item/storage/belt/military/assault,
					/obj/item/clothing/gloves/tackler/combat/insulated,
					/obj/item/clothing/gloves/tackler/combat/insulated)
	crate_name = "swat crate"

/datum/supply_pack/security/armory/woodstock
	name = "WoodStock Classic Shotguns Crate"
	desc = "Contains three rustic, pump action shotguns. Requires Armory access to open."
	cost = 3000
	contains = list(/obj/item/gun/ballistic/shotgun,
					/obj/item/gun/ballistic/shotgun,
					/obj/item/gun/ballistic/shotgun)
	crate_name = "woodstock shotguns crate"

/datum/supply_pack/security/armory/wt550ammo_special
	name = "WT-550 Semi-Auto SMG Special Ammo Crate"
	desc = "Contains two 20-round Armour Piercing and Incendiary magazines for the WT-550 Semi-Auto SMG. Each magazine is designed to facilitate rapid tactical reloads. Requires Armory access to open."
	cost = 3000
	contains = list(/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtap,
					/obj/item/ammo_box/magazine/wt550m9/wtic,
					/obj/item/ammo_box/magazine/wt550m9/wtic)
	crate_name = "auto rifle ammo crate"

/datum/supply_pack/science/nuke_b_gone
	name = "Nuke Defusal Kit"
	desc = "Contains a set of tools to defuse a nuke."
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

