//boss chests
/obj/structure/closet/crate/necropolis/bubblegum/PopulateContents()
	new /obj/item/clothing/suit/space/hostile_environment(src)
	new /obj/item/clothing/head/helmet/space/hostile_environment(src)
	new /obj/item/borg/upgrade/modkit/shotgun(src)
	var/loot = rand(1,3)
	switch(loot)
		if(1)
			new /obj/item/mayhem(src)
		if(2)
			new /obj/item/blood_contract(src)
		if(3)
			new /obj/item/gun/magic/staff/spellblade(src)

/mob/living/simple_animal/hostile/megafauna/bubblegum/hard
	name = "enraged bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor(src)
	new /obj/item/borg/upgrade/modkit/shotgun(src)
	new /obj/item/mayhem(src)
	new /obj/item/blood_contract(src)
	new /obj/item/gun/magic/staff/spellblade(src)

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher
	name = "enraged bloody bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/demon_claws(src)

/obj/structure/closet/crate/necropolis/dragon/PopulateContents()
	new /obj/item/borg/upgrade/modkit/knockback(src)
	var/loot = rand(1,4)
	switch(loot)
		if(1)
			new /obj/item/melee/ghost_sword(src)
		if(2)
			new /obj/item/lava_staff(src)
		if(3)
			new /obj/item/book/granter/spell/sacredflame(src)
			new /obj/item/gun/magic/wand/fireball(src)
		if(4)
			new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/hard
	name = "enraged dragon chest"

/obj/structure/closet/crate/necropolis/dragon/hard/PopulateContents()
	new /obj/item/borg/upgrade/modkit/knockback(src)
	new /obj/item/melee/ghost_sword(src)
	new /obj/item/lava_staff(src)
	new /obj/item/book/granter/spell/sacredflame(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/dragons_blood(src)

/obj/structure/closet/crate/necropolis/dragon/hard/crusher
	name = "enraged fiery dragon chest"

/obj/structure/closet/crate/necropolis/dragon/hard/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/tail_spike(src)

/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
	var/random_crystal = pick(choices)
	new random_crystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/borg/upgrade/modkit/bolter(src)

//normal chests
/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = rand(1,28)
	switch(loot)
		if(1)
			new /obj/item/shared_storage/red(src)
			return /obj/item/shared_storage/red
		if(2)
			new /obj/item/clothing/suit/space/hardsuit/cult(src)
			return /obj/item/clothing/suit/space/hardsuit/cult
		if(3)
			new /obj/item/soulstone/anybody(src)
			return /obj/item/soulstone/anybody
		if(4)
			new /obj/item/katana/cursed(src)
			return /obj/item/katana/cursed
		if(5)
			new /obj/item/clothing/glasses/godeye(src)
			return /obj/item/clothing/glasses/godeye
		if(6)
			new /obj/item/reagent_containers/glass/bottle/potion/flight(src)
			return /obj/item/reagent_containers/glass/bottle/potion/flight
		if(7)
			new /obj/item/pickaxe/diamond(src)
			return /obj/item/pickaxe/diamond
		if(8)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/resonator_blast(src)
				return /obj/item/disk/design_disk/modkit_disc/resonator_blast
			else
				new /obj/item/disk/design_disk/modkit_disc/rapid_repeater(src)
				return /obj/item/disk/design_disk/modkit_disc/rapid_repeater
		if(9)
			new /obj/item/rod_of_asclepius(src)
			return /obj/item/rod_of_asclepius
		if(10)
			new /obj/item/organ/heart/cursed/wizard(src)
			return /obj/item/organ/heart/cursed/wizard
		if(11)
			new /obj/item/ship_in_a_bottle(src)
			return /obj/item/ship_in_a_bottle
		if(12)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker(src)
			return /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker
		if(13)
			new /obj/item/jacobs_ladder(src)
			return /obj/item/jacobs_ladder
		if(14)
			new /obj/item/nullrod/scythe/talking(src)
			return /obj/item/nullrod/scythe/talking
		if(15)
			new /obj/item/nullrod/armblade(src)
			return /obj/item/nullrod/armblade
		if(16)
			new /obj/item/guardiancreator(src)
			return /obj/item/guardiancreator
		if(17)
			if(prob(50))
				new /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe(src)
				return /obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe
			else
				new /obj/item/disk/design_disk/modkit_disc/bounty(src)
				return /obj/item/disk/design_disk/modkit_disc/bounty
		if(18)
			new /obj/item/warp_cube/red(src)
			return /obj/item/warp_cube/red
		if(19)
			new /obj/item/wisp_lantern(src)
			return /obj/item/wisp_lantern
		if(20)
			new /obj/item/immortality_talisman(src)
			return /obj/item/immortality_talisman
		if(21)
			new /obj/item/gun/magic/hook(src)
			return /obj/item/gun/magic/hook
		if(22)
			new /obj/item/voodoo(src)
			return /obj/item/voodoo
		if(23)
			new /obj/item/grenade/clusterbuster/inferno(src)
			return /obj/item/grenade/clusterbuster/inferno
		if(24)
			new /obj/item/reagent_containers/food/drinks/bottle/holywater/hell(src)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor(src)
			return /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor
		if(25)
			new /obj/item/book/granter/spell/summonitem(src)
			return /obj/item/book/granter/spell/summonitem
		if(26)
			new /obj/item/book_of_babel(src)
			return /obj/item/book_of_babel
		if(27)
			new /obj/item/borg/upgrade/modkit/lifesteal(src)
			new /obj/item/bedsheet/cult(src)
			return /obj/item/borg/upgrade/modkit/lifesteal
		if(28)
			new /obj/item/clothing/neck/necklace/memento_mori(src)
			return /obj/item/clothing/neck/necklace/memento_mori
		if(29)
			new /obj/item/gun/ballistic/shotgun/boltaction/enchanted(src)
			return /obj/item/gun/ballistic/shotgun/boltaction/enchanted
		if(30)
			new /obj/item/gun/magic/staff/door(src)
			return /obj/item/gun/magic/staff/door
		if(31)
			new /obj/item/katana/necropolis(src)
			return /obj/item/katana/necropolis

/obj/item/katana/necropolis
	force = 30 //Wouldn't want a miner walking around with a 40 damage melee around now, would we?

//legion
/obj/structure/closet/crate/necropolis/legion
	name = "echoing crate"

/obj/structure/closet/crate/necropolis/legion/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/clothing/suit/space/hardsuit/deathsquad/praetor(src)

/obj/structure/closet/crate/necropolis/legion/hard
	name = "enraged echoing crate"

/obj/structure/closet/crate/necropolis/legion/hard/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/staff/storm(src)
	new /obj/item/staff/storm(src)
	var/obj/structure/closet/crate/necropolis/tendril/T = new /obj/structure/closet/crate/necropolis/tendril //Yup, i know, VERY spaghetti code.
	var/obj/item/L
	for(var/i = 0, i < 5, i++)
		L = T.PopulateContents()
		new L(src)
	qdel(T)