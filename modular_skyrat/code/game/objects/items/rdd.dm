/*
CONTAINS:
RPD
*/

//Direction Categories
#define DECAL_STRAIGHT			0 //2 directions: N/S, E/W
#define DECAL_BENDABLE			1 //6 directions: N/S, E/W, N/E, N/W, S/E, S/W
#define DECAL_TRINARY			2 //4 directions: N/E/S, E/S/W, S/W/N, W/N/E
#define DECAL_TRIN_M			3 //8 directions: N->S+E, S->N+E, N->S+W, S->N+W, E->W+S, W->E+S, E->W+N, W->E+N
#define DECAL_UNARY				4 //4 directions: N, S, E, W
#define DECAL_ONEDIR			5 //1 direction: N/S/E/W
#define DECAL_UNARY_FLIPPABLE	6 //8 directions: N/S/E/W/N-flipped/S-flipped/E-flipped/W-flipped

#define MARKING_CATEGORY 0
#define COLORING_CATEGORY 1

#define PRINT_MODE (1<<0)
#define CLEAN_MODE (1<<1)
#define REPAINT_MODE (1<<2)

GLOBAL_LIST_INIT(tile_marking_recipes, list(
	"Stripes" = list(
		new /datum/decal_info("Line",				/obj/effect/turf_decal/stripes/line),
		new /datum/decal_info("End",				/obj/effect/turf_decal/stripes/end),
		new /datum/decal_info("Corner",				/obj/effect/turf_decal/stripes/corner),
		new /datum/decal_info("Box",				/obj/effect/turf_decal/stripes/box),
		new /datum/decal_info("Full",				/obj/effect/turf_decal/stripes/full)
	),
	"Asteroid Stripes" = list(
		new /datum/decal_info("Line",				/obj/effect/turf_decal/stripes/asteroid/line),
		new /datum/decal_info("End",				/obj/effect/turf_decal/stripes/asteroid/end),
		new /datum/decal_info("Corner",				/obj/effect/turf_decal/stripes/asteroid/corner),
		new /datum/decal_info("Box",				/obj/effect/turf_decal/stripes/asteroid/box),
		new /datum/decal_info("Full",				/obj/effect/turf_decal/stripes/asteroid/full)
	)
))

GLOBAL_LIST_INIT(tile_coloring_recipes, list(
	"Coloring" = list(
		new /datum/decal_info("Fulltile",			/obj/effect/turf_decal/tile),
		new /datum/decal_info("Trimline",			/obj/effect/turf_decal/trimline)
	)
))

/datum/decal_info
	var/name
	var/icon_state
	var/id = -1
	var/dirtype = DECAL_BENDABLE

/datum/decal_info/proc/Render(dispenser)
	var/dat = "<li><a href='?src=[REF(dispenser)]&[Params()]'>[name]</a></li>"

	return dat

/datum/decal_info/proc/Params()
	return ""

