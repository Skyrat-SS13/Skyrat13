/*
 *Civil Protection
 */
/obj/item/clothing/under/rank/security/civilprotection
	name = "Civil Protection uniform"
	desc = "Pick up that can."
	icon = 'modular_skyrat/icons/obj/clothing/uniform.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/uniform.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "cpuniform"
	item_state = "cpuniform"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE
	unique_reskin_stored = list(
	)
//Civil Protection
/obj/item/clothing/under/rank/security/civilprotection/fake
	name = "Civil Protection replica uniform"
	desc = "No inner armoring, but full of combine style."
	icon_state = "cpcasual"
	item_state = "cpcasual"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 0)

//Blueshield
/obj/item/clothing/under/rank/security/blueshield
	desc = "Gold trim on space-black cloth, this uniform bears \"Blueshield\" on the left shoulder."
	name = "Blueshield Uniform"
	icon = 'modular_skyrat/icons/obj/clothing/uniform.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/uniform.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "blueshield"
	item_state = "blueshield"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 10, "bomb" =10, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 15)
	can_adjust = FALSE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/rank/security/blueshieldturtleneck
	name = "Blueshield's turtleneck"
	desc = "A stylish alternative to the normal Blueshield's Uniform, complete with tactical pants."
	icon = 'modular_skyrat/icons/obj/clothing/uniform.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/uniform.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "bs_turtleneck"
	item_state = "bs_turtleneck"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 10, "bomb" =10, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 15)
	can_adjust = FALSE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE
