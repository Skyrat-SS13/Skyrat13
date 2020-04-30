/* TEMPLATE
	unique_reskin_icons = list(
	)
	unique_reskin_worn = list(
	)
	unique_reskin_worn_anthro = list(
	)
	unique_reskin = list(
	)
*/
//port tg's armor energy resists, adds reskins to various armors
/obj/item/clothing/head/helmet
	can_flashlight = 0 //for the sake of reskins
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Press" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"HECU" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"HECU Green" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Press" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"HECU" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"HECU Green" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Press" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"HECU" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"HECU Green" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin = list(
	"Default" = "helmet",
	"Tactical" = "epic_helmet",
	"Press" = "press_helmet",
	"HECU" = "hecu_helmet",
	"HECU Green" = "hecu_green_helmet"
	)

/obj/item/clothing/head/helmet/alt
	can_flashlight = 1
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	unique_reskin_icons = list(
	"Default" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	)
	unique_reskin = list(
	"Default" = "helmetalt",
	"Tactical" = "epic_bp_helmet"
	)

/obj/item/clothing/suit/radiation
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Hazmat" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "rad",
	"Hazmat" = "hazmat_suit",
	)

/obj/item/clothing/head/radiation
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Hazmat" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head_muzzled.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi',
	)
	unique_reskin = list(
	"Default" = "rad",
	"Hazmat" = "hazmat_hood",
	)

/obj/item/clothing/suit/bio_suit
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Hazmat" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "rad",
	"Hazmat" = "hazmat_hood",
	)

/obj/item/clothing/head/bio_hood
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Hazmat" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head_muzzled.dmi',
	"Hazmat" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi',
	)
	unique_reskin = list(
	"Default" = "bio",
	"Hazmat" = "hazmat_hood",
	)

/obj/item/clothing/head/helmet/riot
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/swat
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 50, "bio" = 90, "rad" = 20, "fire" = 50, "acid" = 50)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Skulldozer" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Skulldozer" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head_muzzled.dmi',
	"Skulldozer" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Default" = "swat",
	"Skulldozer" = "chonker_helmet"
	)

/obj/item/clothing/head/helmet/thunderdome
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/roman
	armor = list("melee" = 25, "bullet" = 0, "laser" = 25, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/roman/fake
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/helmet/redtaghelm
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/bluetaghelm
	armor = list("melee" = 15, "bullet" = 10, "laser" = 20,"energy" = 10, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/knight
	armor = list("melee" = 50, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/skull
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/durathread
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 40, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/rus_helmet
	armor = list("melee" = 25, "bullet" = 30, "laser" = 0, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 20, "fire" = 20, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/rus_ushanka
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 20, "bio" = 50, "rad" = 20, "fire" = -10, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/caphat
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/hopcap
	armor = list("melee" = 25, "bullet" = 15, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/fedora/det_hat
	armor = list("melee" = 25, "bullet" = 5, "laser" = 25, "energy" = 35, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 50)

/obj/item/clothing/head/beret/durathread
	armor = list("melee" = 15, "bullet" = 5, "laser" = 15, "energy" = 25, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 5)

/obj/item/clothing/head/HoS
	armor = list("melee" = 40, "bullet" = 30, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 10, "rad" = 0, "fire" = 50, "acid" = 60)
	unique_reskin = list(
	"Default" = "hoscap",
	"Helmet" = "helmet",
	"Beret" = "hosberetblack",
	"Centcom Beret" = "beret_centcom_officer"
	)

/obj/item/clothing/head/HoS/beret/syndicate
	unique_reskin = list(
	)

/obj/item/clothing/head/warden
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 60)
	unique_reskin = list(
	"Default" = "policehelm",
	"Navy Beret" = "helmet",
	"Corporate Beret" = "beret_corporate_warden",
	"Red Security Beret" = "beret_badge",
	"Helmet" = "helmet"
	)

/obj/item/clothing/head/beret/sec
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 50)
	unique_reskin_icons = list(
	"Default" = "icons/obj/clothing/hats.dmi",
	"Solfed Contractor" = "modular_skyrat/icons/obj/clothing/hats.dmi",
	"Tactical" = "modular_skyrat/icons/obj/clothing/hats.dmi",
	"Green" = "modular_skyrat/icons/obj/clothing/hats.dmi"
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Solfed Contractor" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Green" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Solfed Contractor" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Green" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin = list(
	"Default" = "beret_badge",
	"Solfed Contractor" = "contractor_beret",
	"Tactical" = "tactical_beret",
	"Green" = "green_beret"
	)

/obj/item/clothing/head/beret/sec/navywarden
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/space/hardsuit
	armor = list("melee" = 10, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 50, "acid" = 75)
	unique_reskin = list(
	)

/obj/item/clothing/suit/space/hardsuit
	armor = list("melee" = 10, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 50, "acid" = 75)
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/space/hardsuit/engine
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/engine
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75)

/obj/item/clothing/head/helmet/space/hardsuit/engine/atmos
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 25, "fire" = 100, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/engine/atmos
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 25, "fire" = 100, "acid" = 75)

/obj/item/clothing/head/helmet/space/hardsuit/engine/elite
	armor = list("melee" = 40, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 90)

/obj/item/clothing/suit/space/hardsuit/engine/elite
	armor = list("melee" = 40, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 90)

/obj/item/clothing/head/helmet/space/hardsuit/mining
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 75)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Explorer" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Explorer" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head_muzzled.dmi',
	"Explorer" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit0-mining",
	"Explorer" = "hardsuit0-explorer",
	)

