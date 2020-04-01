/datum/component/construction/unordered/mecha_chassis/skyrat/spawn_result()
	.=..()
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
			"icon_state" = "powerarmor0" //Absolutely nothing I've tried has worked so fuck it. Im just going have to force the icon_states manually.
		),

		//2
		list(
			"key" = TOOL_SCREWDRIVER,
			"desc" = "The bluespace power core is installed."
			"icon_state" = "powerarmor1"
		),

		//3
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 5,
			"desc" = "The bluespace power core is secured."
			"icon_state" = "powerarmor2"
		),

		//4
		list(
			"key" = TOOL_WIRECUTTER,
			"desc" = "Wires have been installed."
			"icon_state" = "powerarmor3"
		),

		//5
		list(
			"key" = /obj/item/stock_parts/capacitor/quadratic,
			"action" = ITEM_DELETE,
			"desc" = "The wires have been secured."
			"icon_state" = "powerarmor4"
		),

		//6
		list(
			"key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor has been installed."
			"icon_state" = "powerarmor5"
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