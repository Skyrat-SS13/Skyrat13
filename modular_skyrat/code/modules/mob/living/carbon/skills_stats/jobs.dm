//Assigns points properly to each job datum
/datum/job
	//Stat defines
	var/stat_variance_positive = 2 //How much we can vary positively
	var/stat_variance_negative = 2 //How much we can vary negatively
	var/stat_str = JOB_STATPOINTS_AVERAGE
	var/stat_end = JOB_STATPOINTS_AVERAGE
	var/stat_dex = JOB_STATPOINTS_AVERAGE
	var/stat_int = JOB_STATPOINTS_AVERAGE

	//Skill defines
	var/skill_variance_positive = 2 //How much we can vary positively
	var/skill_variance_negative = 2 //How much we can vary negatively
	var/skill_melee = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_ranged = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_firstaid = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_surgery = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_chemistry = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_construction = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_electronics = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_research = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_cooking = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_agriculture = JOB_SKILLPOINTS_HORRENDOUS
	var/skill_gaming = JOB_SKILLPOINTS_HORRENDOUS

//Handles post-spawn skill and stat gains
/datum/job/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source)
	. = ..()
	if(istype(H) && H.mind)
		//Do the normal skill assignment
		assign_skills_stats(H)
		//Attempt the weirder skill assignment
		special_assign_skills_stats(H)

/datum/job/proc/assign_skills_stats(mob/living/carbon/human/H)
	//Assign stats
	var/list/all_stats = list(
							STAT_DATUM(str) = stat_str,
							STAT_DATUM(end) = stat_end,
							STAT_DATUM(dex) = stat_dex,
							STAT_DATUM(int) = stat_int,
							)
	for(var/currentpath in all_stats)
		var/datum/stats/stat = H.mind.mob_stats[currentpath]
		if(stat)
			stat.level = clamp(rand(all_stats[currentpath] - stat_variance_negative, all_stats[currentpath] + stat_variance_positive), 0, MAX_STAT)
	
	//Assign skills
	var/list/all_skills = list(
							SKILL_DATUM(melee) = skill_melee,
							SKILL_DATUM(ranged) = skill_ranged,
							SKILL_DATUM(firstaid) = skill_firstaid,
							SKILL_DATUM(surgery) = skill_surgery,
							SKILL_DATUM(chemistry) = skill_chemistry,
							SKILL_DATUM(construction) = skill_construction,
							SKILL_DATUM(electronics) = skill_electronics,
							SKILL_DATUM(gaming) = skill_gaming,
							SKILL_DATUM(cooking) = skill_cooking,
							SKILL_DATUM(agriculture) = skill_agriculture,
							SKILL_DATUM(research) = skill_research,
							)
	for(var/currentpath in all_skills)
		var/datum/skills/skill = H.mind.mob_skills[currentpath]
		if(skill)
			skill.level = clamp(rand(all_skills[currentpath] - skill_variance_negative, all_skills[currentpath] + skill_variance_positive), 0, MAX_SKILL)

/datum/job/proc/special_assign_skills_stats(mob/living/carbon/human/H)
	return

//Point value assignment
/datum/job/assistant
	//Assistants have WACKY stats
	stat_variance_negative = 4
	stat_variance_positive = 4
	stat_str = 9 //str needs to be limited because 13 str is already *very* good

	//But they suck at pretty much every skill, save for a bit of
	//construction, electronics and gaming
	skill_variance_negative = 2
	skill_variance_positive = 2
	skill_gaming = JOB_STATPOINTS_AVERAGE
	skill_construction = JOB_STATPOINTS_NOVICE
	skill_electronics = JOB_STATPOINTS_NOVICE

/datum/job/atmos
	//Average stats all around, save for
	//extra endurance
	stat_end = JOB_STATPOINTS_TRAINED
	//Fantastic construction, trained electronics
	skill_construction = JOB_SKILLPOINTS_EXPERT
	skill_electronics = JOB_SKILLPOINTS_TRAINED

