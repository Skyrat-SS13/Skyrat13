/datum/round_event_control/bureaucratic_error
	name = "Bureaucratic Error"
	typepath = /datum/round_event/bureaucratic_error
	max_occurrences = 1
	weight = 5

/datum/round_event/bureaucratic_error
	announceWhen = 1

/datum/round_event/bureaucratic_error/announce(fake)
	priority_announce("A recent bureaucratic error in the Organic Resources Department may result in personnel shortages in some departments and redundant staffing in others.", "Paperwork Mishap Alert")

/datum/round_event/bureaucratic_error/start()
	//Skyrat edit -- start
	var/datum/job/random_job = SSjob.GetJob(pick(get_all_jobs() - "Assistant"))
	var/cap = rand(10,15)
	random_job.spawn_positions = cap
	random_job.total_positions = cap
	//Skyrat edit -- end
