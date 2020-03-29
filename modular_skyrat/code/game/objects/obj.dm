//god making clothing reskinnable is a mess
/obj
	var/list/unique_reskin_icons
	var/list/unique_reskin_worn
	var/list/unique_reskin_worn_digi
	var/list/unique_reskin_worn_muzzled

//altered the proc for reskins that require other icon files (and for alternate skins for clothing to be a thing)
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
		return
	current_skin = choice
	if(LAZYLEN(unique_reskin_icons))
		icon = unique_reskin_icons[choice]
	if(LAZYLEN(unique_reskin_worn))
		var/obj/item/I = src
		if(I)
			I.alternate_worn_icon = unique_reskin_worn[choice]
	if(LAZYLEN(unique_reskin_worn_digi))
		var/obj/item/I = src
		if(I)
			I.alternate_worn_icon_digi = unique_reskin_worn_digi[choice]
	if(LAZYLEN(unique_reskin_worn_muzzled))
		var/obj/item/I = src
		if(I)
			I.alternate_worn_icon_muzzled = unique_reskin_worn_muzzled[choice]
	icon_state = unique_reskin[choice]
	to_chat(M, "[src] is now skinned as '[choice]'.")
