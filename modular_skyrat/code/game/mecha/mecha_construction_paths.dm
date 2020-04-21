//Power armor: now actually built!
/datum/component/construction/unordered/mecha_chassis/powerarmor
	result = /datum/component/construction/mecha/powerarmor
	steps = list(
		/obj/item/mecha_parts/part/powerarmor_torso,
		/obj/item/mecha_parts/part/powerarmor_helmet,
		/obj/item/mecha_parts/part/powerarmor_left_arm,
		/obj/item/mecha_parts/part/powerarmor_right_arm,
		/obj/item/mecha_parts/part/powerarmor_left_leg,
		/obj/item/mecha_parts/part/powerarmor_right_leg
	)

/datum/component/construction/mecha/powerarmor/update_parent(step_index)
	..()
	var/atom/parent_atom = parent
	parent_atom.icon = 'modular_skyrat/icons/mecha/mech_construction.dmi'

/datum/component/construction/mecha/powerarmor/spawn_result()
	if(!result)
		return
	new result(drop_location())
	SSblackbox.record_feedback("tally", "mechas_created", 1, "Power Armor")
	QDEL_NULL(parent)

/datum/component/construction/mecha/powerarmor
	result = /obj/item/clothing/suit/space/hardsuit/powerarmor
	base_icon = "powerarmor"
	steps = list(
		//1
		list(
			"key" = TOOL_WRENCH,
			"desc" = "The parts are disconnected."
		),

		//2
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "The parts are wrenched."
		),

		//3
		list(
			"key" = /obj/item/stack/sheet/bluespace_crystal,
			"amount" = 5,
			"back_key" = TOOL_WELDER,
			"desc" = "The parts are welded onto the chassis."
		),

		//4
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The bluespace crystals are slotted."
		),

		//5
		list(
			"key" = /obj/item/stock_parts/capacitor/quadratic,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_WRENCH,
			"desc" = "The bluespace crystals are secured."
		),

		//6
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor is slotted."
		),

		//7
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 10,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor is secured."
		),

		//8
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_WIRECUTTER,
			"desc" = "The chassis is wired."
		),

		//9
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The wiring is linked to the limbs."
		),
	)

/datum/component/construction/mecha/powerarmor/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	switch(index)
		if(1)
			user.visible_message("[user] wrenches [parent]'s parts.", "<span class='notice'>You wrench [parent]'s parts.</span>")
		if(2)
			if(diff==FORWARD)
				user.visible_message("[user] welds [parent]'s parts.", "<span class='notice'>You weld [parent]'s parts</span>")
			else
				user.visible_message("[user] unwrenches [parent]'s parts.", "<span class='notice'>You unwrench [parent]'s parts.</span>")
		if(3)
			if(diff==FORWARD)
				user.visible_message("[user] slots bluespace crystals onto [parent].", "<span class='notice'>You slot the bluespace crystals onto [parent].</span>")
			else
				user.visible_message("[user] unwelds [parent]'s parts.", "<span class='notice'>You unweld [parent]'s parts.</span>")
		if(4)
			if(diff==FORWARD)
				user.visible_message("[user] secures the [parent]'s bluespace crystal slots.", "<span class='notice'>You secure the [parent]'s bluespace crystal slots</span>")
			else
				user.visible_message("[user] removes the bluespace crystals from [parent].", "<span class='notice'>You remove [parent]'s bluespace crystals.</span>")
		if(5)
			if(diff==FORWARD)
				user.visible_message("[user] slots the capacitor onto [parent].", "<span class='notice'>You slot the capacitor onto [parent].</span>")
			else
				user.visible_message("[user] unsecures the bluespace crystal slots from [parent].", "<span class='notice'>You unsecure [parent]'s bluespace crystal slots.</span>")
		if(6)
			if(diff==FORWARD)
				user.visible_message("[user] secures [parent]'s capacitor.", "<span class='notice'>You secure [parent]'s capacitor.</span>")
			else
				user.visible_message("[user] removes the [parent]'s capacitor.", "<span class='notice'>You remove the [parent]'s capacitor.</span>")
		if(7)
			if(diff==FORWARD)
				user.visible_message("[user] wires the [parent].", "<span class='notice'>You wire the [parent].</span>")
			else
				user.visible_message("[user] unsecures [parent]'s capacitor.", "<span class='notice'>You unsecure [parent]'s capacitor.</span>")
		if(8)
			if(diff==FORWARD)
				user.visible_message("[user] links [parent]'s wires to the limbs.", "<span class='notice'>You link [parent]'s wires to the limbs.</span>")
			else
				user.visible_message("[user] snips off [parent]'s wires.", "<span class='notice'>You snip off [parent]'s wires.</span>")
		if(9)
			if(diff==FORWARD)
				user.visible_message("[user] welds [parent]'s external armor layer.", "<span class='notice'>You weld [parent]'s external armor layer.</span>")
			else
				user.visible_message("[user] unlinks [parent]'s wires from the limbs.", "<span class='notice'>You unlink [parent]'s wires from the limbs.</span>")
	return TRUE

