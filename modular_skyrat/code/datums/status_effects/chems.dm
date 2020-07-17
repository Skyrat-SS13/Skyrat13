/datum/status_effect/chem/breast_enlarger/on_apply()
	log_game("FERMICHEM: [owner]'s breasts has reached comical sizes. ID: [owner.key]")
	return ..()

/datum/status_effect/chem/breast_enlarger/tick()//If you try to wear clothes, you fail. Slows you down if you're comically huge
	var/mob/living/carbon/human/H = owner
	var/obj/item/organ/genital/breasts/B = H.getorganslot(ORGAN_SLOT_BREASTS)
	if(!B)
		H.remove_status_effect(src)
		return
	moveCalc = 1+((round(B.cached_size) - 9)/3) //Afffects how fast you move, and how often you can click.

	if(last_checked_size != B.cached_size)
		H.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/status_effect/breast_hypertrophy, multiplicative_slowdown = moveCalc)
		sizeMoveMod(moveCalc)

	if(B.cached_size > 11)
		var/message = FALSE
		if(H.w_uniform)
			H.dropItemToGround(H.w_uniform, TRUE)
			message = TRUE
		if(H.wear_suit)
			H.dropItemToGround(H.wear_suit, TRUE)
			message = TRUE
		if(message)
			playsound(H.loc, 'sound/items/poster_ripped.ogg', 50, 1)
			to_chat(H, "<span class='warning'>Your enormous breasts are way too large to fit anything over them!</b></span>")

	if (B.size == "huge")
		if(prob(1))
			to_chat(owner, "<span class='notice'>Your back feels painfully sore.</span>")
			var/target = H.get_bodypart(BODY_ZONE_CHEST)
			H.apply_damage(0.1, BRUTE, target)
	else
		if(prob(1))
			to_chat(H, "<span class='notice'>Your back feels very sore.</span>")
	last_checked_size = B.cached_size
	..()
