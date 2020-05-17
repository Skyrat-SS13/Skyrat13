/mob/living/simple_animal/hostile/megafauna/legion
	loot = list(/obj/item/stack/sheet/bone = 3)
	song = sound('modular_skyrat/sound/ambience/mastermind.ogg', 100) //Threading on some lines here.
	songlength = 3550

/mob/living/simple_animal/hostile/megafauna/legion/death()
	if(health > 0)
		return
	if(size > 1)
		adjustHealth(-maxHealth) //heal ourself to full in prep for splitting
		var/mob/living/simple_animal/hostile/megafauna/legion/L = new(loc)

		L.maxHealth = round(maxHealth * 0.6,DAMAGE_PRECISION)
		maxHealth = L.maxHealth

		L.health = L.maxHealth
		health = maxHealth

		size--
		L.size = size

		L.resize = L.size * 0.2
		transform = initial(transform)
		resize = size * 0.2

		L.update_transform()
		update_transform()

		L.faction = faction.Copy()

		L.GiveTarget(target)

		visible_message("<span class='boldannounce'>[src] splits in twain!</span>")
	else
		var/last_legion = TRUE
		for(var/mob/living/simple_animal/hostile/megafauna/legion/other in GLOB.mob_living_list)
			if(other != src)
				last_legion = FALSE
				break
		if(last_legion)
			loot = list(/obj/structure/closet/crate/necropolis/tendril/legion_loot)
			elimination = 0
		else if(prob(20))
			loot = list(/obj/structure/closet/crate/necropolis/tendril)
		..()
