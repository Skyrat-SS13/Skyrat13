/obj/item/clothing/mask/gas/welding/visor_toggling(mob/user)
	. = ..()
	if(up && flags_inv & HIDEFACE)
		flags_inv -= HIDEFACE
	else if (!up && !(flags_inv & HIDEFACE))
		flags_inv += HIDEFACE