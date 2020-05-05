/datum/outfit/ninja/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source)
	if(istype(H.wear_suit, suit))
		var/obj/item/clothing/suit/space/space_ninja/S = H.wear_suit
		if(istype(H.belt, belt))
			S.energyKatana = H.belt
		S.randomize_param()
	H.grant_language(/datum/language/neokanji)
	var/datum/language_holder/holder = H.get_language_holder()
	holder.selected_default_language = /datum/language/neokanji
