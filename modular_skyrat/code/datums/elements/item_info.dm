//Item info menu element
/datum/element/item_info
	element_flags = ELEMENT_DETACH
	id_arg_index = 2

/datum/element/item_info/Attach(datum/target)
	. = ..()
	RegisterSignal(target, COMSIG_ITEM_ITEMINFO, .proc/item_ui_interact) //Wonky, but we use this to be able to pass the item as an argument

/datum/element/item_info/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_ITEM_ITEMINFO)

/datum/element/item_info/proc/item_ui_interact(obj/item/item, mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
					datum/tgui/master_ui = null, datum/ui_state/state = GLOB.always_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "iteminfo", capitalize(item.name), 300, 500, master_ui, state)
		ui.reinitialize(data = item_ui_data(item, user))
		ui.open()

/datum/element/item_info/proc/item_ui_data(obj/item/item, mob/user)
	var/list/data = list()
	data["name"] = capitalize(item.name)
	data["integrity"] = item.obj_integrity
	data["max_integrity"] = item.max_integrity
	data["force"] = item.force
	data["force_unwielded"] = 0
	data["force_wielded"] = 0
	var/datum/component/two_handed/two_handed = item.GetComponent(/datum/component/two_handed)
	if(two_handed)
		if(two_handed.force_multiplier)
			data["force_wielded"] = (item.force * two_handed.force_multiplier)
		else
			data["force_wielded"] = two_handed.force_wielded
		data["force_unwielded"] = two_handed.force_unwielded
	data["sharpness"] = "Blunt"
	switch(item.sharpness)
		if(1)
			data["sharpness"] = "Slashing"
		if(2)
			data["sharpness"] = "Piercing"
	data["armor_penetration"] = item.armour_penetration
	data["armor"] = item.armor.getList()

	return data
