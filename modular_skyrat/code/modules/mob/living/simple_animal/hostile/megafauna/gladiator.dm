/* THE GLADIATOR
* Has 4 special attacks, which are used depending on the phase (the gladiator has 3 phases).
* AoE Zweihander swing: In a square of 3×3, he swings his sword in a 360 degree arc, damaging anything within it.
* Shield bash: The gladiator charges and chases you with increased speed for 21 tiles, if he makes contact, he bashes you and knocks you down.
He will stuns himself for 2 seconds, no matter the result of the charge attack; This leaves him vulnerable for attacks for a few precious moments.
* Bone daggers: At random times if the player is running, he can throw bone daggers that will go considerably fast in the players direction.
They deal 35 brute (armor is considered).
* Additionally, he gets more speedy and aggressive as he raises in phase, at the cost of some special attacks.
* On phase 1, the gladiator has a 50% block chance for any attack.
* Loot:
* Gladiator tower shield - A powerful and indestructible shield, that can also be used as a surfboard.
* Shielding modkit - A modkit that grants your PKA a 15% chance to block any incoming attack while held.
* Tomahawk - Basically a one handed crusher to complement the shield.
*/
/mob/living/simple_animal/hostile/megafauna/gladiator
	name = "\proper The Gladiator"
	desc = "An immortal ash walker, whose powers have been granted by the necropolis itself."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "gladiator1"
	icon_dead = "gladiator_dying"
	attacktext = "slashes"
	attack_sound = 'sound/weapons/slice.ogg'
	death_sound = 'modular_skyrat/sound/effects/gladiatordeathsound.ogg'
	deathmessage = "gets discombobulated and fucking dies."
	rapid_melee = 2
	melee_queue_distance = 2
	melee_damage_lower = 30
	melee_damage_upper = 30
	speed = 1
	move_to_delay = 2.5
	wander = FALSE
	var/block_chance = 50
	ranged = 1
	ranged_cooldown_time = 30
	minimum_distance = 1
	health = 1500
	maxHealth = 1500
	movement_type = GROUND
	weather_immunities = list("lava","ash")
	var/phase = 1
	var/list/introduced = list() //Basically all the mobs which the gladiator has already introduced himself to.
	var/speen = FALSE
	var/speenrange = 4
	var/obj/savedloot = null
	var/stunned = FALSE
	var/stunduration = 15
	song = sound('modular_skyrat/sound/ambience/gladiator.ogg', 100)
	songlength = 3850
	loot = list(/obj/structure/closet/crate/necropolis/gladiator)
	crusher_loot = list(/obj/structure/closet/crate/necropolis/gladiator/crusher)

/obj/item/gps/internal/gladiator
	icon_state = null
	gpstag = "Dreadful Signal"
	desc = "Let me help you to see, miner."

/mob/living/simple_animal/hostile/megafauna/gladiator/Initialize(mapload)
	. = ..()
	internal = new /obj/item/gps/internal/gladiator(src)

/mob/living/simple_animal/hostile/megafauna/gladiator/Life()
	. = ..()
	for(var/mob/living/M in view(4, src))
		if(!(M in introduced))
			introduction(M)

/mob/living/simple_animal/hostile/megafauna/gladiator/apply_damage(damage, damagetype, def_zone, blocked, forced)
	if(speen)
		visible_message("<span class='danger'>[src] brushes off all incoming attacks!")
		return FALSE
	else if(prob(50) && (phase == 1) && !stunned)
		visible_message("<span class='danger'>[src] blocks all incoming damage with his shield!")
		return FALSE
	..()
	update_phase()
	var/adjustment_amount = damage * 0.1
	if(world.time + adjustment_amount > next_move)
		changeNext_move(adjustment_amount)

