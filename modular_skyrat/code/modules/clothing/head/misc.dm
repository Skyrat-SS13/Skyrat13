/obj/item/clothing/head/goatpelt
	name = "goat pelt hat"
	desc = "Fuzzy and Warm!"
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "goatpelt"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	item_state = "goatpelt"

/obj/item/clothing/head/goatpelt/king
	name = "king goat pelt hat"
	desc = "Fuzzy, Warm and Robust!"
	icon_state = "goatpelt"
	item_state = "goatpelt"
	color = "#ffd700"
	body_parts_covered = HEAD
	armor = list("melee" = 60, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 20, "rad" = 20, "fire" = 100, "acid" = 100)
	dog_fashion = null
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/goatpelt/king/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		user.faction |= "goat"

/obj/item/clothing/head/goatpelt/king/dropped(mob/living/carbon/human/user)
	if (user.head == src)
		user.faction -= "goat"
	..()

/obj/item/clothing/head/goatpope
	name = "goat pope hat"
	desc = "And on the seventh day King Goat said there will be cabbage!"
	mob_overlay_icon = 'modular_skyrat/icons/mob/large-worn-icons/64x64/head.dmi'
	icon_state = "goatpope"
	item_state = "goatpope"
	worn_x_dimension = 64
	worn_y_dimension = 64
	resistance_flags = FLAMMABLE

/obj/item/clothing/head/goatpope/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		user.faction |= "goat"

/obj/item/clothing/head/goatpope/dropped(mob/living/carbon/human/user, slot)
	if (user.head == src)
		user.faction -= "goat"
	..()

/obj/item/clothing/head/assu_helmet
	desc = "A cheap replica of a helmet. It has \"D.A.B.\" written on the front. Doesn't help against stun batons to the head."
	armor = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 1, "bio" = 1, "rad" = 1, "fire" = 1, "acid" = 1)
	unique_reskin_icons = list(
	"Default" = 'icons/obj/clothing/hats.dmi',
	"Bluetide" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Alternative" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Alternative Bluetide" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Medical Assistant" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Engineering Assistant" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Service Assistant" = 'modular_skyrat/icons/obj/clothing/hats.dmi',
	"Science Assistant" = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	)
	unique_reskin_worn = list(
	"Default" = 'icons/mob/clothing/head.dmi',
	"Bluetide" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Alternative" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Alternative Bluetide" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Medical Assistant" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Engineering Assistant" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Service Assistant" = 'modular_skyrat/icons/mob/clothing/head.dmi',
	"Science Assistant" = 'modular_skyrat/icons/mob/clothing/head.dmi'
	)
	unique_reskin = list(
	"Default" = "assu_helmet",
	"Bluetide" = "assu_helmet_blue",
	"Alternative" = "assu_helmet_alt",
	"Alternative Bluetide" = "assu_helmet_alt_blue",
	"Medical Assistant" = "assu_helmet_med",
	"Engineering Assistant" = "assu_helmet_eng",
	"Service Assistant" = "assu_helmet_srv",
	"Science Assistant" = "assu_helmet_sci"
	)

//yee haw
/obj/item/clothing/head/cowboydark
	name = "dark cowboy hat"
	desc = "People with ropes around their necks don't always hang."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_black"


/obj/item/clothing/head/cowboywide
	name = "wide brimmed cowboy hat"
	desc = "Aim for the heart Ramone."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	icon_state = "cowboy_wide"

//bo stuff
/obj/item/clothing/head/bocap
	name = "bridge officer cap"
	desc = "For a person with no authority who takes themselves very VERY seriously."
	icon_state = "bridgeofficerhard"

/obj/item/clothing/head/bohat
	name = "bridge officer hat"
	desc = "For a person with no authority who takes themselves very seriously."
	icon_state = "bridgeofficersoft"



