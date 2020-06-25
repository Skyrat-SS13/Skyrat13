/obj/item/clothing/mask/gas/welding/visor_toggling(mob/user)
	. = ..()
	if(up && flags_inv & HIDEFACE)
		flags_inv -= HIDEFACE
	else if (!up && !(flags_inv & HIDEFACE))
		flags_inv |= HIDEFACE

//coldstorm's citadel donator item
/obj/item/clothing/mask/hheart
	name = "Hollow Heart"
	desc = "It's an odd ceramic mask. Set in the internal side are several suspicious electronics branded by Steele Tech."
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "hheart"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	var/c_color_index = 1
	var/list/possible_colors = list("off", "blue", "red")
	actions_types = list(/datum/action/item_action/hheart)

/obj/item/clothing/mask/hheart/Initialize()
	. = ..()
	update_icon()

/obj/item/clothing/mask/hheart/update_icon()
	. = ..()
	icon_state = "hheart-[possible_colors[c_color_index]]"

/datum/action/item_action/hheart
	name = "Toggle Mode"
	desc = "Toggle the color of the hollow heart."

/obj/item/clothing/mask/hheart/ui_action_click(mob/user, action)
	. = ..()
	if(istype(action, /datum/action/item_action/hheart))
		if(!isliving(user))
			return
		var/mob/living/ooser = user
		var/the = possible_colors.len
		var/index = 0
		if(c_color_index >= the)
			index = 1
		else
			index = c_color_index + 1
		c_color_index = index
		update_icon()
		ooser.update_inv_wear_mask()
		ooser.update_action_buttons_icon()
		to_chat(ooser, "<span class='notice'>You toggle the [src] to [possible_colors[c_color_index]].</span>")