/mob/living/simple_animal/hostile/megafauna/gladiator/Retaliate()
	. = ..()
	if(!wander)
		wander = TRUE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/introduction(mob/living/target)
	if(src == target)
		introduced += src
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/species/Hspecies = H.dna.species
		if(Hspecies.id == "ashlizard")
			var/list/messages = list("I am sorry, tribesssmate. I cannot let you through.",\
									"Pleassse leave, walker.",\
									"The necropolisss must be protected even from it'ss servants. Pleassse retreat.")
			say(message = pick(messages), language = /datum/language/draconic)
			introduced |= H
		else if(Hspecies.id == "lizard")
			var/list/messages = list("Thisss isss not the time nor place to be. Leave.",\
									"Go back where you came from. I am sssafeguarding thisss sssacred place.",\
									"You ssshould not be here. Turn.",\
									"I can sssee an outlander from a mile away. You're not one of us."\
									)
			say(message = pick(messages), language = /datum/language/draconic)
			introduced |= H
		else if(Hspecies.id == "dunmer")
			var/list/messages = list("I will finisssh what little of your race remainsss, starting with you!",\
									"Lavaland belongsss to the lizzzards!",\
									"No marine can save you now, dark elf!",\
									"Thisss sacred land wasn't your property before, it won't be now!")
			say(message = pick(messages))
			introduced |= H
			GiveTarget(H)
			Retaliate()
		else
			var/list/messages = list("Get out of my sssight, outlander.",\
									"You will not run your dirty handsss through what little sssacred land we have left. Out.",\
									"My urge to end your life isss immeasssurable, but I am willing to ssspare you. Leave.",\
									"I can sssee an outlander from a mile away. You're not one of us.")
			say(message = pick(messages))
			introduced |= H

	else
		say("You are not welcome into the necropolisss.")
		introduced |= target

/mob/living/simple_animal/hostile/megafauna/gladiator/Move(atom/newloc, dir, step_x, step_y)
	if(speen || stunned)
		return FALSE
	else
		if(ischasm(newloc))
			var/list/possiblelocs = list()
			switch(dir)
				if(NORTH)
					possiblelocs += locate(x +1, y + 1, z)
					possiblelocs += locate(x -1, y + 1, z)
				if(EAST)
					possiblelocs += locate(x + 1, y + 1, z)
					possiblelocs += locate(x + 1, y - 1, z)
				if(WEST)
					possiblelocs += locate(x - 1, y + 1, z)
					possiblelocs += locate(x - 1, y - 1, z)
				if(SOUTH)
					possiblelocs += locate(x - 1, y - 1, z)
					possiblelocs += locate(x + 1, y - 1, z)
				if(SOUTHEAST)
					possiblelocs += locate(x + 1, y, z)
					possiblelocs += locate(x + 1, y + 1, z)
				if(SOUTHWEST)
					possiblelocs += locate(x - 1, y, z)
					possiblelocs += locate(x - 1, y + 1, z)
				if(NORTHWEST)
					possiblelocs += locate(x - 1, y, z)
					possiblelocs += locate(x - 1, y - 1, z)
				if(NORTHEAST)
					possiblelocs += locate(x + 1, y - 1, z)
					possiblelocs += locate(x + 1, y, z)
			for(var/turf/T in possiblelocs)
				if(ischasm(T))
					possiblelocs -= T
			if(possiblelocs.len)
				var/turf/validloc = pick(possiblelocs)
				return ..(validloc)
			return FALSE
		else
			..()

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/update_phase()
	var/healthpercentage = 100 * (health/maxHealth)
	if(src.stat == DEAD)
		return
	switch(healthpercentage)
		if(70 to 100)
			phase = 1
			rapid_melee = initial(rapid_melee)
			move_to_delay = initial(move_to_delay)
		if(30 to 70)
			phase = 2
			icon_state = "gladiator2"
			rapid_melee = 3
			move_to_delay = 2
		if(0 to 30)
			phase = 3
			icon_state = "gladiator3"
			rapid_melee = 5
			move_to_delay = 1.7

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/zweispin()
	visible_message("<span class='boldwarning'>[src] lifts his zweihander, and prepares to spin!</span>")
	speen = TRUE
	animate(src, color = "#ff6666", 10)
	sleep(5)
	var/list/speendirs = list(SOUTH, SOUTHWEST, WEST, NORTHWEST, NORTH, NORTHEAST, EAST, SOUTHEAST, SOUTH)
	var/turf/steppy = get_turf(src)
	var/woop = FALSE
	for(var/dirt in speendirs)
		src.dir = dirt
		for(var/i in 1 to speenrange)
			steppy = get_step(steppy, dirt)
			var/obj/effect/temp_visual/small_smoke/smonk = new /obj/effect/temp_visual/small_smoke(steppy)
			QDEL_IN(smonk, 1)
			for(var/mob/living/M in steppy)
				if(!faction_check(faction, M.faction))
					playsound(src, 'sound/weapons/slash.ogg', 75, 0)
					if(M.apply_damage(40, BRUTE, BODY_ZONE_CHEST))
						visible_message("<span class = 'userdanger'>[src] slashes [M] with his spinning zweihander!</span>")
					else
						visible_message("<span class = 'userdanger'>[src]'s spinning zweihander is stopped by [M]!</span>")
						woop = TRUE
		steppy = get_turf(src)
		if(woop)
			break
		sleep(1)
	animate(src, color = initial(color), 3)
	sleep(3)
	speen = FALSE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/chargeattack(atom/target, var/range)
	face_atom(target)
	speen = TRUE
	visible_message("<span class='boldwarning'>[src] lifts his shield, and prepares to charge!</span>")
	animate(src, color = "#ff6666", 3)
	sleep(3 + phase)
	var/longstun = FALSE
	face_atom(target)
	move_to_delay/2
	for(var/i = 0, i >= range, i++)
		var/dirtotarget = get_dir(src, target)
		var/turf/T = get_step(src, dirtotarget)
		if(target in T)
			if(isliving(target))
				var/mob/living/L = target
				visible_message("<span class='userdanger'>[src] knocks [L] down!</span>")
				L.DefaultCombatKnockdown(20)
				longstun = TRUE
				break
		else if(istype(T, /turf/closed))
			visible_message("<span class='userdanger'>[src] bashes his head against the [T], stunning himself!</span>")
			longstun = TRUE
			break
		else
			forceMove(src, T)
			var/time2sleep = 0.5
			sleep(time2sleep)
	speen = FALSE
	stunned = TRUE
	animate(src, color = initial(color), 7)
	move_to_delay = initial(move_to_delay)
	sleep(longstun ? stunduration : ((stunduration/2) * 1.5))
	stunned = FALSE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/teleport(atom/target)
	var/turf/T = get_step(target, -target.dir)
	new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(src))
	sleep(4)
	if(!ischasm(T))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		forceMove(T)
	else
		var/list/possiblelocs = view(3, target)
		for(var/atom/A in possiblelocs)
			if(!isturf(A))
				possiblelocs -= A
			else
				if(ischasm(A) || istype(A, /turf/closed))
					possiblelocs -= A
		if(possiblelocs.len)
			T = pick(possiblelocs)
			new /obj/effect/temp_visual/small_smoke/halfsecond(T)
			forceMove(T)

