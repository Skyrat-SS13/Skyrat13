#define AXE_SLAM 1
#define SUMMON_SHAMBLER 2
#define DASH 3
#define AXE_THROW 4

/**
  * # Necropolis priest
  *
  * Kind of like BD miner's son trying to impress their dad.
  * Has four attacks.
  * - Axe Slam - Slams his axe on the ground, hurting everyone is his direction in a 3 tile radius
  * - Summon Shambler - Summons a shambling miner that focuses on the target.
  * - Dash - Dashes in the target's general direction
  * - Axe Throw - Throws an axe at the target
  */

/mob/living/simple_animal/hostile/asteroid/elite/minerpriest
	name = "Necropolis Priest"
	desc = "Once used to be a miner, now a worshipper of the necropolis."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_elites.dmi'
	icon_state = "minerpriest"
	icon_living = "minerpriest"
	icon_aggro = "minerpriest"
	icon_dead = "minerpriest_dead"
	icon_gib = "syndicate_gib"
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	speed = 1
	move_to_delay = 2
	mouse_opacity = MOUSE_OPACITY_ICON
	deathsound = 'sound/voice/human/manlaugh1.ogg'
	deathmessage = "realizes what they've been doing all this time, and return to their true self."
	loot_drop = /obj/item/melee/diamondaxe
	speak_emote = list("yells")
	del_on_death = TRUE
	attack_action_types = list(/datum/action/innate/elite_attack/axe_slam,
								/datum/action/innate/elite_attack/summon_shambler,
								/datum/action/innate/elite_attack/dash,
								/datum/action/innate/elite_attack/axe_throw)
	glorymessageshand = list("grabs the priest's arm and breaks it, exposing sharp bone which is promptly shoved inside their skull!", "punches into the priest's guts, ripping off their stomach and whatever else was inside!")
	glorymessagescrusher = list("chops the priest's leg off with their crusher, then uses it to beat their skull open while they're downed!")
	glorymessagespka = list("shoots at the priest's hand, exploding it and making them let go of their axe, which is promptly grabbed and slashes their neck open!", "kicks the priest on the ground, then shoots their guts and viscera off with a PKA blast to the chest!")
	glorymessagespkabayonet = list("stabs through the priest's heart and pulls it out, letting them see one last beat before they die!")

/datum/action/innate/elite_attack/axe_slam
	name = "Axe Slam"
	icon_icon = 'modular_skyrat/icons/mob/actions/actions_elites.dmi'
	button_icon_state = "axe_slam"
	chosen_message = "<span class='boldwarning'>You will attempt to slam your axe.</span>"
	chosen_attack_num = AXE_SLAM

/datum/action/innate/elite_attack/summon_shambler
	name = "Summon Shambler"
	icon_icon = 'modular_skyrat/icons/mob/actions/actions_elites.dmi'
	button_icon_state = "summon_shambler"
	chosen_message = "<span class='boldwarning'>You will attempt to summon a shambling miner.</span>"
	chosen_attack_num = SUMMON_SHAMBLER

/datum/action/innate/elite_attack/dash
	name = "Dash"
	icon_icon = 'modular_skyrat/icons/mob/actions/actions_elites.dmi'
	button_icon_state = "dash"
	chosen_message = "<span class='boldwarning'>You will attempt to dash near your target.</span>"
	chosen_attack_num = DASH

/datum/action/innate/elite_attack/axe_throw
	name = "Axe Throw"
	icon_icon = 'modular_skyrat/icons/mob/actions/actions_elites.dmi'
	button_icon_state = "axe_throw"
	chosen_message = "<span class='boldwarning'>You will attempt to throw your axe.</span>"
	chosen_attack_num = AXE_THROW

/mob/living/simple_animal/hostile/asteroid/elite/minerpriest/OpenFire()
	if(client)
		switch(chosen_attack)
			if(AXE_SLAM)
				axe_slam(target)
			if(SUMMON_SHAMBLER)
				summon_shambler(target)
			if(DASH)
				dash(target)
			if(AXE_THROW)
				axe_throw(target)
		return
	var/aiattack = rand(1,4)
	switch(aiattack)
		if(AXE_SLAM)
			axe_slam(target)
		if(SUMMON_SHAMBLER)
			summon_shambler(target)
		if(DASH)
			dash(target)
		if(AXE_THROW)
			axe_throw(target)

// priest actions
/mob/living/simple_animal/hostile/asteroid/elite/minerpriest/proc/axe_slam(target)
	ranged_cooldown = world.time + 30
	var/list/turfs = list(get_turf(src))
	turfs |= getline(src, target)
	var/count = 0
	for(var/turf/T in turfs)
		if(count >= 3)
			break
		count++
		new /obj/effect/temp_visual/dragon_swoop/priest(T)
	visible_message("<span class='boldwarning'>[src] prepares to slam his axe!</span>")
	sleep(5)
	playsound(src,'sound/misc/crunch.ogg', 200, 1)
	var/list/hit_things = list()
	visible_message("<span class='boldwarning'>[src] slams his axe!</span>")
	for(var/turf/T in turfs)
		for(var/mob/living/L in T.contents)
			if(faction_check_mob(L))
				return
			hit_things += L
			visible_message("<span class='boldwarning'>[src] slams his axe on [L]!</span>")
			to_chat(L, "<span class='userdanger'>[src] slams his axe on you!</span>")
			L.Stun(15)
			L.adjustBruteLoss(30)

