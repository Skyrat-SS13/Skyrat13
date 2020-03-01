/mob/living/simple_animal/hostile/megafauna/legion
	loot = list(/obj/item/stack/sheet/bone = 3, /obj/item/crusher_trophy/legion_shard, /obj/item/borg/upgrade/modkit/skull)

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
			loot = list(/obj/item/staff/storm, /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor)
			elimination = 0
		else if(prob(20))
			loot = list(/obj/structure/closet/crate/necropolis/tendril)
		..()

/obj/item/clothing/suit/space/hardsuit/deathsquad/praetor
	name = "Praetor Suit"
	desc = "And those that tasted the bite of his sword named him... The Doom Slayer."
	armor = list("melee" = 75, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	icon_state = "praetor"
	alternate_worn_icon = 'modular_skyrat/icons/mob/suit.dmi'
	item_state = "praetor"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/deathsquad/praetor
	slowdown = 0

/obj/item/clothing/head/helmet/space/hardsuit/deathsquad/praetor
	name = "Praetor Suit helmet"
	desc = "That's one doomed space marine."
	armor = list("melee" = 75, "bullet" = 55, "laser" = 55, "energy" = 45, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	icon_state = "praetor"
	alternate_worn_icon = 'modular_skyrat/icons/mob/head.dmi'
	item_state = "praetor"