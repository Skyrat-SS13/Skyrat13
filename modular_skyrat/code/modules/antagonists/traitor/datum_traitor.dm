/datum/antagonist/traitor/roundend_report()
	var/list/result = list()

	result += printplayer(owner)

	var/TC_uses = 0
	var/uplink_true = FALSE
	var/purchases = ""
	LAZYINITLIST(GLOB.uplink_purchase_logs_by_key)
	var/datum/uplink_purchase_log/H = GLOB.uplink_purchase_logs_by_key[owner.key]
	if(H)
		TC_uses = H.total_spent
		uplink_true = TRUE
		purchases += H.generate_render(FALSE)

	var/objectives_text = ""
	if(objectives.len)//If the traitor had no objectives, don't need to process this.
		var/count = 1
		for(var/datum/objective/objective in objectives)
			objectives_text += "<br><B>Objective #[count]</B>: [objective.explanation_text]"
			count++

	if(uplink_true)
		var/uplink_text = "(used [TC_uses] TC) [purchases]"
		if(TC_uses==0)
			var/static/icon/badass = icon('icons/badass.dmi', "badass")
			uplink_text += "<BIG>[icon2html(badass, world)]</BIG>"
		result += uplink_text

	result += objectives_text

	if(contractor_hub)
		result += contractor_round_end()

	return result.Join("<br>")

/datum/antagonist/traitor/on_gain()
	. = ..()
	if(owner)
		for(var/datum/stats/stat in owner.mob_stats)
			stat.level = min(stat.level + 1, MAX_STAT)
		var/datum/skills/ranged/ranged = owner.mob_skills[SKILL_DATUM(ranged)]
		if(ranged)
			ranged.level = min(ranged.level + 5, MAX_SKILL)
