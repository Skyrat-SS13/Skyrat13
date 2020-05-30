//boss chests
//gladiator
/obj/structure/closet/crate/necropolis/gladiator
	name = "gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/crusher
	name = "dreadful gladiator chest"

/obj/structure/closet/crate/necropolis/gladiator/PopulateContents()
	new /obj/item/shield/riot/tower/swat/gladiator(src)
	new /obj/item/borg/upgrade/modkit/shielding(src)

/obj/structure/closet/crate/necropolis/gladiator/crusher/PopulateContents()
	new /obj/item/shield/riot/tower/swat/gladiator(src)
	new /obj/item/melee/zweihander(src)

/obj/item/shield/riot/tower/swat/gladiator
	name = "\proper Gladiator's shield"
	desc = "A very powerful and near indestructible shield, reinforced with drake and goliath hide. Can be used as a raft on lava."
	icon = 'modular_skyrat/icons/obj/shields.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/shields_righthand.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/shields_lefthand.dmi'
	icon_state = "gladiator"
	item_state = "gladiator"
	shield_flags = SHIELD_FLAGS_DEFAULT | SHIELD_BASH_ALWAYS_DISARM | SHIELD_BASH_GROUND_SLAM_DISARM
	slowdown = 0
	shieldbash_cooldown = 6 SECONDS
	shieldbash_stamcost = 5
	shieldbash_knockback = 2
	shieldbash_brutedamage = 10
	shieldbash_stamdmg = 25
	shieldbash_stagger_duration = 4.5 SECONDS
	shieldbash_push_distance = 2
	max_integrity = 350
	block_chance = 50
	can_shatter = FALSE
	repair_material = /obj/item/stack/sheet/animalhide/goliath_hide
	w_class = WEIGHT_CLASS_BULKY

/obj/item/shield/riot/tower/swat/gladiator/AltClick(mob/user)
	if(isliving(user))
		if(do_after(user, 20, target = src))
			new /obj/vehicle/ridden/lavaboat/dragon/gladiator(get_turf(user))
			qdel(src)

/obj/vehicle/ridden/lavaboat/dragon/gladiator
	name = "lava surfboard"
	desc = "This thing can be used to cross lava rivers... I guess. Alt click to turn into a shield again."
	icon = 'modular_skyrat/icons/obj/shields.dmi'
	icon_state = "raft"

/obj/vehicle/ridden/lavaboat/dragon/gladiator/Initialize()
	..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 1
	D.allowed_turf_typecache = typecacheof(/turf/open)
	D.keytype = null

/obj/vehicle/ridden/lavaboat/dragon/gladiator/AltClick(mob/user)
	..()
	if(isliving(user))
		if(do_after(user, 20, target = src))
			new /obj/item/shield/riot/tower/swat/gladiator(get_turf(user))
			qdel(src)

//bubblegum
/obj/structure/closet/crate/necropolis/bubblegum/PopulateContents()
	new /obj/item/clothing/suit/space/hostile_environment(src)
	new /obj/item/clothing/head/helmet/space/hostile_environment(src)
	new /obj/item/borg/upgrade/modkit/shotgun(src)
	var/loot = rand(1,3)
	switch(loot)
		if(1)
			new /obj/item/book/granter/martial/berserk(src)
		if(2)
			new /obj/item/blood_contract(src)
		if(3)
			new /obj/item/gun/magic/staff/spellblade(src)

/obj/structure/closet/crate/necropolis/bubblegum/crusher/PopulateContents()
	new /obj/item/clothing/suit/space/hostile_environment(src)
	new /obj/item/clothing/head/helmet/space/hostile_environment(src)
	new /obj/item/crusher_trophy/demon_claws(src)
	var/loot = rand(1,3)
	switch(loot)
		if(1)
			new /obj/item/book/granter/martial/berserk(src)
		if(2)
			new /obj/item/blood_contract(src)
		if(3)
			new /obj/item/gun/magic/staff/spellblade(src)

/mob/living/simple_animal/hostile/megafauna/bubblegum/hard
	name = "enraged bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/PopulateContents()
	new /obj/item/book/granter/martial/berserk(src)
	new /obj/item/blood_contract(src)
	new /obj/item/twohanded/crucible(src)
	new /obj/item/gun/ballistic/revolver/doublebarrel/super(src)
	new /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor(src)
	new /obj/item/borg/upgrade/modkit/shotgun(src)

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher
	name = "enraged bloody bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher/PopulateContents()
	new /obj/item/book/granter/martial/berserk(src)
	new /obj/item/blood_contract(src)
	new /obj/item/twohanded/crucible(src)
	new /obj/item/gun/ballistic/revolver/doublebarrel/super(src)
	new /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor(src)
	new /obj/item/crusher_trophy/demon_claws(src)

//super shotty changes (meat hook instead of bursto)

