//USP
/obj/item/ammo_box/c9mm/rubber
	name = "ammo box (9mm)"
	icon = 'modular_skyrat/icons/obj/ammo.dmi'
	icon_state = "9mmrbox"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	max_ammo = 30

//Shotgun clips
/obj/item/ammo_box/shotgun
	name = "stripper clip (shotgun shells)"
	desc = "A lot more convenient than carrying a ton of shells in your bag."
	icon = 'modular_skyrat/icons/obj/ammo.dmi'
	icon_state = "shotgunclip"
	max_ammo = 4
	ammo_type = /obj/item/ammo_casing/shotgun
	multiload = 0
	var/pixeloffsetx = 4
	var/shell_overlay_list = list()

/obj/item/ammo_box/shotgun/update_overlays()
	. = ..()
	if(stored_ammo.len )
		var/shellindex = 0
		var/offset = 0
		for(var/obj/item/ammo_casing/shotgun/C in stored_ammo)
			var/sanity = TRUE
			shellindex++
			if(shellindex > 1)
				offset += pixeloffsetx
			for(var/mutable_appearance/shell in shell_overlay_list)
				if(shell.pixel_x == offset)
					sanity = FALSE
			if(sanity)
				var/mutable_appearance/shell_overlay = mutable_appearance(icon, "[initial(C.icon)]-clip")
				shell_overlay.pixel_x += offset
				shell_overlay.appearance_flags = RESET_COLOR
				shell_overlay_list += shell_overlay
				. += shell_overlay
	var/appearance_index = 0
	for(var/mutable_appearance/shell in shell_overlay_list)
		appearance_index++
		if(!stored_ammo[appearance_index])
			qdel(shell)

/obj/item/ammo_box/shotgun/rubbershot
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/shotgun/buckshot
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot


/obj/item/ammo_box/shotgun/beanbag
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/shotgun/stunslug
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/shotgun/techshell
	ammo_type = /obj/item/ammo_casing/shotgun/techshell

/obj/item/ammo_box/shotgun/incendiary
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary
