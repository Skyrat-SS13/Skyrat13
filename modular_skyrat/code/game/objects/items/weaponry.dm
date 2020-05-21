//switchblades
/obj/item/switchblade/crafted
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "switchblade_ms"
	desc = "A concealable spring-loaded knife."
	force = 2
	throwforce = 3
	extended_force = 15
	extended_throwforce = 18
	extended_icon_state = "switchblade_ext_ms"
	retracted_icon_state = "switchblade_ms"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/switchblade/crafted/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/stack/tile/bronze))
		icon_state = extended ? "brass_switchblade_ext" : "brass_switchblade"
		extended_icon_state = "brass_switchblade_ext"
		retracted_icon_state = "brass_switchblade"
		icon_state = "brass_switchblade"
		to_chat(user, "<span class='notice'>You use part of the bronze to improve your Switchblade. Tick-Tock-Tick.</span>")

/obj/item/switchblade/crafted/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/stack/sheet/mineral/silver))
		icon_state = extended ? "switchblade_ext_msf" : "switchblade_msf"
		extended_icon_state = "switchblade_ext_msf"
		retracted_icon_state = "switchblade_msf"
		icon_state = "switchblade_msf"
		to_chat(user, "<span class='notice'>You use part of the silver to improve your Switchblade. Stylish!</span>")

/obj/item/switchblade/deluxe
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "switchblade_deluxe"
	desc = "A powered switchblade that also burns on impact."
	force = 2
	throwforce = 3
	extended_force = 15
	extended_throwforce = 20
	extended_icon_state = "switchblade_deluxe_ext"
	retracted_icon_state = "switchblade_deluxe"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_righthand.dmi'
	var/firestacking = 0
	var/burn_force = 3
	obj_flags = UNIQUE_RENAME

/obj/item/switchblade/deluxe/CheckParts(list/parts_list)
	var/obj/item/switchblade/source = locate() in parts_list
	if(istype(source, /obj/item/switchblade) && !istype(source, /obj/item/switchblade/crafted))
		force = 5
		throwforce = 5
		extended_force = 18
		extended_throwforce = 24
		burn_force = 4
	qdel(source)

/obj/item/switchblade/deluxe/afterattack(target, user, proximity_flag)
	..()
	if(proximity_flag)
		if(iscarbon(target) && extended)
			var/mob/living/carbon/L = target
			var/mob/living/carbon/ourman = user
			L.apply_damage(damage = burn_force,damagetype = BURN, def_zone = L.get_bodypart(check_zone(ourman.zone_selected)), blocked = FALSE, forced = FALSE)
			L.fire_stacks += firestacking
			L.IgniteMob()
		else if(isliving(target) && extended)
			var/mob/living/thetarget = target
			thetarget.adjustBruteLoss(burn_force)

/obj/item/switchblade/deluxe/attack_self(mob/user)
	extended = !extended
	playsound(user, extended ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 15, 1)
	if(extended)
		force = extended_force
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = extended_throwforce
		icon_state = extended_icon_state
		attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
		sharpness = IS_SHARP
		light_color = "#cc00ff"
		light_range = 1
		light_power = 1
		item_state = "switchblade_deluxe_ext"
	else
		force = initial(force)
		w_class = WEIGHT_CLASS_SMALL
		throwforce = initial(throwforce)
		icon_state = retracted_icon_state
		attack_verb = list("stubbed", "poked")
		hitsound = 'sound/weapons/genhit.ogg'
		sharpness = IS_BLUNT
		light_color = null
		light_range = 0
		light_power = 0
		item_state = null

//dumb roblox sword
/obj/item/claymore/roblox
	name = "Fencing Sword"
	desc = "It seems otherworldly."
	icon = 'modular_skyrat/icons/obj/items/roblox.dmi'
	icon_state = "sword"
	hitsound = 'modular_skyrat/sound/roblox/lunge.wav'
	force = 20
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("oofed")
	sharpness = IS_SHARP_ACCURATE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	var/cooldown = 10
	var/cooldowntime = 0

/obj/item/claymore/roblox/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	return

/obj/item/claymore/roblox/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on [src]! It looks like they lost all their Robux!</span>")
	return(BRUTELOSS)

/obj/item/claymore/roblox/pickup(mob/living/user)
	..()
	var/mob/living/M = user
	playsound(M, 'modular_skyrat/sound/roblox/equip.wav', 200)
	var/obj/effect/temp_visual/robloxsword/S = new /obj/effect/temp_visual/robloxsword(user)
	S.duration = 10
	animate(S, transform = matrix(45, MATRIX_ROTATE), time = 1)
	animate(S, pixel_y += 5, time = 0)
	animate(S, pixel_y -= 5, time = 5)