/datum/job/bartender
	//Average stats, little variance
	stat_variance_negative = 1
	stat_variance_positive = 1
	//Average chemistry because drinkie mixing
	//Good ranged because who's gonna stop the drink flinging
	//Good cooking because burbger
	//Also little variance
	skill_variance_negative = 1
	skill_variance_positive = 1
	skill_chemistry = JOB_SKILLPOINTS_AVERAGE
	skill_ranged = JOB_SKILLPOINTS_TRAINED
	skill_cooking = JOB_SKILLPOINTS_TRAINED

/datum/job/hydro
	//Expert agriculture, trained cooking
	skill_cooking = JOB_SKILLPOINTS_TRAINED
	skill_agriculture = JOB_STATPOINTS_EXPERT

/datum/job/captain
	//A fucking chad, stats are great all around
	stat_variance_negative = 1
	stat_str = 14
	stat_end = 13
	stat_dex = 14
	stat_int = 13
	//Godlike melee, expert ranged and research, good first aid
	//everything else the underlings will have to do
	skill_melee = 18
	skill_ranged = JOB_STATPOINTS_EXPERT
	skill_research = JOB_STATPOINTS_EXPERT
	skill_firstaid = JOB_STATPOINTS_TRAINED

/datum/job/cargo_tech
	//Better str and end, at the cost of int and dex
	stat_str = JOB_STATPOINTS_TRAINED
	stat_end = JOB_STATPOINTS_TRAINED
	stat_dex = 8
	stat_int = 8
	//Decent construction and electronics
	skill_construction = JOB_SKILLPOINTS_TRAINED
	skill_electronics = JOB_SKILLPOINTS_TRAINED

/datum/job/chaplain
	//Decent stats, god blessed them
	stat_variance_negative = 1
	//Decent first aid and cooking
	skill_firstaid = JOB_SKILLPOINTS_TRAINED
	skill_cooking = JOB_SKILLPOINTS_TRAINED

/datum/job/chemist
	//INTJ, physically incapable but smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_TRAINED
	stat_int = JOB_STATPOINTS_EXPERT
	//Expert chemistry, good firstaid, novice surgery
	skill_chemistry = JOB_SKILLPOINTS_EXPERT
	skill_firstaid = JOB_SKILLPOINTS_TRAINED
	skill_surgery = JOB_SKILLPOINTS_NOVICE

/datum/job/chief_engineer
	//Decent endurance and intellect
	stat_end = 14
	stat_int = 14
	//Godlike construction and electronics
	skill_construction = 18
	skill_electronics = 18

/datum/job/cmo
	//High intellect, average everything else
	stat_int = JOB_STATPOINTS_EXPERT
	//Godlike surgery, expert chemsitry and firstaid
	skill_surgery = 18
	skill_chemistry = JOB_SKILLPOINTS_EXPERT
	skill_firstaid = JOB_SKILLPOINTS_EXPERT

/datum/job/clown
	//Absolutely braindead, but high endurance to survive all the beating up
	stat_end = 14
	stat_int = 6
	//Uhhh... godlike gaming?...
	skill_gaming = JOB_SKILLPOINTS_LEGENDARY

//Either gets ridiculously low or ridiculously high strength, no inbetween
/datum/job/clown/special_assign_skills_stats(mob/living/carbon/human/H)
	var/fiddy = prob(65)
	if(fiddy)
		var/datum/stats/str/str = GET_STAT(H, str)
		if(str)
			str.level = rand(2, 6)
	else
		var/datum/stats/str/str = GET_STAT(H, str)
		if(str)
			str.level = rand(16, 18)
	return

/datum/job/cook
	//Expert cooking, trained agriculture
	skill_cooking = JOB_SKILLPOINTS_EXPERT
	skill_agriculture = JOB_SKILLPOINTS_TRAINED

