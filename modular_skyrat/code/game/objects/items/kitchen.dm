/obj/item/kitchen/knife/bloodletter
	name = "bloodletter"
	desc = "An occult looking dagger that is cold to the touch. Somehow, the flawless orb on the pommel is made entirely of liquid blood."
	icon = 'modular_skyrat/icons/obj/ice_moon/artifacts.dmi'
	icon_state = "bloodletter"
	w_class = WEIGHT_CLASS_NORMAL
	force = 15

/obj/item/kitchen/knife/bloodletter/attack(mob/living/M, mob/living/carbon/user)
	. =..()
	if(istype(M) && (M.mob_biotypes & MOB_ORGANIC))
		var/datum/status_effect/saw_bleed/bloodletting/B = M.has_status_effect(/datum/status_effect/saw_bleed/bloodletting)
		if(!B)
			M.apply_status_effect(/datum/status_effect/saw_bleed/bloodletting)
		else
			B.add_bleed(B.bleed_buildup)

/obj/item/kitchen/knife/bloodletter/attack(mob/living/target, mob/living/carbon/human/user)
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(target))
	var/static/list/bloodletter_slice_angles = list(0, -45, 45) //so that the animation animates towards the target clicked and not towards a side target
	for(var/i in bloodletter_slice_angles)
		var/turf/T = get_step(user_turf, turn(dir_to_target, i))
		for(var/mob/living/L in T)
			if(user.Adjacent(L) && L.density)
				melee_attack_chain(user, L)

/obj/item/kitchen/knife/bloodletter/melee_attack_chain(mob/user, atom/target, params)
	..()
	user.changeNext_move(CLICK_CD_MELEE * 0.25) //It attacks FAST.