/mob/living/simple_animal/hostile/asteroid/goliath
	glorymessageshand = list("punches violently into the goliath's skull, ripping out what could be described as their brain!", "rips off one of the goliath's tentacles bare-handed, then whips them with it until they die in humiliation!", "stomps their boot hard down on the goliath's jaw, ripping one of its fangs off with their hand and stabbing it in the eye")
	glorymessagespka = list("climbs on top of the goliath, then shoots their skull open in a violent blast with their pka!")
	glorymessagespkabayonet = list("stabs the goliath's eyes out with their bayonet, then sticks them into the beast's mouth!", "slices off many of the tentacles of the goliath with their bayonet, until it finally gives out!")
	glorymessagescrusher = list("crushers the face of the goliath in one swift move with their crusher!")

/mob/living/simple_animal/hostile/asteroid/goliath/AttackingTarget()
	. = ..()
	if(ranged_cooldown <= world.time)
		OpenFire(target)

/mob/living/simple_animal/hostile/asteroid/goliath/Scar()
	. = ..()
	ranged_cooldown_time *= 0.75
	minimum_distance = 5
	melee_damage_lower += 10
	melee_damage_upper += 10