/datum/job/curator
	//High intellect, but literally no skills
	stat_int = 16

/datum/job/detective
	//High endurance and int
	stat_end = 14
	stat_int = 14
	//Expert ranged, average melee
	skill_melee = JOB_SKILLPOINTS_AVERAGE
	skill_ranged = JOB_SKILLPOINTS_EXPERT

/datum/job/geneticist
	//INTJ, physically incapable but smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_TRAINED
	stat_int = JOB_STATPOINTS_EXPERT
	//Expert research, good firstaid, novice surgery
	skill_research = JOB_SKILLPOINTS_EXPERT
	skill_firstaid = JOB_SKILLPOINTS_TRAINED
	skill_surgery = JOB_SKILLPOINTS_NOVICE

/datum/job/hop
	//INTJ femboy head of staff, physically incapable but VERY smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_EXPERT
	stat_int = JOB_STATPOINTS_EXPERT
	//Passing ranged, research and chemistry skills
	skill_ranged = JOB_SKILLPOINTS_AVERAGE
	skill_chemistry = JOB_SKILLPOINTS_AVERAGE
	skill_research = JOB_SKILLPOINTS_AVERAGE

/datum/job/hos
	//Chad, high strength and endurance, little variance
	stat_variance_negative = 1
	stat_str = 14
	stat_end = 14
	//Godlike melee and ranged, novice firstaid
	skill_melee = JOB_SKILLPOINTS_AVERAGE
	skill_ranged = JOB_SKILLPOINTS_AVERAGE

/datum/job/janitor
	//Decent endurance, below average strength
	stat_str = 9
	stat_end = 14
	//Average construction and electronics i guess?
	skill_construction = JOB_SKILLPOINTS_AVERAGE
	skill_electronics = JOB_SKILLPOINTS_AVERAGE

/datum/job/lawyer
	//Uhhh... decent research and ranged?
	skill_ranged = JOB_SKILLPOINTS_AVERAGE
	skill_research = JOB_SKILLPOINTS_AVERAGE

/datum/job/doctor
	//Good surgery and first aid, average chemistry
	skill_chemistry = JOB_SKILLPOINTS_AVERAGE
	skill_firstaid = JOB_SKILLPOINTS_EXPERT
	skill_surgery = JOB_SKILLPOINTS_EXPERT

//Mime does the same meme as the clown
/datum/job/mime
	//Absolutely braindead, but high endurance to survive all the beating up
	stat_end = 14
	stat_int = 6
	//Uhhh... godlike gaming?...
	skill_gaming = JOB_SKILLPOINTS_LEGENDARY

//Either gets ridiculously low or ridiculously high strength, no inbetween
/datum/job/mime/special_assign_skills_stats(mob/living/carbon/human/H)
	var/fiddy = prob(65)
	if(fiddy)
		var/datum/stats/str/str = GET_STAT(H, str)
		if(str)
			str.level = rand(2, 6)
	else
		var/datum/stats/str/str = GET_STAT(H, str)
		if(str)
			str.level = rand(16, 18)
	return

/datum/job/paramedic
	//Good endurance and str
	stat_str = 12
	stat_end = 12
	//Expert surgery and expert first aid
	skill_firstaid = JOB_SKILLPOINTS_EXPERT
	skill_surgery = JOB_SKILLPOINTS_EXPERT

/datum/job/brig_physician
	//Good endurance
	stat_end = 12
	//Average ranged, surgery and expert first aid
	skill_melee = JOB_SKILLPOINTS_NOVICE
	skill_ranged = JOB_SKILLPOINTS_AVERAGE
	skill_firstaid = JOB_SKILLPOINTS_EXPERT
	skill_surgery = JOB_SKILLPOINTS_AVERAGE

