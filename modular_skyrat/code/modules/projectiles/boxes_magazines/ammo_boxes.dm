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
	multiload = 1
	var/pixeloffsetx = 4
	var/shell_overlay_list = list(null, null, null, null) //Runtime in ammo_boxes.dm,41: list index out of bounds

/obj/item/ammo_box/shotgun/update_icon()
	..()
	update_overlays()

/obj/item/ammo_box/shotgun/update_overlays()
	. = ..()
	cut_overlay(shell_overlay_list, TRUE)
	if(stored_ammo.len)
		var/shellindex = 0
		var/offset = -4
		for(var/obj/item/ammo_casing/shotgun/C in stored_ammo)
			shellindex++
			offset += pixeloffsetx
			var/mutable_appearance/shell_overlay = mutable_appearance(icon, "[initial(C.icon_state)]-clip")
			shell_overlay.pixel_x += offset
			shell_overlay.appearance_flags = RESET_COLOR
			shell_overlay_list[shellindex] = shell_overlay
			C.current_overlay = shell_overlay
			add_overlay(shell_overlay, TRUE)

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

/obj/item/ammo_box/shotgun/dart
	ammo_type = /obj/item/ammo_casing/shotgun/dart
