//fucking hell why do caps have to be so snowflakey
/obj/item/clothing/head/soft/reskin_obj(mob/M)
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
	var/soft = unique_reskin[choice]
	icon_state = "[soft]soft[flipped ? "_flipped":""]"
	soft_type = "[soft]"
	to_chat(M, "[src] is now skinned as '[choice]'.")
	return TRUE

//brig phys softcap
/obj/item/clothing/head/soft/sec/brig_phys
	name = "security medic cap"
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON
	icon_state = "secmedsoft"
	item_state = "secmedsoft"
	soft_type = "secmed"
	unique_reskin = list(
	)
	unique_reskin_stored = list(
	)

//sec softcap
/obj/item/clothing/head/soft/sec
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "secsoft"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON
	unique_reskin_stored = list(
	"Default" = "sec", //soft caps use some snowflake icon updating code, so we don't write the "soft" part
	"Corporate" = "corp",
	"Sol Federation" = "sol",
	"Expedition" = "expedition",
	"Fleet" = "fleet"
	)