/obj/item/clothing/suit/space/hardsuit/mining
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 75)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Explorer" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Explorer" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Explorer" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "hardsuit-mining",
	"Explorer" = "hardsuit-explorer"
	)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/gun/energy/plasmacutter)

/obj/item/clothing/head/helmet/space/hardsuit/syndi
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90)

/obj/item/clothing/suit/space/hardsuit/syndi
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90)

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite
	armor = list("melee" = 60, "bullet" = 60, "laser" = 50, "energy" = 60, "bomb" = 55, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100)

/obj/item/clothing/suit/space/hardsuit/syndi/elite
	armor = list("melee" = 60, "bullet" = 60, "laser" = 50, "energy" = 60, "bomb" = 55, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100)

/obj/item/clothing/head/helmet/space/hardsuit/wizard
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 50, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)

/obj/item/clothing/suit/space/hardsuit/wizard
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 50, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)

/obj/item/clothing/head/helmet/space/hardsuit/medical
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/medical
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75)

/obj/item/clothing/head/helmet/space/hardsuit/rd
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 100, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 80)

/obj/item/clothing/suit/space/hardsuit/rd
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 100, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 80)

/obj/item/clothing/head/helmet/space/hardsuit/security
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "hardsuit0-sec"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	armor = list("melee" = 35, "bullet" = 15, "laser" = 30,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Riot" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Asset Protection" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"ODST" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Riot" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Asset Protection" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"ODST" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/head_muzzled.dmi',
	"Riot" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi',
	"Asset Protection" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi',
	"ODST" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Default" = "hardsuit0-sec",
	"Riot" = "hardsuit0-riot",
	"Tactical" = "hardsuit0-tactical",
	"Asset Protection" = "hardsuit0-assprotection",
	"ODST" = "hardsuit0-odst"
	)

/obj/item/clothing/suit/space/hardsuit/security
	armor = list("melee" = 35, "bullet" = 15, "laser" = 30,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Riot" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Asset Protection" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"ODST" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Riot" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Asset Protection" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"ODST" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Riot" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"Asset Protection" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"ODST" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Default" = "hardsuit-sec",
	"Riot" = "hardsuit-riot",
	"Tactical" = "hardsuit-tactical",
	"Asset Protection" = "hardsuit-assprotection",
	"ODST" = "hardsuit-odst"
	)

/obj/item/clothing/head/helmet/space/hardsuit/security/hos
	armor = list("melee" = 45, "bullet" = 25, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 95)
	unique_reskin = list(
	)

/obj/item/clothing/suit/space/hardsuit/security/hos
	armor = list("melee" = 45, "bullet" = 25, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 95)
	unique_reskin = list(
	)

/obj/item/clothing/suit/space/swat
	armor = list("melee" = 40, "bullet" = 50, "laser" = 50, "energy" = 60, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Skulldozer" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Skulldozer" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Skulldozer" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Default" = "heavy",
	"Skulldozer" = "chonker_suit"
	)

/obj/item/clothing/head/helmet/space/hardsuit/clown
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 60, "acid" = 30)

/obj/item/clothing/suit/space/hardsuit/clown
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/helmet/space/hardsuit/ancient
	armor = list("melee" = 30, "bullet" = 5, "laser" = 5, "energy" = 15, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/ancient
	armor = list("melee" = 30, "bullet" = 5, "laser" = 5, "energy" = 15, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/shielded
	armor = list("melee" = 30, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)

/obj/item/clothing/suit/space/hardsuit/shielded/ctf
	armor = list("melee" = 0, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 95)

/obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf
	armor = list("melee" = 0, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 95)

/obj/item/clothing/suit/space/hardsuit/shielded/syndi
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)

/obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)

/obj/item/clothing/suit/space/hardsuit/shielded/swat
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 60, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/clothing/head/helmet/space/hardsuit/shielded/swat
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 60, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/clothing/suit/armor
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Tactical Classic" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Press" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"HECU" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Bloody" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Tactical Classic" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Press" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"HECU" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Bloody" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Tactical Classic" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Press" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"HECU" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Bloody" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin = list(
	"Default" = "armor",
	"Tactical" = "epic_armor",
	"Tactical Classic" = "epic_armor_classic",
	"Press" = "press_armor",
	"HECU" = "hecu_armor",
	"Bloody" = "bloody_armor"
	)

