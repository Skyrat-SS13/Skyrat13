/obj/item/pickaxe/minecraft
	name = "Diamond Pickaxe"
	desc = "Aw man."
	force = 10
	icon = 'modular_skyrat/icons/obj/minecraft_items.dmi'
	icon_state = "pickaxe"
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.001 //best pickaxe bro

/obj/item/claymore/minecraft
	name = "Diamond Sword"
	desc = "It's good at taking revenge."
	force = 20
	icon = 'modular_skyrat/icons/obj/minecraft_items.dmi'
	icon_state = "sword"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/claymore/minecraft/attack(mob/M, mob/living/carbon/human/user)
	..()
	if(M.stat != DEAD)
		playsound(M.loc, 'modular_skyrat/sound/minecraft/oof.ogg', 75, 1, -1)
	M.color = "#FF0000"
	addtimer(CALLBACK(src, .proc/recallcolor, M), 5)

/obj/item/claymore/minecraft/proc/recallcolor(mob/target)
	target.color = initial(color)

/turf/closed/wall/minecraft
	name = "dirt block"
	desc = "it's....totally square?"
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "dirt"
	smooth = FALSE
	var/strong = FALSE //can you mine this by hand? if false, you can
	var/hit_sounds = list('modular_skyrat/sound/minecraft/grass1.ogg','modular_skyrat/sound/minecraft/grass2.ogg','modular_skyrat/sound/minecraft/grass3.ogg','modular_skyrat/sound/minecraft/grass4.ogg')
	var/beingdug = FALSE
	var/floor_type = /turf/open/floor/minecraft
	var/drop_type = /obj/item/minecraft
	var/mob/steve
	var/ores = list(/obj/item/stack/ore/iron,/obj/item/stack/ore/uranium,/obj/item/stack/ore/diamond,/obj/item/stack/ore/silver,/obj/item/stack/ore/plasma,/obj/item/stack/ore/bluespace_crystal,/obj/item/stack/ore/bananium)

/turf/open/floor/attackby(obj/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/minecraft))
		to_chat(user, "You begin placing a block...")
		if(do_after(user, 20, target = src))
			var/obj/item/minecraft/X = I
			to_chat(user, "You place [I].")
			ChangeTurf(X.build_type)
			qdel(I)

/obj/item/minecraft
	name = "Block"
	desc = "You build things with it :)"
	icon = 'modular_skyrat/icons/obj/minecraft_items.dmi'
	icon_state = "dirt"
	var/build_type = /turf/closed/wall/minecraft

/obj/item/minecraft/stone
	icon_state = "stone"
	build_type = /turf/closed/wall/minecraft/stone

/obj/item/minecraft/cobblestone
	icon_state = "cobblestone"
	build_type = /turf/closed/wall/minecraft/cobblestone

/obj/item/minecraft/andesite
	icon_state = "andesite"
	build_type = /turf/closed/wall/minecraft/andesite

/obj/item/minecraft/stonebrick
	icon_state = "stonebrick"
	build_type = /turf/closed/wall/minecraft/stonebrick

/obj/item/minecraft/Initialize()
	. = ..()
	SpinAnimation(1000,1000)

/turf/closed/wall/minecraft/attack_hand(mob/user)
	if(strong)
		to_chat(user, "<span_class='warning'>[src] is too strong to mine by hand!</span>")
		return
	if(isliving(user))
		to_chat(user, "You start picking away at [src].")
		START_PROCESSING(SSfastprocess,src)
		beingdug = TRUE
		steve = user
		if(do_after(user, 30, target = src))
			var/sound = pick(hit_sounds)//Spam the mining sound minecraft style :)
			playsound(src,sound,50)
			new drop_type(src)
			ChangeTurf(floor_type)
		beingdug = FALSE
		STOP_PROCESSING(SSfastprocess,src)
		steve = null

/turf/closed/wall/minecraft/attackby(obj/I, mob/user, params)
	if(istype(I, /obj/item/pickaxe))
		to_chat(user, "You start picking away at [src].")
		START_PROCESSING(SSfastprocess,src)
		beingdug = TRUE
		steve = user
		if(do_after(user, 20, target = src))
			var/sound = pick(hit_sounds)//Spam the mining sound minecraft style :)
			SEND_SOUND(user,sound)
			if(strong && prob(5))
				var/mineralType = pick(ores)
				var/num = rand(1,5)
				new mineralType(src, num)
			else
				new drop_type(src)
		ChangeTurf(floor_type)
		beingdug = FALSE
		STOP_PROCESSING(SSfastprocess,src)
		steve = null

/turf/closed/wall/minecraft/process()
	if(steve)
		var/sound = pick(hit_sounds)//Spam the mining sound minecraft style :)
		SEND_SOUND(steve, sound)

/turf/open/floor/minecraft
	name = "dirt block"
	desc = "it's....totally square?"
	icon_state = "dirt"
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'

/turf/closed/wall/minecraft/stone
	name = "stone block"
	icon_state = "stone"
	strong = TRUE
	drop_type = /obj/item/minecraft/cobblestone
	floor_type = /turf/open/floor/minecraft/stone
	hit_sounds = list('modular_skyrat/sound/minecraft/stone1.ogg','modular_skyrat/sound/minecraft/stone2.ogg','modular_skyrat/sound/minecraft/stone3.ogg','modular_skyrat/sound/minecraft/stone4.ogg')

