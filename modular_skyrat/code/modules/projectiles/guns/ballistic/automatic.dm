//wt550 reskinning
/obj/item/gun/ballistic/automatic/wt550
	name = "security semi-auto WT-550"
	desc = "An outdated personal defence weapon. Uses 4.6x30mm rounds."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "wt550"
	item_state = "arg"
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	var/skintype = "wt550"
	unique_name = list(
	"Default" = "security semi-auto WT-550",
	"AR46" = "security semi-auto AR-46",
	"P90" = "security semi-auto P90",
	"MP5" = "security semi-auto MP5"
	)
	unique_desc = list(
	"Default" = "An outdated personal defence weapon. Uses 4.6x30mm rounds.",
	"AR46" = "An outdated personal defence weapon. Uses 4.6x30mm rounds. Refitted to resemble an AR-46.",
	"P90" = "An outdated personal defence weapon. Uses 4.6x30mm rounds. Refitted to resemble a P90.",
	"MP5" = "An outdated personal defence weapon. Uses 4.6x30mm rounds. Refitted to resemble a MP5."
	)
	unique_item_state = list(
	"Default" = "arg",
	"AR46" = "ar46",
	"P90" = "arg",
	"MP5" = "arg"
	)
	unique_reskin_stored = list(
	"Default" = "wt550",
	"AR46" = "ar46",
	"P90" = "p90",
	"MP5" = "mp5"
	)

/obj/item/gun/ballistic/automatic/wt550/reskin_obj(mob/M) //snowflake reskin because yada yada
	if(!LAZYLEN(unique_reskin))
		return
	var/dat = "<b>Reskin options for [name]:</b>\n"
	for(var/V in unique_reskin)
		if(LAZYLEN(unique_reskin_icons)) //hacky solution but i don't want to break all the code man
			var/output = icon2html(unique_reskin_icons[V], M, unique_reskin[V])
			dat += "[V]: <span class='reallybig'>[output]</span>\n"
		if(!LAZYLEN(unique_reskin_icons))
			var/output = icon2html(src, M, unique_reskin[V])
			dat += "[V]: <span class='reallybig'>[output]</span>\n"
	to_chat(M, dat)

	var/choice = input(M, always_reskinnable ? "Choose the a reskin for [src]" : "Warning, you can only reskin [src] once!","Reskin Object") as null|anything in unique_reskin
	if(QDELETED(src) || !choice || (current_skin && !always_reskinnable) || M.incapacitated() || !in_range(M,src) || !unique_reskin[choice] || unique_reskin[choice] == current_skin)
		return FALSE
	current_skin = choice
	if(LAZYLEN(unique_reskin_icons))
		icon = unique_reskin_icons[choice]
	if(LAZYLEN(unique_reskin_worn))
		var/obj/item/I = src
		if(I)
			I.mob_overlay_icon = unique_reskin_worn[choice]
	if(LAZYLEN(unique_reskin_worn_digi))
		var/obj/item/I = src
		if(I)
			I.anthro_mob_worn_overlay = unique_reskin_worn_digi[choice]
	if(LAZYLEN(unique_reskin_worn_muzzled))
		var/obj/item/I = src
		if(I)
			I.anthro_mob_worn_overlay = unique_reskin_worn_muzzled[choice]
	if(LAZYLEN(unique_reskin_worn_anthro))
		var/obj/item/I = src
		if(I)
			I.anthro_mob_worn_overlay = unique_reskin_worn_anthro[choice]
	skintype = unique_reskin[choice]
	icon_state = unique_reskin[choice]
	to_chat(M, "[src] is now skinned as '[choice]'.")
	return TRUE


/obj/item/gun/ballistic/automatic/wt550/update_icon()
	..()
	icon_state = "[skintype][magazine ? "-[CEILING((	(get_ammo(FALSE) / magazine.max_ammo) * 20) /4, 1)*4]" : "-0"]"	//Sprites only support up to 20.

//HoS MP5
/obj/item/gun/ballistic/automatic/mp5
	name = "\proper H&K MP5A1"
	desc = "An ancient machine gun, used by law enforcement worldwide in the old pre-space exploration days.\
			This is an antique model, marked as an original Hacky & Kool 1964 prototype."
	icon = 'modular_skyrat/icons/obj/guns/mp5.dmi'
	item_state = "arg"
	icon_state = "mp5"
	can_suppress = FALSE
	burst_size = 3
	burst_shot_delay = 4
	actions_types = list(/datum/action/item_action/toggle_firemode)
	automatic_burst_overlay = FALSE
	actions_types = null
	mag_type = /obj/item/ammo_box/magazine/smgm9mm/rubber

/obj/item/gun/ballistic/automatic/mp5/emag_act(mob/user)
	if(magazine)
		var/obj/item/ammo_box/magazine/M = magazine
		M.emag_act(user)
