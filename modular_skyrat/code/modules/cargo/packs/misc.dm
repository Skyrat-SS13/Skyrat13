
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.

//////////////////////////////////////////////////////////////////////////////
////////////////////////// Headset Encyption Keys ////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/misc/encryption/bin_key
	name = "Binary Headset Encryption Key"
	desc = "A highly illegal item found within the depths of the blackmarket."
	cost = 5000
	hidden = TRUE
	contains = list(/obj/item/encryptionkey/binary)
	crate_name = "binary headset encryption crate"
	crate_type = /obj/structure/closet/crate/engineering

/datum/supply_pack/misc/encryption/com_key
	name = "Command Headset Encryption Key"
	desc = "Spare command headset encryption keys. Requires captain level access to open."
	cost = 2500
	access = ACCESS_CAPTAIN
	contains = list(/obj/item/encryptionkey/headset_com, /obj/item/encryptionkey/headset_com, /obj/item/encryptionkey/headset_com)
	crate_name = "command headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure/weapon

/datum/supply_pack/misc/encryption/eng_key
	name = "Engineer Headset Encryption Key"
	desc = "Spare engineering headset encryption keys. Requires engineering access to open."
	cost = 1250
	access = ACCESS_ENGINE
	contains = list(/obj/item/encryptionkey/headset_eng, /obj/item/encryptionkey/headset_eng, /obj/item/encryptionkey/headset_eng)
	crate_name = "engineer headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/encryption/med_key
	name = "Medical Headset Encryption Key"
	desc = "Spare medical headset encryption keys. Requires medical access to open."
	cost = 1500
	access = ACCESS_MEDICAL
	contains = list(/obj/item/encryptionkey/headset_med, /obj/item/encryptionkey/headset_med, /obj/item/encryptionkey/headset_med)
	crate_name = "medical headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/encryption/sci_key
	name = "Science Headset Encryption Key"
	desc = "Spare science headset encryption keys. Requires research access to open."
	cost = 1250
	access = ACCESS_RESEARCH
	contains = list(/obj/item/encryptionkey/headset_sci, /obj/item/encryptionkey/headset_sci, /obj/item/encryptionkey/headset_sci)
	crate_name = "science headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/encryption/sec_key
	name = "Security Headset Encryption Key"
	desc = "Spare security headset encryption keys. Requires armory access to open."
	cost = 2000
	access = ACCESS_ARMORY
	contains = list(/obj/item/encryptionkey/headset_sec, /obj/item/encryptionkey/headset_sec, /obj/item/encryptionkey/headset_sec,)
	crate_name = "security headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure/weapon


/datum/supply_pack/misc/encryption/serv_key
	name = "Service Headset Encryption Key"
	desc = "Spare service headset encryption keys. Requires HoP access to open."
	cost = 1250
	access = ACCESS_HOP
	contains = list(/obj/item/encryptionkey/headset_service, /obj/item/encryptionkey/headset_service, /obj/item/encryptionkey/headset_service)
	crate_name = "service headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/encryption/supply_key
	name = "Supply Headset Encryption Key"
	desc = "Spare supply headset encryption keys. Requires cargo access to open."
	cost = 1250
	access = ACCESS_CARGO
	contains = list(/obj/item/encryptionkey/headset_cargo, /obj/item/encryptionkey/headset_cargo, /obj/item/encryptionkey/headset_cargo)
	crate_name = "supply headset encryption crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/misc/carpet_premium
	name = "Premium Carpet Crate"
	desc = "Plasteel floor tiles getting on your nerves? These stacks of extra soft carpet will tie any room together. Contains some classic carpet, along with black, red, and monochrome varients."
	cost = 1350
	contains = list(/obj/item/stack/tile/carpet/fifty,
					/obj/item/stack/tile/carpet/fifty,
					/obj/item/stack/tile/carpet/black/fifty,
					/obj/item/stack/tile/carpet/black/fifty,
					/obj/item/stack/tile/carpet/blackred/fifty,
					/obj/item/stack/tile/carpet/blackred/fifty,
					/obj/item/stack/tile/carpet/monochrome/fifty,
					/obj/item/stack/tile/carpet/monochrome/fifty)
	crate_name = "premium carpet crate"


/datum/supply_pack/misc/carpet_exotic
	name = "Exotic Carpet Crate"
	desc = "Exotic carpets straight from Space Russia, for all your decorating needs. Contains 100 tiles each of 10 different flooring patterns."
	cost = 7000
	contains = list(/obj/item/stack/tile/carpet/blue/fifty,
					/obj/item/stack/tile/carpet/blue/fifty,
					/obj/item/stack/tile/carpet/cyan/fifty,
					/obj/item/stack/tile/carpet/cyan/fifty,
					/obj/item/stack/tile/carpet/green/fifty,
					/obj/item/stack/tile/carpet/green/fifty,
					/obj/item/stack/tile/carpet/orange/fifty,
					/obj/item/stack/tile/carpet/orange/fifty,
					/obj/item/stack/tile/carpet/purple/fifty,
					/obj/item/stack/tile/carpet/purple/fifty,
					/obj/item/stack/tile/carpet/red/fifty,
					/obj/item/stack/tile/carpet/red/fifty,
					/obj/item/stack/tile/carpet/royalblue/fifty,
					/obj/item/stack/tile/carpet/royalblue/fifty,
					/obj/item/stack/tile/carpet/royalblack/fifty,
					/obj/item/stack/tile/carpet/royalblack/fifty,
					/obj/item/stack/tile/carpet/blackred/fifty,
					/obj/item/stack/tile/carpet/blackred/fifty,
					/obj/item/stack/tile/carpet/monochrome/fifty,
					/obj/item/stack/tile/carpet/monochrome/fifty)
	crate_name = "exotic carpet crate"