//Clarke! Taken from TG... which took from VG i think.
/datum/component/construction/unordered/mecha_chassis/clarke
	result = /datum/component/construction/mecha/clarke
	steps = list(
		/obj/item/mecha_parts/part/clarke_torso,
		/obj/item/mecha_parts/part/clarke_left_arm,
		/obj/item/mecha_parts/part/clarke_right_arm,
		/obj/item/mecha_parts/part/clarke_head
	)

/datum/component/construction/mecha/clarke
	base_icon = "clarke"
	result = /obj/mecha/working/clarke
	steps = list(
		//1
		list(
			"key" = /obj/item/stack/conveyor,
			"amount" = 4,
			"desc" = "The treads are added."
		),
		//2
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "The hydraulic systems are disconnected."
		),
		//3
		list(
			"key" = TOOL_SCREWDRIVER,
			"back_key" = TOOL_WRENCH,
			"desc" = "The hydraulic systems are connected."
		),
		//4
		list(
			"key" = /obj/item/stack/cable_coil,
			"amount" = 5,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The hydraulic systems are active."
		),
		//5
		list(
			"key" = TOOL_WIRECUTTER,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The wiring is added."
		),
		//6
		list(
			"key" = /obj/item/circuitboard/mecha/clarke/main,
			"back_key" = TOOL_WIRECUTTER,
			"desc" = "The wiring is adjusted."
		),
		//7
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The main board is installed."
		),
		//8
		list(
			"key" = /obj/item/circuitboard/mecha/clarke/peripherals,
			"back_key" = TOOL_WIRECUTTER,
			"desc" = "The main board is secured."
		),
		//9
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The peripherals control module is installed."
		),
		//10
		list(
			"key" = /obj/item/stock_parts/scanning_module,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The peripherals control module is secured."
		),
		//11
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The scanning module is installed."
		),
		//12
		list(
			"key" = /obj/item/stock_parts/capacitor,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The scanning module is secured."
		),
		//13
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor is installed."
		),
		//14
		list(
			"key" = /obj/item/stock_parts/cell,
			"action" = ITEM_MOVE_INSIDE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The capacitor is secured."
		),
		//15
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The power cell is installed."
		),
		//16
		list(
			"key" = /obj/item/stack/sheet/plasteel,
			"amount" = 5,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_SCREWDRIVER,
			"desc" = "The power cell is secured."
		),
		//17
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "The inner armor layer is installed."
		),
		//18
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "The inner armor layer is secured."
		),
		//19
		list(
			"key" = /obj/item/stack/sheet/mineral/plastitanium,
			"amount" = 15,
			"action" = ITEM_DELETE,
			"back_key" = TOOL_WELDER,
			"desc" = "The inner armor layer is welded."
		),
		//20
		list(
			"key" = TOOL_WRENCH,
			"back_key" = TOOL_CROWBAR,
			"desc" = "The external armor layer is installed."
		),
		//21
		list(
			"key" = TOOL_WELDER,
			"back_key" = TOOL_WRENCH,
			"desc" = "The external armor layer is secured."
		),
	)

