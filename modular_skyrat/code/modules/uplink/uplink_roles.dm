//miner exclusives
/*
/datum/uplink_item/role_restricted/crusher
	name = "Harmful Crusher"
	desc = "A kinetic crusher with the ability to harm complex and small lifeforms. Looks like a normal crusher from a distance."
	item = /obj/item/twohanded/kinetic_crusher/harm
	cost = 15
	limited_stock = 1
	restricted_roles = list("Shaft Miner", "Quartermaster")

/datum/uplink_item/role_restricted/pka_tenmm
	name = "10mm Proto-Kinetic Accelerator"
	desc = "An accelerator loaded in 10mm bullets. Accepts normal PKA mods and suffers no pressure penalty, and looks like a normal accelerator from a distance."
	item = /obj/item/gun/energy/kinetic_accelerator/tenmm
	cost = 15
	limited_stock = 1
	restricted_roles = list("Shaft Miner", "Quartermaster")

/datum/uplink_item/role_restricted/pka_nopenalty
	name = "On-station Proto-Kinetic Accelerator"
	desc = "An accelerator that receives no penalties from pressure increases."
	item = /obj/item/gun/energy/kinetic_accelerator/nopenalty
	cost = 15
	limited_stock = 1
	restricted_roles = list("Shaft Miner", "Quartermaster")
*/
//engineer/atmos tech exclusives
/datum/uplink_item/role_restricted/powergloves
	name = "Not-tendo(TM) Power Gloves"
	desc = "Rechargeable gloves that are capable of stunning targets and throwing lightning at them."
	item = /obj/item/clothing/gloves/color/yellow/power
	cost = 12
	limited_stock = 1
	restricted_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")

//clown
/datum/uplink_item/role_restricted/clumsyDNA
	name = "Clumsy Clown DNA"
	desc = "A DNA injector that has been loaded with the clown gene that makes people clumsy.. \
	Making someone clumsy will allow them to use clown firing pins as well as Reverse Revolvers. For a laugh try using this on the HOS to see how many times they shoot themselves in the foot!"
	cost = 1
	item = /obj/item/dnainjector/clumsymut
	restricted_roles = list("Clown")

//botanist
/datum/uplink_item/role_restricted/strange_seeds_25pack
	name = "Pack of strange seeds x25"
	desc = "Mysterious seeds as strange as their name implies. Spooky. These come in a lot."
	item = /obj/item/storage/box/strange_seeds_25pack
	cost = 20
	restricted_roles = list("Botanist")

/datum/uplink_item/role_restricted/strange_seeds_10pack
	name = "Pack of strange seeds x10"
	desc = "Mysterious seeds as strange as their name implies. Spooky. These come in bulk."
	item = /obj/item/storage/box/strange_seeds_10pack
	cost = 10
	restricted_roles = list("Botanist")

/datum/uplink_item/role_restricted/strange_seeds
	name = "Pack of strange seeds"
	desc = "Mysterious seeds as strange as their name implies. Spooky."
	item = /obj/item/seeds/random
	cost = 2
	restricted_roles = list("Botanist")
	illegal_tech = FALSE

/datum/uplink_item/dangerous/nettlebane
	name = "Mors Plant"
	desc = "A dagger. As effective as a combat knife, with the added benefit of causing death on any plant matter instantaneously."
	item = /obj/item/kitchen/knife/combat/nettlebane
	cost = 12
	restricted_roles = list("Botanist")
	exclude_modes = list(/datum/game_mode/nuclear/clown_ops)

/datum/uplink_item/role_restricted/syndicatejack
	name = "Syndicate Cyborg Module"
	desc = "An illegally modified module-board, holding all the neccesary tools and abilities for near-perfect sabotage and support. Due to its relatively experimental nature, it will only work on cyborgs which have already been jailbroken by an electromagnetic sequencer. "
	item = /obj/item/borg/upgrade/transform/syndicatejack
	cost = 5
	restricted_roles = list("Roboticist")