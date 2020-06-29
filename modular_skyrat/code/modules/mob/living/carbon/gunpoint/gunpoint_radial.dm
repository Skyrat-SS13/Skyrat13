/*
	A derivative of radial menu which persists onscreen until closed and invokes a callback each time an element is clicked
*/

/datum/radial_menu/gunpoint
	var/uniqueid
	var/datum/callback/select_proc_callback
	icon_path = 'modular_skyrat/icons/mob/radial_gunpoint.dmi'

/datum/radial_menu/gunpoint/New()


/datum/radial_menu/gunpoint/element_chosen(choice_id,mob/user)
	select_proc_callback.Invoke(choices_values[choice_id])


/datum/radial_menu/gunpoint/proc/change_choices(list/newchoices, tooltips)
	if(!newchoices.len)
		return
	Reset()
	set_choices(newchoices,tooltips)

/datum/radial_menu/gunpoint/Destroy()
	QDEL_NULL(select_proc_callback)
	GLOB.radial_menus -= uniqueid
	Reset()
	hide()
	. = ..()

/*
	Creates a persistent radial menu and shows it to the user, anchored to anchor (or user if the anchor is currently in users screen).
	Choices should be a list where list keys are movables or text used for element names and return value
	and list values are movables/icons/images used for element icons
	Select_proc is the proc to be called each time an element on the menu is clicked, and should accept the chosen element as its final argument
	Clicking the center button will return a choice of null
*/
/proc/show_radial_menu_gunpoint(mob/user, atom/anchor, list/choices, datum/callback/select_proc, uniqueid, radius, tooltips = FALSE)
	if(!user || !anchor || !length(choices) || !select_proc)
		return
	if(!uniqueid)
		uniqueid = "defmenu_[REF(user)]_[REF(anchor)]"

	if(GLOB.radial_menus[uniqueid])
		return

	var/datum/radial_menu/gunpoint/menu = new
	menu.uniqueid = uniqueid
	GLOB.radial_menus[uniqueid] = menu
	if(radius)
		menu.radius = radius
	menu.select_proc_callback = select_proc
	menu.anchor = anchor
	menu.check_screen_border(user) //Do what's needed to make it look good near borders or on hud
	menu.set_choices(choices, tooltips)
	menu.show_to(user)
	return menu
