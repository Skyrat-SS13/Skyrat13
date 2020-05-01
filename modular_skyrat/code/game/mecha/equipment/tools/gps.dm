//funny gps thing that actually displays GPS stats on the mech UI
/obj/item/mecha_parts/mecha_equipment/gps
	name = "exosuit gps"
	icon = 'modular_skyrat/icons/mecha/mecha_equipment.dmi'
	icon_state = "gps-m"
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	obj_flags = UNIQUE_RENAME
	var/gpstag = "MECHA0"
	var/emped = FALSE
	var/tracking = TRUE
	var/updating = TRUE
	var/global_mode = TRUE
	selectable = 0

//pardon me gods of coding for this, but i had to pretty much copy everyhing about the GPS since making this
//not a subtype of equipment would suck just as bad
/obj/item/mecha_parts/mecha_equipment/gps/examine(mob/user)
	. = ..()
	var/turf/curr = get_turf(src)
	. += "The screen says: [get_area_name(curr, TRUE)] ([curr.x], [curr.y], [curr.z])"
	. += "<span class='notice'>Alt-click to switch it [tracking ? "off":"on"].</span>"

/obj/item/mecha_parts/mecha_equipment/gps/Initialize()
	. = ..()
	GLOB.GPS_list += src
	name = "exosuit global positioning system ([gpstag])"
	add_overlay("working")

/obj/item/mecha_parts/mecha_equipment/gps/Destroy()
	GLOB.GPS_list -= src
	return ..()

/obj/item/mecha_parts/mecha_equipment/gps/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	emped = TRUE
	cut_overlay("working")
	add_overlay("emp")
	addtimer(CALLBACK(src, .proc/reboot), 300, TIMER_UNIQUE|TIMER_OVERRIDE) //if a new EMP happens, remove the old timer so it doesn't reactivate early
	SStgui.close_uis(src) //Close the UI control if it is open.

/obj/item/mecha_parts/mecha_equipment/gps/proc/reboot()
	emped = FALSE
	cut_overlay("emp")
	add_overlay("working")

/obj/item/mecha_parts/mecha_equipment/gps/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	toggletracking(user)
	return TRUE

/obj/item/mecha_parts/mecha_equipment/gps/proc/toggletracking(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE))
		return //user not valid to use gps
	if(emped)
		to_chat(user, "It's busted!")
		return
	if(tracking)
		cut_overlay("working")
		to_chat(user, "[src] is no longer tracking, or visible to other GPS devices.")
		tracking = FALSE
	else
		add_overlay("working")
		to_chat(user, "[src] is now tracking, and visible to other GPS devices.")
		tracking = TRUE


/obj/item/mecha_parts/mecha_equipment/gps/ui_interact(mob/user, ui_key = "gps", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state) // Remember to use the appropriate state.
	if(emped)
		to_chat(user, "[src] fizzles weakly.")
		return
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		// Variable window height, depending on how many GPS units there are
		// to show, clamped to relatively safe range.
		var/gps_window_height = clamp(325 + GLOB.GPS_list.len * 14, 325, 700)
		ui = new(user, src, ui_key, "gps", "Global Positioning System", 470, gps_window_height, master_ui, state) //width, height
		ui.open()

	ui.set_autoupdate(state = updating)


/obj/item/mecha_parts/mecha_equipment/gps/ui_data(mob/user)
	var/list/data = list()
	data["power"] = tracking
	data["tag"] = gpstag
	data["updating"] = updating
	data["globalmode"] = global_mode
	if(!tracking || emped) //Do not bother scanning if the GPS is off or EMPed
		return data

	var/turf/curr = get_turf(src)
	data["current"] = "[get_area_name(curr, TRUE)] ([curr.x], [curr.y], [curr.z])"
	data["currentArea"] = "[get_area_name(curr, TRUE)]"
	data["currentCoords"] = "[curr.x], [curr.y], [curr.z]"

	var/list/signals = list()
	data["signals"] = list()

	for(var/gps in GLOB.GPS_list)
		var/obj/item/gps/G = gps
		if(G.emped || !G.tracking || G == src)
			continue
		var/turf/pos = get_turf(G)
		if(!global_mode && pos.z != curr.z)
			continue
		var/list/signal = list()
		signal["entrytag"] = G.gpstag //Name or 'tag' of the GPS
		signal["coords"] = "[pos.x], [pos.y], [pos.z]"
		if(pos.z == curr.z) //Distance/Direction calculations for same z-level only
			signal["dist"] = max(get_dist(curr, pos), 0) //Distance between the src and remote GPS turfs
			signal["degrees"] = round(Get_Angle(curr, pos)) //0-360 degree directional bearing, for more precision.

		signals += list(signal) //Add this signal to the list of signals
	data["signals"] = signals
	return data



/obj/item/mecha_parts/mecha_equipment/gps/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("rename")
			var/a = input("Please enter desired tag.", name, gpstag) as text
			a = copytext(sanitize(a), 1, 20)
			gpstag = a
			. = TRUE
			name = "global positioning system ([gpstag])"

		if("power")
			toggletracking(usr)
			. = TRUE
		if("updating")
			updating = !updating
			. = TRUE
		if("globalmode")
			global_mode = !global_mode
			. = TRUE
