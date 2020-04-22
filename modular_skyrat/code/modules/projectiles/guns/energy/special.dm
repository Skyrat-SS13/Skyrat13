/obj/item/gun/energy/plasmacutter
	sharpness = IS_SHARP_ACCURATE //can't sharpen, just to be sure.
	toolspeed = 0.75 //plasmacutters can be used as welders, and are 25% faster than standard welders

/obj/item/gun/energy/plasmacutter/tool_use_check(mob/living/user, amount)
	if(!QDELETED(cell) && (cell.charge >= amount * 100))
		cell.use(amount * 100) //using cutters as welders now actually costs energy
		return TRUE

	to_chat(user, "<span class='warning'>You need more charge to complete this task!</span>")
	return FALSE

/obj/item/gun/energy/plasmacutter/adv
	force = 14 //does not outclass survival knives
