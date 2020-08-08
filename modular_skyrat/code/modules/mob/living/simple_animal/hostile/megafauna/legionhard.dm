/**
  *LEGION
  *
  *Legion spawns from the necropolis gate in the far north of lavaland. It is the guardian of the Necropolis and emerges from within whenever an intruder tries to enter through its gate.
  *Whenever Legion emerges, everything in lavaland will receive a notice via color, audio, and text. This is because Legion is powerful enough to slaughter the entirety of lavaland with little effort. LOL
  *
  *It has three attacks.
  *Spawn Skull. Most of the time it will use this attack. Spawns a single legion skull.
  *Spawn Sentinel. The legion will spawn up to three sentinels, depending on its size.
  *CHARGE! The legion starts spinning and tries to melee the player. It will try to flick itself towards the player, dealing some damage if it hits.
  *
  *When Legion dies, it will split into three smaller skulls up to three times.
  *If you kill all of the smaller ones it drops a staff of storms, which allows its wielder to call and disperse ash storms at will and functions as a powerful melee weapon.
  *
  *Difficulty: Medium
  *
  *SHITCODE AHEAD. BE ADVISED. Also comment extravaganza
  */
/mob/living/simple_animal/hostile/megafauna/legion/hard
	name = "Enraged Legion"
	desc = "THE one in the many."
	icon = 'modular_skyrat/icons/mob/lavaland/96x96megafauna.dmi'
	icon_state = "mega_legion"
	icon_living = "mega_legion"
	armour_penetration = 50
	melee_damage_lower = 25
	melee_damage_upper = 25
	speed = 5
	ranged = TRUE
	del_on_death = TRUE
	retreat_distance = 5
	minimum_distance = 5
	ranged_cooldown_time = 20
	pixel_y = -16
	pixel_x = -32

	loot = list(/obj/item/stack/sheet/bone = 3)
	vision_range = 13
	wander = FALSE
	elimination = TRUE
	appearance_flags = 0
	mouse_opacity = MOUSE_OPACITY_ICON
	size = 3
	charging = FALSE
	true_spawn = TRUE

/obj/item/gps/internal/legion/hard
	icon_state = null
	gpstag = "Enraged Echoing Signal"
	desc = "The message screeches."
	invisibility = 100

/mob/living/simple_animal/hostile/megafauna/legion/hard/Initialize()
	..()
	internal = new/obj/item/gps/internal/legion/hard(src)

/mob/living/simple_animal/hostile/megafauna/legion/hard/OpenFire(the_target)
	if(charging)
		return
	ranged_cooldown = world.time + ranged_cooldown_time
	switch(rand(4)) //Larger skulls use more attacks.
		if(0 to 2)
			create_legion_skull()
		if(3)
			charge_target()
		if(4)
			create_legion_turrets()

//SKULLS

///Attack proc. Spawns a singular legion skull.
/mob/living/simple_animal/hostile/megafauna/legion/hard/proc/create_legion_skull()
	var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/A = new(loc)
	A.GiveTarget(target)
	A.friends = friends
	A.faction = faction

//CHARGE

///Attack proc. Gives legion some movespeed buffs and switches the AI to melee. At lower sizes, this also throws the skull at the player.
/mob/living/simple_animal/hostile/megafauna/legion/hard/proc/charge_target()
	visible_message("<span class='warning'><b>[src] charges!</b></span>")
	SpinAnimation(speed = 20, loops = 3, parallel = FALSE)
	ranged = FALSE
	retreat_distance = 0
	minimum_distance = 0
	set_varspeed(0)
	charging = TRUE
	addtimer(CALLBACK(src, .proc/reset_charge), 60)
	var/mob/living/L = target
	if(!istype(L) || L.stat != DEAD) //I know, weird syntax, but it just works.
		addtimer(CALLBACK(src, .proc/throw_thyself), 20)