/turf/open/floor/minecraft/stone
	name = "stone block"
	icon_state = "stone"

/turf/closed/wall/minecraft/andesite
	name = "andesite block"
	icon_state = "andesite"
	strong = TRUE
	floor_type = /turf/open/floor/minecraft/stone
	drop_type = /obj/item/minecraft/andesite
	hit_sounds = list('modular_skyrat/sound/minecraft/stone1.ogg','modular_skyrat/sound/minecraft/stone2.ogg','modular_skyrat/sound/minecraft/stone3.ogg','modular_skyrat/sound/minecraft/stone4.ogg')

/turf/closed/wall/minecraft/stonebrick
	name = "stone brick block"
	icon_state = "stonebrick"
	strong = TRUE
	floor_type = /turf/open/floor/minecraft/stone
	drop_type = /obj/item/minecraft/stonebrick
	hit_sounds = list('modular_skyrat/sound/minecraft/stone1.ogg','modular_skyrat/sound/minecraft/stone2.ogg','modular_skyrat/sound/minecraft/stone3.ogg','modular_skyrat/sound/minecraft/stone4.ogg')

/turf/closed/wall/minecraft/cobblestone
	name = "cobblestone block"
	icon_state = "cobblestone"
	strong = TRUE
	floor_type = /turf/open/floor/minecraft/stone
	drop_type = /obj/item/minecraft/cobblestone
	hit_sounds = list('modular_skyrat/sound/minecraft/stone1.ogg','modular_skyrat/sound/minecraft/stone2.ogg','modular_skyrat/sound/minecraft/stone3.ogg','modular_skyrat/sound/minecraft/stone4.ogg')

/turf/closed/mineral/random/minecraft
	name = "stone block"
	desc = "It's... squarer than normal."
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "stone"
	smooth_icon = null
	mineralSpawnChanceList = list(/turf/closed/mineral/diamond/minecraft = 40, /turf/closed/mineral/gold/minecraft = 25, /turf/closed/mineral/iron/minecraft = 25,
		/turf/closed/mineral/gibtonite/minecraft = 5, /turf/open/floor/plating/asteroid/airless/cave/minecraft = 5)
	baseturfs = /turf/open/floor/plating/asteroid/airless/cave/minecraft

/turf/closed/mineral/minecraft
	name = "stone block"
	desc = "It's... squarer than normal."
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "stone"

/turf/closed/mineral/random/minecraft/Initialize()
	..()
	icon = initial(icon)

/turf/closed/mineral/diamond/minecraft
	scan_state = "rock_Diamond_minecraf"
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "stone"

/turf/closed/mineral/gold/minecraft
	scan_state = "rock_Gold_minecraft"
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "stone"

/turf/closed/mineral/iron/minecraft
	scan_state = "rock_Iron_minecraft"
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "stone"

/turf/closed/mineral/gibtonite/minecraft
	scan_state = "rock_TNT"
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "stone"

/obj/item/twohanded/required/gibtonite/tnt
	icon = 'modular_skyrat/icons/obj/minecraft_items.dmi'
	icon_state = "tnt"
	name = "TNT"
	desc = "Good at griefing houses."

/turf/closed/mineral/gibtonite/tnt/gets_drilled(mob/user, triggered_by_explosion = 0)
	if(stage == GIBTONITE_UNSTRUCK && mineralAmt >= 1) //Gibtonite deposit is activated
		playsound(src,'modular_skyrat/sound/minecraft/hiss.ogg',200,1)
		explosive_reaction(user, triggered_by_explosion)
		return
	if(stage == GIBTONITE_ACTIVE && mineralAmt >= 1) //Gibtonite deposit goes kaboom
		var/turf/bombturf = get_turf(src)
		mineralAmt = 0
		stage = GIBTONITE_DETONATE
		playsound(src,'modular_skyrat/sound/minecraft/tntold.ogg',200,1)
		explosion(bombturf,1,2,5, adminlog = 0)
	if(stage == GIBTONITE_STABLE) //Gibtonite deposit is now benign and extractable. Depending on how close you were to it blowing up before defusing, you get better quality ore.
		new /obj/item/twohanded/required/gibtonite/tnt(src)

/turf/open/floor/plating/asteroid/airless/cave/minecraft
	name = "cobblestone floor"
	desc = "Don't dig down."
	icon = 'modular_skyrat/icons/turf/minecraft.dmi'
	icon_state = "cobblestone"
	mob_spawn_list = list(/mob/living/simple_animal/hostile/asteroid/goliath/zombie = 50, /obj/structure/spawner/lavaland/minecraft/zombie = 3, \
		/mob/living/simple_animal/hostile/asteroid/basilisk/ghast = 40, /obj/structure/spawner/lavaland/minecraft/ghast = 2, \
		/mob/living/simple_animal/hostile/asteroid/hivelord/creeper = 10, /obj/structure/spawner/lavaland/minecraft/creeper = 3)

/turf/open/floor/plating/asteroid/airless/cave/minecraft/getDug()
	src.TerraformTurf(/turf/open/lava, /turf/open/lava, flags = CHANGETURF_INHERIT_AIR)