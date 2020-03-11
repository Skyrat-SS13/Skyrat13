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