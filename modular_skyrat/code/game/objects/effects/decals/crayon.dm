/obj/effect/decal/tiledecal/rdd
	name = "Warning Line"
	desc = "Graffiti. Damn kids."
	icon = 'modular_skyrat/icons/effects/crayondecals.dmi'
	icon_state = "warningline_white"
	plane = GAME_PLANE //makes the graffiti visible over a wall.
	gender = NEUTER
	var/paint_colour = "#FFFFFF"

/obj/effect/decal/tiledecal/rdd/Initialize(mapload, main, type, e_name, graf_dir, alt_icon = null)
	. = ..()

	if(e_name)
		name = e_name
	desc = "A [name] improving the station."
	if(alt_icon)
		icon = alt_icon
	if(type)
		icon_state = type
	if(graf_dir)
		dir = graf_dir
	if(main)
		paint_colour = main
	add_atom_colour(paint_colour, FIXED_COLOUR_PRIORITY)
