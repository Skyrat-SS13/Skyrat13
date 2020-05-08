/obj/item/mecha_parts/mecha_equipment/weapon
	var/shouldberestricted = FALSE //Maybe a bit redundant. It's just a boolean checked when attacked by an ID card. If true, the ID card will fiddle with restriction, otherwise it won't.
	var/securitylevelrestriction = null //Does this weapon only work depending on the security level? If so, at which level will it work?
	var/savedrestriction = null //Used to save restrictions, for locking/unlocking the weapon with an armory access ID card.
	var/open = FALSE //Used for hacking

/obj/item/mecha_parts/mecha_equipment/weapon/emag_act()
	. = ..()
	obj_flags |= EMAGGED
	shouldberestricted = FALSE
	securitylevelrestriction = null 
	savedrestriction = null

/obj/item/mecha_parts/mecha_equipment/weapon/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/card/id) && shouldberestricted)
		var/obj/item/card/id/id = I
		if(ACCESS_ARMORY in id.access)
			to_chat(user, securitylevelrestriction ? "<span class='notice'>You lock \the [src] for security level based use.</span>" : "<span class='notice'>You unlock \the [src] from security level based use.</span>")
			if(securitylevelrestriction)
				savedrestriction = securitylevelrestriction
				securitylevelrestriction = null
			else 
				securitylevelrestriction = savedrestriction
				savedrestriction = null
	if(istype(I, /obj/item/screwdriver))
		open = !open
		to_chat(user, open ? "You open \the [src]'s hatch.' : 'You close \the [src]'s hatch.")
	if(istype(I, /obj/item/multitool) && open)
		if(securitylevelrestriction)
			savedrestriction = securitylevelrestriction
			securitylevelrestriction = null
		else 
			securitylevelrestriction = savedrestriction
			savedrestriction = null
		to_chat(user, "You hack \the [src] to have [securitylevelrestriction ? "no restrictions" : "[NUM2SECLEVEL(securitylevelrestriction)] restriction"].")

/obj/item/mecha_parts/mecha_equipment/weapon/examine(mob/user)
	. = ..()
	if(shouldberestricted)
		. +=  "It's usage is locked to [securitylevelrestriction ? NUM2SECLEVEL(securitylevelrestriction) : "no"] security level."

/obj/item/mecha_parts/mecha_equipment/weapon/action(atom/target, params)
	if(!action_checks(target))
		return 0
	if(securitylevelrestriction && !(obj_flags & EMAGGED))
		if(!(GLOB.security_level >= securitylevelrestriction))
			chassis.mecha_log_message("Attempted to fire from [src.name], targeting [target], on [NUM2SECLEVEL(securitylevelrestriction)] alert.")
			visible_message("<span class='danger'>*click*</span>")
			playsound(chassis, "gun_dry_fire", 60, 0)
			return FALSE 

	var/turf/curloc = get_turf(chassis)
	var/turf/targloc = get_turf(target)
	if (!targloc || !istype(targloc) || !curloc)
		return 0
	if (targloc == curloc)
		return 0

	set_ready_state(0)
	for(var/i=1 to get_shot_amount())
		var/obj/item/projectile/A = new projectile(curloc)
		A.firer = chassis.occupant
		A.original = target
		if(!A.suppressed && firing_effect_type)
			new firing_effect_type(get_turf(src), chassis.dir)

		var/spread = 0
		if(variance)
			if(randomspread)
				spread = round((rand() - 0.5) * variance)
			else
				spread = round((i / projectiles_per_shot - 0.5) * variance)
		A.preparePixelProjectile(target, chassis.occupant, params, spread)

		A.fire()
		playsound(chassis, fire_sound, 50, 1)

		sleep(max(0, projectile_delay))

	if(kickback)
		chassis.newtonian_move(turn(chassis.dir,180))
	chassis.mecha_log_message("Fired from [src.name], targeting [target].")
	return 1
