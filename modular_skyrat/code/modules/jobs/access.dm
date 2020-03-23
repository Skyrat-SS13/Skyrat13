/proc/get_all_jobs()
	return list("Assistant", "Captain", "Head of Personnel", "Bartender", "Cook", "Botanist", "Quartermaster", "Cargo Technician",
				"Shaft Miner", "Clown", "Mime", "Janitor", "Curator", "Lawyer", "Chaplain", "Chief Engineer", "Station Engineer",
				"Atmospheric Technician", "Chief Medical Officer", "Medical Doctor", "Chemist", "Geneticist", "Virologist", "Paramedic",
				"Research Director", "Scientist", "Roboticist", "Head of Security", "Warden", "Detective", "Security Officer","Prisoner", "Brig Physician")

/proc/get_modular_jobs()
	return list("Brig Physician")

/proc/get_modular_job_icons() //For all existing HUD icons
	return get_modular_jobs()

/obj/item/proc/GetModularJobName() //Used in secHUD icon generation
	var/obj/item/card/id/I = GetID()
	if(!I)
		return
	var/jobName = I.assignment
	if(jobName in get_modular_job_icons()) //Check if the job has a hud icon
		return jobName
	return "Unknown" //Return unknown if none of the above apply