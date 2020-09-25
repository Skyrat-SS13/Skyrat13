//god making clothing reskinnable is a mess
/obj
	var/list/unique_reskin_stored //used for the reskinning kit!
	var/list/unique_reskin_icons
	var/list/unique_reskin_worn
	var/list/unique_reskin_worn_digi //kept as legacy, use unique_reskin_anthro  if possible
	var/list/unique_reskin_worn_muzzled //kept as legacy, use unique_reskin_anthro  if possible
	var/list/unique_reskin_worn_anthro
	var/list/unique_inhand_icon_left
	var/list/unique_inhand_icon_right
	var/list/unique_item_state
	var/list/unique_hardsuit_type //Used so hardsuits update the icon proper without mucking up
	var/list/unique_name
	var/list/unique_desc
//SO MANY FUCKING VARS FUCK

//altered the proc for reskins that require other icon files (and for alternate skins for clothing to be a thing) nd also item states haha
/obj/reskin_obj(mob/M)
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
	if(LAZYLEN(unique_hardsuit_type))
		var/obj/item/clothing/head/helmet/space/hardsuit/H = src
		if(istype(H))
			H.hardsuit_type = unique_hardsuit_type[choice]
	if(LAZYLEN(unique_name))
		name = unique_name[choice]
	if(LAZYLEN(unique_desc))
		desc = unique_desc[choice]
	icon_state = unique_reskin[choice]
	to_chat(M, "[src] is now skinned as '[choice]'.")
	return TRUE
