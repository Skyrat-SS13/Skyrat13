/*
 *Civil Protection
 */
/obj/item/clothing/under/rank/security/civilprotection
	name = "Civil Protection uniform"
	desc = "Pick up that can."
	icon = 'modular_skyrat/icons/obj/clothing/uniforms.dmi'
	alternate_worn_icon = 'modular_skyrat/icons/mob/uniform.dmi'
	icon_state = "cpuniform"
	item_state = "cpuniform"
	item_color = null
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/civilprotection/fake
	name = "Civil Protection replica uniform"
	desc = "No inner armoring, but full of combine style."
	item_state = "cpcasual"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)