/mob/living/simple_animal/hostile/megafauna/gladiator/AttackingTarget()
	. = ..()
	if(speen || stunned)
		return
	if(. && prob(5 * phase))
		teleport(target)

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/boneappletea(atom/target)
	var/obj/item/kitchen/knife/combat/bone/boned = new /obj/item/kitchen/knife/combat/bone(get_turf(src))
	boned.throwforce = 35
	playsound(src, 'sound/weapons/fwoosh.wav', 60, 0)
	boned.throw_at(target, 7, 3, src)
	QDEL_IN(boned, 30)

/mob/living/simple_animal/hostile/megafauna/gladiator/OpenFire()
	if(world.time < ranged_cooldown)
		return FALSE
	if(speen || stunned)
		return FALSE
	ranged_cooldown = world.time
	switch(phase)
		if(1)
			if(prob(25) && (get_dist(src, target) <= 4))
				zweispin()
				ranged_cooldown += 60
			else
				if(prob(66))
					chargeattack(target, 21)
					ranged_cooldown += 40
				else
					teleport(target)
					ranged_cooldown += 40
		if(2)
			if(prob(40) && (get_dist(src, target) <= 4))
				zweispin()
				ranged_cooldown += 45
			else
				if(prob(35))
					boneappletea(target)
					ranged_cooldown += 35
				else
					teleport(target)
					ranged_cooldown += 30
		if(3)
			if(prob(30))
				boneappletea(target)
				ranged_cooldown += 30
			else
				teleport(target)
				ranged_cooldown += 20

//Aggression helpers
/obj/effect/step_trigger/gladiator
	var/mob/living/simple_animal/hostile/megafauna/gladiator/glady

/obj/effect/step_trigger/gladiator/Initialize()
	. = ..()
	for(var/mob/living/simple_animal/hostile/megafauna/gladiator/G in view(7, src))
		if(!glady)
			glady = G

/obj/effect/step_trigger/gladiator/Trigger(atom/movable/A)
	if(isliving(A))
		var/mob/living/bruh = A
		glady.enemies |= bruh
		glady.GiveTarget(bruh)
		for(var/obj/effect/step_trigger/gladiator/glad in view(7, src))
			qdel(glad)
		return TRUE
	return FALSE
