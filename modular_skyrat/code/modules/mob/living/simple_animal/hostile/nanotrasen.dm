/mob/living/simple_animal/hostile/nanotrasen
	speak_chance = 0
	faction = list(ROLE_DEATHSQUAD)
	check_friendly_fire = 1
	del_on_death = 1
	dodging = TRUE

/mob/living/simple_animal/hostile/nanotrasen/screaming
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"

/mob/living/simple_animal/hostile/nanotrasen/screaming/Aggro()
	..()
	summon_backup(15)
	say("411 in progress, requesting backup!")

/mob/living/simple_animal/hostile/nanotrasen/ranged
	loot = null

/mob/living/simple_animal/hostile/nanotrasen/ranged/smg
	loot = null