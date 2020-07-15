/mob/living/simple_animal/hostile/asteroid/basilisk/watcher
	glorymessageshand = list("rips out both of the watcher's wings and shoves them aside, then kicks the downed body until it turns into mush!", "violently rips off one of the watcher's spikes, then stabs them repeatedly with it!")
	glorymessagespka = list("bashes the shit out of the watcher with their PKA, gushing blood everywhere!", "shoots both of the watcher's wings off, then sticks their PKA on their face and shoots, showering everything in gore!")
	glorymessagespkabayonet = list("stabs the watcher's eye repeatedly, turning it into a bloody mess!", "slices one wing after another off the watcher, in swift moves!")
	glorymessagescrusher = list("repeatedly chops the watcher with their crusher, turning it into bloody mush!", "mark detonates the watcher in close proximity, showering viscera everywhere!", "flips their Crusher around, ramming the handle up the Watcher's eye, impaling it, before smashing it against the ground brutally!")

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/Scar()
	ranged_cooldown_time *= 0.75
	melee_damage_lower += 10
	melee_damage_upper += 10

/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/AttackingTarget()
	. = ..()
	if(ranged_cooldown <= world.time)
		OpenFire(target)
