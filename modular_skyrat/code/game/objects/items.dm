//Hiding underwear
/obj/item
	hide_underwear_examine = TRUE

//Item pickup text
/obj/item
	var/grabtext
	var/grabsound
	hide_underwear_examine = TRUE

/obj/item/pickup(mob/living/user)
	. = ..()
	if(grabtext)
		var/t = replacetext(grabtext,"user","[user]")
		t = replacetext(t,"src","[src.name]")
		user.visible_message("<span class='danger'>[t]</span>")
	if(grabsound)
		playsound(src,grabsound,50,1)

//TGUI item info menu
/obj/item/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
					datum/tgui/master_ui = null, datum/ui_state/state = GLOB.always_state)
	. = ..()
	if(ui_key == "info")
		ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
		if(!ui)
			ui = new(user, src, ui_key, "iteminfo", capitalize(name), 300, 500, master_ui, state)
			ui.open()

/obj/item/ui_data(mob/user)
	var/list/data = list()
	data["name"] = capitalize(name)
	data["integrity"] = obj_integrity
	data["max_integrity"] = max_integrity
	data["force"] = force
	data["force_unwielded"] = 0
	data["force_wielded"] = 0
	var/datum/component/two_handed/two_handed = GetComponent(/datum/component/two_handed)
	if(two_handed)
		if(two_handed.force_multiplier)
			data["force_wielded"] = (force * two_handed.force_multiplier)
		else
			data["force_wielded"] = two_handed.force_wielded
		data["force_unwielded"] = two_handed.force_unwielded
	data["sharpness"] = "Blunt"
	switch(sharpness)
		if(1)
			data["sharpness"] = "Slashing"
		if(2)
			data["sharpness"] = "Piercing"
	data["armor_penetration"] = armour_penetration
	data["armor"] = armor.getList()

	return data