/obj/item/gun/ballistic/revolver/doublebarrel/super
	burst_size = 1
	actions_types = list(/datum/action/item_action/toggle_hook)
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "heckgun"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	item_state = "heckgun"
	sharpness = IS_SHARP
	force = 15
	var/recharge_rate = 4
	var/charge_tick = 0
	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/gun/ballistic/revolver/doublebarrel/super/Initialize()
	. = ..()
	if(!alternate_magazine)
		alternate_magazine = new /obj/item/ammo_box/magazine/internal/shot/dual/heck/hook(src)
	START_PROCESSING(SSobj, src)

/obj/item/gun/ballistic/revolver/doublebarrel/super/attack_self(mob/living/user)
	if(toggled)
		return 0
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel/super/process()
	if(toggled)
		charge_tick++
		if(charge_tick < recharge_rate)
			return 0
		charge_tick = 0
		chambered.newshot()
		return 1
	else
		..()

/obj/item/ammo_box/magazine/internal/shot/dual/heck/hook
	name = "hookshot internal magazine"
	max_ammo = 1
	ammo_type = /obj/item/ammo_casing/magic/hook/heck

/obj/item/ammo_casing/magic/hook/heck
	projectile_type = /obj/item/projectile/heckhook

/obj/item/projectile/heckhook //had to create a separate, non-child projectile because otherwise there would be conflicts when calling parent procs.
	name = "hook"
	icon_state = "hook"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	pass_flags = PASSTABLE
	damage = 10
	armour_penetration = 100
	damage_type = BRUTE
	hitsound = 'sound/effects/splat.ogg'
	knockdown = 0
	var/chain

/obj/item/projectile/heckhook/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "chain", time = INFINITY, maxdistance = INFINITY)
	..()

/obj/item/projectile/heckhook/on_hit(atom/target)
	. = ..()
	var/atom/A = target
	A.visible_message("<span class='danger'>[A] is snagged by [firer]'s hook!</span>")
	new /datum/forced_movement(firer, get_turf(A), 1, TRUE)

/obj/item/projectile/heckhook/Destroy()
	qdel(chain)
	return ..()

/datum/action/item_action/toggle_hook
	name = "Toggle Hook"

/obj/item/gun/ballistic/revolver/doublebarrel/super/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_hook))
		toggle_hook(user)
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel/super/proc/toggle_hook(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "You will now fire a hookshot.")
	else
		to_chat(user, "You will now fire normal shotgun rounds.")

/obj/item/gun/ballistic/revolver/doublebarrel/super/sawoff(mob/user)
	to_chat(user, "<span class='warning'>Why would you mutilate this work of art?</span>")
	return

/obj/item/gun/ballistic/revolver/doublebarrel/super/upgraded
	desc = "It was fearsome before, now it's even worse with an internal system that makes it fire both barrels at once."
	burst_size = 2
	burst_shot_delay = 1

//crucible
/obj/item/twohanded/crucible
	name = "Crucible Sword"
	desc = "Made from pure argent energy, this sword can cut through flesh like butter."
	icon = 'modular_skyrat/icons/obj/1x2.dmi'
	icon_state = "crucible0"
	var/icon_state_on = "crucible1"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_righthand.dmi'
	item_state = "crucible0"
	var/item_state_on = "crucible1"
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	var/w_class_on = WEIGHT_CLASS_HUGE
	force_unwielded = 5
	force_wielded = 25
	wieldsound = 'sound/weapons/saberon.ogg'
	unwieldsound = 'sound/weapons/saberoff.ogg'
	hitsound = "swing_hit"
	var/hitsound_on = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 50
	light_color = "#ff0000"//BLOOD RED
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	block_chance = 0
	var/block_chance_on = 50
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF
	var/brightness_on = 6
	total_mass = 1
	var/total_mass_on = TOTAL_MASS_MEDIEVAL_WEAPON

/obj/item/twohanded/crucible/suicide_act(mob/living/carbon/user)
	if(wielded)
		user.visible_message("<span class='suicide'>[user] DOOMs themselves with the [src]!</span>")

		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)//stole from chainsaw code
		var/obj/item/organ/brain/B = user.getorganslot(ORGAN_SLOT_BRAIN)
		B.organ_flags &= ~ORGAN_VITAL	//this cant possibly be a good idea
		var/randdir
		for(var/i in 1 to 24)//like a headless chicken!
			if(user.is_holding(src))
				randdir = pick(GLOB.alldirs)
				user.Move(get_step(user, randdir),randdir)
				user.emote("spin")
				if (i == 3 && myhead)
					myhead.drop_limb()
				sleep(3)
			else
				user.visible_message("<span class='suicide'>[user] panics and starts choking to death!</span>")
				return OXYLOSS


	else
		user.visible_message("<span class='suicide'>[user] begins beating [user.p_them()]self to death with \the [src]'s handle! It probably would've been cooler if [user.p_they()] turned it on first!</span>")
	return BRUTELOSS

/obj/item/twohanded/crucible/update_icon_state()
	if(wielded)
		icon_state = "crucible[wielded]"
	else
		icon_state = "crucible0"
	clean_blood()

