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
	if(source)
		if(istype(source, /obj/item/switchblade) && !istype(source, /obj/item/switchblade/crafted))
			force = 5
			throwforce = 5
			extended_force = 18
			extended_throwforce = 24
			burn_force = 4
		parts_list -= source
		qdel(source)
	return ..()

/obj/item/switchblade/deluxe/afterattack(target, user, proximity_flag)
	. = ..()
	if(proximity_flag)
		if(iscarbon(target) && extended)
			var/mob/living/carbon/L = target
			var/mob/living/carbon/ourman = user
			var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(ourman.zone_selected))
			L.apply_damage(damage = burn_force,damagetype = BURN, def_zone = affecting, blocked = L.getarmor(affecting,  "melee"), forced = FALSE)
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
		sharpness = SHARP_EDGED
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
		sharpness = SHARP_NONE
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
	sharpness = SHARP_EDGED
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
	sharpness = SHARP_EDGED
	block_chance = 0
	var/block_chance_wielded = 20
	force = 5
	force_unwielded = 5
	force_wielded = 13
	var/current_lifesteal = 0
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
	if(tip)
		if (istype(tip, /obj/item/shard/plasma))
			force = 12
			throwforce = 12
			custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
		parts_list -= tip
		qdel(tip)
	return ..()

//a fucking shank
/obj/item/shank
	name = "shank"
	desc = "A nasty looking shard of glass. There's paper wrapping over one of the ends."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "shank"
	force = 5 // Bad force, but it stabs twice as fast
	throwforce = 10
	sharpness = SHARP_EDGED
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
	if(tip)
		if(istype(tip, /obj/item/shard/plasma))
			force = 6
			throwforce = 12
			custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
			clickmodifier = 0.4
		parts_list -= tip
		qdel(tip)
	return ..()

/obj/item/shank/update_icon()
	icon_state = "shank"

