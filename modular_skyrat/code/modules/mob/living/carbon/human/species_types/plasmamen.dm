/datum/species/plasmaman/before_equip_job(datum/job/J, mob/living/carbon/human/H, visualsOnly = FALSE)
	var/current_job = J?.title
	var/datum/outfit/plasmaman/O = new /datum/outfit/plasmaman
	switch(current_job)
		if("Chaplain")
			O = new /datum/outfit/plasmaman/chaplain

		if("Curator")
			O = new /datum/outfit/plasmaman/curator

		if("Janitor")
			O = new /datum/outfit/plasmaman/janitor

		if("Botanist")
			O = new /datum/outfit/plasmaman/botany

		if("Bartender", "Lawyer")
			O = new /datum/outfit/plasmaman/bar

		if("Cook")
			O = new /datum/outfit/plasmaman/chef

		if("Prisoner")
			O = new /datum/outfit/plasmaman/prisoner

		if("Security Officer")
			O = new /datum/outfit/plasmaman/security

		if("Detective")
			O = new /datum/outfit/plasmaman/detective

		if("Warden")
			O = new /datum/outfit/plasmaman/warden

		if("Brig Physician")
			O = new /datum/outfit/plasmaman/brigphys

		if("Cargo Technician", "Quartermaster")
			O = new /datum/outfit/plasmaman/cargo

		if("Shaft Miner")
			O = new /datum/outfit/plasmaman/mining

		if("Medical Doctor")
			O = new /datum/outfit/plasmaman/medical

		if("Chemist")
			O = new /datum/outfit/plasmaman/chemist

		if("Geneticist")
			O = new /datum/outfit/plasmaman/genetics

		if("Roboticist")
			O = new /datum/outfit/plasmaman/robotics

		if("Virologist")
			O = new /datum/outfit/plasmaman/viro

		if("Scientist")
			O = new /datum/outfit/plasmaman/science

		if("Station Engineer")
			O = new /datum/outfit/plasmaman/engineering

		if("Atmospheric Technician")
			O = new /datum/outfit/plasmaman/atmospherics

		if("Captain")
			O = new /datum/outfit/plasmaman/captain

		if("Head of Personnel")
			O = new /datum/outfit/plasmaman/hop

		if("Head of Security")
			O = new /datum/outfit/plasmaman/hos

		if("Chief Engineer")
			O = new /datum/outfit/plasmaman/ce

		if("Chief Medical Officer")
			O = new /datum/outfit/plasmaman/cmo

		if("Research Director")
			O = new /datum/outfit/plasmaman/rd

		if("Mime")
			O = new /datum/outfit/plasmaman/mime

		if("Clown")
			O = new /datum/outfit/plasmaman/clown

		if("Blueshield")
			O = new /datum/outfit/plasmaman/blueshield

	H.equipOutfit(O, visualsOnly)
	H.internal = H.get_item_for_held_index(2)
	H.update_internals_hud_icon(1)
	return 0