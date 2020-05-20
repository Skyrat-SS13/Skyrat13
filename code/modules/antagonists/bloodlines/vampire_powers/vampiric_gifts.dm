/datum/vampiric_gifts
	var/name = "cellular emporium"
	var/datum/antagonist/vampire/vampire_datum

/datum/vampiric_gifts/New(my_vampire)
	. = ..()
	vampire_datum = my_vampire

/datum/vampiric_gifts/Destroy()
	vampire_datum = null
	. = ..()

/datum/vampiric_gifts/ui_interact(mob/user)
	. = ..()
	var/list/available_disciplines = list()
	for(var/path in vampire_datum.bloodlines)
		var/datum/bloodline/bl = path
		for(var/path2 in initial(bl.disciplines))
			message_admins("[path2]")
			available_disciplines |= path2

	message_admins("[available_disciplines.len]")

	var/bright = FALSE
	var/dat = "<center>"
	dat += "<table align='center' width='100% background-color: #2e251b'>"
	dat += "<center><b>Vampiric Gifts:</b></center>"
	dat += "<center>Remaining gift points: <b>[vampire_datum.gift_points]</b></center>"
	dat += "<tr style='vertical-align:top;'><td width=20%><b>Name</b></td>"
	dat += "<td width=50%><font size=2><b>Description</b></font></td>"
	dat += "<td width=15%><font size=2><b>Current</b></font></td>"
	dat += "<td width=15%><font size=2><b>Buy</b></font></td></tr>"
	for(var/ability_path in vampire_datum.all_powers)
		var/datum/action/vampire/action_datum = ability_path
		message_admins("[action_datum]")
		message_admins("[initial(action_datum.required_discipline)]")
		message_admins("[initial(action_datum.purchasable)]")
		if(initial(action_datum.purchasable) && (!(initial(action_datum.required_discipline) || initial(action_datum.required_discipline) in available_disciplines)))
			var/max_level = FALSE
			var/can_buy = FALSE
			var/is_owned = FALSE
			var/datum/action/vampire/owned_datum
			for(var/datum/action/vampire/P in vampire_datum.powers)
				if(initial(action_datum.name) == P.name)
					is_owned = TRUE
					owned_datum = P
					break

			if(is_owned && owned_datum.level_current == owned_datum.level_max)
				max_level = TRUE
			if(initial(action_datum.gift_cost) <= vampire_datum.gift_points && !max_level)
				can_buy = TRUE
			bright = !bright

			var/status_line = "Unlearned"
			if(is_owned)
				status_line = "Level: [owned_datum.level_current]"

			var/buy_link = "class='linkOff'"
			var/buy_button = "Gain ([initial(action_datum.gift_cost)])"
			if(max_level)
				buy_button = "Maxed out"
			else if (is_owned)
				buy_button = "Level up ([initial(action_datum.gift_cost)])"
			if(can_buy)
				buy_link = "href='?src=[REF(src)];bought_ability=[ability_path]'"

			dat += "<tr style='vertical-align:top; background-color: [bright?"#4f4243":"#3d3334"];'>"
			dat += "<td><center><b>[initial(action_datum.name)]</b></center></td>" //Name
			dat += "<td><center><i>[initial(action_datum.desc)]</i></center></td>" //Descriptoin
			dat += "<td><center>[status_line]</center></td>" //Current status
			dat += "<td><center><a [buy_link]>[buy_button]</a></center></td></tr>" //Buy button

	dat += "</table>"
	var/datum/browser/popup = new(user, "vampire_gifts_shop", "Choose your Vampiric Gifts", 800, 650)
	popup.set_content(dat)
	popup.open()

/datum/vampiric_gifts/Topic(href, href_list)
	var/ability_path = text2path(href_list["bought_ability"])
	if(ability_path)
		vampire_datum.AttemptPurchasePowerAbility(ability_path)
		ui_interact(usr)


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