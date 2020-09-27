//Assigns points properly to each job datum
/datum/job
	//How many stat points this will allow you to dump
	var/available_stat_points = JOB_STATPOINTS_WORTHLESS
	//How many skill points this will allow you to dump
	var/available_skill_points = JOB_SKILLPOINTS_WORTHLESS
	//The default skillset for a given job - Keep null if there is none, associative list otherwise
	var/list/default_skillset = null
	//The default statset for a given job - Keep null if there is none, associative list otherwise
	var/list/default_statset = null

//Handles post-spawn skill and stat gains
/datum/job/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source)
	. = ..()
	if(H.mind)
		H.mind.available_skill_points += available_skill_points
		H.mind.available_stat_points += available_stat_points

//Point value assignment
/datum/job/assistant
	//Very unskilled, sucks at everything
	available_skill_points = JOB_SKILLPOINTS_WORTHLESS
	//They have *potential* though
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/atmos
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/bartender
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Novice stats
	available_stat_points = JOB_STATPOINTS_NOVICE

/datum/job/hydro
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Novice stats
	available_stat_points = JOB_STATPOINTS_NOVICE

/datum/job/captain
	//Legendary training
	available_skill_points = JOB_SKILLPOINTS_LEGENDARY
	//Expert stats
	available_stat_points = JOB_STATPOINTS_EXPERT

/datum/job/cargo_tech
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Novice stats
	available_stat_points = JOB_STATPOINTS_NOVICE

/datum/job/chaplain
	//Poorly trained
	available_skill_points = JOB_SKILLPOINTS_NOVICE
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/chemist
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/chief_engineer
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/cmo
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/clown
	//Absolutely awfully untrained
	available_skill_points = JOB_SKILLPOINTS_HORRENDOUS
	//They are "gifted", though
	available_stat_points = JOB_STATPOINTS_LEGENDARY

/datum/job/cook
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Novice stats
	available_stat_points = JOB_STATPOINTS_NOVICE

/datum/job/curator
	//Very well trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//But also not physically capable
	available_stat_points = JOB_STATPOINTS_WORTHLESS

/datum/job/detective
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/geneticist
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/hop
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/hos
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Very robust
	available_stat_points = JOB_STATPOINTS_LEGENDARY

/datum/job/janitor
	//Very badly trained
	available_skill_points = JOB_SKILLPOINTS_WORTHLESS
	//They are somewhat "gifted", though
	available_stat_points = JOB_STATPOINTS_EXPERT

/datum/job/lawyer
	//Very unskilled
	available_skill_points = JOB_SKILLPOINTS_NOVICE
	//Below average stats
	available_stat_points = JOB_STATPOINTS_NOVICE

/datum/job/doctor
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/mime
	//Absolutely awfully untrained
	available_skill_points = JOB_SKILLPOINTS_HORRENDOUS
	//They are "gifted", though
	available_stat_points = JOB_STATPOINTS_LEGENDARY

/datum/job/paramedic
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Physically capable
	available_stat_points = JOB_STATPOINTS_EXPERT

/datum/job/qm
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/rd
	//Legendarily trained
	available_skill_points = JOB_SKILLPOINTS_LEGENDARY
	//Average stats
	available_stat_points = JOB_STATPOINTS_NOVICE

/datum/job/roboticist
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/scientist
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/officer
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/mining
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/engineer
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/virologist
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/psychologist
	//Well trained
	available_skill_points = JOB_SKILLPOINTS_TRAINED
	//Well rounded
	available_stat_points = JOB_STATPOINTS_TRAINED

/datum/job/warden
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Physically capable
	available_stat_points = JOB_STATPOINTS_EXPERT

/datum/job/blueshield
	//Expertly trained
	available_skill_points = JOB_SKILLPOINTS_EXPERT
	//Physically capable
	available_stat_points = JOB_STATPOINTS_EXPERT