/obj/item/shank/afterattack(atom/target, mob/living/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		user.changeNext_move(CLICK_CD_MELEE * clickmodifier)

//"mace of molag bal"
/obj/item/melee/cleric_mace/molagbal
	name = "Will Breaker"
	desc = "A heavy mace, covered in intricate runes."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "molagmace"
	item_state = "molagmace"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/mace_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/mace_righthand.dmi'
	material_flags = null
	custom_materials = list(/datum/material/iron = 12000)
	slot_flags = ITEM_SLOT_BELT
	force = 15
	throwforce = 8
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 30
	armour_penetration = 200
	var/stamdamage = 30
	var/confusion = 10
	var/organdamage = 10
	overlay_state = null
	overlay = null
	attack_verb = list("disciplined", "struck", "dominated", "consumed", "beaten", "enslaved")

/obj/item/melee/cleric_mace/molagbal/attack(mob/living/target, mob/living/user)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/H = target
		H.confused += confusion
		H.adjust_blurriness(confusion)
		if(prob(15) && user.zone_selected == BODY_ZONE_HEAD)
			H.gain_trauma(/datum/brain_trauma/mild/concussion)
		if(prob(67))
			for(var/obj/item/organ/O in H.getorganszone(user.zone_selected))
				O.damage += organdamage
		H.adjustStaminaLoss(stamdamage)
		var/stamloss = H.getStaminaLoss()
		if(stamloss > 100)
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
	if(tip)
		force = tip.force
		force_unwielded = tip.force
		parts_list -= tip
		qdel(tip)
	var/obj/item/twohanded/spear/pear = locate() in parts_list
	if(pear)
		if(!istype(pear, /obj/item/twohanded/spear/halberd))
			force_wielded = pear.force_wielded + (tip.force/10)
			throwforce = pear.throwforce + (tip.throwforce/10)
		else
			force_wielded = pear.force_wielded
			throwforce = pear.throwforce
		parts_list -= pear
		qdel(pear)
	update_icon()
	return ..()

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

//"blade of woe"
/obj/item/kitchen/knife/combat/woe
	name = "Blackened Dagger"
	desc = "An ornate obsidian-black dagger, with deep grooves for blood, you feel a slight prick everytime you touch the handle."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "bladeofwoe"
	w_class = WEIGHT_CLASS_NORMAL
	var/currentbrute = 0
	var/mob/living/currenttarget = null

/obj/item/kitchen/knife/combat/woe/pre_attack(atom/A, mob/living/user, params)
	. = ..()
	var/mob/living/LM = A
	if(istype(LM))
		currentbrute = LM.bruteloss
		currenttarget = LM

/obj/item/kitchen/knife/combat/woe/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(currenttarget == target)
		var/newbrute = currenttarget.bruteloss - currentbrute
		if(newbrute > 0)
			var/mob/living/ooser = user
			if(istype(ooser))
				ooser.adjustBruteLoss(newbrute * -0.5)

//ghostface's knife
/datum/movespeed_modifier/slaughter/ghostface
	multiplicative_slowdown = -0.25

/obj/item/kitchen/knife/combat/ghost
	name = "silvery knife"
	desc = "Just killing. Chilling."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "ghoststabber"
	force = 12
	var/forceunder = 12
	var/forceover = 20
	var/attackspeed = 0.5
	var/attackspeedunder = 0.5
	var/attackspeedover = 1.3
	slowdown = 0
	var/mode = 1 //1 is under hand, 2 is over head
	var/list/oversounds = list(
		'modular_skyrat/sound/ghostface/highnote1.ogg',
		'modular_skyrat/sound/ghostface/highnote2.ogg',
		'modular_skyrat/sound/ghostface/highnote3.ogg',
		'modular_skyrat/sound/ghostface/highnote4.ogg',
		'modular_skyrat/sound/ghostface/highnote5.ogg'
	)
	var/dramaticsound = 'modular_skyrat/sound/ghostface/psychoviolin.ogg'
	var/playingsound = 0
	var/soundlength = 600
	var/soundend = 0

/obj/item/kitchen/knife/combat/ghost/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/kitchen/knife/combat/ghost/examine(mob/user)
	. = ..()
	. += "<span class='danger' style='font-family:\"Times New Roman\", Times, serif;'><b>Currently attacking in [mode == 1 ? "under hand" : "over head"] mode.</b></span>"

/obj/item/kitchen/knife/combat/ghost/process()
	if(ismob(loc))
		if(playingsound && (world.time > soundend))
			playsound(loc, dramaticsound, 100, 0, 0, -3, null, channel = CHANNEL_AMBIENCE)
			soundend = world.time + soundlength

/obj/item/kitchen/knife/combat/ghost/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)
	
/obj/item/kitchen/knife/combat/ghost/attack_self(mob/user)
	. = ..()
	switch(mode)
		if(1)
			user.visible_message("<span class='danger'><b>[user]</b> lifts the [src] over their head.</span>", \
							"<span class='danger'>You lift the [src] over your head.</span>")
			mode = 2
			user.add_movespeed_modifier(/datum/movespeed_modifier/slaughter/ghostface)
			attackspeed = attackspeedover
			force = forceover
			for(var/mob/living/bro in (view(5, user) - user))
				playingsound = 1
		if(2)
			user.visible_message("<span class='danger'><b>[user]</b> lowers the [src].</span>", \
							"<span class='danger'>You lower [src].</span>")
			mode = 1
			user.remove_movespeed_modifier(/datum/movespeed_modifier/slaughter/ghostface)
			attackspeed = attackspeedunder
			force = forceunder
			playingsound = 0
			soundend = 0
			for(var/mob/L in view(5, user))
				L.stop_sound_channel(CHANNEL_AMBIENCE)
	user.changeNext_move(CLICK_CD_MELEE * 2)

/obj/item/kitchen/knife/combat/ghost/pickup(mob/living/user)
	. = ..()
	if(.)
		if(mode == 2)
			user.add_movespeed_modifier(/datum/movespeed_modifier/slaughter/ghostface)

