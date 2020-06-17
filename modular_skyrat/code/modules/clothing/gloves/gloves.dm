//blueshit gloves
/obj/item/clothing/gloves/combat/blueshield
    name = "combat gloves"
    desc = "These tactical gloves appear to be unique, made out of double woven durathread fibers which make it fireproof as well as acid resistant"
    icon_state = "combat"
    item_state = "blackgloves"
    siemens_coefficient = 0
    permeability_coefficient = 0.05
    strip_delay = 80
    cold_protection = HANDS
    min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
    heat_protection = HANDS
    max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
    resistance_flags = FIRE_PROOF |  ACID_PROOF
    armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100, "wound" = 15)
    strip_mod = 1.5

//Power gloves (TM)
/obj/item/clothing/gloves/color/yellow/power
	name = "\proper Power Gloves (TM)"
	desc = "Produced by Not-tendo, these gloves are capable of both stunning and throwing lightning bolts at targets."
	icon = 'modular_skyrat/icons/obj/clothing/gloves.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/hands.dmi'
	icon_state = "powergloves"
	item_state = "powergloves"
	var/obj/item/stock_parts/cell/ourcell
	var/stamforce = 50
	var/stuncost = 250
	var/boltcost = 1000
	var/knockdown = TRUE
	var/knockdown_force = 100
	var/lightning_energy = 50
	var/bounces = 5
	var/mode = "none"
	var/worn = FALSE
	actions_types = list(/datum/action/item_action/powerstun, /datum/action/item_action/powerbolt)

/datum/action/item_action/powerstun
	name = "Stun Mode"
	desc = "Activate/Deactivate powerglove stun mode."

/datum/action/item_action/powerbolt
	name = "Lightning Bolt Mode"
	desc = "Activate/Deactivate lightning bolt mode."

/obj/item/clothing/gloves/color/yellow/power/Initialize()
	..()
	ourcell = new /obj/item/stock_parts/cell(src)

/obj/item/clothing/gloves/color/yellow/power/examine(mob/user)
	. = ..()
	var/chargepercentage = ((ourcell.charge/ourcell.maxcharge) * 100)
	. += " It's cell is [chargepercentage]% charged. <br> It is currently in [mode] mode."