/obj/item/clothing/suit/armor/hos
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 90)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Trench" = 'icons/obj/clothing/suits.dmi',
	"Cloak" = 'modular_citadel/icons/mob/citadel/suit.dmi',
	"Navy Blue" = 'icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Trench" = 'icons/mob/clothing/suit.dmi',
	"Cloak" = 'modular_citadel/icons/mob/citadel/suit.dmi',
	"Navy Blue" = 'icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Trench" = 'icons/mob/clothing/suit_digi.dmi',
	"Cloak" = 'modular_citadel/icons/mob/citadel/suit.dmi',
	"Navy blue" = 'icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Default" = "hos",
	"Trench" = "hostrench",
	"Cloak" = "hostrench",
	"Navy blue" = "hosbluejacket"
	)

/obj/item/clothing/suit/armor/vest/capcarapace
	armor = list("melee" = 50, "bullet" = 40, "laser" = 50, "energy" = 50, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 90)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/riot
	armor = list("melee" = 55, "bullet" = 20, "laser" = 15, "energy" = 25, "bomb" = 10, "bio" = 10, "rad" = 0, "fire" = 65, "acid" = 70)
	slowdown = 0
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/bone
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/bulletproof
	armor = list("melee" = 15, "bullet" = 60, "laser" = 10, "energy" = 10, "bomb" = 40, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "bulletproof",
	"Tactical" = "epic_bp_armor",
	)

/obj/item/clothing/suit/armor/laserproof
	armor = list("melee" = 10, "bullet" = 10, "laser" = 60, "energy" = 60, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/centcom
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/heavy
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/tdome
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 90)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/riot/knight/greyscale
	armor = list("melee" = 35, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 10, "rad" = 10, "fire" = 40, "acid" = 40)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/durathread
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 40, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 40, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/russian
	armor = list("melee" = 25, "bullet" = 30, "laser" = 0, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 20, "fire" = 20, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/russian_coat
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 20, "bio" = 50, "rad" = 20, "fire" = -10, "acid" = 50)
	unique_reskin = list(
	)

/obj/item/clothing/suit/det_suit
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 35, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/security/officer
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 35, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 45)

/obj/item/clothing/suit/security/warden
	armor = list("melee" = 35, "bullet" = 25, "laser" = 30, "energy" = 35, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 60)

/obj/item/clothing/suit/security/hos
	armor = list("melee" = 45, "bullet" = 35, "laser" = 35, "energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 90)

/obj/item/clothing/under/rank/security/officer
	can_adjust = FALSE //sorry but adjusting it with reskins would FUCK everything, sacrifice for the greater good
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/uniforms.dmi',
	"Tactical" = 'modular_skyrat/icons/obj/clothing/uniform.dmi',
	"Sol Federation" = 'modular_skyrat/icons/obj/clothing/uniform.dmi',
	"HECU" = 'modular_skyrat/icons/obj/clothing/uniform.dmi',
	"Firestarter" = 'modular_skyrat/icons/obj/clothing/uniform.dmi',
	"Gorka" = 'modular_skyrat/icons/obj/clothing/uniform.dmi',
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/uniform.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/uniform.dmi',
	"Sol Federation" = 'modular_skyrat/icons/mob/clothing/uniform.dmi',
	"HECU" = 'modular_skyrat/icons/mob/clothing/uniform.dmi',
	"Firestarter" = 'modular_skyrat/icons/mob/clothing/uniform.dmi',
	"Gorka" = 'modular_skyrat/icons/mob/clothing/uniform.dmi',
	)
	unique_reskin_worn_anthro = list(
	"Default" = 'icons/mob/clothing/uniform_digi.dmi',
	"Tactical" = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi',
	"Sol Federation" = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi',
	"HECU" = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi',
	"Firestarter" = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi',
	"Gorka" = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi',
	)
	unique_reskin = list(
	"Default" = "rsecurity",
	"Tactical" = "tactical_uniform",
	"Sol Federation" = "solfed_uniform",
	"HECU" = "hecu_uniform",
	"Firestarter" = "firestarter_uniform",
	"Gorka" = "gorka_uniform"
	)

/obj/item/clothing/under/rank/security/officer/blueshirt
	icon = 'icons/obj/clothing/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/uniform.dmi'
	anthro_mob_worn_overlay = 'icons/mob/clothing/uniform_digi.dmi'
	icon_state = "blueshift"
	item_state = "blueshift"
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/roman
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/gladiator
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/skull
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/knight
	unique_reskin = list(
	)

/obj/item/clothing/head/helmet/infiltrator
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/old
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/blueshirt
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/infiltrator
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/riot/knight
	unique_reskin = list(
	)

/obj/item/clothing/suit/armor/vest/warden
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_ALL_TAURIC
	taur_mob_worn_overlay = 'modular_skyrat/icons/mob/suits_taur.dmi'

/obj/item/clothing/suit/hooded/techpriest
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_ALL_TAURIC|STYLE_NO_ANTHRO_ICON
	taur_mob_worn_overlay = 'modular_skyrat/icons/mob/suits_taur.dmi'
