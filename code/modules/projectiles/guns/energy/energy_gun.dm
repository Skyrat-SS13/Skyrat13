/obj/item/gun/energy/e_gun
	name = "energy gun"
	desc = "A basic hybrid energy gun with two settings: disable and kill."
	icon_state = "energy"
	item_state = null	//so the human update icon uses the icon_state instead.
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	modifystate = 1
	can_flashlight = 1
	ammo_x_offset = 3
	flight_x_offset = 15
	flight_y_offset = 10

/obj/item/gun/energy/e_gun/mini
	name = "miniature energy gun"
	desc = "A small, pistol-sized energy gun with a built-in flashlight. It has two settings: stun and kill."
	icon_state = "mini"
	item_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell{charge = 600; maxcharge = 600}
	ammo_x_offset = 2
	charge_sections = 3
	can_flashlight = 0 // Can't attach or detach the flashlight, and override it's icon update

/obj/item/gun/energy/e_gun/mini/Initialize()
	gun_light = new /obj/item/flashlight/seclite(src)
	return ..()

/obj/item/gun/energy/e_gun/mini/update_icon()
	..()
	if(gun_light && gun_light.on)
		add_overlay("mini-light")

/obj/item/gun/energy/e_gun/stun
	name = "tactical energy gun"
	desc = "Military issue energy gun, is able to fire stun rounds."
	icon_state = "energytac"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)

/obj/item/gun/energy/e_gun/old
	name = "prototype energy gun"
	desc = "NT-P:01 Prototype Energy Gun. Early stage development of a unique laser rifle that has multifaceted energy lens allowing the gun to alter the form of projectile it fires on command."
	icon_state = "protolaser"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/laser, /obj/item/ammo_casing/energy/electrode/old)

/obj/item/gun/energy/e_gun/mini/practice_phaser
	name = "practice phaser"
	desc = "A modified version of the basic phaser gun, this one fires less concentrated energy bolts designed for target practice."
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/practice)
	icon_state = "decloner"

/obj/item/gun/energy/e_gun/hos
	name = "\improper X-01 MultiPhase Energy Gun"
	desc = "This is an expensive, modern recreation of a Z-10 MultiPhase Energy Gun. This gun has several unique firemodes, but lacks the ability to recharge over time in exchange for inbuilt advanced firearm EMP shielding."
	icon_state = "hoslaser"
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/ion/hos)
	ammo_x_offset = 4
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/gun/energy/e_gun/hos/emp_act(severity)
	return

/obj/item/gun/energy/e_gun/dragnet
	name = "\improper DRAGnet"
	desc = "The \"Dynamic Rapid-Apprehension of the Guilty\" net is a revolution in law enforcement technology."
	icon_state = "dragnet"
	item_state = "dragnet"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/net, /obj/item/ammo_casing/energy/trap)
	can_flashlight = 0
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/dragnet/snare
	name = "Energy Snare Launcher"
	desc = "Fires an energy snare that slows the target down."
	ammo_type = list(/obj/item/ammo_casing/energy/trap)

/obj/item/gun/energy/e_gun/turret
	name = "hybrid turret gun"
	desc = "A heavy hybrid energy cannon with two settings: Stun and kill."
	icon_state = "turretlaser"
	item_state = "turretlaser"
	slot_flags = null
	w_class = WEIGHT_CLASS_HUGE
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	weapon_weight = WEAPON_HEAVY
	can_flashlight = 0
	trigger_guard = TRIGGER_GUARD_NONE
	ammo_x_offset = 2

