/mob/living/simple_animal/hostile/megafauna/kingclown
	name = "King Clown"
	desc = "An extremely psychotic and mutated clown."
	health = 2500
	maxHealth = 2500
	icon_state = "kingclown1"
	icon_living = "kingclown1"
	icon = 'modular_skyrat/icons/mob/icemoon/kingclown.dmi'
	attacktext = "honks"
	attack_sound = 'sound/items/bikehorn.ogg'
	pixel_x = -16
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	light_color = "#E4C7C5"
	movement_type = GROUND
	weather_immunities = list("snow")
	speak_emote = list("honks")
	armour_penetration = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	rapid_melee = 1
	speed = 1
	move_to_delay = 3
	ranged = TRUE
	crusher_loot = list(/obj/item/borg/upgrade/modkit/trombone, /obj/item/crusher_trophy/bikehorn, /obj/item/laughterbottle)
	loot = list(/obj/item/borg/upgrade/modkit/trombone, /obj/item/laughterbottle)
	wander = FALSE
	del_on_death = TRUE
	blood_volume = BLOOD_VOLUME_MAXIMUM
	song = sound('modular_skyrat/sound/ambience/dandyboy.ogg', 100) // yes more lisa
	songlength = 870
	deathmessage = "falls to the ground, turning into... a banana."
	deathsound = 'sound/misc/sadtrombone.ogg'
	medal_type = BOSS_MEDAL_CLOWN
	score_type = CLOWN_SCORE
	pass_flags = PASSTABLE
	faction = list("clown")
	mob_size = MOB_SIZE_LARGE

/obj/item/gps/internal/clown
	icon_state = null
	gpstag = "Honking Signal"
	desc = "Honk!"
	invisibility = 100

/obj/item/projectile/bullet/honker/king
	name = "king's nannering"
	damage = 25
	knockdown = 10
	speed = 4
	movement_type = FLYING

/obj/item/projectile/bullet/honker/king
	. = ..()
	addtimer(CALLBACK(GLOBAL_PROC, .proc/qdel, src), 80)

/mob/living/simple_animal/hostile/megafauna/kingclown/Initialize()
	. = ..()
	internal = new/obj/item/gps/internal/clown(src)

/mob/living/simple_animal/hostile/megafauna/kingclown/Life()
	. = ..()
	anger_modifier = round(CLAMP(((maxHealth - health) / 42),0,60))

/mob/living/simple_animal/hostile/megafauna/kingclown/Move()
	..()
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE, 2, TRUE)

/mob/living/simple_animal/hostile/megafauna/kingclown/OpenFire(atom/target)
	if(anger_modifier < 20)
		INVOKE_ASYNC(src, .proc/shootbanana, target)
		ranged_cooldown = world.time + 50
	if(anger_modifier >= 20 && anger_modifier < 30)
		INVOKE_ASYNC(src, .proc/shootbanana, target)
		ranged_cooldown = world.time + 50
		if(prob(75))
			INVOKE_ASYNC(src, .proc/bananapeels)
		if(prob(60))
			INVOKE_ASYNC(src, .proc/honkdown)
	if(anger_modifier >= 30 && anger_modifier < 40)
		ranged_cooldown = world.time + 150
		INVOKE_ASYNC(src, .proc/summonclownhallucination, target)
		INVOKE_ASYNC(src, .proc/bananapeels)
		INVOKE_ASYNC(src, .proc/honkdown)
		INVOKE_ASYNC(src, .proc/shootbanana, target)
	if(anger_modifier >= 40 && anger_modifier < 50)
		ranged_cooldown = world.time + 150
		retreat_distance = 0
		INVOKE_ASYNC(src, .proc/honkdown)
		INVOKE_ASYNC(src, .proc/summonclownguard, target)
		retreat_distance = 30
		INVOKE_ASYNC(src, .proc/bluespaceteleport)
		INVOKE_ASYNC(src, .proc/surroundpeels, target)
		INVOKE_ASYNC(src, .proc/bluespaceteleporter)
	if(anger_modifier >= 50)
		ranged_cooldown = world.time + 100
		retreat_distance = 30
		if(prob(50))
			INVOKE_ASYNC(src, .proc/bluespaceteleport)
		INVOKE_ASYNC(src, .proc/summonclownguard, target)
		INVOKE_ASYNC(src, .proc/bananapeels)
		if(prob(50))
			INVOKE_ASYNC(src, .proc/surroundpeels, target)
		INVOKE_ASYNC(src, .proc/bluespaceteleporter)


