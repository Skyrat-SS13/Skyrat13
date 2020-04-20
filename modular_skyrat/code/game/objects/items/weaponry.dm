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
	item_state = null
	var/firestacking = 5
	var/burn_force = 3
	obj_flags = UNIQUE_RENAME

/obj/item/switchblade/deluxe/afterattack(target, user)
	..()
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
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/ebonyblade_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/ebonyblade_righthand.dmi'
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

//Contender, made by ArcLumin. Ported from hippie.
/obj/item/gun/ballistic/shotgun/doublebarrel/contender
	desc = "The Contender G13, a favorite amongst space hunters. An easily modified bluespace barrel and break action loading means it can use any ammo available.\
	The side has an engraving which reads 'Made by ArcWorks'."
	name = "Contender"
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "contender-s"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/contender
	w_class = WEIGHT_CLASS_NORMAL
	obj_flags = UNIQUE_RENAME
	unique_reskin = 0

/obj/item/gun/ballistic/shotgun/doublebarrel/contender/sawoff(mob/user)
	to_chat(user, "<span class='warning'>Why would you mutilate this work of art?</span>")
	return

/obj/item/ammo_box/magazine/internal/shot/contender
	name = "contender internal magazine"
	caliber = "all"
	ammo_type = /obj/item/ammo_casing
	start_empty = TRUE
	max_ammo = 2
	multiload = 0 // thou must load every shot individually

/obj/item/storage/box/syndie/contender
	name = "Contender Starter Kit"
	desc = "Contains a contender and some extra supplies for your oncoming rampage."

/obj/item/storage/box/syndie/contender/PopulateContents()
	new /obj/item/clothing/head/helmet/swat(src)
	new /obj/item/gun/ballistic/shotgun/doublebarrel/contender(src)
	new /obj/item/ammo_casing/a762(src)
	new /obj/item/ammo_casing/a762(src)
	new /obj/item/ammo_casing/a762(src)
	new /obj/item/ammo_casing/a762(src)
	new /obj/item/kitchen/knife/combat(src)

//Box gun - the shitty contender. Adapted from a rejected hippie pr.
/obj/item/gun/ballistic/revolver/doublebarrel/contender/box_gun
	name = "box gun"
	desc = "Assistant's favourite. The huge space inside the box means it can use any ammo available. Doesn't look very safe."
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "box_gun"
	item_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/contender/box_gun
	recoil = 3
	fire_delay = 2
	var/explodioprob = 33

/obj/item/gun/ballistic/revolver/doublebarrel/contender/box_gun/afterattack(atom/target, mob/living/user, flag, params)
	. = ..()
	if(istype(user) && prob(explodioprob))
		var/obj/item/bodypart/l_arm = user.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/r_arm = user.get_bodypart(BODY_ZONE_R_ARM)
		user.visible_message("<span class='warning'>\The [src] explodes in [user]'s hand!</span>", "<span class='warning'>\The [src] explodes in your hand!</span>")
		explosion(user, 0, 0, 0, 1)
		if(prob(50) && (l_arm != null ))
			l_arm.dismember()
		else
			r_arm.dismember()
		qdel(src)

/obj/item/ammo_box/magazine/internal/shot/contender/box_gun
	name = "box gun internal magazine"
	caliber = "all"
	ammo_type = /obj/item/ammo_casing
	max_ammo = 1

//watcher projector. also stolen from hippie.
/obj/item/gun/energy/watcherprojector
	name = "watcher projector"
	desc = "A spiny, gruesome tool which reproduces the icy beam of a watcher, shattering rock and freezing individuals."
	icon_state = "watcherprojector"
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	item_state = "watcherprojector"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/watcher)
	attack_verb = list("bashed", "stared down", "whacked", "smashed")
	force = 10
	can_charge = 0
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/energy/watcherprojector/examine(mob/user)
	. = ..()
	if(cell)
		. +="<span class='notice'>[src]'s diamond core is [round(cell.percent())]% energized.</span>"

