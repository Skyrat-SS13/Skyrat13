//THE GLADIATOR
//Will write a description later lole
/mob/living/simple_animal/hostile/megafauna/gladiator
	name = "\proper The Gladiator"
	desc = "An immortal ash walker, whose powers have been granted by the necropolis itself."
	icon = 'modular_skyrat/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "gladiator1"
	attacktext = "slashes"
	attack_sound = 'sound/weapons/slice.ogg'
	death_sound = 'modular_skyrat/sound/effects/gladiatordeathsound.ogg'
	deathmessage = "gets discombobulated and fucking dies."
	rapid_melee = 4
	armour_penetration = 20
	speed = 1
	move_to_delay = 4
	var/block_chance = 50
	ranged = 1
	ranged_cooldown_time = 30
	health = 1500
	maxHealth = 1500
	var/phase = 1

/obj/item/gps/internal/gladiator
	icon_state = null 
	gpstag = "Dreadful Signal"
	desc = "Let me help you to see, miner."

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/introduction(mob/living/target)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target 
		var/datum/species/Hspecies = H.dna.species
		if(Hspecies.id = "ashlizard")
			say("Walker.")
		else
			var/list/messages = list("What you interfere with now isss bigger than you can imagine... If you continue, you'll bring down the necropolisss' wrath.",\
									"You cannot kill the Legion, miner.",\
									"Retreat, outlander.",\
									)
			say(pick(messages))
	else 
		say("You are not welcome into the necropolisss.")

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/update_rage()
	var/healthpercentage = 100 * (health/maxHealth)
	switch(healthpercentage)
		if(65 to 100)
			phase = 1
		if(30 to 65)
			phase = 2
		if(0 to 30)
			phase = 3