/datum/component/construction/mecha/clarke/custom_action(obj/item/I, mob/living/user, diff)
	if(!..())
		return FALSE

	//TODO: better messages.
	switch(index)
		if(1)
			user.visible_message("<span class='notice'>[user] adds the tread systems.</span>", "<span class='notice'>You add the tread systems.</span>")
		if(2)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] connects [parent] hydraulic systems.</span>", "<span class='notice'>You connect [parent] hydraulic systems.</span>")
			else
				user.visible_message("<span class='notice'>[user] removes the tread systems.</span>", "<span class='notice'>You remove the tread systems.</span>")

		if(3)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] activates [parent] hydraulic systems.</span>", "<span class='notice'>You activate [parent] hydraulic systems.</span>")
			else
				user.visible_message("<span class='notice'>[user] disconnects [parent] hydraulic systems.</span>", "<span class='notice'>You disconnect [parent] hydraulic systems.</span>")
		if(4)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] adds the wiring to [parent].</span>", "<span class='notice'>You add the wiring to [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] deactivates [parent] hydraulic systems.</span>", "<span class='notice'>You deactivate [parent] hydraulic systems.</span>")
		if(5)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] adjusts the wiring of [parent].</span>", "<span class='notice'>You adjust the wiring of [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] removes the wiring from [parent].</span>", "<span class='notice'>You remove the wiring from [parent].</span>")
		if(6)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs [I] into [parent].</span>", "<span class='notice'>You install [I] into [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] disconnects the wiring of [parent].</span>", "<span class='notice'>You disconnect the wiring of [parent].</span>")
		if(7)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the mainboard.</span>", "<span class='notice'>You secure the mainboard.</span>")
			else
				user.visible_message("<span class='notice'>[user] removes the central control module from [parent].</span>", "<span class='notice'>You remove the central computer mainboard from [parent].</span>")
		if(8)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs [I] into [parent].</span>", "<span class='notice'>You install [I] into [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the mainboard.</span>", "<span class='notice'>You unfasten the mainboard.</span>")
		if(9)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the peripherals control module.</span>", "<span class='notice'>You secure the peripherals control module.</span>")
			else
				user.visible_message("<span class='notice'>[user] removes the peripherals control module from [parent].</span>", "<span class='notice'>You remove the peripherals control module from [parent].</span>")
		if(10)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs [I] into [parent].</span>", "<span class='notice'>You install [I] into [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the peripherals control module.</span>", "<span class='notice'>You unfasten the peripherals control module.</span>")
		if(11)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the scanner module.</span>", "<span class='notice'>You secure the scanner module.</span>")
			else
				user.visible_message("<span class='notice'>[user] removes the scanner module from [parent].</span>", "<span class='notice'>You remove the scanner module from [parent].</span>")
		if(12)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs [I] to [parent].</span>", "<span class='notice'>You install [I] to [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the scanner module.</span>", "<span class='notice'>You unfasten the scanner module.</span>")
		if(13)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the capacitor.</span>", "<span class='notice'>You secure the capacitor.</span>")
			else
				user.visible_message("<span class='notice'>[user] removes the capacitor from [parent].</span>", "<span class='notice'>You remove the capacitor from [parent].</span>")
		if(14)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs [I] into [parent].</span>", "<span class='notice'>You install [I] into [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the capacitor.</span>", "<span class='notice'>You unfasten the capacitor.</span>")
		if(15)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the power cell.</span>", "<span class='notice'>You secure the power cell.</span>")
			else
				user.visible_message("<span class='notice'>[user] pries the power cell from [parent].</span>", "<span class='notice'>You pry the power cell from [parent].</span>")
		if(16)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs the internal armor layer to [parent].</span>", "<span class='notice'>You install the internal armor layer to [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the power cell.</span>", "<span class='notice'>You unfasten the power cell.</span>")
		if(17)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the internal armor layer.</span>", "<span class='notice'>You secure the internal armor layer.</span>")
			else
				user.visible_message("<span class='notice'>[user] pries internal armor layer from [parent].</span>", "<span class='notice'>You pry internal armor layer from [parent].</span>")
		if(18)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] welds the internal armor layer to [parent].</span>", "<span class='notice'>You weld the internal armor layer to [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the internal armor layer.</span>", "<span class='notice'>You unfasten the internal armor layer.</span>")
		if(19)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] installs the external armor layer to [parent].</span>", "<span class='notice'>You install the external reinforced armor layer to [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] cuts the internal armor layer from [parent].</span>", "<span class='notice'>You cut the internal armor layer from [parent].</span>")
		if(20)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] secures the external armor layer.</span>", "<span class='notice'>You secure the external reinforced armor layer.</span>")
			else
				user.visible_message("<span class='notice'>[user] pries the external armor layer from [parent].</span>", "<span class='notice'>You pry the external armor layer from [parent].</span>")
		if(21)
			if(diff==FORWARD)
				user.visible_message("<span class='notice'>[user] welds the external armor layer to [parent].</span>", "<span class='notice'>You weld the external armor layer to [parent].</span>")
			else
				user.visible_message("<span class='notice'>[user] unfastens the external armor layer.</span>", "<span class='notice'>You unfasten the external armor layer.</span>")
	return TRUE

/datum/component/construction/mecha/clarke/update_parent(step_index)
	..()
	var/atom/parent_atom = parent
	parent_atom.icon = 'modular_skyrat/icons/mecha/mech_construction.dmi'
