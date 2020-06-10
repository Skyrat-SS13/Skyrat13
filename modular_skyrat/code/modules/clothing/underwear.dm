/obj/item/clothing/under/underwear
	name = "bob's programming socks"
	desc = "If you're reading this, something went terribly wrong... <i>Stay calm and tell me to get my shit together on #main-dev.</i>"
	icon = 'icons/mob/clothing/underwear.dmi'
	mob_overlay_icon = 'icons/mob/clothing/underwear.dmi'
	icon_state = "stockings_lpink"
	body_parts_covered = null
	has_sensor = FALSE
	var/stored_icon_state = "stockings_lpink"
	var/stored_underwear = "Stockings - Programmer"
	var/stored_color = "FFFFFF"

/obj/item/clothing/under/underwear/equipped(mob/user, slot)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.dna.species.mutant_bodyparts["legs"] && (H.dna.features["legs"] == "Digitigrade" || H.dna.features["legs"] == "Avian"))
			icon_state = stored_icon_state + "_d"
		else
			if(stored_icon_state)
				icon_state = stored_icon_state

/obj/item/clothing/under/underwear/attack_self(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/safe_to_del = FALSE
		var/datum/sprite_accessory/underwear/und
		if(GLOB.underwear_list[stored_underwear])
			und = GLOB.underwear_list[stored_underwear]
			H.underwear = stored_underwear
			H.saved_underwear = stored_underwear
			H.undie_color = stored_color
			safe_to_del = TRUE
		else if(GLOB.undershirt_list[stored_underwear])
			und = GLOB.undershirt_list[stored_underwear]
			H.undershirt = stored_underwear
			H.saved_undershirt = stored_underwear
			H.shirt_color = stored_color
			safe_to_del = TRUE
		else if(GLOB.socks_list[stored_underwear])
			und = GLOB.socks_list[stored_underwear]
			H.socks = und.icon_state
			H.saved_socks = stored_underwear
			H.socks_color = stored_color
			safe_to_del = TRUE
		H.update_body()
		if(safe_to_del)
			return qdel(src)
		else
			return to_chat(H, "<span class='danger'>Something went extremely stinky poopy on the underwear item code... Please shout at Bob in #main-dev until he cries.</span>")
	else
		return FALSE
