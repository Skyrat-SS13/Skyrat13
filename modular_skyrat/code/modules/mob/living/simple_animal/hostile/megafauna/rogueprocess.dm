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
	crusher_loot = list(/obj/item/borg/upgrade/modkit/plasma, /obj/item/crusher_trophy/brokentech, /obj/item/twohanded/rogue)
	loot = list(/obj/item/borg/upgrade/modkit/plasma, /obj/item/twohanded/rogue)
	deathmessage = "sparkles and emits corrupted screams in agony, falling defeated on the ground."
	death_sound = 'sound/mecha/critdestr.ogg'
	anger_modifier = 0
	do_footstep = TRUE
	mob_biotypes = MOB_ROBOTIC
	wander = FALSE
	movement_type = GROUND
	song = sound('modular_skyrat/sound/ambience/systemshockremixmbr.ogg', 100) //System shock is abandonware right?
	songlength = 2940

/obj/item/gps/internal/rogueprocess
	icon_state = null
	gpstag = "Corrupted Signal"
	desc = "It's full of ransomware."
	invisibility = 100

/obj/item/projectile/plasma/rogue
	speed = 2
	range = 21
	color = "#FF0000"

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Initialize()
	. = ..()
	internal = new /obj/item/gps/internal/rogueprocess(src)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Life()
	. = ..()
	anger_modifier = round(CLAMP(((maxHealth - health) / 42),0,60))
	move_to_delay = CLAMP(round((src.health/src.maxHealth) * 10), 3, 18)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/OpenFire(atom/target)
	ranged_cooldown = world.time + (ranged_cooldown_time - anger_modifier) //Ranged cooldown will always be at least 15
	if(anger_modifier < 20)
		INVOKE_ASYNC(src, .proc/spawnminion)
		ranged_cooldown += 100
	if(anger_modifier < 30 && anger_modifier >= 20)
		if(prob(50))
			INVOKE_ASYNC(src, .proc/plasmashot, target)
		else
			INVOKE_ASYNC(src, .proc/shockwave, src.dir, 7)
	if(anger_modifier >= 30 && anger_modifier <40)
		if(prob(50))
			INVOKE_ASYNC(src, .proc/plasmaburst, target)
		else
			INVOKE_ASYNC(src, .proc/shockwave, src.dir, 10)
	if(anger_modifier >= 30 && anger_modifier <40)
		if(prob(50))
			INVOKE_ASYNC(src, .proc/plasmaforall, target)
		else
			INVOKE_ASYNC(src, .proc/shockwave, NORTH, 15)
			INVOKE_ASYNC(src, .proc/shockwave, SOUTH, 15)
			INVOKE_ASYNC(src, .proc/shockwave, WEST, 15)
			INVOKE_ASYNC(src, .proc/shockwave, EAST, 15)
	if(anger_modifier >= 50)
		if(prob(50))
			INVOKE_ASYNC(src, .proc/plasmacrazy, target)
			INVOKE_ASYNC(src, .proc/shockwave, src.dir, 15)
		else
			INVOKE_ASYNC(src, .proc/shockwave, NORTH, 15)
			INVOKE_ASYNC(src, .proc/shockwave, SOUTH, 15)
			INVOKE_ASYNC(src, .proc/shockwave, WEST, 15)
			INVOKE_ASYNC(src, .proc/shockwave, EAST, 15)
			INVOKE_ASYNC(src, .proc/shockwave2, NORTHEAST, 15)
			INVOKE_ASYNC(src, .proc/shockwave2, NORTHWEST, 15)
			INVOKE_ASYNC(src, .proc/shockwave2, SOUTHWEST, 15)
			INVOKE_ASYNC(src, .proc/shockwave2, SOUTHEAST, 15)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/AttackingTarget(atom/target)
	say("YOU ARE PATHETIC.")
	if(prob(25))
		if(prob(50))
			knockdown()
		else
			shockwave(src.dir)
	else
		..()

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Move()
	. = ..()
	playsound(src.loc, 'sound/mecha/mechmove01.ogg', 200, 1, 2, 1)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Bump(atom/A)
	. = ..()
	if(isturf(A) || isobj(A) && A.density)
		A.ex_act(EXPLODE_HEAVY)
		DestroySurroundings()

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/plasmashot(atom/target)
	var/list/theline = getline(src, target)
	if(theline.len > 2)
		visible_message("<span class='boldwarning'>[src] raises it's plasma cutter!</span>")
		sleep(5)
		say("I CLEANSE THE WORLD WITH MY CUTTERS.")
		var/turf/T = get_turf(src)
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
	else
		visible_message("<span class='boldwarning'>[src] raises it's drill!</span>")
		say("YOUR WEAK MELEES WON'T DENT ME.")
		sleep(5)
		AttackingTarget(target)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/plasmaburst(atom/target)
	var/list/theline = getline(src, target)
	if(theline.len > 2)
		visible_message("<span class='boldwarning'>[src] raises it's tri-shot plasma cutter!</span>")
		say("MY AIM IS PRECISE AND MY WILL IS PLASTEEL.")
		var/turf/T = get_turf(src)
		sleep(15)
		for(var/i = 0, i < 3, i++)
			var/obj/item/projectile/P = new /obj/item/projectile/plasma/rogue(T)
			var/turf/startloc = get_turf(src)
			playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
			P.starting = startloc
			P.firer = src
			P.fired_from = src
			P.yo = target.y - startloc.y
			P.xo = target.x - startloc.x
			P.original = target
			P.preparePixelProjectile(target.loc, src)
			switch(i)
				if(1)
					P.Angle += 30
				if(2)
					P.Angle -= 30
				if(3)
					P.Angle += 0
			P.fire()
	else
		visible_message("<span class='boldwarning'>[src] raises it's drill!</span>")
		say("YOUR ATTACKS BARELY AFFECT ME.")
		sleep(5)
		AttackingTarget(target)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/plasmacrazy(atom/target)
	var/list/theline = getline(src, target)
	if(theline.len > 2)
		visible_message("<span class='boldwarning'>[src] releases a burst of energy!</span>")
		say("I AM UNBREAKABLE.")
		sleep(15)
		say("WEAK!!! STUPID!!! ORGANIC!!!")
		var/dir_to_target = get_dir(get_turf(src), get_turf(target))
		var/ogangle = dir2angle(dir_to_target)
		var/turf/T = get_turf(src)
		for(var/angle = 0, angle < initial(angle) + 360, angle += 30)
			sleep(5)
			var/obj/item/projectile/P = new /obj/item/projectile/plasma/rogue(T)
			var/turf/startloc = get_turf(src)
			playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
			P.starting = startloc
			P.firer = src
			P.fired_from = src
			P.yo = target.y - startloc.y
			P.xo = target.x - startloc.x
			P.original = target
			P.preparePixelProjectile(target.loc, src)
			P.Angle = ogangle
			P.Angle += angle
			P.fire()
	else
		visible_message("<span class='boldwarning'>[src] raises it's drill!</span>")
		say("I AM IMMORTAL!")
		sleep(5)
		AttackingTarget(target)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/plasmaforall(atom/target)
	var/list/theline = getline(src, target)
	if(theline.len > 2)
		visible_message("<span class='boldwarning'>[src] raises FOUR tri-shot plasma cutters! What the heck?!</span>")
		say("I AM UNBREAKABLE.")
		var/dir_to_target = get_dir(get_turf(src), get_turf(target))
		var/ogangle = dir2angle(dir_to_target)
		var/turf/T = get_turf(src)
		for(var/angle = 0, angle < initial(angle) + 360, angle += 30)
			var/obj/item/projectile/P = new /obj/item/projectile/plasma/rogue(T)
			var/turf/startloc = get_turf(src)
			playsound(src, 'sound/weapons/laser.ogg', 100, TRUE)
			P.starting = startloc
			P.firer = src
			P.fired_from = src
			P.yo = target.y - startloc.y
			P.xo = target.x - startloc.x
			P.original = target
			P.preparePixelProjectile(target.loc, src)
			P.Angle = ogangle
			P.Angle += angle
			P.fire()
	else
		visible_message("<span class='boldwarning'>[src] raises it's drill!</span>")
		say("I AM IMMORTAL!")
		sleep(5)
		AttackingTarget(target)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/knockdown()
	visible_message("<span class='boldwarning'>[src] smashes into the ground!</span>")
	playsound(src,'sound/misc/crunch.ogg', 200, 1)
	var/list/hit_things = list()
	sleep(10)
	for(var/turf/T in oview(1, src))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		for(var/mob/living/L in T.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(src, get_dir(src, L))
				L.safe_throw_at(throwtarget, 10, 1, src)
				L.Stun(10)
				L.adjustBruteLoss(25)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/spawnminion()
	visible_message("<span class='boldwarning'>[src] opens his back and a swarmer comes out of it!</span>")
	var/chosen = /mob/living/simple_animal/hostile/swarmer/ai/ranged_combat/rogue
	var/mob/living/simple_animal/hostile/swarmer/ai/minion = new chosen(src.loc)
	var/turf/T = get_step(src, -dir)
	sleep(5)
	say("YOU'RE SO WEAK EVEN MY CHILDREN CAN KILL YOU.")
	minion.forceMove(T)


/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/shockwave(direction, range)
	visible_message("<span class='boldwarning'>[src] smashes the ground in a general direction!!</span>")
	playsound(src,'sound/misc/crunch.ogg', 200, 1)
	sleep(10)
	var/list/hit_things = list()
	var/turf/T = get_turf(get_step(src, src.dir))
	var/ogdir = direction
	var/turf/otherT = get_step(T, turn(ogdir, 90))
	var/turf/otherT2 = get_step(T, turn(ogdir, -90))
	for(var/i = 0, i<range, i++)
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		new /obj/effect/temp_visual/small_smoke/halfsecond(otherT)
		new /obj/effect/temp_visual/small_smoke/halfsecond(otherT2)
		for(var/mob/living/L in T.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(T, get_dir(T, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.adjustBruteLoss(20)
		for(var/mob/living/L in otherT.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(otherT, get_dir(otherT, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.adjustBruteLoss(20)
		for(var/mob/living/L in otherT2.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(otherT2, get_dir(otherT2, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.adjustBruteLoss(20)
		T = get_step(T, ogdir)
		otherT = get_step(otherT, ogdir)
		otherT2 = get_step(otherT2, ogdir)
		sleep(2)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/proc/shockwave2(direction, range)
	visible_message("<span class='boldwarning'>[src] quickly smashes the ground in a general direction!!</span>")
	playsound(src,'sound/misc/crunch.ogg', 200, 1)
	sleep(10)
	var/list/hit_things = list()
	var/turf/T = get_turf(get_step(src, src.dir))
	var/ogdir = direction
	var/turf/otherT = get_step(T, turn(ogdir, 45))
	var/turf/otherT2 = get_step(T, turn(ogdir, -45))
	for(var/i = 0, i<range, i++)
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		new /obj/effect/temp_visual/small_smoke/halfsecond(otherT)
		new /obj/effect/temp_visual/small_smoke/halfsecond(otherT2)
		for(var/mob/living/L in T.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(T, get_dir(T, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.Stun(10)
				L.adjustBruteLoss(25)
		for(var/mob/living/L in otherT.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(otherT, get_dir(otherT, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.Stun(10)
				L.adjustBruteLoss(25)
		for(var/mob/living/L in otherT2.contents)
			if(L != src && !(L in hit_things))
				var/throwtarget = get_edge_target_turf(otherT2, get_dir(otherT2, L))
				L.safe_throw_at(throwtarget, 5, 1, src)
				L.Stun(10)
				L.adjustBruteLoss(25)
		T = get_step(T, ogdir)
		otherT = get_step(otherT, ogdir)
		otherT2 = get_step(otherT2, ogdir)
		sleep(1)

//loot
/obj/item/twohanded/rogue
	name = "Rogue's Drill"
	desc = "A drill coupled with an internal mechanism that produces shockwaves on demand. Serves as a very robust melee."
	force = 0
	force_wielded = 25
	force_unwielded = 0
	icon = 'modular_skyrat/icons/obj/mining.dmi'
	icon_state = "roguedrill"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/equipment/mining_righthand.dmi'
	item_state = "roguedrill"
	w_class = WEIGHT_CLASS_BULKY
	tool_behaviour = TOOL_MINING
	toolspeed = 0.05
	slot_flags = ITEM_SLOT_BELT
	custom_materials = list(/datum/material/diamond=2000)
	usesound = 'sound/weapons/drill.ogg'
	hitsound = 'sound/weapons/drill.ogg'
	attack_verb = list("drilled")
	var/cooldowntime
	var/range = 7
	var/cooldown = 50

/obj/item/twohanded/rogue/attack(atom/A, mob/living/carbon/human/user)
	. = ..()
	if(isliving(A))
		playsound(src,'sound/misc/crunch.ogg', 200, 1)
		var/mob/living/M = A
		if(ishuman(M))
			M.Knockdown(25, override_stamdmg = 0)
		M.adjustStaminaLoss(25)
		M.drop_all_held_items()

/obj/item/twohanded/rogue/afterattack(atom/target, mob/living/user, proximity_flag)
	. = ..()
	if(wielded)
		if(!proximity_flag)
			if(cooldowntime < world.time)
				cooldowntime = world.time + cooldown
				playsound(src,'sound/misc/crunch.ogg', 200, 1)
				var/list/hit_things = list()
				var/turf/T = get_turf(get_step(user, user.dir))
				var/ogdir = user.dir
				var/turf/otherT = get_step(T, turn(ogdir, 90))
				var/turf/otherT2 = get_step(T, turn(ogdir, -90))
				for(var/i = 0, i < range, i++)
					new /obj/effect/temp_visual/small_smoke/halfsecond(T)
					new /obj/effect/temp_visual/small_smoke/halfsecond(otherT)
					new /obj/effect/temp_visual/small_smoke/halfsecond(otherT2)
					for(var/mob/living/L in T.contents)
						if(L != src && !(L in hit_things))
							L.Stun(20)
							L.adjustBruteLoss(10)
					for(var/mob/living/L in otherT.contents)
						if(L != src && !(L in hit_things))
							L.Stun(20)
							L.adjustBruteLoss(10)
					for(var/mob/living/L in otherT2.contents)
						if(L != src && !(L in hit_things))
							L.Stun(20)
							L.adjustBruteLoss(10)
					if(ismineralturf(T))
						var/turf/closed/mineral/M = T
						M.gets_drilled(user)
					if(ismineralturf(otherT))
						var/turf/closed/mineral/M = otherT
						M.gets_drilled(user)
					if(ismineralturf(otherT2))
						var/turf/closed/mineral/M = otherT2
						M.gets_drilled(user)
					T = get_step(T, ogdir)
					otherT = get_step(otherT, ogdir)
					otherT2 = get_step(otherT2, ogdir)
					sleep(2)

//helpers
/mob/living/simple_animal/hostile/swarmer/ai/ranged_combat/rogue
	name = "Rogue's Guard"
	desc = "A loyal spawn of their robotic master."
	health = 100
	mob_size = MOB_SIZE_LARGE