/obj/item/claymore/roblox/afterattack(atom/target, mob/living/user)
	if(cooldowntime < world.time)
		if(!target || !istype(target, /mob))
			playsound(src, 'modular_skyrat/sound/roblox/lunge.wav', 200)
		cooldowntime = world.time + cooldown
		var/dirtotarget = get_dir(user, target)
		var/turf/T = get_step(user, dirtotarget)
		var/obj/effect/temp_visual/robloxsword/S = new /obj/effect/temp_visual/robloxsword(T)
		animate(S, transform = matrix(dir2angle(dirtotarget) + 45, MATRIX_ROTATE), time = 0)
		animate(S, transform = matrix(dir2angle(dirtotarget), MATRIX_ROTATE), time = 3)
		for(var/mob/living/M in T.contents)
			attack(M, user)
			if(M.health <= 0)
				playsound(M, 'modular_skyrat/sound/roblox/OOF.wav', 200)

/obj/effect/temp_visual/robloxsword
	name = "sword"
	desc = "oof"
	icon = 'modular_skyrat/icons/obj/items/roblox.dmi'
	icon_state = "sword2"
	duration = 4
	layer = ABOVE_MOB_LAYER

//ebony blade
/obj/item/twohanded/ebonyblade
	name = "Ebony Blade"
	desc = "Forged in deceit, this weapon gets more powerful with the blood of those that are alligned with you."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "ebonyblade"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_righthand.dmi'
	item_state = "ebonyblade"
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "destroyed", "ripped", "devastated", "shredded")
	sharpness = IS_SHARP_ACCURATE
	block_chance = 0
	var/block_chance_wielded = 20
	force = 5
	force_unwielded = 5
	force_wielded = 13
	var/current_lifesteal = 2.5
	var/lifesteal = 2.5
	var/forceadd_samerole = 5
	var/forceadd_sameantagonist = 10
	var/blockadd_anydeceit = 10
	var/datum/status_effect/tracker = /datum/status_effect/ebony_damage

/obj/item/twohanded/ebonyblade/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 110)

/obj/item/twohanded/ebonyblade/unwield(mob/living/carbon/user, show_message = TRUE)
	..()
	block_chance = initial(block_chance)
	lifesteal = initial(current_lifesteal)

/obj/item/twohanded/ebonyblade/wield(mob/living/carbon/user, show_message = TRUE)
	..()
	block_chance = block_chance_wielded
	current_lifesteal = lifesteal

/obj/item/twohanded/ebonyblade/attack(mob/living/target, mob/living/carbon/user)
	if(target.stat == DEAD)
		..()
		return
	if(!target.has_status_effect(tracker))
		target.apply_status_effect(tracker, "ebony blade")
	var/datum/status_effect/ebony_damage/C = target.has_status_effect(tracker)
	var/target_health = target.health
	..()
	user.adjustBruteLoss(-current_lifesteal)
	user.adjustFireLoss(-current_lifesteal)
	user.adjustOxyLoss(-current_lifesteal)
	user.adjustToxLoss(-current_lifesteal)
	user.adjustCloneLoss(-current_lifesteal)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health
		if(C.total_damage > (target.maxHealth * 0.33)) //At least a third of the damage must be done by the blade for the kill to count.
			if(target.stat == DEAD && user.mind && target.mind)
				var/obj/item/card/id/userid = user.get_item_by_slot(SLOT_WEAR_ID)
				var/list/useraccess = userid.GetAccess()
				var/obj/item/card/id/targetid = target.get_item_by_slot(SLOT_WEAR_ID)
				var/list/targetaccess = targetid.GetAccess()
				var/combinedaccess = useraccess | targetaccess
				if((user.mind.assigned_role == target.mind.assigned_role) || (targetaccess == combinedaccess))
					src.force_wielded += forceadd_samerole
					src.lifesteal += forceadd_samerole/2
					src.block_chance_wielded += blockadd_anydeceit
					if(src.block_chance_wielded > 90)
						src.block_chance_wielded = 90
				if(user.mind.special_role == target.mind.special_role)
					src.force_wielded += forceadd_sameantagonist
					src.lifesteal += forceadd_sameantagonist/2
					src.block_chance_wielded += (blockadd_anydeceit * 2)
					if(src.block_chance_wielded > 90)
						src.block_chance_wielded = 90
				if(user.mind.isholy == target.mind.isholy)
					src.force_wielded += forceadd_samerole
					src.lifesteal += forceadd_samerole/2
					src.block_chance_wielded += blockadd_anydeceit
					if(src.block_chance_wielded > 90)
						src.block_chance_wielded = 90

//shitty hatchet
/obj/item/hatchet/improvised
	name = "glass hatchet"
	desc = "A makeshift hand axe with a crude blade of broken glass."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "glasshatchet"
	item_state = "glasshatchet"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/righthand.dmi'
	force = 11
	throwforce = 11

/obj/item/hatchet/improvised/CheckParts(list/parts_list)
	var/obj/item/shard/tip = locate() in parts_list
	if (istype(tip, /obj/item/shard/plasma))
		force = 12
		throwforce = 12
		custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	qdel(tip)

