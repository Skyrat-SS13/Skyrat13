/datum/antagonist/abductor
	threat = 10

/datum/objective/experiment/New()
	explanation_text = "Experiment on [target_amount] sentient lifeforms."

/datum/antagonist/abductor/greet()
	to_chat(owner.current, "<span class='notice'>You are the [owner.special_role]!</span>")
	to_chat(owner.current, "<span class='notice'>With the help of your team, kidnap and experiment on the station's crew members!</span>")
	to_chat(owner.current, "<span class='notice'><b>Do your best not to harm the habititat, as it could lead to skewed research results.</b></span>")
	to_chat(owner.current, "<span class='notice'>[greet_text]</span>")
	owner.announce_objectives()


/datum/team/abductor_team/New()
	..()
	team_number = team_count++
	name = "Mothership [pick(GLOB.possible_changeling_IDs)]"
	add_objective(new/datum/objective/experiment)
	add_objective(new/datum/objective/escape)