/obj/item/twohanded/crucible/attack(mob/target, mob/living/carbon/human/user)
	var/def_zone = user.zone_selected
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.getarmor(def_zone, "melee") < 35)
			if((user.zone_selected != BODY_ZONE_CHEST) && (user.zone_selected != BODY_ZONE_HEAD))
				..()
				var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
				bodyp.dismember()
			else
				..()
		else if(user.zone_selected == BODY_ZONE_CHEST && H.health <= 0)
			..()
			H.spill_organs()
		else if(user.zone_selected == BODY_ZONE_HEAD && H.health <= 0)
			..()
			var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
			bodyp.drop_limb()
		else
			..()
	else
		..()

/obj/item/twohanded/crucible/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!wielded)
		return BLOCK_NONE
	return ..()

/obj/item/twohanded/crucible/wield(mob/living/carbon/M)
	..()
	if(wielded)
		sharpness = IS_SHARP
		w_class = w_class_on
		total_mass = total_mass_on
		hitsound = hitsound_on
		item_state = item_state_on
		block_chance = block_chance_on
		START_PROCESSING(SSobj, src)
		set_light(brightness_on)
		AddElement(/datum/element/sword_point)

/obj/item/twohanded/crucible/unwield()
	sharpness = initial(sharpness)
	w_class = initial(w_class)
	total_mass = initial(total_mass)
	..()
	hitsound = "swing_hit"
	block_chance = initial(block_chance)
	item_state = initial(item_state)
	STOP_PROCESSING(SSobj, src)
	set_light(0)
	RemoveElement(/datum/element/sword_point)

/obj/item/twohanded/crucible/process()
	if(wielded)
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/twohanded/crucible/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!wielded)
		return BLOCK_NONE
	return ..()

/obj/item/twohanded/crucible/ignition_effect(atom/A, mob/user)
	if(!wielded)
		return FALSE
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [user.p_their()] nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)

