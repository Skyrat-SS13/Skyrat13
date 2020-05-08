//legion (the big one!)
/obj/item/crusher_trophy/legion_shard
	name = "legion bone shard"
	desc = "Part of a legion's cranium. Suitable as a trophy for a kinetic crusher."
	icon = 'icons/obj/mining.dmi'
	icon_state = "bone"
	denied_type = /obj/item/crusher_trophy/legion_shard

/obj/item/crusher_trophy/legion_shard/effect_desc()
	return "a kinetic crusher to make dead animals into friendly fauna, as well as turning corpses into legions"

/obj/item/crusher_trophy/legion_shard/on_mark_detonation(mob/living/target, mob/living/user)
	if(target.stat == DEAD)
		if(istype(target, /mob/living/simple_animal/hostile/asteroid))
			var/mob/living/simple_animal/hostile/asteroid/L = target
			L.revive(full_heal = 1, admin_revive = 1)
			if(ishostile(L))
				L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly fauna</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)

/obj/item/crusher_trophy/legion_shard/on_melee_hit(mob/living/target, mob/living/user)
	if(ishuman(target) && (target.stat == DEAD))
		var/confirm = input("Are you sure you want to turn [target] into a friendly legion?", "Sure?") in list("Yes", "No")
		if(confirm == "Yes")
			var/mob/living/carbon/human/H = target
			var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(H.loc)
			L.stored_mob = H
			H.forceMove(L)
			L.faction = list("neutral")
			L.revive(full_heal = 1, admin_revive = 1)
			if(ishostile(L))
				L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly legion.</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)
		else
			(to_chat(user, "<span class='notice'>You cancel turning [target] into a legion.</span>"))

//shambling miner
/obj/item/crusher_trophy/blaster_tubes/mask
	name = "mask of a shambling miner"
	desc = "It really doesn't seem like it could be worn. Suitable as a crusher trophy."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "miner_mask"
	bonus_value = 5
	denied_type = /obj/item/crusher_trophy/blaster_tubes/mask

/obj/item/crusher_trophy/blaster_tubes/mask/effect_desc()
	return "mark detonation to make the next destabilizer shot deal <b>[bonus_value]</b> damage"

/obj/item/crusher_trophy/blaster_tubes/mask/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "kinetic [marker.name]"
		marker.icon_state = "ka_tracer"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/mask/on_mark_application(mob/living/target, datum/status_effect/crusher_mark/mark, had_mark)
	new /obj/effect/temp_visual/kinetic_blast(target)
	playsound(target.loc, 'sound/weapons/kenetic_accel.ogg', 60, 0)

//lava imp
/obj/item/crusher_trophy/blaster_tubes/impskull
	name = "imp skull"
	desc = "Somebody got glory killed. Suitable as a trophy."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "impskull"
	bonus_value = 5
	denied_type = /obj/item/crusher_trophy/blaster_tubes/impskull

/obj/item/crusher_trophy/blaster_tubes/impskull/effect_desc()
	return "causes every marker to deal <b>[bonus_value]</b> damage."

/obj/item/crusher_trophy/blaster_tubes/impskull/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	marker.name = "fiery [marker.name]"
	marker.icon_state = "fireball"
	marker.damage = bonus_value
	marker.nodamage = FALSE
	playsound(user.loc, 'modular_skyrat/sound/misc/impranged.wav', 50, 0)

//traitor crusher

/obj/item/projectile/destabilizer/harm
	name = "harmful destabilzing force"
	range = 10

/obj/item/projectile/destabilizer/harm/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		var/had_effect = (L.has_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM)) //used as a boolean
		var/datum/status_effect/crusher_mark/CM = L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM, hammer_synced)
		if(hammer_synced)
			for(var/t in hammer_synced.trophies)
				var/obj/item/crusher_trophy/T = t
				T.on_mark_application(target, CM, had_effect)
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		var/turf/closed/mineral/M = target_turf
		new /obj/effect/temp_visual/kinetic_blast(M)
		M.gets_drilled(firer)
	..()

/obj/item/twohanded/kinetic_crusher/harm
	desc = "An early design of the proto-kinetic accelerator, it is little more than an combination of various mining tools cobbled together, forming a high-tech club. \
	While it is an effective mining tool, it did little to aid any but the most skilled and/or suicidal miners against local fauna. Something's very odd about this one, however..."

/obj/item/twohanded/kinetic_crusher/harm/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	if(istype(target, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = target
		T.add_to(src, user)
	if(!wielded)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/item/projectile/destabilizer/harm/D = new /obj/item/projectile/destabilizer/harm(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, 1)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, 1) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

			if(user && lavaland_equipment_pressure_check(get_turf(user))) //CIT CHANGE - makes sure below only happens in low pressure environments
				user.adjustStaminaLoss(-30)//CIT CHANGE - makes crushers heal stamina
	SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user, proximity_flag, clickparams)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, clickparams)

