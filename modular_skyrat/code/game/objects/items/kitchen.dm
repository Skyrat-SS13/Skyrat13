/obj/item/kitchen/knife/bloodletter
	name = "bloodletter"
	desc = "An occult looking dagger that is cold to the touch. Somehow, the flawless orb on the pommel is made entirely of liquid blood."
	icon = 'modular_skyrat/icons/obj/ice_moon/artifacts.dmi'
	icon_state = "bloodletter"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/kitchen/knife/bloodletter/attack(mob/living/M, mob/living/carbon/user)
	. =..()
	if(istype(M) && (M.mob_biotypes & MOB_ORGANIC))
		var/datum/status_effect/saw_bleed/bloodletting/B = M.has_status_effect(/datum/status_effect/saw_bleed/bloodletting)
		if(!B)
			M.apply_status_effect(/datum/status_effect/saw_bleed/bloodletting)
		else
			B.add_bleed(B.bleed_buildup)