/obj/item/gun/energy/watcherprojector/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sheet/mineral/plasma))
		I.use(1)
		cell.give(1000)
		to_chat(user, "<span class='notice'>You feed [I] to [src], recharging it.</span>")
	else if(istype(I, /obj/item/stack/ore/plasma))
		I.use(1)
		cell.give(500)
		to_chat(user, "<span class='notice'>You feed [I] to [src], recharging it.</span>")
	else
		..()

/obj/item/gun/energy/watcherprojector/use(amount)
	return cell.use(amount * 100)

/obj/item/gun/energy/watcherprojector/update_icon()
	return

/obj/item/ammo_casing/energy/plasma/watcher
	projectile_type = /obj/item/projectile/plasma/watcher
	select_name = "freezing blast shot"
	fire_sound = 'sound/weapons/pierce.ogg'
	delay = 15
	e_cost = 100

/obj/item/projectile/plasma/watcher
	name = "freezing blast"
	icon_state = "ice_2"
	damage = 2.5
	flag = "energy"
	damage_type = BURN
	range = 4 //terrible range
	mine_range = 0
	var/temperature = -100
	dismemberment = FALSE

/obj/item/projectile/plasma/watcher/on_hit(atom/target, blocked = 0)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.adjust_bodytemperature(((100-blocked)/100)*(temperature - L.bodytemperature)) // the new body temperature is adjusted by 100-blocked % of the delta between body temperature and the bullet's effect temperature

//surplus rifle changes, because its fucking actual garbage, a fucking PIPE PISTOL is better.
/obj/item/gun/ballistic/automatic/surplus
	fire_delay = 10
	w_class = WEIGHT_CLASS_BULKY

/obj/item/ammo_box/magazine/m10mm/rifle
	max_ammo = 7

//improvised laser rifle
/obj/item/gun/energy/laser/makeshiftlasrifle
	name = "makeshift laser rifle"
	desc = "A makeshift rifle that shoots lasers. Lacks factory precision, but can rapidly alternate power cells."
	icon_state = "lasrifle"
	item_state = "makeshiftlas"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/laser/makeshiftlasrifle, /obj/item/ammo_casing/energy/laser/makeshiftlasrifle/weak, /obj/item/ammo_casing/energy/laser/makeshiftlasrifle/medium)
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	can_charge = TRUE
	charge_sections = 1
	ammo_x_offset = 2
	shaded_charge = FALSE //if this gun uses a stateful charge bar for more detail
	var/upgraded = 0
	var/maxcellcharge = 2500 //jesus that's still a lot of shots.
	fire_delay = 40
	spread = 30

/obj/item/ammo_casing/energy/laser/makeshiftlasrifle
	e_cost = 1000 //The amount of energy a cell needs to expend to create this shot.
	projectile_type = /obj/item/projectile/beam/laser/makeshiftlasrifle
	select_name = "strong"
	variance = 2

/obj/item/projectile/beam/laser/makeshiftlasrifle
	damage = 20

/obj/item/ammo_casing/energy/laser/makeshiftlasrifle/weak
	e_cost = 100 //The amount of energy a cell needs to expend to create this shot.
	projectile_type = /obj/item/projectile/beam/laser/makeshiftlasrifle/weak
	select_name = "weak"
	fire_sound = 'sound/weapons/laser2.ogg'

/obj/item/projectile/beam/laser/makeshiftlasrifle/weak
	name = "weak laser"
	damage = 5

/obj/item/ammo_casing/energy/laser/makeshiftlasrifle/medium
	e_cost = 300
	projectile_type = /obj/item/projectile/beam/laser/makeshiftlasrifle/medium
	select_name = "medium"
	fire_sound = 'sound/weapons/laser2.ogg'

