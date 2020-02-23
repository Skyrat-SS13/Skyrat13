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

/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
	var/random_crystal = pick(choices)
	new random_crystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/borg/upgrade/modkit/bolter(src)

//normal chests
//who the fuck coded the original? using a switch for this is cringe bro

/obj/structure/closet/crate/necropolis/tendril
	var/list/loot_pool = list(/obj/item/shared_storage/red,
							/obj/item/clothing/suit/space/hardsuit/cult,
							/obj/item/soulstone/anybody,
							/obj/item/katana/cursed,
							/obj/item/katana/necropolis,
							/obj/item/clothing/glasses/godeye,
							/obj/item/reagent_containers/glass/bottle/potion/flight,
							/obj/item/pickaxe/diamond,
							/obj/item/disk/design_disk/modkit_disc/resonator_blast,
							/obj/item/disk/design_disk/modkit_disc/rapid_repeater,
							/obj/item/rod_of_asclepius,
							/obj/item/organ/heart/cursed/wizard,
							/obj/item/ship_in_a_bottle,
							list(/obj/item/reagent_containers/food/drinks/bottle/holywater/hell, /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor),
							/obj/item/jacobs_ladder,
							/obj/item/nullrod/scythe/talking,
							/obj/item/nullrod/armblade,
							/obj/item/guardiancreator,
							/obj/item/disk/design_disk/modkit_disc/mob_and_turf_aoe,
							/obj/item/disk/design_disk/modkit_disc/bounty,
							/obj/item/warp_cube/red,
							/obj/item/wisp_lantern,
							/obj/item/immortality_talisman,
							/obj/item/gun/magic/hook,
							/obj/item/voodoo,
							/obj/item/grenade/clusterbuster/inferno,
							/obj/item/book/granter/spell/summonitem,
							/obj/item/book_of_babel,
							list(/obj/item/borg/upgrade/modkit/lifesteal, /obj/item/bedsheet/cult),
							/obj/item/clothing/neck/necklace/memento_mori,
							/obj/item/gun/ballistic/shotgun/boltaction/enchanted,
							/obj/item/gun/magic/staff/door,
							/obj/item/storage/belt/sabre)

/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = pick(src.loot_pool)
	if(islist(loot))
		for(var/obj/item/I in loot)
			new I(src)
	else
		new loot(src)

/obj/item/katana/necropolis
	force = 30 //Wouldn't want a miner walking around with a 40 damage melee around now, would we?