/datum/action/bloodsucker/levelup
	name = "Forced Evolution"
	desc = "Spend the lovely sanguine running through your veins; aging you at an accelerated rate."
	button_icon_state = "power_feed"
	bloodcost = prev_cost * total_uses
	cooldown = 50
	bloodsucker_can_buy = TRUE


	var/prev_cost = 50
	var/total_uses = 1

/datum/action/bloodsucker/levelup/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return

	return TRUE


/datum/action/bloodsucker/levelup/ActivatePower()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	if(istype(bloodsuckerdatum))
		bloodsuckerdatum.ForcedRankUp()	// Rank up! Must still be in a coffin to level!

	total_uses++
