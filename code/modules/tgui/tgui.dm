<<<<<<< HEAD
 /**
  * tgui
  *
  * /tg/station user interface library
 **/

 /**
  * tgui datum (represents a UI).
 **/
=======
/**
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */

/**
 * tgui datum (represents a UI).
 */
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
/datum/tgui
	/// The mob who opened/is using the UI.
	var/mob/user
	/// The object which owns the UI.
	var/datum/src_object
	/// The title of te UI.
	var/title
	/// The window_id for browse() and onclose().
<<<<<<< HEAD
	var/window_id
	/// The window width.
	var/width = 0
	/// The window height
	var/height = 0
	/// The style to be used for this UI.
	var/style = "nanotrasen"
=======
	var/datum/tgui_window/window
	/// Key that is used for remembering the window geometry.
	var/window_key
	/// Deprecated: Window size.
	var/window_size
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
	/// The interface (template) to be used for this UI.
	var/interface
	/// Update the UI every MC tick.
	var/autoupdate = TRUE
	/// If the UI has been initialized yet.
	var/initialized = FALSE
<<<<<<< HEAD
	/// The data (and datastructure) used to initialize the UI.
	var/list/initial_data
	/// The static data used to initialize the UI.
	var/list/initial_static_data
=======
	/// Time of opening the window.
	var/opened_at
	/// Stops further updates when close() was called.
	var/closing = FALSE
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
	/// The status/visibility of the UI.
	var/status = UI_INTERACTIVE
	/// Topic state used to determine status/interactability.
	var/datum/ui_state/state = null
<<<<<<< HEAD
	/// The parent UI.
	var/datum/tgui/master_ui
	/// Children of this UI.
	var/list/datum/tgui/children = list()
	var/custom_browser_id = FALSE
	var/ui_screen = "home"

 /**
  * public
  *
  * Create a new UI.
  *
  * required user mob The mob who opened/is using the UI.
  * required src_object datum The object or datum which owns the UI.
  * required ui_key string The ui_key of the UI.
  * required interface string The interface used to render the UI.
  * optional title string The title of the UI.
  * optional width int The window width.
  * optional height int The window height.
  * optional master_ui datum/tgui The parent UI.
  * optional state datum/ui_state The state used to determine status.
  *
  * return datum/tgui The requested UI.
 **/
/datum/tgui/New(mob/user, datum/src_object, ui_key, interface, title, width = 0, height = 0, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state, browser_id = null)
	src.user = user
	src.src_object = src_object
	src.ui_key = ui_key
	src.window_id = browser_id ? browser_id : "[REF(src_object)]-[ui_key]" // DO NOT replace with \ref here. src_object could potentially be tagged
	src.custom_browser_id = browser_id ? TRUE : FALSE

	set_interface(interface)

=======

/**
 * public
 *
 * Create a new UI.
 *
 * required user mob The mob who opened/is using the UI.
 * required src_object datum The object or datum which owns the UI.
 * required interface string The interface used to render the UI.
 * optional title string The title of the UI.
 * optional ui_x int Deprecated: Window width.
 * optional ui_y int Deprecated: Window height.
 *
 * return datum/tgui The requested UI.
 */
/datum/tgui/New(mob/user, datum/src_object, interface, title, ui_x, ui_y)
	log_tgui(user, "new [interface] fancy [user.client.prefs.tgui_fancy]")
	src.user = user
	src.src_object = src_object
	src.window_key = "[REF(src_object)]-main"
	src.interface = interface
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
	if(title)
		src.title = title
	src.state = src_object.ui_state()
	// Deprecated
	if(ui_x && ui_y)
		src.window_size = list(ui_x, ui_y)

 /**
  * public
  *
  * Open this UI (and initialize it with data).
 **/
/datum/tgui/proc/open()
	if(!user.client)
		return null
	if(window)
		return null
	process_status()
	if(status < UI_UPDATE)