///This is the proc that actually does the throwing. Charge only adds a timer for this.
/mob/living/simple_animal/hostile/megafauna/legion/hard/proc/throw_thyself()
	playsound(src, 'sound/weapons/sonic_jackhammer.ogg', 50, TRUE)
	throw_at(target, 7, 1.1, src, FALSE, FALSE, CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/effects/meteorimpact.ogg', 50 * size, TRUE, 2), INFINITY)

///Deals some extra damage on throw impact.
/mob/living/simple_animal/hostile/megafauna/legion/hard/throw_impact(mob/living/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(istype(hit_atom))
		playsound(src, attack_sound, 100, TRUE)
		hit_atom.apply_damage(22 * size / 2) //It gets pretty hard to dodge the skulls when there are a lot of them. Scales down with size
		hit_atom.safe_throw_at(get_step(src, get_dir(src, hit_atom)), 2) //Some knockback. Prevent the legion from melee directly after the throw.

//TURRETS

///Attack proc. Creates up to three legion turrets on suitable turfs nearby.
/mob/living/simple_animal/hostile/megafauna/legion/hard/proc/create_legion_turrets(minimum = 2, maximum = size * 2)
	playsound(src, 'sound/magic/RATTLEMEBONES.ogg', 100, TRUE)
	var/list/possiblelocations = list()
	for(var/turf/T in oview(src, 4)) //Only place the turrets on open turfs
		if(is_blocked_turf(T))
			continue
		possiblelocations += T
	for(var/i in 1 to min(rand(minimum, maximum), LAZYLEN(possiblelocations))) //Makes sure aren't spawning in nullspace.
		var/chosen = pick(possiblelocations)
		new /obj/structure/legionturret(chosen)
		possiblelocations -= chosen

/mob/living/simple_animal/hostile/megafauna/legion/hard/GiveTarget(new_target)
	. = ..()
	if(target)
		wander = TRUE

///This makes sure that the legion door opens on taking damage, so you can't cheese this boss.
/mob/living/simple_animal/hostile/megafauna/legion/hard/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	if(GLOB.necropolis_gate && true_spawn)
		GLOB.necropolis_gate.toggle_the_gate(null, TRUE) //very clever.
	return ..()

///In addition to parent functionality, this will also turn the target into a small legion if they are unconcious.
/mob/living/simple_animal/hostile/megafauna/legion/hard/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/L = target
		if(L.stat == UNCONSCIOUS)
			var/mob/living/simple_animal/hostile/asteroid/hivelordbrood/legion/A = new(loc)
			A.infest(L)

///Resets the charge buffs.
/mob/living/simple_animal/hostile/megafauna/legion/hard/reset_charge()
	ranged = TRUE
	retreat_distance = 5
	minimum_distance = 5
	set_varspeed(2)
	charging = FALSE

///Special snowflake death() here. Can only die if size is 1 or lower and HP is 0 or below.
/mob/living/simple_animal/hostile/megafauna/legion/hard/death()
	//Make sure we didn't get cheesed
	if(health > 0)
		return
	if(Split())
		return
	//We check what loot we should drop.
	var/last_legion = TRUE
	for(var/mob/living/simple_animal/hostile/megafauna/legion/hard/other in GLOB.mob_living_list)
		if(other != src)
			last_legion = FALSE
			break
	if(last_legion)
		loot = list(/obj/structure/closet/crate/necropolis/legion/hard)
		elimination = FALSE
	else if(prob(80)) //80% chance for sick lootz!
		loot = list(/obj/structure/closet/crate/necropolis/tendril/legion_loot)
		if(!true_spawn)
			loot = null
	return ..()

///Splits legion into smaller skulls.
/mob/living/simple_animal/hostile/megafauna/legion/hard/proc/Split()
	size--
	if(size < 1)
		return FALSE
	adjustHealth(-maxHealth) //We heal in preparation of the split
	switch(size) //Yay, switches
		if(3 to INFINITY)
			icon = initial(icon)
			pixel_x = initial(pixel_x)
			pixel_y = initial(pixel_y)
			maxHealth = initial(maxHealth)
		if(2)
			icon = 'modular_skyrat/icons/mob/lavaland/64x64megafauna.dmi'
			pixel_x = -16
			pixel_y = -8
			maxHealth = 350
		if(1)
			icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
			pixel_x = 0
			pixel_y = 0
			maxHealth = 200
	visible_message("<span class='boldannounce'>This is getting out of hands. Now there are three of them!</span>")
	for(var/i in 1 to 2) //Create three skulls in total
		var/mob/living/simple_animal/hostile/megafauna/legion/hard/L = new(loc)
		L.setVarsAfterSplit(src)
	return TRUE

///Sets the variables for new legion skulls. Usually called after splitting.
/mob/living/simple_animal/hostile/megafauna/legion/hard/proc/setVarsAfterSplit(var/mob/living/simple_animal/hostile/megafauna/legion/L)
	maxHealth = L.maxHealth
	updatehealth()
	size = L.size
	icon = L.icon
	pixel_x = L.pixel_x
	pixel_y = L.pixel_y
	faction = L.faction.Copy()
	GiveTarget(L.target)

///A basic turret that shoots at nearby mobs. Intended to be used for the legion megafauna.
/obj/structure/legionturret
	name = "\improper Legion sentinel"
	desc = "The eye pierces your soul."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "legion_turret"
	light_power = 0.5
	light_range = 2
	max_integrity = 80
	luminosity = 6
	anchored = TRUE
	density = TRUE
	layer = ABOVE_OBJ_LAYER
	armor = list("melee" = 0, "bullet" = 0, "laser" = 100,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	///What kind of projectile the actual damaging part should be.
	var/projectile_type = /obj/item/projectile/beam/legion
	///Time until the tracer gets shot
	var/initial_firing_time = 18
	///How long it takes between shooting the tracer and the projectile.
	var/shot_delay = 8
	///Compared with the targeted mobs. If they have the faction, turret won't shoot.
	var/faction = list("mining")

/obj/structure/legionturret/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/set_up_shot), initial_firing_time)

///Handles an extremely basic AI
/obj/structure/legionturret/proc/set_up_shot()
	for(var/mob/living/L in oview(9, src))
		if(L.stat == DEAD || L.stat == UNCONSCIOUS)
			continue
		if(faction_check(faction, L.faction))
			continue
		fire(L)
		return
	fire(get_edge_target_turf(src, pick(GLOB.cardinals)))

///Called when attacking a target. Shoots a projectile at the turf underneath the target.
/obj/structure/legionturret/proc/fire(atom/target)
	var/turf/T = get_turf(target)
	var/turf/T1 = get_turf(src)
	if(!T || !T1)
		return
	//Now we generate the tracer.
	var/angle = Get_Angle(T1, T)
	var/datum/point/vector/V = new(T1.x, T1.y, T1.z, 0, 0, angle)
	generate_tracer_between_points(V, V.return_vector_after_increments(6), /obj/effect/projectile/tracer/legion/tracer, 0, shot_delay, 0, 0, 0, null)
	playsound(src, 'sound/machines/airlockopen.ogg', 100, TRUE)
	addtimer(CALLBACK(src, .proc/fire_beam, angle), shot_delay)

///Called shot_delay after the turret shot the tracer. Shoots a projectile into the same direction.
/obj/structure/legionturret/proc/fire_beam(angle)
	var/obj/item/projectile/ouchie = new projectile_type(loc)
	ouchie.firer = src
	ouchie.fire(angle)
	playsound(src, 'sound/effects/bin_close.ogg', 100, TRUE)
	QDEL_IN(src, 5)

///Used for the legion turret.
/obj/item/projectile/beam/legion
	name = "blood pulse"
	hitsound = 'sound/magic/magic_missile.ogg'
	damage = 19
	range = 6
	eyeblur = 0
	light_color = LIGHT_COLOR_RED
	impact_effect_type = /obj/effect/temp_visual/kinetic_blast
	tracer_type = /obj/effect/projectile/tracer/legion
	muzzle_type = /obj/effect/projectile/tracer/legion
	impact_type = /obj/effect/projectile/tracer/legion
	hitscan = TRUE
	movement_type = UNSTOPPABLE

///Used for the legion turret tracer.
/obj/effect/projectile/tracer/legion/tracer
	icon = 'modular_skyrat/icons/effects/beam.dmi'
	icon_state = "blood_light"

///Used for the legion turret beam.
/obj/effect/projectile/tracer/legion
	icon = 'modular_skyrat/icons/effects/beam.dmi'
	icon_state = "blood"
