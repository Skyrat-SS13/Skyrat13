/datum/vampire_clan
	var/name = "Example Clan"
	var/desc = "Is this gonna be used?"
	var/list/bloodlines = list()
	var/list/members = list()
	var/datum/mind/leader

/datum/vampire_clan/proc/setup_clan(bloodline_type)
	bloodlines += bloodline_type
	var/number = rand(1,3)
	switch(number)
		if(1)
			name = "House of [pick(list("Others", "Grim", "Revelation"))]"
		if(2)
			name = "Circle of [pick(list("Death", "Life", "Pain", "Domination", "Power"))]"
		if(3)
			name = pick(list("Bleeding Stones", "Bloody Eagles", "Rose's Thorns", "Apex Predators"))

/datum/vampire_clan/proc/add_member(var/datum/mind/vampire_mind, silent = TRUE)
	var/datum/antagonist/vampire/vamp_datum = vampire_mind.has_antag_datum(/datum/antagonist/vampire)
	if(vamp_datum)
		members += vampire_mind
		vamp_datum.vampire_clan = src
		vamp_datum.GainBloodlinesFromClan(src)
		if(!silent)
			to_chat(vampire_mind.current, "<B><font size=2 color=orange>You are now a member of [name], a clan of vampires</font></B>")

/datum/vampire_clan/proc/full_greet(var/datum/mind/vampire_mind)
	var/mob/living/carbon/human/current_member = vampire_mind.current
	to_chat(current_member, "<B><font size=3 color=orange>You are a member of [name], a clan of vampires</font></B>")
	if(members.len > 1)
		var/string = "Your fellow clan members are: "
		var/first_passed = FALSE

		for(var/datum/mind/Mind in members)
			var/mob/living/carbon/human/iterate_member = Mind.current
			if(iterate_member != current_member)
				if(first_passed)
					string = "[string],"
				string = "[string] [iterate_member.real_name]"
				first_passed = TRUE
		to_chat(current_member, "<B><font size=2 color=orange>[string]</font></B>")
	if(!leader)
		to_chat(current_member, "<B><font size=2 color=orange>Your clan didn't choose a leader yet.. you should meet up and discuss matters.</font></B>")