<<<<<<< HEAD
		return // Bail if we're not supposed to open.

	var/window_size
	if(width && height) // If we have a width and height, use them.
		window_size = "size=[width]x[height];"
	else
		window_size = ""

	// Remove titlebar and resize handles for a fancy window
	var/have_title_bar
	if(user.client.prefs.tgui_fancy)
		have_title_bar = "titlebar=0;can_resize=0;"
	else
		have_title_bar = "titlebar=1;can_resize=1;"

	// Generate page html
	var/html
	html = SStgui.basehtml
	// Allow the src object to override the html if needed
	html = src_object.ui_base_html(html)
	// Replace template tokens with important UI data
	// NOTE: Intentional \ref usage; tgui datums can't/shouldn't
	// be tagged, so this is an effective unwrap
	html = replacetextEx(html, "\[ref]", "\ref[src]")
	html = replacetextEx(html, "\[style]", style)

	// Open the window.
	user << browse(html, "window=[window_id];can_minimize=0;auto_format=0;[window_size][have_title_bar]")
	if (!custom_browser_id)
		// Instruct the client to signal UI when the window is closed.
		// NOTE: Intentional \ref usage; tgui datums can't/shouldn't
		// be tagged, so this is an effective unwrap
		winset(user, window_id, "on-close=\"uiclose \ref[src]\"")

	if(!initial_data)
		initial_data = src_object.ui_data(user)
	if(!initial_static_data)
		initial_static_data = src_object.ui_static_data(user)
=======
		return null
	window = SStgui.request_pooled_window(user)
	if(!window)
		return null
	opened_at = world.time
	window.acquire_lock(src)
	if(!window.is_ready())
		window.initialize(inline_assets = list(
			get_asset_datum(/datum/asset/simple/tgui),
		))
	else
		window.send_message("ping")
	window.send_asset(get_asset_datum(/datum/asset/simple/fontawesome))
	for(var/datum/asset/asset in src_object.ui_assets(user))
		window.send_asset(asset)
	window.send_message("update", get_payload(
		with_data = TRUE,
		with_static_data = TRUE))
	SStgui.on_open(src)

/**
 * public
 *
 * Close the UI.
 *
 * optional can_be_suspended bool
 */
/datum/tgui/proc/close(can_be_suspended = TRUE)
	if(closing)
		return
	closing = TRUE
	// If we don't have window_id, open proc did not have the opportunity
	// to finish, therefore it's safe to skip this whole block.
	if(window)
		// Windows you want to keep are usually blue screens of death
		// and we want to keep them around, to allow user to read
		// the error message properly.
		window.release_lock()
		window.close(can_be_suspended)
		src_object.ui_close(user)
		SStgui.on_close(src)
	state = null
	qdel(src)

/**
 * public
 *
 * Enable/disable auto-updating of the UI.
 *
 * required value bool Enable/disable auto-updating.
 */
/datum/tgui/proc/set_autoupdate(autoupdate)
	src.autoupdate = autoupdate
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4

/**
 * public
 *
 * Replace current ui.state with a new one.
 *
 * required state datum/ui_state/state Next state
 */
/datum/tgui/proc/set_state(datum/ui_state/state)
	src.state = state

<<<<<<< HEAD
 /**
  * public
  *
  * Reinitialize the UI.
  * (Possibly with a new interface and/or data).
  *
  * optional template string The name of the new interface.
  * optional data list The new initial data.
 **/
/datum/tgui/proc/reinitialize(interface, list/data, list/static_data)
	if(interface)
		set_interface(interface) // Set a new interface.
	if(data)
		initial_data = data
	if(static_data)
		initial_static_data = static_data
	open()

 /**
  * public
  *
  * Close the UI, and all its children.
 **/
/datum/tgui/proc/close()
	user << browse(null, "window=[window_id]") // Close the window.
	src_object.ui_close(user)
	SStgui.on_close(src)
	for(var/datum/tgui/child in children) // Loop through and close all children.
		child.close()
	children.Cut()
	state = null
	master_ui = null
	qdel(src)

 /**
  * public
  *
  * Set the style for this UI.
  *
  * required style string The new UI style.
 **/
/datum/tgui/proc/set_style(style)
	src.style = lowertext(style)

 /**
  * public
  *
  * Set the interface (template) for this UI.
  *
  * required interface string The new UI interface.
 **/
/datum/tgui/proc/set_interface(interface)
	src.interface = lowertext(interface)

 /**
  * public
  *
  * Enable/disable auto-updating of the UI.
  *
  * required state bool Enable/disable auto-updating.
 **/
/datum/tgui/proc/set_autoupdate(state = TRUE)
	autoupdate = state

 /**
  * private
  *
  * Package the data to send to the UI, as JSON.
  * This includes the UI data and config_data.
  *
  * return string The packaged JSON.
 **/
/datum/tgui/proc/get_json(list/data, list/static_data)
=======
/**
 * public
 *
 * Makes an asset available to use in tgui.
 *
 * required asset datum/asset
 */