//praetor suit and helmet
/obj/item/clothing/suit/space/hardsuit/deathsquad/praetor
	name = "Praetor Suit"
	desc = "And those that tasted the bite of his sword named him... The Doom Slayer."
	armor = list("melee" = 75, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "praetor"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	item_state = "praetor"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/deathsquad/praetor
	slowdown = 0
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/head/helmet/space/hardsuit/deathsquad/praetor
	name = "Praetor Suit helmet"
	desc = "That's one doomed space marine."
	armor = list("melee" = 75, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "praetor"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay  = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	mutantrace_variation = STYLE_MUZZLE

//berserk rune
/obj/item/book/granter/martial/berserk
	name = "Strange Rune"
	desc = "Tales tell that this rune may grant the user power beyond measure... for a limited time."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "berserk"
	martial = /datum/martial_art/berserk
	martialname = "berserk"
	greet = "<span class='userdanger' style='color:rgb(0, 0, 0);'><b>DIG THE PROWESS. THE CAPACITY FOR VIOLENCE!</b></span>"
	pages_to_mastery = 0
	remarks = list("In the first age, in the first battle...", "Rip and tear...", "Huge guts...", "Big Fucking gun...")

/obj/item/book/granter/martial/berserk/onlearned(mob/user)
	playsound(source = get_turf(src), soundin = 'modular_skyrat/sound/ambience/e1m1riff.mid', vol = 150, vary = 0, pressure_affected = FALSE)
	sleep(35) //i could use a timer but this works too whatever.
	playsound(source = get_turf(src), soundin = 'modular_skyrat/sound/ambience/e1m1.mid', vol = 100, vary = 0, pressure_affected = FALSE)

//drake
/obj/structure/closet/crate/necropolis/dragon/PopulateContents()
	new /obj/item/borg/upgrade/modkit/knockback(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/crusher/PopulateContents()
	new /obj/item/crusher_trophy/tail_spike(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/hard
	name = "enraged dragon chest"

/obj/structure/closet/crate/necropolis/dragon/hard/PopulateContents()
	new /obj/item/melee/ghost_sword(src)
	new /obj/item/lava_staff(src)
	new /obj/item/book/granter/spell/sacredflame(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/borg/upgrade/modkit/knockback(src)
	new /obj/item/dragons_blood/distilled(src)
	new /obj/item/clothing/neck/necklace/memento_mori/king(src)

/obj/structure/closet/crate/necropolis/dragon/hard/crusher
	name = "enraged fiery dragon chest"

/obj/structure/closet/crate/necropolis/dragon/hard/crusher/PopulateContents()
	new /obj/item/melee/ghost_sword(src)
	new /obj/item/lava_staff(src)
	new /obj/item/book/granter/spell/sacredflame(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/dragons_blood/distilled(src)
	new /obj/item/clothing/neck/king(src)
	new /obj/item/crusher_trophy/tail_spike(src)


/obj/item/dragons_blood/distilled
	name = "bottle of distilled dragon's blood"
	desc = "You ARE going to drink this. Once."
	var/uses = 1 //originally the intent was for it to be shared with other miners but apparently improvedname likes when miners powergame and keep shit for themselves so there you go
	var/list/users = list() //list of people who already drank it. Take your choice, you're not gonna be both lava and stormproof.
	var/communist = TRUE //can you drink it more than once? true if no
	var/list/choices = list("Lizard", "Skeleton", "Lava", "Storm", "Organs", "Dragon", "Nothing")

/obj/item/dragons_blood/distilled/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return
	var/mob/living/carbon/human/H = user
	var/choice = input(H,"What blessing will you receive?","Choose your blessing") as null|anything in choices
	if(uses)
		if(communist)
			if(users.Find(H))
				to_chat(user, "<span class='danger'>You have already gotten your blessing, fool!</span>")
				return
		switch(choice)
			if("Lizard")
				to_chat(user, "<span class='danger'>Your appearance morphs to that of a very small humanoid ash dragon! You get to look like a freak without the cool abilities.</span>")
				H.dna.features = list("mcolor" = "A02720", "tail_lizard" = "Dark Tiger", "tail_human" = "None", "snout" = "Sharp", "horns" = "Curled", "ears" = "None", "wings" = "None", "frills" = "None", "spines" = "Long", "body_markings" = "Dark Tiger Body", "legs" = "Digitigrade")
				H.eye_color = "fee5a3"
				H.set_species(/datum/species/lizard)
				users |= H
				uses--
			if("Skeleton")
				to_chat(user, "<span class='danger'>Your flesh begins to melt! Miraculously, you seem fine otherwise.</span>")
				H.set_species(/datum/species/skeleton)
				users |= H
				uses--
			if("Lava")
				to_chat(user, "<span class='danger'>You feel like you could walk straight through lava now.</span>")
				H.weather_immunities |= "lava"
				users |= H
				uses--
			if("Storm")
				to_chat(user, "<span class='danger'>You feel like no type of storm could burn you.</span>")
				H.weather_immunities |= "ash"
				H.weather_immunities |= "snow"
				users |= H
				uses--
			if("Organs")
				to_chat(user, "<span class='danger'>Your lungs and heart feel... way more robust. Wait, what is that on the ground?</span>")
				var/obj/item/organ/lungs/super/newlungs = new /obj/item/organ/lungs/super(src.loc)
				newlungs.Insert(H)
				var/obj/item/organ/heart/undying/newheart = new /obj/item/organ/heart/undying(src.loc)
				newheart.Insert(H)
				users |= H
				uses--
			if("Dragon")
				to_chat(user, "<span class='danger'>Power courses through you! You can now shift your form at will.</span>")
				if(user.mind)
					var/obj/effect/proc_holder/spell/targeted/shapeshift/dragon/akatosh/D = new
					user.mind.AddSpell(D)
			else
				to_chat(user, "<span class='warning'>You think again and take a step back from drinking from the bottle.</span>")
		if(choice && choice != "Nothing")
			playsound(user.loc,'sound/items/drink.ogg', rand(25,50), 1)
	else
		to_chat(user, "<span class='warning'>You try drinking the bottle... but it's empty! And now it's just a normal vial!</span>")
		new /obj/item/reagent_containers/glass/bottle/vial(user.loc)
		qdel(src)

/obj/item/dragons_blood/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return

	var/mob/living/carbon/human/H = user
	var/random = rand(1,6)

	switch(random)
		if(1)
			to_chat(user, "<span class='danger'>Your appearance morphs to that of a very small humanoid ash dragon! You get to look like a freak without the cool abilities.</span>")
			H.dna.features = list("mcolor" = "A02720", "tail_lizard" = "Dark Tiger", "tail_human" = "None", "snout" = "Sharp", "horns" = "Curled", "ears" = "None", "wings" = "None", "frills" = "None", "spines" = "Long", "body_markings" = "Dark Tiger Body", "legs" = "Digitigrade")
			H.eye_color = "fee5a3"
			H.set_species(/datum/species/lizard)
		if(2)
			to_chat(user, "<span class='danger'>Your flesh begins to melt! Miraculously, you seem fine otherwise.</span>")
			H.set_species(/datum/species/skeleton)
		if(3)
			to_chat(user, "<span class='danger'>Power courses through you! You can now shift your form at will.</span>")
			if(user.mind)
				var/obj/effect/proc_holder/spell/targeted/shapeshift/dragon/D = new
				user.mind.AddSpell(D)
		if(4)
			to_chat(user, "<span class='danger'>You feel like you could walk straight through lava now.</span>")
			H.weather_immunities |= "lava"
		if(5)
			to_chat(user, "<span class='danger'>You feel like no type of storm could burn you.</span>")
			H.weather_immunities |= "ash"
			H.weather_immunities |= "snow"
		if(6)
			to_chat(user, "<span class='danger'>Your lungs and heart feel... way more robust. Wait, what is that on the ground?</span>")
			var/obj/item/organ/lungs/super/newlungs = new /obj/item/organ/lungs/super(src.loc)
			newlungs.Insert(H)
			var/obj/item/organ/heart/undying/newheart = new /obj/item/organ/heart/undying(src.loc)
			newheart.Insert(H)
	playsound(user.loc,'sound/items/drink.ogg', rand(10,50), 1)
	qdel(src)

/obj/item/organ/lungs/super
	name = "super lungs"
	desc = "Do these things even breathe or are they purely cosmetic?"
	safe_oxygen_min = 0
	safe_oxygen_max = 4000
	safe_nitro_min = 0
	safe_nitro_max = 0
	safe_co2_min = 0
	safe_co2_max = 4000
	safe_toxins_min = 0
	safe_toxins_max = 4000
	SA_para_min = 4000
	SA_sleep_min = 4000
	BZ_trip_balls_min = 4000
	gas_stimulation_min = 0.0005
	cold_level_1_threshold = 0
	cold_level_2_threshold = 0
	cold_level_3_threshold = 0
	heat_level_1_threshold = 4000
	heat_level_2_threshold = 4000
	heat_level_3_threshold = 4000
	crit_stabilizing_reagent = /datum/reagent/medicine //any medicine will stabilize you lol

/obj/item/organ/heart/undying
	name = "undying heart"
	desc = "This heart pumps with passion for life. It won't ever stop beating."
	organ_flags = ORGAN_SYNTHETIC
	var/min_next_adrenaline = 0
	var/amount2heal = 5

/obj/item/organ/heart/undying/Stop() //IT WON'T LET GO.
	return 0

/obj/item/organ/heart/undying/on_life()
	. = ..()
	if(owner.health <= 5 && world.time > min_next_adrenaline)
		min_next_adrenaline = world.time + rand(300, 600) //anywhere from 30 seconds to 1 minute (i think?)
		to_chat(owner, "<span class='userdanger'>You feel yourself dying, but you refuse to give up!</span>")
		owner.heal_overall_damage(amount2heal, amount2heal)
		if(owner.reagents.get_reagent_amount(/datum/reagent/medicine/ephedrine) < 20)
			owner.reagents.add_reagent(/datum/reagent/medicine/ephedrine, 10)
	if(damage >= (maxHealth/4)*2) //if at 75% or more damage, heal time
		damage -= rand(1, 15)
	if(!beating)
		beating = !beating

/obj/item/clothing/neck/necklace/memento_mori/king
	name = "amulet of kings"
	desc = "An amulet that shows everyone who the true emperor is."
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	icon_state = "dragon_amulet"
	item_state = "dragon_amulet"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

//colossus
/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	new /obj/item/bluecrystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/borg/upgrade/modkit/bolter(src)

/obj/structure/closet/crate/necropolis/colossus/crusher/PopulateContents()
	new /obj/item/bluecrystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/crusher_trophy/blaster_tubes(src)

//crystal choosing thing from colosssus
/obj/item/bluecrystal
	name = "\improper blue crystal"
	desc = "It's very shiny... one may wonder what it does."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "bluecrystal"
	w_class = WEIGHT_CLASS_SMALL
	var/list/choices = list(
	"Clown" = /obj/machinery/anomalous_crystal/honk,
	"Theme Warp" = /obj/machinery/anomalous_crystal/theme_warp,
	"Bolter" = /obj/machinery/anomalous_crystal/emitter,
	"Dark Revival" = /obj/machinery/anomalous_crystal/dark_reprise,
	"Lightgeist Healers" = /obj/machinery/anomalous_crystal/helpers,
	"Refresher" = /obj/machinery/anomalous_crystal/refresher,
	"Possessor" = /obj/machinery/anomalous_crystal/possessor
	)
	var/list/methods = list(
	"touch",
	"speech",
	"heat",
	"bullet",
	"energy",
	"bomb",
	"bumping",
	"weapon",
	"magic"
	)

/obj/item/bluecrystal/attack_self(mob/user)
	var/choice = input(user, "Choose your destiny", "Crystal") as null|anything in choices
	var/method = input(user, "Choose your activation method", "Crystal") as null|anything in methods
	if(!choice || !method)
		return
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	var/choosey = choices[choice]
	var/obj/machinery/anomalous_crystal/A = new choosey(user.loc)
	A.activation_method = method
	to_chat(user, "<span class='userdanger'>[A] appears under your feet as the [src] breaks apart!</span>")
	qdel(src)

//normal chests
/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = rand(1,31)
	new /obj/item/stock_parts/cell/high/plus/argent(src)
	switch(loot)
		if(1)
			new /obj/item/shared_storage/red(src)
			return /obj/item/shared_storage/red
		if(2)
			new /obj/item/clothing/suit/space/hardsuit/cult(src)
			return /obj/item/clothing/suit/space/hardsuit/cult
		if(3)
			new /obj/item/soulstone/anybody(src)
			return /obj/item/soulstone/anybody
		if(4)
			new /obj/item/katana/cursed(src)
			return /obj/item/katana/cursed
		if(5)
			new /obj/item/clothing/glasses/godeye(src)
			return /obj/item/clothing/glasses/godeye
		if(6)
			new /obj/item/reagent_containers/glass/bottle/potion/flight(src)
			return /obj/item/reagent_containers/glass/bottle/potion/flight
		if(7)
			new /obj/item/pickaxe/diamond(src)
			return /obj/item/pickaxe/diamond
		if(8)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
				return /obj/item/disk/design_disk/modkit_disc/resonator_blast
			else
				new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
				return /obj/item/disk/design_disk/modkit_disc/rapid_repeater
		if(9)
			new /obj/item/rod_of_asclepius(src)
			return /obj/item/rod_of_asclepius
		if(10)
			new /obj/item/organ/heart/cursed/wizard(src)
			return /obj/item/organ/heart/cursed/wizard
		if(11)
			new /obj/item/ship_in_a_bottle(src)
			return /obj/item/ship_in_a_bottle
		if(12)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker(src)
			return /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker
		if(13)
			new /obj/item/jacobs_ladder(src)
			return /obj/item/jacobs_ladder
		if(14)
			new /obj/item/nullrod/scythe/talking(src)
			return /obj/item/nullrod/scythe/talking
		if(15)
			new /obj/item/nullrod/armblade(src)
			return /obj/item/nullrod/armblade
		if(16)
			new /obj/item/guardiancreator(src)
			return /obj/item/guardiancreator
		if(17)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
				return /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe
			else
				new /obj/item/disk/design_disk/modkit_disc/bounty(src)
				return /obj/item/disk/design_disk/modkit_disc/bounty
		if(18)
			new /obj/item/warp_cube/red(src)
			return /obj/item/warp_cube/red
		if(19)
			new /obj/item/wisp_lantern(src)
			return /obj/item/wisp_lantern
		if(20)
			new /obj/item/immortality_talisman(src)
			return /obj/item/immortality_talisman
		if(21)
			new /obj/item/gun/magic/hook(src)
			return /obj/item/gun/magic/hook
		if(22)
			new /obj/item/voodoo(src)
			return /obj/item/voodoo
		if(23)
			new /obj/item/grenade/clusterbuster/inferno(src)
			return /obj/item/grenade/clusterbuster/inferno
		if(24)
			new /obj/item/reagent_containers/food/drinks/bottle/holywater/hell(src)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor(src)
			return /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor
		if(25)
			new /obj/item/book/granter/spell/summonitem(src)
			return /obj/item/book/granter/spell/summonitem
		if(26)
			new /obj/item/book_of_babel(src)
			return /obj/item/book_of_babel
		if(27)
			new /obj/item/borg/upgrade/modkit/lifesteal(src)
			new /obj/item/bedsheet/cult(src)
			return /obj/item/borg/upgrade/modkit/lifesteal
		if(28)
			new /obj/item/clothing/neck/necklace/memento_mori(src)
			return /obj/item/clothing/neck/necklace/memento_mori
		if(29)
			new /obj/item/gun/ballistic/shotgun/boltaction/enchanted(src)
			return /obj/item/gun/ballistic/shotgun/boltaction/enchanted
		if(30)
			new /obj/item/gun/magic/staff/door(src)
			return /obj/item/gun/magic/staff/door
		if(31)
			new /obj/item/katana/necropolis(src)
			return /obj/item/katana/necropolis

/obj/item/stock_parts/cell/high/plus/argent
	name = "Argent Energy Cell"
	desc = "Harvested from the necropolis, this autocharging energy cell can be crushed to provide a temporary 90% damage reduction bonus. Also useful for research."
	self_recharge = 1
	maxcharge = 1500 //only barely better than a normal power cell now
	chargerate = 700 //good recharge time doe
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "argentcell"
	ratingdesc = FALSE
	rating = 6
	custom_materials = list(/datum/material/glass=500, /datum/material/uranium=250, /datum/material/plasma=1000, /datum/material/diamond=500)
	var/datum/status_effect/onuse = /datum/status_effect/blooddrunk/argent

/obj/item/stock_parts/cell/high/plus/argent/attack_self(mob/user)
	..()
	user.visible_message("<span class='danger'>[user] crushes the [src] in his hands, absorbing it's energy!</span>")
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	var/mob/living/M = user
	M.apply_status_effect(onuse)
	qdel(src)

/obj/item/stock_parts/cell/high/plus/argent/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF)

/obj/item/katana/necropolis
	force = 25 //Wouldn't want a miner walking around with a 40 damage melee around now, would we?
	armour_penetration = 25
	block_chance = 0 //blocky bad

/obj/item/immortality_talisman
	w_class = WEIGHT_CLASS_SMALL //why the fuck are they large anyways
//legion
/obj/structure/closet/crate/necropolis/legion
	name = "echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/crusher_trophy/golden_skull(src)
	new /obj/item/borg/upgrade/modkit/skull(src)

/obj/structure/closet/crate/necropolis/legion/hard
	name = "enraged echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/hard/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/clothing/mask/gas/dagoth(src)
	new /obj/item/crusher_trophy/golden_skull(src)
	new /obj/item/borg/upgrade/modkit/skull(src)
	var/obj/structure/closet/crate/necropolis/tendril/T = new /obj/structure/closet/crate/necropolis/tendril //Yup, i know, VERY spaghetti code.
	var/obj/item/L
	for(var/i = 0, i < 3, i++)
		L = T.PopulateContents()
		new L(src)
	qdel(T)

//dagoth ur mask
/obj/item/clothing/mask/gas/dagoth
	name = "Golden Mask"
	desc = "Such a grand and intoxicating innocence."
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay  = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "dagoth"
	item_state = "dagoth"
	actions_types = list(/datum/action/item_action/ashstorm)
	flash_protect = 2
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10,"energy" = 10, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)//HOW CAN YOU KILL A GOD?
	var/static/list/excluded_areas = list(/area/reebe/city_of_cogs)
	var/storm_type = /datum/weather/ash_storm
	var/storm_cooldown = 0
	w_class = WEIGHT_CLASS_BULKY //its a fucking full metal mask man
	mutantrace_variation = STYLE_MUZZLE

/datum/action/item_action/ashstorm
	name = "Summon Ash Storm"
	desc = "Bring the wrath of the sixth house upon the area where you stand."

/obj/item/clothing/mask/gas/dagoth/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/ashstorm))
		if(storm_cooldown > world.time)
			to_chat(user, "<span class='warning'>The [src] is still recharging!</span>")
			return

		var/area/user_area = get_base_area(user)
		var/turf/user_turf = get_turf(user)
		if(!user_area || !user_turf || (user_area.type in excluded_areas))
			to_chat(user, "<span class='warning'>Something is preventing you from using the [src] here.</span>")
			return
		var/datum/weather/A
		for(var/V in SSweather.processing)
			var/datum/weather/W = V
			if((user_turf.z in W.impacted_z_levels) && W.area_type == user_area.type)
				A = W
				break

		if(A)
			if(A.stage != END_STAGE)
				if(A.stage == WIND_DOWN_STAGE)
					to_chat(user, "<span class='warning'>The storm is already ending! It would be a waste to use the [src] now.</span>")
					return
				user.visible_message("<span class='warning'>[user] gazes into the sky with [src], seemingly repelling the current storm!</span>", \
				"<span class='notice'>You gaze intently skyward, dispelling the storm!</span>")
				playsound(user, 'sound/magic/staff_change.ogg', 200, 0)
				A.wind_down()
				log_game("[user] ([key_name(user)]) has dispelled a storm at [AREACOORD(user_turf)]")
				return
		else
			A = new storm_type(list(user_turf.z))
			A.name = "staff storm"
			log_game("[user] ([key_name(user)]) has summoned [A] at [AREACOORD(user_turf)]")
			if (is_special_character(user))
				message_admins("[A] has been summoned in [ADMIN_VERBOSEJMP(user_turf)] by [user] ([key_name_admin(user)], a non-antagonist")
			A.area_type = user_area.type
			A.telegraph_duration = 100
			A.end_duration = 100

		user.visible_message("<span class='warning'>[user] gazes skyward with his [src], terrible red lightning strikes seem to accompany them!</span>", \
		"<span class='notice'>You gaze skyward with [src], calling down a terrible storm!</span>")
		playsound(user, 'sound/magic/staff_change.ogg', 200, 0)
		A.telegraph()
		storm_cooldown = world.time + 200
	else
		..()

//glaurung (needs unique loot and crusher trophy)
/obj/structure/closet/crate/necropolis/glaurung
	name = "drake chest"

/obj/structure/closet/crate/necropolis/glaurung/PopulateContents()
	new /obj/item/borg/upgrade/modkit/knockback(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/glaurung/crusher
	name = "wise drake chest"

/obj/structure/closet/crate/necropolis/glaurung/crusher/PopulateContents()
	new /obj/item/crusher_trophy/tail_spike(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

//Sif stuff
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=Sword Of The Forsaken=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//

/*Videos on what the sword can do:
**
**Attacking: ----------	https://bungdeep.com/Sif/Sword_of_the_Forsaken_Attack.mp4
**Butchering: --------- https://bungdeep.com/Sif/Sword_of_the_Forsaken_Butcher.mp4
**Dodging: ------------ https://bungdeep.com/Sif/Sword_of_the_Forsaken_Block_Melee.png
**Projectile Dodging: - https://bungdeep.com/Sif/Sword_of_the_Forsaken_Block.png
**
*/
/obj/item/melee/sword_of_the_forsaken
	name = "Sword of the Forsaken"
	desc = "A glowing giant heavy blade that grows and slightly shrinks in size depending on the wielder's strength."
	icon = 'modular_skyrat/icons/obj/lavaland/sif.dmi'
	icon_state = "sword_of_the_forsaken"
	item_state = "sword_of_the_forsaken"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/item_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/item_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 15
	throwforce = 10
	block_chance = 10
	armour_penetration = 80
	hitsound = 'modular_skyrat/sound/sif/sif_slash.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut", "gutted", "gored")
	sharpness = IS_SHARP
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

//Enables the sword to butcher bodies
/obj/item/melee/sword_of_the_forsaken/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 50, 100, 10)

//Sword blocking attacks, really hard to block projectiles but still possible.
/obj/item/melee/sword_of_the_forsaken/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(attack_type == ATTACK_TYPE_PROJECTILE)
		final_block_chance = 5
	return ..()

//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=End of Sworf Of The Forsaken=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//


//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=Necklace Of The Forsaken=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//

/*Videos on what the necklace can do:
**
**Binding the necklace to yourself: ------- https://bungdeep.com/Sif/Necklace_of_the_Forsaken_Binding.mp4
**Reviving when died: --------------------- https://bungdeep.com/Sif/Necklace_of_the_Forsaken_Death_Revive.mp4
**Becomes a cosmetic item after it is used: https://bungdeep.com/Sif/Necklace_of_the_Forsaken_Revive_Used.png
**
*/
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken
	name = "Necklace of the Forsaken"
	desc = "A rose gold necklace with a small static ember that burns inside of the black gem stone, making it warm to the touch."
	icon = 'modular_skyrat/icons/obj/lavaland/sif.dmi'
	icon_state = "necklace_forsaken_active"
	actions_types = list(/datum/action/item_action/hands_free/necklace_of_the_forsaken)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/mob/living/carbon/human/active_owner
	var/numUses = 1

/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/item_action_slot_check(slot)
	return slot == ITEM_SLOT_NECK

/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/dropped(mob/user)
	..()
	if(active_owner)
		remove_necklace()

//Apply a temp buff until the necklace is used
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/proc/temp_buff(mob/living/carbon/human/user)
	to_chat(user, "<span class='warning'>You feel as if you have a second chance at something, but you're not sure what.</span>")
	if(do_after(user, 40, target = user))
		to_chat(user, "<span class='notice'>The ember warms you...</span>")
		ADD_TRAIT(user, TRAIT_NOHARDCRIT, "necklace_of_the_forsaken")//less chance of being gibbed
		active_owner = user

//Revive the user and remove buffs
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/proc/second_chance()
	icon_state = "necklace_forsaken_active"
	if(!active_owner)
		return
	var/mob/living/carbon/human/H = active_owner
	active_owner = null
	to_chat(H, "<span class='userdanger'>You feel a scorching burn fill your body and limbs!</span>")
	H.revive(TRUE, FALSE)
	remove_necklace() //remove buffs

//Remove buffs
/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/proc/remove_necklace()
	icon_state = "necklace_forsaken_active"
	if(!active_owner)
		return
	REMOVE_TRAIT(active_owner, TRAIT_NOHARDCRIT, "necklace_of_the_forsaken")
	active_owner = null //just in case

//Add action
/datum/action/item_action/hands_free/necklace_of_the_forsaken
	check_flags = NONE
	name = "Necklace of the Forsaken"
	desc = "Bind the necklaces ember to yourself, so that next time you activate it, it will revive or fully heal you whether dead or knocked out. (Beware of being gibbed)"

//What happens when the user clicks on datum
/datum/action/item_action/hands_free/necklace_of_the_forsaken/Trigger()
	var/obj/item/clothing/neck/necklace/necklace_of_the_forsaken/MM = target
	if(MM.numUses == 0)//skip if it has already been used up
		return
	if(!MM.active_owner)//apply bind if there is no active owner
		if(ishuman(owner))
			MM.temp_buff(owner)
		src.desc = "Revive or fully heal yourself, but you can only do this once! Can be used when knocked out or dead."
		to_chat(MM.active_owner, "<span class='userdanger'>You have binded the ember to yourself! The next time you use the necklace it will heal you!</span>")
	else if(MM.numUses == 1 && MM.active_owner)//revive / heal then remove usage
		MM.second_chance()
		MM.numUses = 0
		MM.icon_state = "necklace_forsaken"
		MM.desc = "A rose gold necklace that used to have a bright burning ember inside of it."
		src.desc = "The necklaces ember has already been used..."
//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=End of Necklace of The Forsaken=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=//


//Sifs loot chest
/obj/structure/closet/crate/necropolis/sif
	name = "Great Brown Wolf Sif's chest"

/obj/structure/closet/crate/necropolis/sif/PopulateContents()
	new /obj/item/melee/sword_of_the_forsaken(src)
	new /obj/item/clothing/neck/necklace/necklace_of_the_forsaken(src)
	new /obj/item/borg/upgrade/modkit/critical(src)

/obj/structure/closet/crate/necropolis/sif/crusher
	name = "Great Brown Wolf Sif's infinity chest"

/obj/structure/closet/crate/necropolis/sif/crusher/PopulateContents()
	new /obj/item/melee/sword_of_the_forsaken(src)
	new /obj/item/clothing/neck/necklace/necklace_of_the_forsaken(src)
	new /obj/item/crusher_trophy/dark_energy(src)