/datum/job/qm
	//Better str and end, no int or dex cost
	stat_str = JOB_STATPOINTS_TRAINED
	stat_end = JOB_STATPOINTS_TRAINED
	//Decent construction and electronics
	skill_construction = JOB_SKILLPOINTS_TRAINED
	skill_electronics = JOB_SKILLPOINTS_TRAINED

/datum/job/rd
	//INTJ femboy head of staff, physically incapable but VERY smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_EXPERT
	stat_int = JOB_STATPOINTS_EXPERT
	//Amazing research and chemistry
	skill_chemistry = JOB_SKILLPOINTS_EXPERT
	skill_research = 18

/datum/job/roboticist
	//INTJ, physically incapable but smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_TRAINED
	stat_int = JOB_STATPOINTS_EXPERT
	//Godlike electronics, expert research, trained surgery
	skill_research = JOB_SKILLPOINTS_EXPERT
	skill_surgery = JOB_SKILLPOINTS_TRAINED
	skill_electronics = 18

/datum/job/scientist
	//INTJ, physically incapable but smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_TRAINED
	stat_int = JOB_STATPOINTS_EXPERT
	//Godlike research, expert electronics
	skill_research = 18
	skill_electronics = JOB_SKILLPOINTS_EXPERT

/datum/job/officer
	//Better str and end, at the cost of int and dex
	stat_str = JOB_STATPOINTS_TRAINED
	stat_end = JOB_STATPOINTS_TRAINED
	stat_dex = 8
	stat_int = 8
	//Decent melee and ranged
	skill_melee = JOB_SKILLPOINTS_TRAINED
	skill_ranged = JOB_SKILLPOINTS_TRAINED

/datum/job/mining
	//Better str and end, at the cost of int and dex
	stat_str = JOB_STATPOINTS_TRAINED
	stat_end = 14
	stat_dex = 8
	stat_int = 8
	//Average melee and ranged
	skill_melee = JOB_SKILLPOINTS_AVERAGE
	skill_ranged = JOB_SKILLPOINTS_AVERAGE

/datum/job/engineer
	//Average stats all around, save for
	//extra endurance
	stat_end = JOB_STATPOINTS_TRAINED
	//Fantastic construction, trained electronics
	skill_construction = JOB_SKILLPOINTS_EXPERT
	skill_electronics = JOB_SKILLPOINTS_TRAINED

/datum/job/virologist
	//INTJ, physically incapable but smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_TRAINED
	stat_int = JOB_STATPOINTS_EXPERT
	//Expert research, good firstaid, novice surgery
	skill_research = JOB_SKILLPOINTS_EXPERT
	skill_firstaid = JOB_SKILLPOINTS_TRAINED
	skill_surgery = JOB_SKILLPOINTS_NOVICE

/datum/job/psychologist
	//INTJ, physically incapable but smort
	stat_str = 8
	stat_end = 8
	stat_dex = JOB_STATPOINTS_TRAINED
	stat_int = JOB_STATPOINTS_EXPERT
	//Expert research, good firstaid, novice surgery
	skill_research = JOB_SKILLPOINTS_EXPERT
	skill_firstaid = JOB_SKILLPOINTS_TRAINED
	skill_surgery = JOB_SKILLPOINTS_NOVICE

/datum/job/warden
	//Better str and end, at the cost of int
	stat_str = JOB_STATPOINTS_TRAINED
	stat_end = JOB_STATPOINTS_TRAINED
	stat_int = 8
	//Great melee, trained ranged
	skill_melee = JOB_SKILLPOINTS_EXPERT
	skill_ranged = JOB_SKILLPOINTS_TRAINED

/datum/job/blueshield
	//Better str and end, at the cost of int
	stat_str = JOB_STATPOINTS_TRAINED
	stat_end = JOB_STATPOINTS_TRAINED
	stat_int = 8
	//Decent melee and ranged
	skill_melee = JOB_SKILLPOINTS_TRAINED
	skill_ranged = JOB_SKILLPOINTS_TRAINED