/datum/tgui/proc/send_asset(datum/asset/asset)
	if(!window)
		CRASH("send_asset() can only be called after open().")
	window.send_asset(asset)

/**
 * public
 *
 * Send a full update to the client (includes static data).
 *
 * optional custom_data list Custom data to send instead of ui_data.
 * optional force bool Send an update even if UI is not interactive.
 */
/datum/tgui/proc/send_full_update(custom_data, force)
	if(!user.client || !initialized || closing)
		return
	var/should_update_data = force || status >= UI_UPDATE
	window.send_message("update", get_payload(
		custom_data,
		with_data = should_update_data,
		with_static_data = TRUE))

/**
 * public
 *
 * Send a partial update to the client (excludes static data).
 *
 * optional custom_data list Custom data to send instead of ui_data.
 * optional force bool Send an update even if UI is not interactive.
 */
/datum/tgui/proc/send_update(custom_data, force)
	if(!user.client || !initialized || closing)
		return
	var/should_update_data = force || status >= UI_UPDATE
	window.send_message("update", get_payload(
		custom_data,
		with_data = should_update_data))

/**
 * private
 *
 * Package the data to send to the UI, as JSON.
 *
 * return list
 */
/datum/tgui/proc/get_payload(custom_data, with_data, with_static_data)
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
	var/list/json_data = list()
	json_data["config"] = list(
		"title" = title,
		"status" = status,
		"screen" = ui_screen,
		"style" = style,
		"interface" = interface,
<<<<<<< HEAD
		"fancy" = user.client.prefs.tgui_fancy,
		"locked" = user.client.prefs.tgui_lock && !custom_browser_id,
		"observer" = isobserver(user),
		"window" = window_id,
		// NOTE: Intentional \ref usage; tgui datums can't/shouldn't
		// be tagged, so this is an effective unwrap
		"ref" = "\ref[src]"
	)
	
	if(!isnull(data))
=======
		"window" = list(
			"key" = window_key,
			"size" = window_size,
			"fancy" = user.client.prefs.tgui_fancy,
			"locked" = user.client.prefs.tgui_lock
		),
		"user" = list(
			"name" = "[user]",
			"ckey" = "[user.ckey]",
			"observer" = isobserver(user)
		)
	)
	var/data = custom_data || with_data && src_object.ui_data(user)
	if(data)
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
		json_data["data"] = data
	var/static_data = with_static_data && src_object.ui_static_data(user)
	if(static_data)
		json_data["static_data"] = static_data
<<<<<<< HEAD

	// Generate the JSON.
	var/json = json_encode(json_data)
	// Strip #255/improper.
	json = replacetext(json, "\proper", "")
	json = replacetext(json, "\improper", "")
	return json

 /**
  * private
  *
  * Handle clicks from the UI.
  * Call the src_object's ui_act() if status is UI_INTERACTIVE.
  * If the src_object's ui_act() returns 1, update all UIs attacked to it.
 **/
/datum/tgui/Topic(href, href_list)
	if(user != usr)
		return // Something is not right here.

	var/action = href_list["action"]
	var/params = href_list; params -= "action"

	switch(action)
		if("tgui:initialize")
			user << output(url_encode(get_json(initial_data, initial_static_data)), "[custom_browser_id ? window_id : "[window_id].browser"]:initialize")
			initialized = TRUE
		if("tgui:view")
			if(params["screen"])
				ui_screen = params["screen"]
			SStgui.update_uis(src_object)
		if("tgui:log")
			// Force window to show frills on fatal errors
			if(params["fatal"])
				winset(user, window_id, "titlebar=1;can-resize=1;size=600x600")
		if("tgui:link")
			user << link(params["url"])
		if("tgui:fancy")
			user.client.prefs.tgui_fancy = TRUE
		if("tgui:nofrills")
			user.client.prefs.tgui_fancy = FALSE
		else
			update_status(push = FALSE) // Update the window state.
			if(src_object.ui_act(action, params, src, state)) // Call ui_act() on the src_object.
				SStgui.update_uis(src_object) // Update if the object requested it.

 /**
  * private
  *
  * Update the UI.
  * Only updates the data if update is true, otherwise only updates the status.
  *
  * optional force bool If the UI should be forced to update.
 **/
=======
	if(src_object.tgui_shared_states)
		json_data["shared"] = src_object.tgui_shared_states
	return json_data

