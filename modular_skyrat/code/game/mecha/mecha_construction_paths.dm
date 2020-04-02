/datum/component/construction/unordered/mecha_chassis/skyrat/custom_action(obj/item/I, mob/living/user, typepath)
	. = user.transferItemToLoc(I, parent)
	if(.)
		var/atom/parent_atom = parent
		user.visible_message("[user] has connected [I] to [parent].", "<span class='notice'>You connect [I] to [parent].</span>")
		parent_atom.add_overlay(I.icon_state+"+o")
		qdel(I)

/datum/component/construction/unordered/mecha_chassis/skyrat/spawn_result()
	. = ..()
	var/atom/parent_atom = parent
	parent_atom.icon = 'modular_skyrat/icons/mecha/mech_construction.dmi'
	parent_atom.density = TRUE
	parent_atom.cut_overlays()


/datum/component/construction/unordered/mecha_chassis/skyrat/powerarmor
	result = /datum/component/construction/mecha/powerarmor
	steps = list(
		/obj/item/mecha_parts/part/powerarmor_torso,
		/obj/item/mecha_parts/part/powerarmor_helmet,
		/obj/item/mecha_parts/part/powerarmor_left_arm,
		/obj/item/mecha_parts/part/powerarmor_right_arm,
		/obj/item/mecha_parts/part/powerarmor_left_leg,
		/obj/item/mecha_parts/part/powerarmor_right_leg,
	)

/datum/component/construction/mecha/powerarmor
	result = /obj/item/clothing/suit/space/hardsuit/security/powerarmor
	base_icon = "powerarmor"
	steps = list(
		//1
		list(
			"key" = /obj/item/stack/ore/bluespace_crystal,
			"amount" = 1,
			"desc" = "The modules are assembled."
		),

		//2
		list(
			"key" = TOOL_SCREWDRIVER,
			"desc" = "The bluespace power core is installed."
		),

		//3
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 5,
			"desc" = "The bluespace power core is secured."
		),

		//4
		list(
			"key" = TOOL_WIRECUTTER,
			"desc" = "Wires have been installed."
		),

		//5
		list(
			"key" = /obj/item/stock_parts/capacitor/quadratic,
			"action" = ITEM_DELETE,
			"desc" = "The wires have been secured."
		),

		//6
		list(
			"key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor has been installed."
		),
	)

/datum/component/construction/mecha/powerarmor/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	switch(index)
		if(1)
			user.visible_message("[user] connects [parent] bluespace power core.", "<span class='notice'>You connect [parent] bluespace power core.")
		if(2)
			user.visible_message("[user] secures [parent] bluespace power core.", "<span class='notice'>You secure [parent] bluespace power core.")
		if(3)
			user.visible_message("[user] installs wiring in [parent].", "<span class='notice'>You install wiring in [parent].")
		if(4)
			user.visible_message("[user] secures the wiring in [parent].", "<span class='notice'>You secure the wiring in [parent].")
		if(5)
			user.visible_message("[user] installs a capacitor in [parent].", "<span_class='notice'>You install a capacitor in [parent].")
		if(6)
			user.visible_message("[user] secures the capacitor, causing [parent] to retract into itself.", "<span_class='notice'>You secure the capacitor to [parent], causing it to retract into itself. It is ready for use!")
	return TRUE