//a fucking shank
/obj/item/shank
	name = "shank"
	desc = "A nasty looking shard of glass. There's paper wrapping over one of the ends."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "shank"
	force = 5 // Bad force, but it stabs twice as fast
	throwforce = 10
	sharpness = IS_SHARP
	w_class = WEIGHT_CLASS_TINY
	item_state = "shard-glass"
	attack_verb = list("stabbed", "shanked", "sliced", "cut")
	siemens_coefficient = 0 //We are insulated
	var/clickmodifier = 0.5

/obj/item/shank/Initialize()
	..()
	update_icon()

/obj/item/shank/CheckParts(list/parts_list)
	var/obj/item/shard/tip = locate() in parts_list
	if(istype(tip, /obj/item/shard/plasma))
		force = 6
		throwforce = 12
		custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
		clickmodifier = 0.40
	qdel(tip)

/obj/item/shank/update_icon()
	icon_state = "shank"

/obj/item/shank/afterattack(atom/target, mob/living/user, proximity)
	if(proximity)
		user.changeNext_move(CLICK_CD_MELEE * clickmodifier)

//mace of molag bal
/obj/item/melee/cleric_mace/molagbal
	name = "Mace of Molag Bal"
	desc = "Make the weak and frail bend to you."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "molagmace"
	item_state = "molagmace"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/mace_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/mace_righthand.dmi'
	material_flags = null
	custom_materials = list(/datum/material/iron = 12000)
	slot_flags = ITEM_SLOT_BELT
	force = 15
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 8
	block_chance = 30
	armour_penetration = 200
	var/stamdamage = 30
	var/confusion = 8
	var/organdamage = 7
	overlay_state = null
	overlay = null
	attack_verb = list("disciplined", "struck", "dominated", "consumed", "beaten", "enslaved")

/obj/item/melee/cleric_mace/molagbal/attack(mob/living/target, mob/living/user)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/H = target
		var/loss = H.getStaminaLoss()
		H.confused += confusion
		H.adjust_blurriness(confusion)
		if(prob(15) && user.zone_selected == BODY_ZONE_HEAD)
			H.gain_trauma(/datum/brain_trauma/mild/concussion)
		if(prob(25))
			for(var/obj/item/organ/O in H.getorganszone(user.zone_selected))
				O.damage += organdamage
		H.adjustStaminaLoss(stamdamage)
		if(loss > 100)
			H.Sleeping(60)

//stun baton staff
/obj/item/melee/baton/staff
	name = "batonstaff"
	desc = "This... is two batons welded together? Oh god this is awful."
	icon = 'modular_skyrat/icons/obj/staff.dmi'
	icon_state = "batonstaff"
	item_state = "staff"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/staff_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/staff_righthand.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/back.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 15 //same damage as a survival knife, not really good
	block_chance = 25 //terrible when compared to an actual electrostaff, can't block bullets
	throwforce = 6
	stamforce = 35 //not too much of an improvement, normal baton is 25
	hitcost = 1250 //terrible, same cell as a normal baton
	throw_hit_chance = 20 //awful
	slot_flags = ITEM_SLOT_BACK
	preload_cell_type = /obj/item/stock_parts/cell/high/plus

/obj/item/melee/baton/staff/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(attack_type == ATTACK_TYPE_PROJECTILE)
		final_block_chance = 0
	return ..()

/obj/item/twohanded/spear/halberd
	name = "makeshift halberd"
	desc = "A horrible creation that shouldn't even work. Simply put, a hatchet attached to the end of a makeshift glass spear."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "mhalberd0"
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/axes_righthand.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/axes_lefthand.dmi'
	item_state = "mhalberd0"
	icon_prefix = "mhalberd"
	embedding = list("embedded_impact_pain_multiplier" = 3, "embed_chance" = 50)
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored", "stabbed", "slashed")
	armour_penetration = 5

/obj/item/twohanded/spear/halberd/CheckParts(list/parts_list)
	var/obj/item/hatchet/tip = locate() in parts_list
	var/obj/item/twohanded/spear/pear = locate() in parts_list
	force = tip.force
	force_unwielded = tip.force
	if(!istype(pear, /obj/item/twohanded/spear/halberd))
		force_wielded = pear.force_wielded + (tip.force/10)
		throwforce = pear.throwforce + (tip.throwforce/10)
	else
		force_wielded = pear.force_wielded
		throwforce = pear.throwforce
	qdel(tip)
	qdel(pear)
	update_icon()

//KINKY. Clone of the banhammer.
/obj/item/bdsm_whip
	name = "bdsm whip"
	desc = "A less lethal version of the whip the librarian has. Still hurts, but just the way you like it."
	icon_state = "whip"
	item_state = "chain"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")

/obj/item/bdsm_whip/suicide_act(mob/user)
		user.visible_message("<span class='suicide'>[user] is getting just a little too kinky!</span>")
		return (OXYLOSS)

/obj/item/bdsm_whip/attack(mob/M, mob/user)
	playsound(loc, 'sound/weapons/whip.ogg', 30)
	if(user.a_intent != INTENT_HELP)
		return ..(M, user)