/datum/decal_info/proc/get_preview(selected_dir)
	var/list/dirs
	switch(dirtype)
		if(DECAL_STRAIGHT, DECAL_BENDABLE)
			dirs = list("[NORTH]" = "Vertical", "[EAST]" = "Horizontal")
			if(dirtype == DECAL_BENDABLE)
				dirs += list("[NORTHWEST]" = "West to North", "[NORTHEAST]" = "North to East",
							"[SOUTHWEST]" = "South to West", "[SOUTHEAST]" = "East to South")
		if(DECAL_TRINARY)
			dirs = list("[NORTH]" = "West South East", "[SOUTH]" = "East North West",
						"[EAST]" = "North West South", "[WEST]" = "South East North")
		if(DECAL_TRIN_M)
			dirs = list("[NORTH]" = "North East South", "[SOUTHWEST]" = "North West South",
						"[NORTHEAST]" = "South East North", "[SOUTH]" = "South West North",
						"[WEST]" = "West North East", "[SOUTHEAST]" = "West South East",
						"[NORTHWEST]" = "East North West", "[EAST]" = "East South West",)
		if(DECAL_UNARY)
			dirs = list("[NORTH]" = "North", "[SOUTH]" = "South", "[WEST]" = "West", "[EAST]" = "East")
		if(DECAL_ONEDIR)
			dirs = list("[SOUTH]" = name)
		if(DECAL_UNARY_FLIPPABLE)
			dirs = list("[NORTH]" = "North", "[EAST]" = "East", "[SOUTH]" = "South", "[WEST]" = "West",
						"[NORTHEAST]" = "North Flipped", "[SOUTHEAST]" = "East Flipped", "[SOUTHWEST]" = "South Flipped", "[NORTHWEST]" = "West Flipped")


	var/list/rows = list()
	var/list/row = list("previews" = list())
	var/i = 0
	for(var/dir in dirs)
		var/numdir = text2num(dir)
		var/flipped = ((dirtype == DECAL_TRIN_M) || (dirtype == DECAL_UNARY_FLIPPABLE)) && (numdir in GLOB.diagonals)
		row["previews"] += list(list("selected" = (numdir == selected_dir), "dir" = dir2text(numdir), "dir_name" = dirs[dir], "icon_state" = icon_state, "flipped" = flipped))
		if(i++ || dirtype == DECAL_ONEDIR)
			rows += list(row)
			row = list("previews" = list())
			i = 0

	return rows
/obj/effect/turf_decal
	var/dirtype = DECAL_UNARY

/datum/decal_info/New(label, obj/effect/turf_decal/path)
	name = label
	id = path
	icon_state = initial(path.icon_state)
	var/obj/effect/turf_decal/d = initial(path.construction_type)
	dirtype = initial(d.dirtype)

/obj/item/decal_dispenser
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
	var/datum/effect_system/spark_spread/spark_system
	var/effectcooldown
	var/working = 0
	var/p_dir = NORTH
	var/p_flipped = FALSE
	var/paint_color = "grey"
	var/print_speed = 3 // 300ms
	var/clean_speed = 2
	var/repaint_speed = 2
	var/datum/pipe_info/recipe
	var/static/datum/decal_info/first_marking
	var/static/datum/decal_info/first_coloring
	var/mode = PRINT_MODE | CLEAN_MODE

/obj/item/decal_dispenser/New()
	. = ..()
	spark_system = new /datum/effect_system/spark_spread
	spark_system.set_up(1, 0, src)
	spark_system.attach(src)
	if(!first_marking)
		first_marking = GLOB.tile_marking_recipes[GLOB.tile_marking_recipes[1]][1]
	if(!first_coloring)
		first_coloring = GLOB.tile_coloring_recipes[GLOB.tile_coloring_recipes[1]][1]

	recipe = first_marking

/obj/item/decal_dispenser/Destroy()
	qdel(spark_system)
	spark_system = null
	return ..()

/obj/item/decal_dispenser/attack_self(mob/user)
	ui_interact(user)

/obj/item/decal_dispenser/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] points the end of the RDD at [user.p_their()] chest and marks himself for death! It looks like [user.p_theyre()] trying to commit suicide...</span>")
	playsound(get_turf(user), 'sound/machines/click.ogg', 50, 1)
	playsound(get_turf(user), 'sound/items/deconstruct.ogg', 50, 1)
	return(BRUTELOSS)

/datum/asset/spritesheet/decals
	name = "pipes"

/datum/asset/spritesheet/decals/register()
	InsertAll("", 'icons/turf/decals.dmi', GLOB.alldirs)
	..()

/obj/item/decal_dispenser/ui_base_html(html)
	var/datum/asset/spritesheet/assets = get_asset_datum(/datum/asset/spritesheet/decals)
	. = replacetext(html, "<!--customheadhtml-->", assets.css_tag())

