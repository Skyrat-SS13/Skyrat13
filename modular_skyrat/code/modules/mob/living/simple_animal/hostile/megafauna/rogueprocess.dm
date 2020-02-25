/mob/living/simple_animal/hostile/megafauna/rogueprocess
	name = "Rogue Process"
	desc = "Once an experimental ripley carrying an advanced mining AI, now it's out for blood."
	health = 2500
	maxHealth = 2500
	attacktext = "drills"
	attack_sound = 'sound/weapons/drill.ogg'
	icon = 'modular_skyrat/icons/mob/lavaland/rogue.dmi'
	icon_state = "rogue"
	icon_living = "rogue"
	icon_dead = "rogue-broken"
	friendly = "pokes"
	speak_emote = list("screeches")
	armour_penetration = 75
	melee_damage_lower = 30
	melee_damage_upper = 30
	speed = 1
	move_to_delay = 18
	ranged_cooldown_time = 75
	ranged = 1
	del_on_death = 0
	crusher_loot = list()
	loot = list()
	deathmessage = "sparkles and emits corrupted screams in agony, falling defeated on the ground."
	death_sound = 'sound/mecha/critdestr.ogg'
	anger_modifier = 0
	do_footstep = TRUE
	mob_biotypes = list(MOB_ROBOTIC)

/obj/item/gps/internal/rogueprocess
	icon_state = null
	gpstag = "Corrupted Signal"
	desc = "It's full of ransomware."
	invisibility = 100

/obj/item/projectile/plasma/rogue
	speed = 3
	range = 7

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Initialize()
	. = ..()
	internal = new /obj/item/gps/internal/rogueprocess(src)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Life()
	. = ..()
	anger_modifier = round(CLAMP(((maxHealth - health) / 42),0,60))
	move_to_delay = CLAMP(round((src.health/src.maxHealth) * 10), 3, 18)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/AttackingTarget()
	if(target && isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			if(L.stat == CONSCIOUS && L.health > 0)
				OpenFire()
		else
			devour(L)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/OpenFire(target)
	ranged_cooldown = world.time + (ranged_cooldown - anger_modifier) //Ranged cooldown will always be at least 15
	if(anger_modifier < 30)
		if(prob(50))
			src.plasmashot(target)
		else
			src.shockwave(src.dir)
	if(anger_modifier >= 30 && anger_modifier < 50)
		if(prob(50))
			src.plasmaburst(target)
		else
			src.shockwave(src.dir)
	if(anger_modifier >= 50)
		if(prob(50))
			src.plasmaburst(target)
			src.shockwave(src.dir)
		else
			src.shockwave(NORTH)
			src.shockwave(SOUTH)
			src.shockwave(WEST)
			src.shockwave(EAST)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Move()
	. = ..()
	playsound(src.loc, 'sound/mecha/mechmove01.ogg', 200, 1, 2, 1)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Bump(atom/A)
	. = ..()
	if(isturf(A) || isobj(A) && A.density)
		A.ex_act(EXPLODE_HEAVY)
		DestroySurroundings()

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/plasmashot(atom/target)
	visible_message("<span class='boldwarning'>[src] raises it's plasma cutter!</span>")
	sleep(5)
	var/turf/T = get_turf(target)
	var/obj/item/projectile/P = new /obj/item/projectile/plasma/rogue(T)
	var/turf/startloc = T
	playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
	P.starting = startloc
	P.firer = src
	P.fired_from = src
	P.yo = target.y - startloc.y
	P.xo = target.x - startloc.x
	P.original = target
	P.preparePixelProjectile(target, src)
	P.fire()

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/plasmaburst(atom/target)
	visible_message("<span class='boldwarning'>[src] raises it's tri-shot plasma cutter!</span>")
	var/ogdir = src.dir
	sleep(15)
	var/obj/item/projectile/P = new /obj/item/projectile/plasma/rogue(T)
	var/turf/T = get_turf(target)
	var/turf/otherT = get_step(T, ogdir + 90)
	var/turf/otherT2 = get_step(T, ogdir - 90)
	var/turf/startloc = T
	playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
	P.starting = startloc
	P.firer = src
	P.fired_from = src
	P.yo = target.y - startloc.y
	P.xo = target.x - startloc.x
	P.original = target
	P.preparePixelProjectile(target, src)
	P.fire()
	var/obj/item/projectile/X = new /obj/item/projectile/plasma/rogue(otherT)
	startloc = otherT
	playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
	X.starting = startloc
	X.firer = src
	X.fired_from = src
	X.yo = target.y - startloc.y
	X.xo = target.x - startloc.x
	X.original = target
	X.preparePixelProjectile(target, src)
	X.fire()
	var/obj/item/projectile/Y = new /obj/item/projectile/plasma/rogue(otherT2)
	startloc = otherT2
	playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
	Y.starting = startloc
	Y.firer = src
	Y.fired_from = src
	Y.yo = target.y - startloc.y
	Y.xo = target.x - startloc.x
	Y.original = target
	Y.preparePixelProjectile(target, src)
	Y.fire()
	return P

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/knockdown()
	playsound(src,'sound/misc/crunch.ogg', 200, 1)
	visible_message("<span class='boldwarning'>[src] smashes into the ground!</span>")
	var/list/hit_things = list()
	sleep(10)
	for(var/turf/T in oview(1, src))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		for(var/mob/living/L in T.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(src, get_dir(src, L))
				L.safe_throw_at(throwtarget, 10, 1, src)
				L.Stun(20)
				L.adjustBruteLoss(50)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/shockwave(direction)
	playsound(src,'sound/misc/crunch.ogg', 200, 1)
	visible_message("<span class='boldwarning'>[src] smashes the ground in front of them!</span>")
	sleep(10)
	var/list/hit_things = list()
	var/turf/T = get_turf(get_step(src, src.dir))
	var/ogdir = direction
	var/turf/otherT = get_step(T, turn(ogdir, 90))
	var/turf/otherT2 = get_step(T, turn(ogdir, -90))
	for(var/i = 0, i<5, i++)
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		new /obj/effect/temp_visual/small_smoke/halfsecond(otherT)
		new /obj/effect/temp_visual/small_smoke/halfsecond(otherT2)
		for(var/mob/living/L in T.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(T, get_dir(T, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.Stun(20)
				L.adjustBruteLoss(50)
		for(var/mob/living/L in otherT.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(otherT, get_dir(otherT, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.Stun(20)
				L.adjustBruteLoss(50)
		for(var/mob/living/L in otherT2.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(otherT2, get_dir(otherT2, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.Stun(20)
				L.adjustBruteLoss(50)
		T = get_step(T, ogdir)
		otherT = get_step(otherT, ogdir)
		otherT2 = get_step(otherT2, ogdir)
		sleep(5)