/mob/living/simple_animal/hostile/megafauna/kingclown/proc/shootbanana(atom/target)
	var/turf/T = get_turf(src)
	var/obj/item/projectile/P = new /obj/item/projectile/bullet/honker/king(T)
	var/turf/startloc = T
	playsound(src, 'sound/items/airhorn.ogg', 200, TRUE)
	P.preparePixelProjectile(target.loc, src.loc)
	P.starting = startloc
	P.firer = src
	P.fired_from = src
	if(target)
		P.original = target
	P.fire()

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/summonclownhallucination(atom/target)
	playsound(src, 'sound/items/bikehorn.ogg', 200, TRUE, 2, TRUE)
	if(!target)
		return
	var/list/probableturfs = view(target, 5)
	for(var/turf/T in probableturfs)
		var/chosen = pick(subtypesof(/mob/living/simple_animal/hostile/retaliate/clown))
		if(prob(20))
			var/mob/living/simple_animal/hostile/retaliate/clown/clownguard = new chosen(T)
			clownguard.name = "Clownllucination"
			clownguard.desc = "For honkmother!"
			clownguard.Retaliate()
			addtimer(CALLBACK(GLOBAL_PROC, .proc/qdel, clownguard), 100)

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/summonclownguard(atom/target)
	playsound(src, 'sound/items/bikehorn.ogg', 200, TRUE, 2, TRUE)
	if(!target)
		return
	var/list/probableturfs = view(target, 5)
	for(var/turf/T in probableturfs)
		var/chosen = pick(subtypesof(/mob/living/simple_animal/hostile/retaliate/clown))
		if(prob(10))
			var/mob/living/simple_animal/hostile/retaliate/clown/clownguard = new chosen(T)
			clownguard.name = "Clown Guard"
			clownguard.desc = "For honkmother!"
			clownguard.Retaliate()

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/bananapeels()
	playsound(src, 'sound/magic/blind.ogg', 100, TRUE, 2, TRUE)
	for(var/turf/T in view(5, T))
		if(prob(35))
			var/obj/item/grown/bananapeel/king/thepeel = new /obj/item/grown/bananapeel/king(T.loc)
			addtimer(CALLBACK(GLOBAL_PROC, .proc/qdel, thepeel), 150)

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/surroundpeels(target)
	playsound(src, 'sound/magic/blind.ogg', 100, TRUE, 2, TRUE)
	if(isliving(target))
		var/mob/living/L = target
		L.Stun(10)
	var/list/bananawalls = list()
	for(var/turf/J in view(2, target) - view(1, target))
		var/obj/item/grown/bananapeel/king/B = new /obj/item/grown/bananapeel/king(J)
		bananawalls += B
	sleep(5)
	var/obj/item/grown/bananapeel/king/chosen = pick(bananawalls)
	qdel(chosen)
	for(var/obj/item/grown/bananapeel/king/B in bananawalls)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/qdel, B), 150)

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/honkdown()
	var/list/bananas = list()
	for(var/d in GLOB.alldirs)
		var/turf/T = get_step(src, d)
		var/obj/item/grown/bananapeel/king/B = new /obj/item/grown/bananapeel/king(T)
		B.dirtouse = d
		bananas += B
		addtimer(CALLBACK(GLOBAL_PROC, .proc/qdel, B), 150)
	sleep(10)
	for(var/obj/item/grown/bananapeel/king/B in bananas)
		var/throwtarget = get_edge_target_turf(B, B.dirtouse)
		B.safe_throw_at(throwtarget, 10, 1, src)

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/bluespaceteleporter()
	new /obj/structure/bonfire/clownfire(src.loc)

/mob/living/simple_animal/hostile/megafauna/kingclown/proc/bluespaceteleport()
	var/list/clownfires = list()
	for(var/obj/structure/bonfire/clownfire/C in view(21, src))
		clownfires += C
	if(clownfires.len)
		new /obj/effect/temp_visual/small_smoke/halfsecond/clown(src.loc)
		var/obj/structure/bonfire/clownfire/chosen = pick(clownfires)
		forceMove(chosen)
		new /obj/effect/temp_visual/small_smoke/halfsecond/clown(src.loc)

/mob/living/simple_animal/hostile/megafauna/kingclown/death()
	. = ..()
	new /obj/item/reagent_containers/food/snacks/grown/banana(src.loc)


//helpers
/obj/structure/bonfire/clownfire
	name = "bluespace banana"
	desc = "It helps clowns... teleport."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "banana_blue"
	max_integrity = 50
	obj_integrity = 50

/obj/item/grown/bananapeel/king
	name = "royal banana peel"
	desc = "It looks important."
	var/dirtouse = 1

/obj/item/grown/bananapeel/king/Initialize()
	..()
	AddComponent(/datum/component/slippery, 40)

/obj/effect/temp_visual/small_smoke/halfsecond/clown
	color = "#FFFF00"

//loot
/obj/item/laughterbottle
	name = "king clown's soda"
	desc = "Why would you drink this?"
	icon = 'icons/obj/drinks.dmi'
	icon_state = "laughter"
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	item_state = "carton"
	var/uses = 0

/obj/item/laughterbottle/attack_self(mob/user)
	to_chat(user, "<span class='notice'>You drink the can's contents.</span>")
	uses++
	switch(uses)
		if(1)
			var/obj/effect/proc_holder/spell/targeted/conjure_item/summon_pie/S = new /obj/effect/proc_holder/spell/targeted/conjure_item/summon_pie
			user.mind.AddSpell(S)
			user.log_message("learned the spell summon pie ([S])", LOG_ATTACK, color="orange")
		if(2)
			var/obj/effect/proc_holder/spell/aimed/banana_peel/S = new /obj/effect/proc_holder/spell/aimed/banana_peel
			user.mind.AddSpell(S)
			user.log_message("learned the spell summon banana peel ([S])", LOG_ATTACK, color="orange")
		if(3)
			var/obj/effect/proc_holder/spell/targeted/touch/megahonk/S = new /obj/effect/proc_holder/spell/targeted/touch/megahonk
			user.mind.AddSpell(S)
			user.log_message("learned the spell mega honk ([S])", LOG_ATTACK, color="orange")
		if(4)
			var/obj/effect/proc_holder/spell/targeted/touch/bspie/S = new /obj/effect/proc_holder/spell/targeted/touch/bspie
			user.mind.AddSpell(S)
			user.log_message("learned the spell bluespace pie ([S])", LOG_ATTACK, color="orange")
		else
			to_chat(user, "<span class='notice'>The can disappears!</span>")
			qdel(src)