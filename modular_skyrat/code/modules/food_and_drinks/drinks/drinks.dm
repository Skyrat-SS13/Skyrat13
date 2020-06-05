//maint energy and subtypes
/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy
	name = "Maintenance Energy"
	desc = "A popular energy drink all around the galaxy. Liked by Mercenaries, Pirates, Megacorporations, and you will like it too."
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_trash"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/maint_energy = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/zero_fusion
	name = "Maintenance Energy Zero Fusion"
	desc = "The galaxy's favorite energy drink, now with no calories and less sugar, but with all the energy you need. Unleash the tide!"
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy0"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_trash"
	list_reagents = list(/datum/reagent/consumable/maint_energy/zero_fusion = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/tritium_flood
	name = "Maintenance Energy Tritium Flood"
	desc = "Sometimes you need a break from the standard experience. Tritium Flood will open a canister of acid flavors in your mouth like no drink ever has before."
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy_tritflood"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_trash"
	list_reagents = list(/datum/reagent/consumable/maint_energy/tritium_flood = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/plasma_fire
	name = "Maintenance Energy Plasma Fire"
	desc = "You're gonna burn alright. The galaxy's favorite energy drink now in a spicy mango flavor, feel your throat heating up like the distro pipes but with all the refreshment you'll ever need."
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy_plasmafire"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_trash"
	list_reagents = list(/datum/reagent/consumable/maint_energy/plasma_fire = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/raid
	name = "Maintenance Energy Raid"
	desc = "The intense flavor of cherries with all the energy that you'll need, favored and approved by competitive thunderdome teams all around the sector!"
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy_raid"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_trash"
	list_reagents = list(/datum/reagent/consumable/maint_energy/raid = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/megaflavor
	name = "Maintenance Energy Megaflavor"
	desc = "The miners demanded it, and we gave it to them. This is everything you need after coming back from rock breaking and monster slaying, all compacted into a refreshing multifruit mix."
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy_megaflavor"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_trash"
	list_reagents = list(/datum/reagent/consumable/maint_energy/megaflavor = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/blood_red
	name = "Maintenance Energy Blood Red"
	desc = "Made in partnership with the Gorlex Marauders, Maintenance Energy Blood Red will fill you with the rage of a suited contractor, steel walls will feel like paper!"
	icon = 'modular_skyrat/icons/obj/drinks.dmi'
	icon_state = "maintenergy_bloodred"
	crushed_icon = 'modular_skyrat/icons/obj/janitor.dmi'
	crushed_state = "maintenergy_bloodred_trash"
	list_reagents = list(/datum/reagent/consumable/maint_energy/blood_red = 50)
	foodtype = SUGAR

/obj/item/storage/box/syndie_kit/sixpack
	name = "ME Blood Red Six Pack"
	desc = "Unleash the nuke."

/obj/item/storage/box/syndie_kit/sixpack/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/food/drinks/soda_cans/maint_energy/blood_red(src)