/obj/item/kitchen/knife/combat/ghost/dropped(mob/user)
	. = ..()
	if(.)
		var/mob/living/carbon/H = user
		if(H && istype(H))
			if((loc != user) || !(src in H.held_items))
				user.remove_movespeed_modifier(/datum/movespeed_modifier/slaughter/ghostface)

/obj/item/kitchen/knife/combat/ghost/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(proximity_flag)
		if(mode == 2)
			playsound(user, pick(oversounds), 100, 0)
			if(!playingsound)
				playingsound = 1
		user.changeNext_move(CLICK_CD_MELEE * attackspeed)

//"mehrunes razor"
/obj/item/kitchen/knife/combat/mehrunes
	name = "Serrated Blade"
	desc = "<span class='danger'>Feeling lucky?</span>"
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "mehrunesrazor"
	force = 10
	throwforce = 8
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/kitchen/knife/combat/mehrunes/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(isliving(target) && isliving(user))
		var/mob/living/LM = target
		var/mob/living/ooser
		if(prob(25))
			user.changeNext_move(CLICK_CD_MELEE * 0.5)
		if(prob(10))
			ooser.visible_message("<span class='userdanger'>[ooser] tears through [LM]'s flesh with [src]!</span>", \
							"<span class='userdanger'>You tear through [LM]'s flesh with [src]!</span>")
			var/def_zone = ooser.zone_selected
			var/obj/item/bodypart/affecting = LM.get_bodypart(check_zone(def_zone))
			LM.apply_damage(50, BRUTE, affecting, LM.getarmor(affecting,  "melee"), FALSE)
		if(prob(1))
			ooser.visible_message("<span class='userdanger'>[user] slits [LM]'s throat with [src]!</span>", \
					"<span class='userdanger'>You slit [LM]'s throat!</span>")
			LM.apply_damage(25, BRUTE, BODY_ZONE_HEAD, 0, TRUE)
			if(ishuman(LM))
				var/mob/living/carbon/human/H = LM
				for(var/x in H.bodyparts)
					var/obj/item/bodypart/BP = x
					if(istype(BP))
						BP.generic_bleedstacks += 5
				if(NOBLOOD in H.dna.species.species_traits)
					H.apply_damage(125, BRUTE, user.zone_selected, 0, TRUE)
			if(!LM.has_status_effect(/datum/status_effect/neck_slice))
				LM.apply_status_effect(/datum/status_effect/neck_slice)

//"nettlebane"
/obj/item/kitchen/knife/combat/nettlebane
	name = "Mors Plant"
	desc = "For when you're sick of being green."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "nettlebane"
	w_class = WEIGHT_CLASS_NORMAL
	var/list/plantlist = list(
		"plant",
		"vegetable",
		"fruit",
		"hydroponics",
		"botany",
		"botanist",
		"wood",
		"organic",
		"mushroom"
	)

/obj/item/kitchen/knife/combat/nettlebane/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	var/mob/living/ooser = user
	if(!istype(ooser) || !proximity_flag)
		return FALSE
	if(ooser.a_intent != INTENT_HARM)
		return .
	for(var/plont in plantlist)
		if((findtext(target.name, plont) || findtext(target.desc, plont)) && (!isliving(target)))
			qdel(target)
			return FALSE
		else if((findtext(target.name, plont) || findtext(target.desc, plont)) && (isliving(target)))
			var/mob/living/LM = target
			LM.death()
	for(var/obj/item/reagent_containers/food/snacks/grown/plant in target)
		qdel(plant)
	if(istype(target, /obj/item/reagent_containers/food/snacks/grown))
		qdel(target)
		return FALSE
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/species/S = H.dna.species
		if(istype(S, /datum/species/pod) || istype(S, /datum/species/mush))
			ooser.visible_message("<span class='userdanger'>[user] slits [H]'s throat with [src]!</span>", \
					"<span class='userdanger'>You slit [H]'s throat!</span>")
			for(var/x in H.bodyparts)
				var/obj/item/bodypart/BP = x
				if(istype(BP))
					BP.generic_bleedstacks += 5
			if(NOBLOOD in H.dna.species.species_traits)
				H.apply_damage(100, BRUTE, user.zone_selected, 0, TRUE)
			if(!H.has_status_effect(/datum/status_effect/neck_slice))
				H.apply_status_effect(/datum/status_effect/neck_slice)
			return FALSE