/obj/item/gun/energy/e_gun/nuclear
	name = "advanced energy gun"
	desc = "An energy gun with an experimental miniaturized nuclear reactor that automatically charges the internal power cell."
	icon_state = "nucgun"
	item_state = "nucgun"
	charge_delay = 5
	pin = null
	can_charge = 0
	ammo_x_offset = 1
	ammo_type = list(/obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	selfcharge = EGUN_SELFCHARGE
	var/fail_tick = 0
	var/fail_chance = 0

/obj/item/gun/energy/e_gun/nuclear/process()
	if(fail_tick > 0)
		fail_tick--
	..()

/obj/item/gun/energy/e_gun/nuclear/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	failcheck()
	update_icon()
	..()

/obj/item/gun/energy/e_gun/nuclear/proc/failcheck()
	if(prob(fail_chance))
		switch(fail_tick)
			if(0 to 200)
				fail_tick += (2*(fail_chance))
				radiation_pulse(src, 50)
				var/mob/M = (ismob(loc) && loc) || (ismob(loc.loc) && loc.loc)		//thank you short circuiting. if you powergame and nest these guns deeply you get to suffer no-warning radiation death.
				if(M)
					to_chat(M, "<span class='userdanger'>Your [name] feels warmer.</span>")
			if(201 to INFINITY)
				SSobj.processing.Remove(src)
				radiation_pulse(src, 200)
				crit_fail = TRUE
				var/mob/M = (ismob(loc) && loc) || (ismob(loc.loc) && loc.loc)
				if(M)
					to_chat(M, "<span class='userdanger'>Your [name]'s reactor overloads!</span>")

/obj/item/gun/energy/e_gun/nuclear/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	fail_chance = min(fail_chance + round(15/severity), 100)

/obj/item/gun/energy/e_gun/nuclear/update_icon()
	..()
	if(crit_fail)
		add_overlay("[icon_state]_fail_3")
	else
		switch(fail_tick)
			if(0)
				add_overlay("[icon_state]_fail_0")
			if(1 to 150)
				add_overlay("[icon_state]_fail_1")
			if(151 to INFINITY)
				add_overlay("[icon_state]_fail_2")

/obj/item/gun/energy/e_gun/large //SPECIAL THANKS to Jake Park for helping me with the alert lock code! You're the best, man <3
	name = "energy rifle"
	desc = "A basic hybrid energy rifle with two settings: disable and kill."
	icon_state = "energy_rifle"
	cell_type = /obj/item/stock_parts/cell/secborg
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	charge_sections = 3
	var/weapon_hacked = FALSE //Is this weapon hacked to allow lethal blasts outside of an alert level?
	var/weapon_superhacked = FALSE //Have the weapon's safeties been irreparably damaged?
	var/panel_open = FALSE //Is this weapon's modification panel currently open?
	var/sec_level = SEC_LEVEL_GREEN

/obj/item/gun/energy/e_gun/large/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/gun/energy/e_gun/large/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/gun/energy/e_gun/large/process()
	if(GLOB.security_level == SEC_LEVEL_GREEN && current_firemode_index == 2)
		if(!weapon_hacked && !weapon_superhacked)
			audible_message("<span class='warning'>WARNING: Security level mismatch, changing energy mode!</span>")
			playsound(loc, 'sound/machines/beep.ogg', 50, 1)
			chambered = null
			current_firemode_index = 1
			fire_sound = 'sound/weapons/taser2.ogg' //I have to set these manually unfortunately
			fire_delay = 3.5
			post_set_firemode()
			update_icon(TRUE)

/obj/item/gun/energy/e_gun/large/attack_self(mob/living/user)
	. = ..()
	if(can_select_fire(user))
		if(GLOB.security_level == SEC_LEVEL_GREEN && !weapon_hacked && !weapon_superhacked)
			audible_message("<span class='warning'>ERROR: Security level mismatch, cannot change energy mode!</span>")
			playsound(loc, 'sound/machines/beep.ogg', 50, 1)
			chambered = null
			current_firemode_index = 1
			fire_sound = 'sound/weapons/taser2.ogg'
			fire_delay = 3.5
			post_set_firemode()
			update_icon(TRUE)
		else
			return

/obj/item/gun/energy/e_gun/large/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE

	panel_open = !panel_open
	to_chat(user, "<span class='notice'>You [panel_open ? "open" : "close"] the circuitry panel on the rifle.</span>")
	desc = "A basic hybrid energy rifle with two settings: disable and kill. [panel_open ? "<b>Its modification panel is open!</b>" : " "]"

/obj/item/gun/energy/e_gun/large/multitool_act(mob/user, obj/item/I)
	if(panel_open)
		weapon_hacked = !weapon_hacked
		to_chat(user, "<span class='warning'>You modify the safety circuit on the rifle, [weapon_hacked ? "enabling" : "disabling"] unrestricted lethal firing.</span>")
		playsound(src, 'sound/machines/terminal_alert.ogg', 10, 1)
	else
		return

/obj/item/gun/energy/e_gun/large/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	weapon_hacked = TRUE
	weapon_superhacked = TRUE
	to_chat(user, "<span class='warning'>You swipe the card along the rifle, shutting off its lethal firing safeties!</span>")
	playsound(src, 'sound/machines/terminal_alert.ogg', 20, 2)
	STOP_PROCESSING(SSobj, src)
	. = ..()