/obj/item/projectile/beam/laser/makeshiftlasrifle/medium
	name = "medium laser"
	damage = 12.5

/obj/item/gun/energy/laser/makeshiftlasrifle/AltClick(mob/living/carbon/user)
	..()
	playsound(user, 'sound/items/Screwdriver.ogg', 35)
	var/obj/item/stock_parts/cell/thecell = cell
	cell = null
	thecell.forceMove(user.loc)
	user.put_in_l_hand(thecell)

/obj/item/gun/energy/laser/makeshiftlasrifle/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/stock_parts/cell) && !cell)
		var/obj/item/stock_parts/cell/C = I
		if(C.maxcharge <= maxcellcharge)
			playsound(user, 'sound/items/Screwdriver.ogg', 35)
			C.forceMove(src)
			cell = C
		else
			to_chat(user, "<span class='warning'>Using a cell with this much power on this pile of crap would break it!</span>")
	if(istype(I, /obj/item/stack/sheet/plasteel) && !upgraded)
		var/obj/item/stack/sheet/plasteel/oursteel = I
		if(oursteel.use(3))
			new /obj/item/gun/energy/laser/makeshiftlasrifle/adv(user.loc)
			qdel(src)
		else
			to_chat(user, "<span class='notice'>There's not enough plasteel to upgrade the [src]!</span>")
	else if(istype(I, /obj/item/stack/sheet/plasteel) && upgraded)
		to_chat(user, "<span class='notice'>\the [src] is already upgraded!</span>")

/obj/item/gun/energy/laser/makeshiftlasrifle/adv
	name = "plasteel makeshift laser rifle"
	desc = "A makeshift rifle that shoots lasers. Lacks factory precision, but can rapidly alternate power cells. This one has been upgraded."
	icon_state = "adv_lasermakeshift"
	upgraded = 1
	shaded_charge = 1
	charge_sections = 4
	automatic_charge_overlays = TRUE
	maxcellcharge = 5000
	ammo_x_offset = 2
	fire_delay = 10
	spread = 15
	obj_flags = UNIQUE_RENAME

//laser musket
/obj/item/gun/energy/pumpaction/musket
	name = "laser musket"
	desc = "Another settlment needs your help."
	icon = 'modular_skyrat/icons/obj/guns/lasermusket.dmi'
	icon_state = "musket"
	item_state = "musket"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	shaded_charge = FALSE
	w_class = WEIGHT_CLASS_BULKY
	cell_type = /obj/item/stock_parts/cell/pumpaction/musket
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun, /obj/item/ammo_casing/energy/disabler)
	obj_flags = UNIQUE_RENAME

/obj/item/stock_parts/cell/pumpaction/musket
	name = "laser musket internal cell"
	maxcharge = 1250 //better than the warden's shotgun cell lmao

//shitty hatchet
/obj/item/hatchet/improvised
	name = "glass hatchet"
	desc = "A makeshift hand axe with a crude blade of broken glass."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "glasshatchet"
	item_state = "glasshatchet"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/righthand.dmi'

//a fucking shank
/obj/item/shard/shank
	name = "shank"
	desc = "A nasty looking shard of glass. There's paper wrapping over one of the ends."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "shank"
	force = 10 //Average force
	throwforce = 10
	item_state = "shard-glass"
	attack_verb = list("stabbed", "shanked", "sliced", "cut")
	siemens_coefficient = 0 //Means it's insulated
	sharpness = IS_SHARP

//mace of molag bal
/obj/item/melee/cleric_mace/molagbal
	name = "Mace of Molag Bal"
	desc = "Make the weak and frail bend to you."
	icon = 'modular_skyrat/icons/obj/molagmace.dmi'
	icon_state = "mace_greyscale"
	item_state = "mace_greyscale"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/mace_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/mace_righthand.dmi'
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
	lefthand_file = 'modular_skyrat/icons/mob/inhands/staff_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/staff_righthand.dmi'
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