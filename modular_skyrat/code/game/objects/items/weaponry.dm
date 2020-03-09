/obj/item/claymore/roblox
	name = "Fencing Sword"
	desc = "It seems otherworldly."
	icon = 'modular_skyrat/icons/obj/item/roblox.dmi'
	icon_state = "sword"
	hitsound = 'modular_skyrat/sound/roblox/lunge.ogg'
	force = 20
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("oofed")
	sharpness = IS_SHARP_ACCURATE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)

/obj/item/claymore/roblox/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is falling on [src]! It looks like they lost all their Robux!</span>")
	return(BRUTELOSS)

/obj/item/claymore/roblox/pickup(mob/living/user)
	..()
	playsound(M, 'modular_skyrat/sound/roblox/equip.ogg', 100)

/obj/item/claymore/roblox/afterattack(atom/target, mob/living/user)
	var/turf/T = get_step(src, src.dir)
	var/dirtotarget = get_dir(target, user)
	var/obj/effect/temp_visual/robloxsword/S = new /obj/effect/temp_visual/robloxsword(T)
	animate(M, transform = matrix(dir2angle(dirtotarget), MATRIX_ROTATE), time = 3)
	for(var/mob/M in T.contents)
		attack(M, user)
		if(M.health <= 0)
			playsound(M, 'modular_skyrat/sound/roblox/OOF.ogg', 100)