/mob/living/simple_animal/hostile/asteroid/elite/minerpriest/proc/summon_shambler(target)
	ranged_cooldown = world.time + 150
	visible_message("<span class='boldwarning'>[src] summons a minion!</span>")
	playsound(src,'sound/magic/CastSummon.ogg', 200, 1)
	var/list/turfs = list()
	for(var/turf/T in oview(2, src))
		turfs += T
	var/turf/pick1 = pick(turfs)
	new /obj/effect/temp_visual/small_smoke/halfsecond(pick1)
	var/mob/living/simple_animal/hostile/asteroid/miner/m1 = new /mob/living/simple_animal/hostile/asteroid/miner(pick1)
	m1.faction = faction.Copy()
	m1.GiveTarget(target)

/mob/living/simple_animal/hostile/asteroid/elite/minerpriest/proc/dash(atom/dash_target)
	if(!dash_target)
		return
	var/turf/original_turf = get_turf(src)
	var/turf/chargeturf = get_turf(dash_target) //get target turf
	if(!chargeturf) //no turf, we cancel.
		return
	var/vrr_dir = get_dir(src, chargeturf)//get direction
	var/turf/T = get_ranged_target_turf(chargeturf,dir,5)//get final dash turf
	if(!T) //the final dash turf was out of range - we settle for the target turf instead
		T = chargeturf
	ranged_cooldown = world.time + 20
	visible_message("<span class='boldwarning'>[src] dashes dashes to [dash_target]!</span>")
	new /obj/effect/temp_visual/small_smoke/halfsecond(src.loc)
	//Stop movement
	walk(src,0)
	setDir(vrr_dir)
	var/movespeed = 0.7
	//Dash through the dash target if possible
	if(dash_target.CanPass(src, T))
		walk_to(src, T, 0, 1, movespeed)
		//If the dash target was a mob, we damage them because basically we ran into them at mach 7
		if(isliving(dash_target) && (dash_target.loc in getline(original_turf, loc)))
			var/mob/living/L = dash_target
			L.visible_message("<span class='danger'>[L] gets rammed by \the [src]!</span>")
			L.apply_damage(15, BRUTE)
	else //we settle for less and dash to adjacent to the dash target itself
		walk_to(src, dash_target, 1, 1, movespeed)
		//If the dash target was a mob, we damage them because basically we ran into them at mach 7
		if(isliving(dash_target) && (loc in view(1, dash_target)))
			var/mob/living/L = dash_target
			L.visible_message("<span class='danger'>[L] gets rammed by \the [src]!</span>")
			L.apply_damage(15, BRUTE)
	playsound(src,'sound/magic/blink.ogg', 200, 1)
	new /obj/effect/temp_visual/small_smoke/halfsecond(src.loc)
	//Stop movement
	walk(src, 0)
	
	return TRUE


/mob/living/simple_animal/hostile/asteroid/elite/minerpriest/proc/axe_throw(atom/target)
	ranged_cooldown = world.time + 20
	visible_message("<span class='boldwarning'>[src] prepares to throw his axe!</span>")
	var/obj/item/melee/diamondaxe/priest/asxe = new(loc)
	asxe.throw_at(target, 5, 4, src, TRUE)
	playsound(src,'sound/weapons/fwoosh.wav', 200, 1)

/mob/living/simple_animal/hostile/asteroid/elite/minerpriest/drop_loot()
	var/mob/living/carbon/human/H = new /mob/living/carbon/human(src.loc)
	if(src.client)
		transfer_ckey(H)
		to_chat(H, "<span class='userdanger'>You have been finally enlightened.  Serving the necropolis is not your duty anymore, thanks to whoever defeated you. You owe them a great debt.</span")
		to_chat(H, "<span class='big bold'>Note that you now share the loyalties of the one who defeated you.  You are expected not to intentionally sabotage their faction unless commanded to!</span>")
	else
		H.adjustBruteLoss(200)
	H.equipOutfit(/datum/outfit/job/miner/equipped/priest)

// priest helpers
/datum/outfit/job/miner/equipped/priest
	name = "Shaft Miner (Necropolis Priest)"
	shoes = /obj/item/clothing/shoes/bronze
	mask = /obj/item/clothing/mask/gas
	backpack_contents = list(
		/obj/item/flashlight/seclite=1,\
		/obj/item/kitchen/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1,
		/obj/item/melee/diamondaxe = 1,
		/obj/item/clothing/head/bronze = 1,
		/obj/item/clothing/suit/bronze = 1)

/obj/effect/temp_visual/dragon_swoop/priest
	duration = 5
	color = rgb(255,0,0)

/obj/effect/temp_visual/dragon_swoop/priest/Initialize()
	. = ..()
	transform *= 0.33

//loot

/obj/item/melee/diamondaxe
	name = "\proper Priest's Axe"
	desc = "Used to be a diamond pickaxe, now there's no pick, just axe."
	icon = 'modular_skyrat/icons/obj/lavaland/artefacts.dmi'
	icon_state = "diamondaxe"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/axes_righthand.dmi'
	item_state = "diamondaxe"
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	w_class = WEIGHT_CLASS_BULKY
	force = 20
	throwforce = 24
	embedding = list("embedded_pain_multiplier" = 3, "embed_chance" = 90, "embedded_fall_chance" = 50)
	armour_penetration = 50
	block_chance = 25
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/slash.ogg'

/obj/item/melee/diamondaxe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 50, 100, null, null, TRUE)

/obj/item/melee/diamondaxe/priest
	name = "temporal diamond axe"
	alpha = 128

/obj/item/melee/diamondaxe/priest/Initialize()
	..()
	QDEL_IN(src, 30)
