/obj/mecha/attackby(obj/item/W as obj, mob/user as mob, params)

	if(istype(W, /obj/item/mmi))
		if(mmi_move_inside(W,user))
			to_chat(user, "[src]-[W] interface initialized successfully.")
		else
			to_chat(user, "[src]-[W] interface initialization failed.")
		return

	if(istype(W, /obj/item/mecha_ammo))
		ammo_resupply(W, user)
		return

	if(istype(W, /obj/item/mecha_parts/mecha_equipment))
		var/obj/item/mecha_parts/mecha_equipment/E = W
		spawn()
			if(E.can_attach(src))
				if(!user.temporarilyRemoveItemFromInventory(W))
					return
				E.attach(src)
				user.visible_message("[user] attaches [W] to [src].", "<span class='notice'>You attach [W] to [src].</span>")
			else
				to_chat(user, "<span class='warning'>You were unable to attach [W] to [src]!</span>")
		return
	if(W.GetID())
		if(add_req_access || maint_access)
			if(internals_access_allowed(user))
				var/obj/item/card/id/id_card
				if(istype(W, /obj/item/card/id))
					id_card = W
				else
					var/obj/item/pda/pda = W
					id_card = pda.id
				output_maintenance_dialog(id_card, user)
				return
			else
				to_chat(user, "<span class='warning'>Invalid ID: Access denied.</span>")
		else
			to_chat(user, "<span class='warning'>Maintenance protocols disabled by operator.</span>")
	else if(istype(W, /obj/item/wrench))
		if(state==1)
			state = 2
			to_chat(user, "<span class='notice'>You undo the securing bolts.</span>")
		else if(state==2)
			state = 1
			to_chat(user, "<span class='notice'>You tighten the securing bolts.</span>")
		return
	else if(istype(W, /obj/item/crowbar))
		if(state==2)
			state = 3
			to_chat(user, "<span class='notice'>You open the hatch to the power unit.</span>")
		else if(state==3)
			state=2
			to_chat(user, "<span class='notice'>You close the hatch to the power unit.</span>")
		return
	else if(istype(W, /obj/item/stack/cable_coil))
		if(state == 3 && (internal_damage & MECHA_INT_SHORT_CIRCUIT))
			var/obj/item/stack/cable_coil/CC = W
			if(CC.use(2))
				clearInternalDamage(MECHA_INT_SHORT_CIRCUIT)
				to_chat(user, "<span class='notice'>You replace the fused wires.</span>")
			else
				to_chat(user, "<span class='warning'>You need two lengths of cable to fix this mech!</span>")
		return
	else if(istype(W, /obj/item/screwdriver) && user.a_intent != INTENT_HARM)
		if(internal_damage & MECHA_INT_TEMP_CONTROL)
			clearInternalDamage(MECHA_INT_TEMP_CONTROL)
			to_chat(user, "<span class='notice'>You repair the damaged temperature controller.</span>")
		else if(state==3 && cell)
			cell.forceMove(loc)
			cell = null
			state = 4
			to_chat(user, "<span class='notice'>You unscrew and pry out the powercell.</span>")
			mecha_log_message("Powercell removed")
		else if(state==4 && cell)
			state=3
			to_chat(user, "<span class='notice'>You screw the cell in place.</span>")
		return
	else if(istype(W, /obj/item/multitool))
		if(state == 4)
			to_chat(user, "<span class='notice'>You manually toggle \the [src]'s security protocols.</span>")
			if(securitylevelrestriction)
				savedrestriction = securitylevelrestriction
				securitylevelrestriction = null 
			else
				securitylevelrestriction = savedrestriction
				savedrestriction = null 
		return