/obj/item/decal_dispenser/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = FALSE, \
									datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		var/datum/asset/assets = get_asset_datum(/datum/asset/spritesheet/decals)
		assets.send(user)

		ui = new(user, src, ui_key, "rdd", name, 425, 472, master_ui, state)
		ui.open()

/obj/item/decal_dispenser/ui_data(mob/user)
	var/list/data = list(
		"category" = category,
		"preview_rows" = recipe.get_preview(p_dir),
		"categories" = list(),
		"selected_color" = paint_color,
		"paint_colors" = GLOB.pipe_paint_colors,
		"mode" = mode
	)

	var/list/recipes
	switch(category)
		if(MARKING_CATEGORY)
			recipes = GLOB.tile_marking_recipes
		if(COLORING_CATEGORY)
			recipes = GLOB.tile_coloring_recipes
	for(var/c in recipes)
		var/list/cat = recipes[c]
		var/list/r = list()
		for(var/i in 1 to cat.len)
			var/datum/decal_info/info = cat[i]
			r += list(list("decal_name" = info.name, "decal_index" = i, "selected" = (info == recipe)))
		data["categories"] += list(list("cat_name" = c, "recipes" = r))

	return data

/obj/item/decal_dispenser/ui_act(action, params)
	if(..())
		return
	if(!usr.canUseTopic(src))
		return
	var/playeffect = TRUE
	switch(action)
		if("color")
			paint_color = params["paint_color"]
		if("category")
			category = text2num(params["category"])
			switch(category)
				if(MARKING_CATEGORY)
					recipe = first_marking
				if(COLORING_CATEGORY)
					recipe = first_coloring
			p_dir = NORTH
			playeffect = FALSE
		if("decal_type")
			var/static/list/recipes
			if(!recipes)
				recipes = GLOB.tile_marking_recipes +  GLOB.tile_coloring_recipes
			recipe = recipes[params["category"]][text2num(params["decal_type"])]
			p_dir = NORTH
		if("setdir")
			p_dir = text2dir(params["dir"])
			p_flipped = text2num(params["flipped"])
			playeffect = FALSE
		if("mode")
			var/n = text2num(params["mode"])
			if(mode & n)
				mode &= ~n
			else
				mode |= n

	if(playeffect && world.time >= effectcooldown)
		spark_system.start()
		effectcooldown = world.time + 100
		playsound(get_turf(src), 'sound/effects/pop.ogg', 50, 0)
	return TRUE

