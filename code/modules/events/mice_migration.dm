/datum/round_event_control/mice_migration
	name = "Mice Migration"
	typepath = /datum/round_event/mice_migration
	weight = 10

/datum/round_event/mice_migration
	var/minimum_mice = 5
	var/maximum_mice = 15

/datum/round_event/mice_migration/announce(fake)
	var/plural = pick("a number of", "a horde of", "a pack of", "a swarm of",
		"not more than [maximum_mice]")
	var/name = pick("rodents", "mice")
	var/movement = pick("migrated", "swarmed", "descended")
	var/location = pick("maintenance tunnels", "maintenance areas")
	if(prob(50))
		priority_announce("Bioscans indicate that [plural] [name] have [movement] \
		into [location].", "Migration Alert",
		'sound/effects/mousesqueek.ogg')
	else
		print_command_report("Bioscans indicate that [plural] [name] have [movement] into [location].", "Rodent Migration")

/datum/round_event/mice_migration/start()
	SSminor_mapping.trigger_migration(rand(minimum_mice, maximum_mice))