//butterfly knife
/obj/item/melee/transforming/butterfly
	name = "balisong knife"
	desc = "A stealthy knife famously used by spy organisations. Capable of piercing armour and causing massive backstab damage when used with harm intent."
	flags_1 = CONDUCT_1
	force = 0
	force_on = 10
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "butterflyknife0"
	icon_state_on = "butterflyknife1"
	hitsound_on = 'modular_skyrat/sound/weapons/knife.ogg'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_righthand.dmi'
	item_state = null
	var/item_state_on = "switchblade_butterfly_ext"
	throwforce = 0
	throwforce_on = 10
	var/backstabforce = 30
	armour_penetration = 20
	attack_verb_on = list("poked", "slashed", "stabbed", "sliced", "torn", "pierced", "diced", "cut")
	attack_verb_off = list("tapped", "prodded")
	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_NONE
	var/sharpness_on = SHARP_EDGED
	w_class_on = WEIGHT_CLASS_NORMAL
	custom_materials = list(MAT_METAL=12000)
	var/onsound
	var/offsound

/obj/item/melee/transforming/butterfly/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(.)
		if(active)
			item_state = item_state_on
			sharpness = sharpness_on
		else if(!active)
			item_state = initial(item_state)
			sharpness = initial(sharpness)


/obj/item/melee/transforming/butterfly/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(check_target_facings(user, M) == FACING_SAME_DIR && active && user.a_intent != INTENT_HELP && ishuman(M))
		var/mob/living/carbon/human/U = M
		return backstab(U,user,backstabforce)

	if(user.zone_selected == "eyes" && active)
		if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
			M = user
		return eyestab(M,user)
	else
		return ..()

/obj/item/melee/transforming/butterfly/transform_messages(mob/living/user, supress_message_text)//no fucking esword on sound
	playsound(user, active ? onsound  : offsound , 50, 1)
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")


/obj/item/melee/transforming/butterfly/proc/backstab(mob/living/carbon/human/U, mob/living/carbon/user, damage)
	var/obj/item/bodypart/affecting = U.get_bodypart("chest")

	if(!affecting || U == user || U.stat == DEAD) //no chest???!!!!
		return

	U.visible_message("<span class='danger'>[user] has backstabbed [U] with [src]!</span>", \
						"<span class='userdanger'>[user] backstabs you with [src]!</span>")

	src.add_fingerprint(user)
	playsound(loc,'modular_skyrat/sound/weapons/knifecrit.ogg', 40, 1, -1)
	user.do_attack_animation(U)
	U.apply_damage(damage, BRUTE, affecting, U.getarmor(affecting, "melee"))
	U.dropItemToGround(U.get_active_held_item())

	log_combat(user, U, "backstabbed", "[src.name]", "(INTENT: [uppertext(user.a_intent)])")

//energy butterfly knife
/obj/item/melee/transforming/butterfly/energy
	name = "energy balisong"
	desc = "A vicious carbon fibre blade and plasma tip allow for unparelled precision strikes against unknowing targets."
	force_on = 15
	throwforce_on = 20
	backstabforce = 100
	item_state_on = "switchblade_butterfly_energy_ext"
	icon_state = "butterflyknifeenergy0"
	icon_state_on = "butterflyknifeenergy1"
	onsound = 'modular_skyrat/sound/weapons/knifeopen.ogg'
	offsound = 'modular_skyrat/sound/weapons/knifeclose.ogg'
