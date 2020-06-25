//EAU (DAB sounded better fuck you)
// Oh okay BobJoga. I'll switch name back to DAB, just 4u -Nopeman
/obj/item/clothing/suit/assu_suit
	desc = "A cheap replica of old SWAT armor. On its back, it is written: \"<i>Desperate Assistance Battleforce</i>\". Tacticool-ish, but not protective."
	armor = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 1, "bio" = 1, "rad" = 1, "fire" = 1, "acid" = 1, "wound" = 2)
	mutantrace_variation = STYLE_DIGITIGRADE
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman, /obj/item/toy)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/suits.dmi',
	"Bluetide" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Medical Assistant" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Engineering Assistant" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Service Assistant" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Science Assistant" = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/suit.dmi',
	"Bluetide" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Medical Assistant" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Engineering Assistant" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Service Assistant" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Science Assistant" = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	)
	unique_reskin_worn_digi = list(
	"Default" = 'icons/mob/clothing/suit_digi.dmi',
	"Bluetide" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"Medical Assistant" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"Engineering Assistant" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"Service Assistant" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi',
	"Science Assistant" = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	)
	unique_reskin = list(
	"Default" = "assu_suit",
	"Bluetide" = "assu_suit_blue",
	"Medical Assistant" = "assu_suit_med",
	"Engineering Assistant" = "assu_suit_eng",
	"Service Assistant" = "assu_suit_srv",
	"Science Assistant" = "assu_suit_sci",
	)
	mutantrace_variation = STYLE_DIGITIGRADE

//ablative coat from tg
/obj/item/clothing/head/hooded/ablative
	name = "ablative hood"
	desc = "Hood hopefully belonging to an ablative trenchcoat. Includes a visor for cool-o-vision."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON
	icon_state = "ablativehood"
	item_state = "ablativehood"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 60, "energy" = 50, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "wound" = 20)
	strip_delay = 30
	var/hit_reflect_chance = 50
	var/hud_type = DATA_HUD_SECURITY_ADVANCED
	var/list/protected_zones = list(BODY_ZONE_HEAD)
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/hooded/ablative/equipped(mob/living/carbon/human/user, slot)
	..()
	to_chat(user, "As you put on the hood, a visor shifts into place and starts analyzing the people around you. Neat!")
	var/datum/atom_hud/H = GLOB.huds[hud_type]
	H.add_hud_to(user)

/obj/item/clothing/head/hooded/ablative/dropped(mob/living/carbon/human/user)
	to_chat(user, "You take off the hood, removing the visor in the process and disabling its integrated hud.")
	if(hud_type && istype(user) && user.head == src)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user)
	..()

/obj/item/clothing/head/hooded/ablative/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(def_zone in protected_zones)
		if(prob(hit_reflect_chance))
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()



/obj/item/clothing/suit/hooded/ablative
	name = "ablative trenchcoat"
	desc = "Experimental trenchcoat specially crafted to reflect and absorb laser and disabler shots. Don't expect it to do all that much against an ax or a shotgun, however."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	icon_state = "ablativecoat"
	item_state = "ablativecoat"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 15, "bullet" = 15, "laser" = 60, "energy" = 65, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "wound" = 20)
	hoodtype = /obj/item/clothing/head/hooded/ablative
	strip_delay = 30
	equip_delay_other = 40
	var/hit_reflect_chance = 50
	var/list/protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/hooded/ablative/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/hooded/ablative/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(def_zone in protected_zones)
		if(prob(hit_reflect_chance))
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/wornshirt
	name = "worn shirt"
	desc = "A worn out (or perhaps just baggy), curiously comfortable t-shirt."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	icon_state = "wornshirt"
	item_state = "labcoat"
	body_parts_covered = CHEST|GROIN
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	unique_reskin_icons = list(
	"Default" = 'modular_skyrat/icons/obj/clothing/suits.dmi',
	"Ian" = 'icons/obj/clothing/suits.dmi',
	"Gamer" = 'icons/obj/clothing/suits.dmi',
	"Vaper" = 'icons/obj/clothing/suits.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'modular_skyrat/icons/mob/clothing/suit.dmi',
	"Ian" = 'icons/mob/clothing/suit.dmi',
	"Gamer" = 'icons/mob/clothing/suit.dmi',
	"Vaper" = 'icons/mob/clothing/suit.dmi'
	)
	unique_reskin = list(
	"Default" = "wornshirt",
	"Ian" = "ianshirt",
	"Gamer" = "nerdshirt",
	"Vaper" = "vapeshirt"
	)
	unique_name = list(
	"Default" = "worn shirt",
	"Ian" = "comfy shirt",
	"Gamer" = "gamer shirt",
	"Vaper" = "\improper Vape Naysh shirt"
	)
	unique_desc = list(
	"Default" = "A worn out (or perhaps just baggy), curiously comfortable t-shirt. Good for sleeping in.",
	"Ian" = "A worn out, curiously comfortable t-shirt with a picture of Ian. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in.",
	"Gamer" = "A baggy shirt with vintage game character... Why would anyone wear this?",
	"Vaper" = "A cheap white T-shirt with a big tacky \"VN\" on the front... Why would anyone wear this unironically?"
	)

/obj/item/clothing/suit/wornshirt/polychromic
	name = "polychromic worn shirt"
	unique_reskin = null

/obj/item/clothing/suit/wornshirt/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF"), 1)
