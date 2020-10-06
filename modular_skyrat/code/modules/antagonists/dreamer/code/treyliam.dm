//Mostly garbage related to the ending "cutscene"
/obj/item/clothing/head/cyberdeck
	name = "cyberdeck headset"
	desc = "Sweet dreams..."
	icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/cyberdeck/cyberdeck.dmi'
	mob_overlay_icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/cyberdeck/cyberdeck_mob.dmi'
	icon_state = "cyberdeck"
	mutantrace_variation = STYLE_NO_ANTHRO_ICON
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100, "magic" = 100, "wound" = 100)

/datum/outfit/treyliam
	name = "Trey Liam"
	head = /obj/item/clothing/head/cyberdeck
	uniform = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	shoes = /obj/item/clothing/shoes/laceup

/obj/effect/landmark/treyliam
	name = "trey"