/**
 * private
 *
 * Run an update cycle for this UI. Called internally by SStgui
 * every second or so.
 */
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
/datum/tgui/process(force = FALSE)
	if(closing)
		return
	var/datum/host = src_object.ui_host(user)
	// If the object or user died (or something else), abort.
	if(!src_object || !host || !user || !window)
		close(can_be_suspended = FALSE)
		return
<<<<<<< HEAD

	if(status && (force || autoupdate))
		update() // Update the UI if the status and update settings allow it.
	else
		update_status(push = TRUE) // Otherwise only update status.

 /**
  * private
  *
  * Push data to an already open UI.
  *
  * required data list The data to send.
  * optional force bool If the update should be sent regardless of state.
 **/
/datum/tgui/proc/push_data(data, static_data, force = FALSE)
	update_status(push = FALSE) // Update the window state.
	if(!initialized)
		return // Cannot update UI if it is not set up yet.
	if(status <= UI_DISABLED && !force)
		return // Cannot update UI, we have no visibility.

	// Send the new JSON to the update() Javascript function.
	user << output(url_encode(get_json(data, static_data)), "[custom_browser_id ? window_id : "[window_id].browser"]:update")

 /**
  * private
  *
  * Updates the UI by interacting with the src_object again, which will hopefully
  * call try_ui_update on it.
  *
  * optional force_open bool If force_open should be passed to ui_interact.
 **/
/datum/tgui/proc/update(force_open = FALSE)
	src_object.ui_interact(user, ui_key, src, force_open, master_ui, state)

 /**
  * private
  *
  * Update the status/visibility of the UI for its user.
  *
  * optional push bool Push an update to the UI (an update is always sent for UI_DISABLED).
 **/
/datum/tgui/proc/update_status(push = FALSE)
	var/status = src_object.ui_status(user, state)
	if(master_ui)
		status = min(status, master_ui.status)
	set_status(status, push)
	if(status == UI_CLOSE)
		close()

 /**
  * private
  *
  * Set the status/visibility of the UI.
  *
  * required status int The status to set (UI_CLOSE/UI_DISABLED/UI_UPDATE/UI_INTERACTIVE).
  * optional push bool Push an update to the UI (an update is always sent for UI_DISABLED).
 **/
/datum/tgui/proc/set_status(status, push = FALSE)
	if(src.status != status) // Only update if status has changed.
		if(src.status == UI_DISABLED)
			src.status = status
			if(push)
				update()
		else
			src.status = status
			if(status == UI_DISABLED || push) // Update if the UI just because disabled, or a push is requested.
				push_data(null, force = TRUE)

/datum/tgui/proc/log_message(message)
	log_tgui("[user] ([user.ckey]) using \"[title]\":\n[message]")

=======
	// Validate ping
	if(!initialized && world.time - opened_at > TGUI_PING_TIMEOUT)
		log_tgui(user, \
			"Error: Zombie window detected, killing it with fire.\n" \
			+ "window_id: [window.id]\n" \
			+ "opened_at: [opened_at]\n" \
			+ "world.time: [world.time]")
		close(can_be_suspended = FALSE)
		return
	// Update through a normal call to ui_interact
	if(status != UI_DISABLED && (autoupdate || force))
		src_object.ui_interact(user, src)
		return
	// Update status only
	var/needs_update = process_status()
	if(status <= UI_CLOSE)
		close()
		return
	if(needs_update)
		window.send_message("update", get_payload())

/**
 * private
 *
 * Updates the status, and returns TRUE if status has changed.
 */
/datum/tgui/proc/process_status()
	var/prev_status = status
	status = src_object.ui_status(user, state)
	return prev_status != status

/**
 * private
 *
 * Callback for handling incoming tgui messages.
 */
/datum/tgui/proc/on_message(type, list/payload, list/href_list)
	// Pass act type messages to ui_act
	if(type && copytext(type, 1, 5) == "act/")
		process_status()
		if(src_object.ui_act(copytext(type, 5), payload, src, state))
			SStgui.update_uis(src_object)
		return FALSE
	switch(type)
		if("ready")
			initialized = TRUE
		if("pingReply")
			initialized = TRUE
		if("suspend")
			close(can_be_suspended = TRUE)
		if("close")
			close(can_be_suspended = FALSE)
		if("log")
			if(href_list["fatal"])
				close(can_be_suspended = FALSE)
		if("setSharedState")
			if(status != UI_INTERACTIVE)
				return
			LAZYINITLIST(src_object.tgui_shared_states)
			src_object.tgui_shared_states[href_list["key"]] = href_list["value"]
			SStgui.update_uis(src_object)
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4
