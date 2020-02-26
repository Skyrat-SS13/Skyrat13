#define MEDAL_PREFIX "Bubblegum"

/*

BUBBLEGUM

Removes slaughterlings (because they are bullshit), instead replacing them with the blood rending thing from tg

*/

/mob/living/simple_animal/hostile/megafauna/bubblegum
	death_sound = 'modular_skyrat/sound/misc/gorenest.ogg' //fuck it

	do_footstep = TRUE

/mob/living/simple_animal/hostile/megafauna/bubblegum/OpenFire()
	anger_modifier = CLAMP(((maxHealth - health)/50),0,20)
	if(charging)
		return
	ranged_cooldown = world.time + ranged_cooldown_time
	blood_warp()
	bloodsmacks()
	if(prob(25))
		INVOKE_ASYNC(src, .proc/blood_spray)
		INVOKE_ASYNC(src, .proc/bloodsmacks)
	else
		if(health > maxHealth/2 && !client)
			INVOKE_ASYNC(src, .proc/charge)
		else
			INVOKE_ASYNC(src, .proc/triple_charge)

/mob/living/simple_animal/hostile/megafauna/bubblegum/proc/bloodsmacks()
	for(var/obj/effect/decal/cleanable/blood/B in view(7, src))
		var/turf/T = get_turf(B)
		for(var/mob/living/L in T.contents)
			var/hand = rand(0,1)
			INVOKE_ASYNC(src, .proc/bloodsmack, T, hand)

/mob/living/simple_animal/hostile/megafauna/bubblegum/proc/bloodsmack(turf/T, handedness)
	if(handedness)
		new /obj/effect/temp_visual/bubblegum_hands/rightsmack(T)
	else
		new /obj/effect/temp_visual/bubblegum_hands/leftsmack(T)
	sleep(5)
	for(var/mob/living/L in T)
		if(!faction_check_mob(L))
			to_chat(L, "<span class='userdanger'>[src] rends you!</span>")
			playsound(T, attack_sound, 100, TRUE, -1)
			var/limb_to_hit = L.get_bodypart(pick(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
			L.apply_damage(35, BRUTE, limb_to_hit, L.run_armor_check(limb_to_hit, "melee", null, null, 100)) // You really, really, really better not stand in blood!
	sleep(3)


/obj/effect/temp_visual/bubblegum_hands
	icon = 'icons/effects/bubblegum.dmi'
	duration = 9

/obj/effect/temp_visual/bubblegum_hands/rightthumb
	icon_state = "rightthumbgrab"

/obj/effect/temp_visual/bubblegum_hands/leftthumb
	icon_state = "leftthumbgrab"

/obj/effect/temp_visual/bubblegum_hands/rightpaw
	icon_state = "rightpawgrab"
	layer = BELOW_MOB_LAYER

/obj/effect/temp_visual/bubblegum_hands/leftpaw
	icon_state = "leftpawgrab"
	layer = BELOW_MOB_LAYER

/obj/effect/temp_visual/bubblegum_hands/rightsmack
	icon_state = "rightsmack"

/obj/effect/temp_visual/bubblegum_hands/leftsmack
	icon_state = "leftsmack"

#undef MEDAL_PREFIX
