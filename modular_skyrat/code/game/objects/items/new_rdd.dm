/obj/item/rdd
	name = "Rapid Decal Device (RDD)"
	desc = "A device used to rapidly decal tiles."
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	icon_state = "rdd"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/tools_righthand.dmi'

	flags_1 = CONDUCT_1
	force = 10
	throwforce = 10
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=1000, /datum/material/glass=1000)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF

	var/graf_dir = NORTH
	var/paint_color = "grey"
	var/drawtype

	var/static/list/warningline = list("warningline_white","warninglinecorner_white","warn_end_white","warn_box_white","warn_full_white","warninglinel_white")
	var/static/list/trimline = list("trimline","trimline_corner","trimline_end","trimline_box","trimlinel")
	var/static/list/trimlinefill = list("trimline_fill","trimline_corner_fill","trimline_end_fill","trimline_box_fill","trimelinel_fill")
	var/static/list/tile = list("singletile","doubletile","tripletile","fulltile","checkertile")
	var/static/list/misc = list("stand_clear_white","caution_white","loadingarea_white","bot_white","delivery_white","box_white","box_left_white","box_right_white","box_corners_white","arrows_white")

	var/static/list/all_tdecal = warningline + trimline + trimlinefill + tile + misc
	
	var/static/list/directions = list(NORTH,SOUTH,EAST,WEST)

/obj/item/rdd/proc/isValidSurface(surface)
	return istype(surface, /turf/open/floor)

/obj/item/rdd/Initialize()
	. = ..()
	drawtype = pick(all_tdecal)

/obj/item/rdd/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, datum/tgui/master_ui = null, datum/ui_state/state = GLOB.hands_state)
	// tgui is a plague upon this codebase

	SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "rdd", name, 600, 600,
			master_ui, state)
		ui.open()

/obj/item/rdd/proc/staticDrawables()

	. = list()

	var/list/wl_items = list()
	. += list(list("name" = "Warning Line", "items" = wl_items))
	for(var/wl in warningline)
		wl_items += list(list("item" = wl))

	var/list/tl_items = list()
	. += list(list("name" = "Trimline", "items" = tl_items))
	for(var/tl in trimline)
		tl_items += list(list("item" = tl))

	var/list/tlf_items = list()
	. += list(list("name" = "Trimline Fill", "items" = tlf_items))
	for(var/tlf in trimlinefill)
		tlf_items += list(list("item" = tlf))

	var/list/t_items = list()
	. += list(list("name" = "Tile", "items" = t_items))
	for(var/t in tile)
		t_items += list(list("item" = t))

	var/list/m_items = list()
	. += list(list(name = "Misc", "items" = m_items))
	for(var/m in misc)
		m_items += list(list("item" = m))

/obj/item/rdd/ui_data()

	var/static/list/rdd_drawables

	if (!rdd_drawables)
		rdd_drawables = staticDrawables()

	. = list()
	.["drawables"] = rdd_drawables
	.["selected_stencil"] = drawtype
	.["current_colour"] = paint_color
	.["directions"] = directions
	.["selected_dir"] = graf_dir

/obj/item/rdd/ui_act(action, list/params)
	if(..())
		return
	switch(action)
		if("select_stencil")
			var/stencil = params["item"]
			if(stencil in all_tdecal)
				drawtype = stencil
				. = TRUE
			else
				return
			graf_dir = NORTH
		if("setdir")
			graf_dir = text2dir(params["dir"])
		if("select_colour")
			var/chosen_colour = input(usr,"","Choose Color",paint_color) as color|null

			if (!isnull(chosen_colour))
				paint_color = chosen_colour
				. = TRUE
			else
				. = FALSE
	update_icon()

/obj/item/rdd/afterattack(atom/target, mob/user, proximity, params)
	. = ..()
	if(!proximity || !check_allowed_items(target))
		return

	if(istype(target, /obj/effect/decal))
		target = target.loc

	if(!isValidSurface(target))
		return

	var/drawing = drawtype

	var/temp = "warningline"
	if(drawing in warningline)
		temp = "warningline"
	else if(drawing in trimline)
		temp = "trimline"
	else if(drawing in trimlinefill)
		temp = "trimlinefill"
	else if(drawing in tile)
		temp = "tile"
	else if(drawing in misc)
		temp = "misc"

	var/list/turf/affected_turfs = list()


	var/obj/effect/decal/crayon/C = new(target, paint_color, drawing, temp, graf_dir)
	C.add_hiddenprint(user)
	C.x = target.x
	C.y = target.y
	affected_turfs += target
