/obj/structure/window/plastic
	name = "plastic window"
	desc = "A plastic window."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticstructures.dmi'
	heat_resistance = 100
	max_integrity = 10
	glass_type = /obj/item/stack/sheet/plastic

/obj/structure/window/plastic/unanchored
	anchored = FALSE

/obj/structure/window/plastic/fulltile
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticwindow.dmi'
	icon_state = "window"
	canSmoothWith = list(	/obj/structure/window/fulltile,
							/obj/structure/window/reinforced/fulltile,
							/obj/structure/window/reinforced/tinted/fulltile,
							/obj/structure/window/plasma/fulltile,
							/obj/structure/window/plasma/reinforced/fulltile,
							/obj/structure/window/plastic/fulltile)
	max_integrity = 20
	dir = FULLTILE_WINDOW_DIR
	fulltile = TRUE
	flags_1 = PREVENT_CLICK_UNDER_1
	smooth = SMOOTH_TRUE
	glass_amount = 2

/obj/structure/window/plastic/fulltile/unanchored
	anchored = FALSE

/obj/structure/window/plastic/attackby(obj/item/I, mob/living/user, params)
	if(!can_be_reached(user))
		return 1 //skip the afterattack

	add_fingerprint(user)

	if(istype(I, /obj/item/weldingtool) && user.a_intent == INTENT_HELP)
		if(obj_integrity < max_integrity)
			if(!I.tool_start_check(user, amount=0))
				return

			to_chat(user, "<span class='notice'>You begin repairing [src]...</span>")
			if(I.use_tool(src, user, 40, volume=50))
				obj_integrity = max_integrity
				update_nearby_icons()
				to_chat(user, "<span class='notice'>You repair [src].</span>")
		else
			to_chat(user, "<span class='warning'>[src] is already in good condition!</span>")
		return

	if(istype(I, /obj/item/electronics/electrochromatic_kit) && user.a_intent == INTENT_HELP)
		var/obj/item/electronics/electrochromatic_kit/K = I
		if(electrochromatic_status != NOT_ELECTROCHROMATIC)
			to_chat(user, "<span class='warning'>[src] is already electrochromatic!</span>")
			return
		if(anchored)
			to_chat(user, "<span class='warning'>[src] must not be attached to the floor!</span>")
			return
		if(!K.id)
			to_chat(user, "<span class='warning'>[K] has no ID set!</span>")
			return
		if(!user.temporarilyRemoveItemFromInventory(K))
			to_chat(user, "<span class='warning'>[K] is stuck to your hand!</span>")
			return
		user.visible_message("<span class='notice'>[user] upgrades [src] with [I].</span>", "<span class='notice'>You upgrade [src] with [I].</span>")
		make_electrochromatic(K.id)
		qdel(K)

	if(!(flags_1&NODECONSTRUCT_1))
		if(istype(I, /obj/item/screwdriver))
			I.play_tool_sound(src, 75)
			if(reinf)
				if(state == WINDOW_SCREWED_TO_FRAME || state == WINDOW_IN_FRAME)
					to_chat(user, "<span class='notice'>You begin to [state == WINDOW_SCREWED_TO_FRAME ? "unscrew the window from":"screw the window to"] the frame...</span>")
					if(I.use_tool(src, user, decon_speed, extra_checks = CALLBACK(src, .proc/check_state_and_anchored, state, anchored)))
						state = (state == WINDOW_IN_FRAME ? WINDOW_SCREWED_TO_FRAME : WINDOW_IN_FRAME)
						to_chat(user, "<span class='notice'>You [state == WINDOW_IN_FRAME ? "unfasten the window from":"fasten the window to"] the frame.</span>")
				else if(state == WINDOW_OUT_OF_FRAME)
					to_chat(user, "<span class='notice'>You begin to [anchored ? "unscrew the frame from":"screw the frame to"] the floor...</span>")
					if(I.use_tool(src, user, decon_speed, extra_checks = CALLBACK(src, .proc/check_state_and_anchored, state, anchored)))
						setAnchored(!anchored)
						to_chat(user, "<span class='notice'>You [anchored ? "fasten the frame to":"unfasten the frame from"] the floor.</span>")
			else //if we're not reinforced, we don't need to check or update state
				to_chat(user, "<span class='notice'>You begin to [anchored ? "unscrew the window from":"screw the window to"] the floor...</span>")
				if(I.use_tool(src, user, decon_speed, extra_checks = CALLBACK(src, .proc/check_anchored, anchored)))
					setAnchored(!anchored)
					to_chat(user, "<span class='notice'>You [anchored ? "fasten the window to":"unfasten the window from"] the floor.</span>")
			return


		else if (istype(I, /obj/item/crowbar) && reinf && (state == WINDOW_OUT_OF_FRAME || state == WINDOW_IN_FRAME))
			to_chat(user, "<span class='notice'>You begin to lever the window [state == WINDOW_OUT_OF_FRAME ? "into":"out of"] the frame...</span>")
			I.play_tool_sound(src, 75)
			if(I.use_tool(src, user, decon_speed, extra_checks = CALLBACK(src, .proc/check_state_and_anchored, state, anchored)))
				state = (state == WINDOW_OUT_OF_FRAME ? WINDOW_IN_FRAME : WINDOW_OUT_OF_FRAME)
				to_chat(user, "<span class='notice'>You pry the window [state == WINDOW_IN_FRAME ? "into":"out of"] the frame.</span>")
			return

		else if(istype(I, /obj/item/wrench) && !anchored)
			I.play_tool_sound(src, 75)
			to_chat(user, "<span class='notice'> You begin to disassemble [src]...</span>")
			if(I.use_tool(src, user, decon_speed, extra_checks = CALLBACK(src, .proc/check_state_and_anchored, state, anchored)))
				var/obj/item/stack/sheet/plastic/G = new (user.loc, glass_amount)
				G.add_fingerprint(user)
				playsound(src, 'sound/items/Deconstruct.ogg', 50, 1)
				to_chat(user, "<span class='notice'>You successfully disassemble [src].</span>")
				qdel(src)
			return
	return ..()