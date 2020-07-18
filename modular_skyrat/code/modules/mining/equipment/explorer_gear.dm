//seva shit
/obj/item/clothing/suit/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "seva"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Old" = 'icons/mob/clothing/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

/obj/item/clothing/head/hooded/explorer/seva
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "seva"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Old" = 'icons/mob/clothing/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

/obj/item/clothing/suit/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate, 3, /obj/item/stack/sheet/animalhide/goliath_hide, list("melee" = 5, "wound" = 3.5))

/obj/item/clothing/head/hooded/explorer/seva/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate, 3, /obj/item/stack/sheet/animalhide/goliath_hide, list("melee" = 5, "wound" = 3.5))

/obj/item/clothing/mask/gas/seva
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "seva"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/masks.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Old" = 'icons/mob/clothing/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "seva",
	"Improved" = "seva"
	)

//exosuit shit
/obj/item/clothing/suit/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "exo"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/suits.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/suit.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Old" = 'icons/mob/clothing/suit_digi.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

/obj/item/clothing/head/hooded/explorer/exo
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "exo"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/hats.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/head.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Old" = 'icons/mob/clothing/head_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

/obj/item/clothing/mask/gas/exo
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "exo"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	unique_reskin_icons = list(
	"Old" = 'icons/obj/clothing/masks.dmi',
	"Improved" = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	)
	unique_reskin_worn = list(
	"Old" = 'icons/mob/clothing/mask.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	)
	unique_reskin_worn_anthro = list(
	"Old" = 'icons/mob/clothing/mask_muzzled.dmi',
	"Improved" = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	)
	unique_reskin = list(
	"Old" = "exo",
	"Improved" = "exo"
	)

//dora the explorer suit
/obj/item/clothing/suit/hooded/explorer
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/gun/energy/plasmacutter)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/explorer
	flags_inv = HIDEEARS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/mask/gas/explorer
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 50, "wound" = 5)
	flags_inv = HIDEEYES|HIDEFACE|HIDESNOUT
	mutantrace_variation = STYLE_MUZZLE|STYLE_NO_ANTHRO_ICON

//mining hud glasses
/obj/item/clothing/glasses/hud/mining
	name = "ore scanner HUD"
	desc = "Essentially a worn version of the advanced mining scanner."
	icon = 'modular_skyrat/icons/obj/clothing/glasses.dmi'
	icon_state = "mininghud"
	mob_overlay_icon = 'modular_skyrat/icons/mob/eyes.dmi'
	var/mob/living/carbon/human/wearer
	cooldown = 30
	var/current_cooldown = 0
	var/range = 7

/obj/item/clothing/glasses/hud/mining/Initialize()
	. = ..()
	START_PROCESSING(SSfastprocess, src)

/obj/item/clothing/glasses/hud/mining/equipped(mob/living/carbon/human/user, slot)
	..()
	if(slot == ITEM_SLOT_EYES)
		wearer = user

/obj/item/clothing/glasses/hud/mining/dropped(mob/living/carbon/human/user)
	if (user.glasses == src && wearer == user)
		wearer = null
	..()

/obj/item/clothing/glasses/hud/mining/process()
	..()
	if((!current_cooldown || current_cooldown < world.time) && wearer)
		current_cooldown = world.time + cooldown
		var/turf/t = get_turf(wearer)
		mineral_scan_pulse(t, range)

/obj/item/clothing/glasses/hud/mining/prescription
	name = "prescription ore scanner HUD"
	desc = "Essentially a worn version of the advanced mining scanner. Helps the nearsighted."
	vision_correction = 1

/obj/item/clothing/glasses/hud/mining/sunglasses
	name = "sunglasses ore scanner HUD"
	desc = "Mine with style!"
	icon_state = "sunhudmine"
	darkness_view = 1
	flash_protect = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/hud/mining/prescription/sunglasses
	name = "prescription sunglasses ore scanner HUD"
	desc = "Mine with style! And without blurriness..."
	icon_state = "sunhudmine"
	darkness_view = 1
	flash_protect = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
/* this is quite buggy and doesn't work well
/obj/item/clothing/glasses/hud/mining/fauna
	name = "ore and fauna scanner HUD"
	desc = "Essentially a worn version of the advanced mining scanner, but also allows you to scan the health of fauna."
	hud_type = DATA_HUD_MEDICAL_BASIC
	storehud = TRUE

/obj/item/clothing/glasses/hud/mining/fauna/process()
	..()
	if(ourhud && wearer)
		for(var/mob/M in view(wearer, 15))
			if(!("mining" in M.faction))
				ourhud.remove_from_single_hud(wearer, M) //very hacky solution so only mining mob healths display

/obj/item/clothing/glasses/hud/mining/fauna/sunglasses
	name = "sunglasses ore and fauna scanner HUD"
	desc = "Mine with style! And apply a beating to goliaths with precision."
	icon_state = "sunhudmine"
	darkness_view = 1
	flash_protect = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen
*/