//king goat
/obj/item/crusher_trophy/king_goat
	name = "king goat hoof"
	desc = "A hoof from the king of all goats, it still glows with a fraction of its original power... Suitable as a trophy for a kinetic crusher."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "goat_hoof" //needs a better sprite but I cant sprite .
	denied_type = /obj/item/crusher_trophy/king_goat

/obj/item/crusher_trophy/king_goat/effect_desc()
	return "you to passivily recharge markers 5x as fast while equipped and do a decent amount of damage at the cost of dulling the blade"

/obj/item/crusher_trophy/king_goat/on_projectile_fire(obj/item/projectile/destabilizer/marker, mob/living/user)
	marker.damage = 10 //in my testing only does damage to simple mobs so should be fine to have it high

/obj/item/crusher_trophy/king_goat/add_to(obj/item/twohanded/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time = 3
		H.force_wielded = 5

/obj/item/crusher_trophy/king_goat/remove_from(obj/item/twohanded/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.charge_time = 15
		H.force_wielded = 20

//gladiator
/obj/item/crusher_trophy/gladiator
	name = "gladiator's horn"
	desc = "The remaining horn of the Gladiator. Suitable as a crusher trophy."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "horn"
	bonus_value = 15
	denied_type = /obj/item/crusher_trophy/gladiator

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "the crusher to have a <b>[bonus_value]%</b> chance to block any incoming attack."

/obj/item/crusher_trophy/gladiator/add_to(obj/item/twohanded/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/twohanded/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.block_chance -= bonus_value

//hierophant crusher nerf "but muh i deserve it after killing hierocunt" yes but its op fuck you you piece of shit
/obj/effect/temp_visual/hierophant/wall/crusher
	duration = 45 //this is more than enough time bro

//watcher wing slight buff
/obj/item/crusher_trophy/watcher_wing
	bonus_value = 20 // 1 second isn't enough for much, this should be better

//gladiator tomahawk - it's just a one handed crusher
/obj/item/melee/tomahawk
	icon = 'icons/obj/mining.dmi'
	icon_state = "crusher"
	item_state = "crusher0"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "kinetic tomahawk"
	desc = "It's just a kinetic destroyer with part of the handle cut off and a bunch of drake and goliath hide on it."
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 15
	throw_speed = 4
	armour_penetration = 20
	custom_materials = list(/datum/material/titanium=3150, /datum/material/glass=2075, /datum/material/gold=3000, /datum/material/diamond=5000)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("smashed", "crushed", "cleaved", "chopped", "pulped")
	sharpness = IS_SHARP
	actions_types = list(/datum/action/item_action/toggle_light)
	var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 13
	var/detonation_damage = 65
	var/backstab_bonus = 40
	var/light_on = FALSE
	var/brightness_on = 7

/obj/item/melee/tomahawk/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80, 110)

/obj/item/melee/tomahawk/Destroy()
	QDEL_LIST(trophies)
	return ..()

/obj/item/melee/tomahawk/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Mark a large creature with the destabilizing force, then hit them in melee to do <b>[force + detonation_damage]</b> damage.</span>"
	. += "<span class='notice'>Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.</span>"
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += "<span class='notice'>It has \a [T] attached, which causes [T.effect_desc()].</span>"

/obj/item/melee/tomahawk/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/crowbar))
		if(LAZYLEN(trophies))
			to_chat(user, "<span class='notice'>You remove [src]'s trophies.</span>")
			I.play_tool_sound(src)
			for(var/t in trophies)
				var/obj/item/crusher_trophy/T = t
				T.remove_from(src, user)
		else
			to_chat(user, "<span class='warning'>There are no trophies on [src].</span>")
	else if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()

/obj/item/melee/tomahawk/attack(mob/living/target, mob/living/carbon/user)
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/melee/tomahawk/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if(istype(target, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = target
		T.add_to(src, user)
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/item/projectile/destabilizer/D = new /obj/item/projectile/destabilizer(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, 1)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, 1) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

			if(user && lavaland_equipment_pressure_check(get_turf(user))) //CIT CHANGE - makes sure below only happens in low pressure environments
				user.adjustStaminaLoss(-30)//CIT CHANGE - makes crushers heal stamina

/obj/item/melee/tomahawk/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_icon()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, 1)

/obj/item/melee/tomahawk/ui_action_click(mob/user, actiontype)
	light_on = !light_on
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_brightness(user)
	update_icon()

/obj/item/melee/tomahawk/proc/update_brightness(mob/user = null)
	if(light_on)
		set_light(brightness_on)
	else
		set_light(0)

/obj/item/melee/tomahawk/update_overlays()
	. = ..()
	if(!charged)
		. += "[icon_state]_uncharged"
	if(light_on)
		. += "[icon_state]_lit"
