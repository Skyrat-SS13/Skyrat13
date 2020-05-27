/datum/action/vampire/beckon
	name = "Beckon"
	desc = "You signal to one of your clanmembers that you wish to speak with them."
	button_icon_state = "power_beckon"

	bloodcost = 0
	powercost = 0
	cooldown = 100
	amToggle = FALSE
	level_max = 1

	purchasable = FALSE
	can_be_immobilized = TRUE

/datum/action/vampire/beckon/CheckCanUse()
	. = ..()
	var/datum/antagonist/vampire/user_vamp_datum = owner.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
	if(!user_vamp_datum)
		return FALSE
	var/datum/team/vampire_clan/vamp_clan = user_vamp_datum.vampire_clan
	if(!vamp_clan)
		return FALSE

/datum/action/vampire/beckon/ActivatePower()
	var/datum/antagonist/vampire/user_vamp_datum = owner.mind.has_antag_datum(ANTAG_DATUM_VAMPIRE)
	if(!user_vamp_datum)
		return
	var/datum/team/vampire_clan/vamp_clan = user_vamp_datum.vampire_clan
	if(!vamp_clan)
		return
	var/datum/mind/chosen_mind = input(owner, "Choose who you wish to beckon:", "Beckon") as null|anything in vamp_clan.members
	if(chosen_mind)
		if(!chosen_mind.current)
			to_chat(owner, "<span class='cult'>You're having trouble to signal the target, perhaps they're dead?</span>")
		to_chat(owner, "<span class='cult'>You signal [chosen_mind.name], calling them to you.</span>")
		to_chat(chosen_mind.current, "<span class='cult'>You feel your blood pulsing, [owner.name] calls you.</span>")
