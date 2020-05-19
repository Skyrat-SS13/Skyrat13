/datum/vampiric_gifts
	var/name = "cellular emporium"
	var/datum/antagonist/vampire/vampire

/datum/vampiric_gifts/New(my_vampire)
	. = ..()
	vampire = vampire

/datum/vampiric_gifts/Destroy()
	vampire = null
	. = ..()

/datum/vampiric_gifts/ui_interact(mob/user)

/datum/vampiric_gifts/Topic(href, href_list)

/datum/action/innate/vampiric_gifts
	name = "Vampiric Gifts"
	desc = "Click to open a tab for choosing your abilities."
	icon_icon = 'modular_skyrat/icons/mob/actions/vampire.dmi'
	button_icon = 'modular_skyrat/icons/mob/actions/vampire.dmi'
	button_icon_state = "power_gifts"
	background_icon_state = "vamp_power_off"
	var/datum/vampiric_gifts/vampiric_gifts

/datum/action/innate/vampiric_gifts/New(our_target)
	. = ..()
	button.name = name
	if(istype(our_target, /datum/vampiric_gifts))
		vampiric_gifts = our_target
	else
		CRASH("vampiric_gifts action created with no gift datum")

/datum/action/innate/vampiric_gifts/Activate()
	vampiric_gifts.ui_interact(owner)