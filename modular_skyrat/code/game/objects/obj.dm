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

//Armor stats on examine
/obj
	var/shows_armor = ARMOR_SHOW_DONT

/obj/examine_more(mob/user)
	if(armor)
		var/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
		var/show_the_armor = FALSE
		if(shows_armor == ARMOR_SHOW_ALWAYS)
			show_the_armor = TRUE
		else if((shows_armor == ARMOR_SHOW_WEARABLE) && isitem(src))
			var/obj/item/I = src
			for(var/i in list(ITEM_SLOT_ICLOTHING,
							ITEM_SLOT_OCLOTHING,
							ITEM_SLOT_BELT,
							ITEM_SLOT_FEET,
							ITEM_SLOT_GLOVES,
							ITEM_SLOT_MASK,
							ITEM_SLOT_EYES,
							ITEM_SLOT_HEAD,
							ITEM_SLOT_NECK,
							ITEM_SLOT_BACK))
				if(I.slot_flags & i)
					show_the_armor = TRUE
					break
		if(show_the_armor)
			var/list/stat_strings = list("<span class='notice'>\The [src] has the following armor specifications:</span>")
			var/list/armorlist = armor.getList()
			for(var/i in armorlist)
				var/value = armorlist[i]
				switch(value)
					if(-INFINITY to -1)
						value = "\t[capitalize(i)] - Nulla" //Roman numerals do not have a 0, romans just said "null" instead - they don't have negative numbers either
					if(-1 to 1)
						value = null //we don't show armor stats if we have none, but are not vulnerable to it either
					if(1 to 10)
						value = "\t[capitalize(i)] - I"
					if(10 to 20)
						value = "\t[capitalize(i)] - II"
					if(20 to 30)
						value = "\t[capitalize(i)] - III"
					if(30 to 40)
						value = "\t[capitalize(i)] - IV"
					if(40 to 50)
						value = "\t[capitalize(i)] - V"
					if(50 to 60)
						value = "\t[capitalize(i)] - VI"
					if(60 to 70)
						value = "\t[capitalize(i)] - VII"
					if(70 to 80)
						value = "\t[capitalize(i)] - VIII"
					if(80 to 90)
						value = "\t[capitalize(i)] - IX"
					if(90 to 100)
						value = "\t[capitalize(i)] - X"
					if(100 to INFINITY)
						value = "\t[capitalize(i)] - M"
				if(value)
					stat_strings |= "<span class='notice'>[value]</span>"
			if(length(stat_strings) <= 1)
				msg |= "<span class='notice'>\The [src] has no noticeable armoring.</span>"
			else
				msg |= stat_strings
			return msg
	return ..()
