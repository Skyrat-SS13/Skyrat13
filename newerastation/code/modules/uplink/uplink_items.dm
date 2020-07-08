/datum/uplink_item/ammo/revolver
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/revolver //no OP revolver - get creative with your kills.
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/bladeofwoe
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/contender
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/cxneb
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/ebonyblade
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/rapier
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/mehrunesrazor
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/molagmace
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/sword
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/dangerous/doublesword
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/explosives/detomatix
	exclude_modes = list(/datum/game_mode/infiltration) //stealthhhh!

/datum/uplink_item/explosives/syndicate_minibomb
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/explosives/syndicate_bomb
	exclude_modes = list(/datum/game_mode/infiltration) //no blowing shit up

/datum/uplink_item/explosives/syndicate_bomb_he
	exclude_modes = list(/datum/game_mode/infiltration)

/datum/uplink_item/explosives/c4bag
	exclude_modes = list(/datum/game_mode/infiltration) //you don't need to be blowing that much shit up!

/datum/uplink_item/explosives/x4bag
	exclude_modes = list(/datum/game_mode/infiltration) //you don't need to be blowing that much shit up!

/datum/uplink_item/stealthy_weapons/cqc //standard cqc is fine
	include_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/stealthy_weapons/martialarts //but sleeping carp is a bit too much
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/stealthy_weapons/martialartstwo
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/stealthy_weapons/romerol_kit
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/infiltration)

/datum/uplink_item/device_tools/powersink
	exclude_modes = list(/datum/game_mode/infiltration) //if they have this objective, they get a special one

/datum/uplink_item/device_tools/singularity_beacon
	exclude_modes = list(/datum/game_mode/infiltration) //no.

/datum/uplink_item/suits/infiltrator_bundle //this is an "infiltrator" bundle, but it isn't really that stealty.
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/badass/balloon
	exclude_modes = list(/datum/game_mode/infiltration) //no.

/datum/uplink_item/bundles_TC/bundle
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/infiltration)

/datum/uplink_item/bundles_TC/contract_kit
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/bundles_TC/ghostface
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/bundles_TC/punished //The clap of the asscheeks is just wayyy too loud
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

/datum/uplink_item/bundles_TC/reroll
	exclude_modes = list(/datum/game_mode/infiltration)

/datum/uplink_item/bundles_TC/northstar_bundle
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops, /datum/game_mode/infiltration)

//Infiltrator shit
/datum/uplink_item/infiltration
	category = "Infiltration Gear"
	include_modes = list(/datum/game_mode/infiltration)
	surplus = 0

/datum/uplink_item/infiltration/pinpointer_upgrade
	name = "Pinpointer Upgrade"
	desc = "An infiltration pinpointer upgrade that allows pinpointers to track objective targets."
	item = /obj/item/infiltrator_pinpointer_upgrade
	cost = 8

/datum/uplink_item/infiltration/extra_stealthsuit
	name = "Extra Chameleon Hardsuit"
	desc = "An infiltration hardsuit, capable of changing it's appearance instantly."
	item = /obj/item/clothing/suit/space/hardsuit/infiltration
	cost = 10

// Events
/datum/uplink_item/services
	category = "Services"
	include_modes = list(/datum/game_mode/infiltration, /datum/game_mode/nuclear)
	surplus = 0

/datum/uplink_item/services/manifest_spoof
	name = "Crew Manifest Spoof"
	desc = "A button capable of adding a single person to the crew manifest."
	item = /obj/item/service/manifest
	cost = 10 //Maybe this is too cheap??

/datum/uplink_item/services/fake_ion
	name = "Fake Ion Storm"
	desc = "Fakes an ion storm announcement. A good distraction, especially if the AI is weird anyway."
	item = /obj/item/service/ion
	cost = 7

/datum/uplink_item/services/fake_meteor
	name = "Fake Meteor Announcement"
	desc = "Fakes an meteor announcement. A good way to get any C4 on the station exterior, or really any small explosion, brushed off as a meteor hit."
	item = /obj/item/service/meteor
	cost = 7

/datum/uplink_item/services/fake_rod
	name = "Fake Immovable Rod"
	desc = "Fakes an immovable rod announcement. Good for a short-lasting distraction."
	item = /obj/item/service/rodgod
	cost = 6 //less likely to be believed