/obj/item/clothing/gloves/color/yellow/power/equipped(mob/living/M, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		for(var/datum/action/item_action/A in actions_types)
			A.Grant(M, src)
		worn = TRUE

/obj/item/clothing/gloves/color/yellow/power/dropped(mob/living/M, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		for(var/datum/action/item_action/A in actions_types)
			A.Remove(M, src)
		worn = FALSE

/obj/item/clothing/gloves/color/yellow/power/ui_action_click(mob/living/user, action)
	if(istype(action, /datum/action/item_action/powerstun))
		if(mode != "stun")
			mode = "stun"
			to_chat(user, "<span class='notice'>You will now stun your target.</span>")
		else
			mode = "none"
			to_chat(user, "<span class='notice'>Stun mode deactivated.</span>")
	else if(istype(action, /datum/action/item_action/powerbolt))
		if(mode != "bolt")
			mode = "bolt"
			to_chat(user, "<span class='notice'>You will now throw a lightning bolt at your target.</span>")
		else
			mode = "none"
			to_chat(user, "<span class='notice'>Lightning bolt mode deactivated.</span>")

/obj/item/clothing/gloves/color/yellow/power/Touch(atom/A, proximity)
	var/mob/user = usr
	if(!worn)
		return FALSE
	if(!user)
		return FALSE
	if(mode == "stun")
		if(ishuman(A) && proximity)
			Stun(user, A, TRUE, knockdown_force)
			return TRUE
		return FALSE
	else if(mode == "bolt")
		if(isliving(A))
			Bolt(origin = user, target = A, bolt_energy = lightning_energy, bounces = 5, usecharge = TRUE)
			return TRUE
		return FALSE
	else
		return FALSE

/obj/item/clothing/gloves/color/yellow/power/proc/Stun(mob/user, mob/living/target, disarming = TRUE, knockdown_force = 100)
	var/obj/item/stock_parts/cell/our_cell = ourcell
	if(!our_cell || !our_cell.charge)
		return FALSE
	var/stunpwr = stamforce
	var/stuncharge = our_cell.charge
	if(QDELETED(src) || QDELETED(our_cell)) //it was rigged (somehow?)
		return FALSE
	if(stuncharge < stuncost)
		target.visible_message("<span class='warning'>[user] has touched [target] with [src]. Luckily it was out of charge.</span>", \
							"<span class='warning'>[user] has touched you with [src]. Luckily it was out of charge.</span>")
		return FALSE
	if(knockdown)
		target.DefaultCombatKnockdown(knockdown_force, override_stamdmg = 0)
		target.adjustStaminaLoss(stunpwr)
	if(disarming)
		target.drop_all_held_items()
	target.apply_effect(EFFECT_STUTTER, stamforce)
	SEND_SIGNAL(target, COMSIG_LIVING_MINOR_SHOCK)
	if(user)
		target.lastattacker = user.real_name
		target.lastattackerckey = user.ckey
		target.visible_message("<span class='danger'>[user] has stunned [target] with [src]!</span>", \
								"<span class='userdanger'>[user] has stunned you with [src]!</span>")
		log_combat(user, target, "stunned")
	playsound(loc, 'sound/weapons/egloves.ogg', 100, 1, -1)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.forcesay(GLOB.hit_appends)
	our_cell.use(stuncost)
	return TRUE

/obj/item/clothing/gloves/color/yellow/power/proc/Bolt(mob/origin = usr,mob/target = null, bolt_energy = 50,bounces = 5,mob/user = usr, usecharge = TRUE)
	playsound(get_turf(origin), 'sound/magic/lightningshock.ogg', 150, 1, -1)
	origin.Beam(target,icon_state="lightning[rand(1,12)]",time=5, maxdistance = 7)
	var/mob/living/current = target
	if(bounces < 1)
		current.electrocute_act(bolt_energy,"Lightning Bolt", flags = SHOCK_TESLA)
		playsound(get_turf(current), 'sound/magic/lightningshock.ogg', 150, 1, -1)
	else
		current.electrocute_act(bolt_energy,"Lightning Bolt", flags = SHOCK_TESLA)
		playsound(get_turf(current), 'sound/magic/lightningshock.ogg', 150, 1, -1)
		var/list/possible_targets = new
		for(var/mob/living/M in view_or_range(7,target,"view"))
			if(user == M || target == M && los_check(current,M)) // || origin == M ? Not sure double shockings is good or not
				continue
			possible_targets += M
		if(!possible_targets.len)
			return
		var/mob/living/next = pick(possible_targets)
		if(next)
			Bolt(current,next,max((bolt_energy-5),5),bounces-1,user, usecharge = FALSE)
	if(usecharge)
		ourcell.use(boltcost)

/obj/item/clothing/gloves/color/yellow/power/proc/los_check(atom/movable/user, mob/target)
	var/turf/user_turf = user.loc
	if(!istype(user_turf))
		return 0
	var/obj/dummy = new(user_turf)
	dummy.pass_flags |= PASSTABLE|PASSGLASS|PASSGRILLE
	for(var/turf/turf in getline(user_turf,target))
		if(turf.density)
			qdel(dummy)
			return 0
		for(var/atom/movable/AM in turf)
			if(!AM.CanPass(dummy,turf,1))
				qdel(dummy)
				return 0
	qdel(dummy)
	return 1

/obj/item/clothing/gloves/color/yellow/power/get_cell()
	return ourcell

/obj/item/clothing/gloves/color/yellow/power/debug/Initialize()
	..()
	qdel(ourcell)
	ourcell = new /obj/item/stock_parts/cell()
	ourcell.maxcharge = 9999999
	ourcell.charge = 9999999
