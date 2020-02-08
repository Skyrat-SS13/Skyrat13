/obj/structure/windoor_assembly/attackby(obj/item/W, mob/user, params)
	//I really should have spread this out across more states but thin little windoors are hard to sprite.
	add_fingerprint(user)
	switch(state)
		if("01")
			if(istype(W, /obj/item/weldingtool) && !anchored)
				if(!W.tool_start_check(user, amount=0))
					return

				user.visible_message("[user] disassembles the windoor assembly.",
					"<span class='notice'>You start to disassemble the windoor assembly...</span>")

				if(W.use_tool(src, user, 40, volume=50))
					to_chat(user, "<span class='notice'>You disassemble the windoor assembly.</span>")
					var/obj/item/stack/sheet/rglass/RG = new (get_turf(src), 5)
					RG.add_fingerprint(user)
					if(secure)
						var/obj/item/stack/rods/R = new (get_turf(src), 4)
						R.add_fingerprint(user)
					qdel(src)
				return

			//Wrenching an unsecure assembly anchors it in place. Step 4 complete
			if(istype(W, /obj/item/wrench) && !anchored)
				for(var/obj/machinery/door/window/WD in loc)
					if(WD.dir == dir)
						to_chat(user, "<span class='warning'>There is already a windoor in that location!</span>")
						return
				user.visible_message("[user] secures the windoor assembly to the floor.",
					"<span class='notice'>You start to secure the windoor assembly to the floor...</span>")

				if(W.use_tool(src, user, 40, volume=100))
					if(anchored)
						return
					for(var/obj/machinery/door/window/WD in loc)
						if(WD.dir == dir)
							to_chat(user, "<span class='warning'>There is already a windoor in that location!</span>")
							return
					to_chat(user, "<span class='notice'>You secure the windoor assembly.</span>")
					setAnchored(TRUE)
					if(secure)
						name = "secure anchored windoor assembly"
					else
						name = "anchored windoor assembly"

			//Unwrenching an unsecure assembly un-anchors it. Step 4 undone
			else if(istype(W, /obj/item/wrench) && anchored)
				user.visible_message("[user] unsecures the windoor assembly to the floor.",
					"<span class='notice'>You start to unsecure the windoor assembly to the floor...</span>")

				if(W.use_tool(src, user, 40, volume=100))
					if(!anchored)
						return
					to_chat(user, "<span class='notice'>You unsecure the windoor assembly.</span>")
					setAnchored(FALSE)
					if(secure)
						name = "secure windoor assembly"
					else
						name = "windoor assembly"

			//Adding plasteel makes the assembly a secure windoor assembly. Step 2 (optional) complete.
			else if(istype(W, /obj/item/stack/sheet/plasteel) && !secure)
				var/obj/item/stack/sheet/plasteel/P = W
				if(P.get_amount() < 2)
					to_chat(user, "<span class='warning'>You need more plasteel to do this!</span>")
					return
				to_chat(user, "<span class='notice'>You start to reinforce the windoor with plasteel...</span>")

				if(do_after(user,40, target = src))
					if(!src || secure || P.get_amount() < 2)
						return

					P.use(2)
					to_chat(user, "<span class='notice'>You reinforce the windoor.</span>")
					secure = TRUE
					if(anchored)
						name = "secure anchored windoor assembly"
					else
						name = "secure windoor assembly"

			//Adding cable to the assembly. Step 5 complete.
			else if(istype(W, /obj/item/stack/cable_coil) && anchored)
				user.visible_message("[user] wires the windoor assembly.", "<span class='notice'>You start to wire the windoor assembly...</span>")

				if(do_after(user, 40, target = src))
					if(!src || !anchored || src.state != "01")
						return
					var/obj/item/stack/cable_coil/CC = W
					if(!CC.use(1))
						to_chat(user, "<span class='warning'>You need more cable to do this!</span>")
						return
					to_chat(user, "<span class='notice'>You wire the windoor.</span>")
					state = "02"
					if(secure)
						name = "secure wired windoor assembly"
					else
						name = "wired windoor assembly"
			else
				return ..()

		if("02")

			//Removing wire from the assembly. Step 5 undone.
			if(istype(W, /obj/item/wirecutters))
				user.visible_message("[user] cuts the wires from the airlock assembly.", "<span class='notice'>You start to cut the wires from airlock assembly...</span>")

				if(W.use_tool(src, user, 40, volume=100))
					if(state != "02")
						return

					to_chat(user, "<span class='notice'>You cut the windoor wires.</span>")
					new/obj/item/stack/cable_coil(get_turf(user), 1)
					state = "01"
					if(secure)
						name = "secure anchored windoor assembly"
					else
						name = "anchored windoor assembly"

			//Adding airlock electronics for access. Step 6 complete.
			else if(istype(W, /obj/item/electronics/airlock))
				if(iscarbon(user))
					if(!user.transferItemToLoc(W, src))
						return
				W.play_tool_sound(src, 100)
				user.visible_message("[user] installs the electronics into the airlock assembly.",
					"<span class='notice'>You start to install electronics into the airlock assembly...</span>")

				if(do_after(user, 40, target = src))
					if(iscarbon(user))
						if(!src || electronics)
							W.forceMove(drop_location())
					to_chat(user, "<span class='notice'>You install the airlock electronics.</span>")
					name = "near finished windoor assembly"
					electronics = W
				else
					if(iscarbon(user))
						W.forceMove(drop_location())

			//Screwdriver to remove airlock electronics. Step 6 undone.
			else if(istype(W, /obj/item/screwdriver))
				if(!electronics)
					return

				user.visible_message("[user] removes the electronics from the airlock assembly.",
					"<span class='notice'>You start to uninstall electronics from the airlock assembly...</span>")

				if(W.use_tool(src, user, 40, volume=100) && electronics)
					to_chat(user, "<span class='notice'>You remove the airlock electronics.</span>")
					name = "wired windoor assembly"
					var/obj/item/electronics/airlock/ae
					ae = electronics
					if(iscarbon(user))
						electronics = null
						ae.forceMove(drop_location())

			else if(istype(W, /obj/item/pen))
				var/t = stripped_input(user, "Enter the name for the door.", name, created_name,MAX_NAME_LEN)
				if(!t)
					return
				if(!in_range(src, usr) && loc != usr)
					return
				created_name = t
				return



			//Crowbar to complete the assembly, Step 7 complete.
			else if(istype(W, /obj/item/crowbar))
				if(!electronics)
					to_chat(usr, "<span class='warning'>The assembly is missing electronics!</span>")
					return
				user << browse(null, "window=windoor_access")
				user.visible_message("[user] pries the windoor into the frame.",
					"<span class='notice'>You start prying the windoor into the frame...</span>")

				if(W.use_tool(src, user, 40, volume=100) && electronics)

					density = TRUE //Shouldn't matter but just incase
					to_chat(user, "<span class='notice'>You finish the windoor.</span>")

					if(secure)
						var/obj/machinery/door/window/brigdoor/windoor = new /obj/machinery/door/window/brigdoor(loc)
						if(facing == "l")
							windoor.icon_state = "leftsecureopen"
							windoor.base_state = "leftsecure"
						else
							windoor.icon_state = "rightsecureopen"
							windoor.base_state = "rightsecure"
						windoor.setDir(dir)
						windoor.density = FALSE

						if(electronics.one_access)
							windoor.req_one_access = electronics.accesses
						else
							windoor.req_access = electronics.accesses
						if(iscarbon(user))
							windoor.electronics = electronics
							electronics.forceMove(windoor)
						if(created_name)
							windoor.name = created_name
						qdel(src)
					else
						var/obj/machinery/door/window/windoor = new /obj/machinery/door/window(loc)
						if(facing == "l")
							windoor.icon_state = "leftopen"
							windoor.base_state = "left"
						else
							windoor.icon_state = "rightopen"
							windoor.base_state = "right"
						windoor.setDir(dir)
						windoor.density = FALSE

						if(electronics.one_access)
							windoor.req_one_access = electronics.accesses
						else
							windoor.req_access = electronics.accesses
						windoor.electronics = electronics
						electronics.loc = windoor
						if(created_name)
							windoor.name = created_name
						qdel(src)


			else
				return ..()

	//Update to reflect changes(if applicable)
	update_icon()