/obj/item/decal_dispenser/pre_attack(atom/A, mob/user)
	var/turf/T = get_turf(A)
	if(!user.IsAdvancedToolUser() || !T || istype(T, /turf/closed))
		return ..()

	//So that changing the menu settings doesn't affect the pipes already being built.
	var/queued_p_type = recipe.id
	var/queued_p_dir = p_dir
	var/queued_p_flipped = p_flipped

	. = TRUE

	if((mode & CLEAN_MODE) && istype(A, /obj/item/pipe) || istype(A, /obj/structure/disposalconstruct) || istype(A, /obj/structure/c_transit_tube) || istype(A, /obj/structure/c_transit_tube_pod) || istype(A, /obj/item/pipe_meter))
		to_chat(user, "<span class='notice'>You start cleaning the decals...</span>")
		playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
		if(do_after(user, print_speed, target = A))
			activate()
			qdel(A)
		return

	if((mode & REPAINT_MODE))
		if(istype(A, /obj/machinery/atmospherics/pipe) && !istype(A, /obj/machinery/atmospherics/pipe/layer_manifold))
			var/obj/machinery/atmospherics/pipe/P = A
			to_chat(user, "<span class='notice'>You start painting \the [P] [paint_color]...</span>")
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, repaint_speed, target = A))
				P.paint(GLOB.pipe_paint_colors[paint_color]) //paint the pipe
				user.visible_message("<span class='notice'>[user] paints \the [P] [paint_color].</span>","<span class='notice'>You paint \the [P] [paint_color].</span>")
			return
		var/obj/item/pipe/P = A
		if(istype(P) && findtext("[P.pipe_type]", "/obj/machinery/atmospherics/pipe") && !findtext("[P.pipe_type]", "layer_manifold"))
			to_chat(user, "<span class='notice'>You start painting \the [A] [paint_color]...</span>")
			playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
			if(do_after(user, repaint_speed, target = A))
				A.add_atom_colour(GLOB.pipe_paint_colors[paint_color], FIXED_COLOUR_PRIORITY) //paint the pipe
				user.visible_message("<span class='notice'>[user] paints \the [A] [paint_color].</span>","<span class='notice'>You paint \the [A] [paint_color].</span>")
			return

	if(mode & PRINT_MODE)
		switch(category) //if we've gotten this var, the target is valid
			if(ATMOS_CATEGORY) //Making pipes
				if(!can_make_pipe)
					return ..()
				A = T
				if(is_type_in_typecache(recipe, GLOB.ventcrawl_machinery) && isclosedturf(A)) //wall escapism sanity check.
					to_chat(user, "<span class='warning'>[src]'s error light flickers; there's something in the way!</span>")
					return
				playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
				if (recipe.type == /datum/pipe_info/meter)
					to_chat(user, "<span class='notice'>You start building a meter...</span>")
					if(do_after(user, atmos_build_speed, target = A))
						activate()
						var/obj/item/pipe_meter/PM = new /obj/item/pipe_meter(A)
						PM.setAttachLayer(piping_layer)
						if(mode & WRENCH_MODE)
							PM.wrench_act(user, src)
				else
					to_chat(user, "<span class='notice'>You start building a pipe...</span>")
					if(do_after(user, atmos_build_speed, target = A))
						activate()
						var/obj/machinery/atmospherics/path = queued_p_type
						var/pipe_item_type = initial(path.construction_type) || /obj/item/pipe
						var/obj/item/pipe/P = new pipe_item_type(A, queued_p_type, queued_p_dir)

						if(queued_p_flipped && istype(P, /obj/item/pipe/trinary/flippable))
							var/obj/item/pipe/trinary/flippable/F = P
							F.flipped = queued_p_flipped

						P.update()
						P.add_fingerprint(usr)
						P.setPipingLayer(piping_layer)
						if(findtext("[queued_p_type]", "/obj/machinery/atmospherics/pipe") && !findtext("[queued_p_type]", "layer_manifold"))
							P.add_atom_colour(GLOB.pipe_paint_colors[paint_color], FIXED_COLOUR_PRIORITY)
						if(mode & WRENCH_MODE)
							P.wrench_act(user, src)

			if(DISPOSALS_CATEGORY) //Making disposals pipes
				if(!can_make_pipe)
					return ..()
				A = T
				if(isclosedturf(A))
					to_chat(user, "<span class='warning'>[src]'s error light flickers; there's something in the way!</span>")
					return
				to_chat(user, "<span class='notice'>You start building a disposals pipe...</span>")
				playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)
				if(do_after(user, disposal_build_speed, target = A))
					var/obj/structure/disposalconstruct/C = new (A, queued_p_type, queued_p_dir, queued_p_flipped)

					if(!C.can_place())
						to_chat(user, "<span class='warning'>There's not enough room to build that here!</span>")
						qdel(C)
						return

					activate()

					C.add_fingerprint(usr)
					C.update_icon()
					if(mode & WRENCH_MODE)
						C.wrench_act(user, src)
					return

			else
				return ..()

/obj/item/decal_dispenser/proc/activate()
	playsound(get_turf(src), 'sound/items/deconstruct.ogg', 50, 1)

#undef MARKING_CATEGORY
#undef COLORING_CATEGORY

#undef PRINT_MODE
#undef CLEAN_MODE
#undef REPAINT_MODE
