//boss chests
//bubblegum
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
	new /obj/item/twohanded/crucible(src)
	new /obj/item/gun/ballistic/revolver/doublebarrel/super(src)

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher
	name = "enraged bloody bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/hard/crusher/PopulateContents()
	..()
	new /obj/item/crusher_trophy/demon_claws(src)

//super shotty changes (meat hook instead of bursto)

/obj/item/gun/ballistic/revolver/doublebarrel/super
	burst_size = 1
	actions_types = list(/datum/action/item_action/toggle_hook)
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "heckgun"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	item_state = "heckgun"
	sharpness = IS_SHARP
	force = 15
	var/recharge_rate = 4
	var/charge_tick = 0
	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/gun/ballistic/revolver/doublebarrel/super/Initialize()
	. = ..()
	if(!alternate_magazine)
		alternate_magazine = new /obj/item/ammo_box/magazine/internal/shot/dual/heck/hook(src)
	START_PROCESSING(SSobj, src)

/obj/item/gun/ballistic/revolver/doublebarrel/super/attack_self(mob/living/user)
	if(toggled)
		return 0
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel/super/process()
	if(toggled)
		charge_tick++
		if(charge_tick < recharge_rate)
			return 0
		charge_tick = 0
		chambered.newshot()
		return 1
	else
		..()

/obj/item/ammo_box/magazine/internal/shot/dual/heck/hook
	name = "hookshot internal magazine"
	max_ammo = 1
	ammo_type = /obj/item/ammo_casing/magic/hook/heck

/obj/item/ammo_casing/magic/hook/heck
	projectile_type = /obj/item/projectile/heckhook

/obj/item/projectile/heckhook //had to create a separate, non-child projectile because otherwise there would be conflicts when calling parent procs.
	name = "hook"
	icon_state = "hook"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	pass_flags = PASSTABLE
	damage = 10
	armour_penetration = 100
	damage_type = BRUTE
	hitsound = 'sound/effects/splat.ogg'
	knockdown = 0
	var/chain

/obj/item/projectile/heckhook/fire(setAngle)
	if(firer)
		chain = firer.Beam(src, icon_state = "chain", time = INFINITY, maxdistance = INFINITY)
	..()

/obj/item/projectile/heckhook/on_hit(atom/target)
	. = ..()
	if(ismovableatom(target))
		var/atom/movable/A = target
		if(A.anchored)
			return
		A.visible_message("<span class='danger'>[A] is snagged by [firer]'s hook!</span>")
		new /datum/forced_movement(firer, get_turf(A), 5, TRUE)

/obj/item/projectile/heckhook/Destroy()
	qdel(chain)
	return ..()

/datum/action/item_action/toggle_hook
	name = "Toggle Hook"

/obj/item/gun/ballistic/revolver/doublebarrel/super/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_hook))
		toggle_hook(user)
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel/super/proc/toggle_hook(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "You will now fire a hookshot.")
	else
		to_chat(user, "You will now fire normal shotgun rounds.")

//crucible
/obj/item/twohanded/crucible
	name = "Crucible Sword"
	desc = "Made from pure argent energy, this sword can cut through flesh like butter."
	icon = 'modular_skyrat/icons/obj/1x2.dmi'
	icon_state = "crucible0"
	var/icon_state_on = "crucible1"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/swords_righthand.dmi'
	item_state = "crucible0"
	var/item_state_on = "crucible1"
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	var/w_class_on = WEIGHT_CLASS_HUGE
	force_unwielded = 5
	force_wielded = 25
	wieldsound = 'sound/weapons/saberon.ogg'
	unwieldsound = 'sound/weapons/saberoff.ogg'
	hitsound = "swing_hit"
	var/hitsound_on = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 50
	light_color = "#ff0000"//BLOOD RED
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	block_chance = 0
	var/block_chance_on = 50
	max_integrity = 400
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF
	var/brightness_on = 6
	total_mass = 1
	var/total_mass_on = TOTAL_MASS_MEDIEVAL_WEAPON
	/*
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	*/

/obj/item/twohanded/crucible/suicide_act(mob/living/carbon/user)
	if(wielded)
		user.visible_message("<span class='suicide'>[user] DOOMs themselves with the [src]!</span>")

		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)//stole from chainsaw code
		var/obj/item/organ/brain/B = user.getorganslot(ORGAN_SLOT_BRAIN)
		B.organ_flags &= ~ORGAN_VITAL	//this cant possibly be a good idea
		var/randdir
		for(var/i in 1 to 24)//like a headless chicken!
			if(user.is_holding(src))
				randdir = pick(GLOB.alldirs)
				user.Move(get_step(user, randdir),randdir)
				user.emote("spin")
				if (i == 3 && myhead)
					myhead.drop_limb()
				sleep(3)
			else
				user.visible_message("<span class='suicide'>[user] panics and starts choking to death!</span>")
				return OXYLOSS


	else
		user.visible_message("<span class='suicide'>[user] begins beating [user.p_them()]self to death with \the [src]'s handle! It probably would've been cooler if [user.p_they()] turned it on first!</span>")
	return BRUTELOSS

/obj/item/twohanded/crucible/update_icon_state()
	if(wielded)
		icon_state = "crucible[wielded]"
	else
		icon_state = "crucible0"
	clean_blood()

/obj/item/twohanded/crucible/attack(mob/target, mob/living/carbon/human/user)
	var/def_zone = user.zone_selected
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.getarmor(def_zone, "melee") < 35)
			if((user.zone_selected != BODY_ZONE_CHEST) && (user.zone_selected != BODY_ZONE_HEAD))
				..()
				var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
				bodyp.dismember()
			else
				..()
		else if(user.zone_selected == BODY_ZONE_CHEST && H.health <= 0)
			..()
			H.spill_organs()
		else if(user.zone_selected == BODY_ZONE_HEAD && H.health <= 0)
			..()
			var/obj/item/bodypart/bodyp= H.get_bodypart(def_zone)
			bodyp.drop_limb()
		else
			..()
	else
		..()

/obj/item/twohanded/crucible/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(wielded)
		return ..()
	return 0

/obj/item/twohanded/crucible/wield(mob/living/carbon/M)
	..()
	if(wielded)
		sharpness = IS_SHARP
		w_class = w_class_on
		total_mass = total_mass_on
		hitsound = hitsound_on
		item_state = item_state_on
		block_chance = block_chance_on
		START_PROCESSING(SSobj, src)
		set_light(brightness_on)
		AddElement(/datum/element/sword_point)

/obj/item/twohanded/crucible/unwield()
	sharpness = initial(sharpness)
	w_class = initial(w_class)
	total_mass = initial(total_mass)
	..()
	hitsound = "swing_hit"
	block_chance = initial(block_chance)
	item_state = initial(item_state)
	STOP_PROCESSING(SSobj, src)
	set_light(0)
	RemoveElement(/datum/element/sword_point)

/obj/item/twohanded/crucible/process()
	if(wielded)
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/twohanded/crucible/IsReflect()
	if(wielded)
		return 1

/obj/item/twohanded/crucible/ignition_effect(atom/A, mob/user)
	if(!wielded)
		return ""
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [user.p_their()] nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)

//drake
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

//colossus
/obj/structure/closet/crate/necropolis/colossus/PopulateContents()
	var/list/choices = subtypesof(/obj/machinery/anomalous_crystal)
	var/random_crystal = pick(choices)
	new random_crystal(src)
	new /obj/item/organ/vocal_cords/colossus(src)
	new /obj/item/borg/upgrade/modkit/bolter(src)

//normal chests
/obj/structure/closet/crate/necropolis/tendril/PopulateContents()
	var/loot = rand(1,31)
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
	new /obj/item/stock_parts/cell/high/plus/argent(src)

/obj/item/stock_parts/cell/high/plus/argent
	name = "Argent Energy Cell"
	desc = "Harvested from the necropolis, this autocharging energy cell can be crushed to provide a temporary 90% damage reduction bonus. Also useful for research."
	self_recharge = 1
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "argentcell"
	ratingdesc = FALSE
	rating = 6
	custom_materials = list(/datum/material/glass=500, /datum/material/uranium=250, /datum/material/plasma=1000, /datum/material/diamond=500)
	var/datum/status_effect/onuse = /datum/status_effect/blooddrunk/argent

/obj/item/stock_parts/cell/high/plus/argent/attack_self(mob/user)
	..()
	user.visible_message("<span class='danger'>[user] crushes the [src] in his hands, absorbing it's energy!</span>")
	playsound(user.loc, 'sound/effects/hit_on_shattered_glass.ogg', 100, TRUE)
	user.apply_status_effect(onuse)
	qdel(src)

/obj/item/stock_parts/cell/high/plus/argent/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF)

/datum/controller/subsystem/research // i just cant be bothered to change it somewhere else
	list/techweb_point_items = list(		//path = list(point type = value)
	/obj/item/stock_parts/cell/high/plus/argent = list(TECHWEB_POINT_TYPE_GENERIC = 10000),
	/obj/item/assembly/signaler/anomaly            = list(TECHWEB_POINT_TYPE_GENERIC = 10000),
	/obj/item/slime_extract/grey                   = list(TECHWEB_POINT_TYPE_GENERIC = 500),
	/obj/item/slime_extract/metal                  = list(TECHWEB_POINT_TYPE_GENERIC = 750),
	/obj/item/slime_extract/purple                 = list(TECHWEB_POINT_TYPE_GENERIC = 750),
	/obj/item/slime_extract/orange                 = list(TECHWEB_POINT_TYPE_GENERIC = 750),
	/obj/item/slime_extract/blue                   = list(TECHWEB_POINT_TYPE_GENERIC = 750),
	/obj/item/slime_extract/yellow                 = list(TECHWEB_POINT_TYPE_GENERIC = 1000),
	/obj/item/slime_extract/silver                 = list(TECHWEB_POINT_TYPE_GENERIC = 1000),
	/obj/item/slime_extract/darkblue               = list(TECHWEB_POINT_TYPE_GENERIC = 1000),
	/obj/item/slime_extract/darkpurple             = list(TECHWEB_POINT_TYPE_GENERIC = 1000),
	/obj/item/slime_extract/bluespace              = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/sepia                  = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/cerulean               = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/pyrite                 = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/red                    = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/green                  = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/pink                   = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/gold                   = list(TECHWEB_POINT_TYPE_GENERIC = 1250),
	/obj/item/slime_extract/black                  = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slime_extract/adamantine             = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slime_extract/oil                    = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slime_extract/lightpink              = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slime_extract/rainbow                = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
		//  Reproductive -    Crossbreading Cores!    - (Grey Cores)
	/obj/item/slimecross/reproductive/grey         = list(TECHWEB_POINT_TYPE_GENERIC = 1000),
	/obj/item/slimecross/reproductive/orange       = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slimecross/reproductive/purple       = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slimecross/reproductive/blue         = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slimecross/reproductive/metal        = list(TECHWEB_POINT_TYPE_GENERIC = 1500),
	/obj/item/slimecross/reproductive/yellow       = list(TECHWEB_POINT_TYPE_GENERIC = 1750),
	/obj/item/slimecross/reproductive/darkpurple   = list(TECHWEB_POINT_TYPE_GENERIC = 1750),
	/obj/item/slimecross/reproductive/darkblue     = list(TECHWEB_POINT_TYPE_GENERIC = 1750),
	/obj/item/slimecross/reproductive/silver       = list(TECHWEB_POINT_TYPE_GENERIC = 1750),
	/obj/item/slimecross/reproductive/bluespace    = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/reproductive/sepia        = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/reproductive/cerulean     = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/reproductive/pyrite       = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/reproductive/red          = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/reproductive/green        = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/reproductive/pink         = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/reproductive/gold         = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/reproductive/oil          = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/reproductive/black        = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/reproductive/lightpink    = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/reproductive/adamantine   = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/reproductive/rainbow      = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	//  Burning -    Crossbreading Cores!    - (Orange Cores)
	/obj/item/slimecross/burning/grey              = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/burning/orange            = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/burning/purple            = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/burning/blue              = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/burning/metal             = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/burning/yellow            = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/burning/darkpurple        = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/burning/darkblue          = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/burning/silver            = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/burning/bluespace         = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/burning/sepia             = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/burning/cerulean          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/burning/pyrite            = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/burning/red               = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/burning/green             = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/burning/pink              = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/burning/gold              = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/burning/oil               = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/burning/black             = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/burning/lightpink         = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/burning/adamantine        = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/burning/rainbow           = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
		//  Regenerative -    Crossbreading Cores!    - (Purple Cores)
	/obj/item/slimecross/regenerative/grey         = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/regenerative/orange       = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/regenerative/purple       = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/regenerative/blue         = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/regenerative/metal        = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/regenerative/yellow       = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/regenerative/darkpurple   = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/regenerative/darkblue     = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/regenerative/silver       = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/regenerative/bluespace    = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/regenerative/sepia        = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/regenerative/cerulean     = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/regenerative/pyrite       = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/regenerative/red          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/regenerative/green        = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/regenerative/pink         = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/regenerative/gold         = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/regenerative/oil          = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/regenerative/black        = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/regenerative/lightpink    = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/regenerative/adamantine   = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/regenerative/rainbow      = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
		//  Stabilized -    Crossbreading Cores!    - (Blue Cores)
	/obj/item/slimecross/stabilized/grey           = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/stabilized/orange         = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/stabilized/purple         = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/stabilized/blue           = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/stabilized/metal          = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/stabilized/yellow         = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/stabilized/darkpurple     = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/stabilized/darkblue       = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/stabilized/silver         = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/stabilized/bluespace      = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/stabilized/sepia          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/stabilized/cerulean       = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/stabilized/pyrite         = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/stabilized/red            = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/stabilized/green          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/stabilized/pink           = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/stabilized/gold           = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/stabilized/oil            = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/stabilized/black          = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/stabilized/lightpink      = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/stabilized/adamantine     = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/stabilized/rainbow        = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
		//  Industrial -    Crossbreading Cores!    - (Metal Cores)
	/obj/item/slimecross/industrial/grey           = list(TECHWEB_POINT_TYPE_GENERIC = 2000),
	/obj/item/slimecross/industrial/orange         = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/industrial/purple         = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/industrial/blue           = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/industrial/metal          = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/industrial/yellow         = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/industrial/darkpurple     = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/industrial/darkblue       = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/industrial/silver         = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/industrial/bluespace      = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/industrial/sepia          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/industrial/cerulean       = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/industrial/pyrite         = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/industrial/red            = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/industrial/green          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/industrial/pink           = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/industrial/gold           = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/industrial/oil            = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/industrial/black          = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/industrial/lightpink      = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/industrial/adamantine     = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/industrial/rainbow        = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
		//  Charged -    Crossbreading Cores!    - (Yellow Cores)
	/obj/item/slimecross/charged/grey              = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/charged/orange            = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/charged/purple            = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/charged/blue              = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/charged/metal             = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/charged/yellow            = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/charged/darkpurple        = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/charged/darkblue          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/charged/silver            = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/charged/bluespace         = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/charged/sepia             = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/charged/cerulean          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/charged/pyrite            = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/charged/red               = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/charged/green             = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/charged/pink              = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/charged/gold              = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/charged/oil               = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/charged/black             = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/charged/lightpink         = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/charged/adamantine        = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/charged/rainbow           = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
			//  Selfsustaining -    Crossbreading Cores!    - (Dark Purple Cores)
	/obj/item/slimecross/selfsustaining/grey       = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/selfsustaining/orange     = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/selfsustaining/purple     = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/selfsustaining/blue       = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/selfsustaining/metal      = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/selfsustaining/yellow     = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/selfsustaining/darkpurple = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/selfsustaining/darkblue   = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/selfsustaining/silver     = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/selfsustaining/bluespace  = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/selfsustaining/sepia      = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/selfsustaining/cerulean   = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/selfsustaining/pyrite     = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/selfsustaining/red        = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/selfsustaining/green      = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/selfsustaining/pink       = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/selfsustaining/gold       = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/selfsustaining/oil        = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/selfsustaining/black      = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/selfsustaining/lightpink  = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/selfsustaining/adamantine = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/selfsustaining/rainbow    = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
			//  Consuming -    Crossbreading Cores!    - (Sliver Cores)
	/obj/item/slimecross/consuming/grey            = list(TECHWEB_POINT_TYPE_GENERIC = 2250),
	/obj/item/slimecross/consuming/orange          = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/consuming/purple          = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/consuming/blue            = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/consuming/metal           = list(TECHWEB_POINT_TYPE_GENERIC = 2750),
	/obj/item/slimecross/consuming/yellow          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/consuming/darkpurple      = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/consuming/darkblue        = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/consuming/silver          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/consuming/bluespace       = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/consuming/sepia           = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/consuming/cerulean        = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/consuming/pyrite          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/consuming/red             = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/consuming/green           = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/consuming/pink            = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/consuming/gold            = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/consuming/oil             = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/consuming/black           = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/consuming/lightpink       = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/consuming/adamantine      = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/consuming/rainbow         = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
		//  Prismatic -    Crossbreading Cores!    - (Pyrite Cores)
	/obj/item/slimecross/prismatic/grey            = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/prismatic/orange          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/prismatic/purple          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/prismatic/blue            = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/prismatic/metal           = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/prismatic/yellow          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/prismatic/darkpurple      = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/prismatic/darkblue        = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/prismatic/silver          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/prismatic/bluespace       = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/prismatic/sepia           = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/prismatic/cerulean        = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/prismatic/pyrite          = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/prismatic/red             = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/prismatic/green           = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/prismatic/pink            = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/prismatic/gold            = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/prismatic/oil             = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/prismatic/black           = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/prismatic/lightpink       = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/prismatic/adamantine      = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/prismatic/rainbow         = list(TECHWEB_POINT_TYPE_GENERIC = 4250),
		//  Recurring -    Crossbreading Cores!    - (Cerulean Cores)
	/obj/item/slimecross/recurring/grey            = list(TECHWEB_POINT_TYPE_GENERIC = 2500),
	/obj/item/slimecross/recurring/orange          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/recurring/purple          = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/recurring/blue            = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/recurring/metal           = list(TECHWEB_POINT_TYPE_GENERIC = 3000),
	/obj/item/slimecross/recurring/yellow          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/recurring/darkpurple      = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/recurring/darkblue        = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/recurring/silver          = list(TECHWEB_POINT_TYPE_GENERIC = 3250),
	/obj/item/slimecross/recurring/bluespace       = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/recurring/sepia           = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/recurring/cerulean        = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/recurring/pyrite          = list(TECHWEB_POINT_TYPE_GENERIC = 3500),
	/obj/item/slimecross/recurring/red             = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/recurring/green           = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/recurring/pink            = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/recurring/gold            = list(TECHWEB_POINT_TYPE_GENERIC = 3750),
	/obj/item/slimecross/recurring/oil             = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/recurring/black           = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/recurring/lightpink       = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/recurring/adamantine      = list(TECHWEB_POINT_TYPE_GENERIC = 4000),
	/obj/item/slimecross/recurring/rainbow         = list(TECHWEB_POINT_TYPE_GENERIC = 4250)
	)

/obj/item/katana/necropolis
	force = 30 //Wouldn't want a miner walking around with a 40 damage melee around now, would we?

//legion
/obj/structure/closet/crate/necropolis/legion
	name = "echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/crusher_trophy/legion_shard(src)
	new /obj/item/borg/upgrade/modkit/skull(src)

/obj/structure/closet/crate/necropolis/legion/hard
	name = "enraged echoing legion crate"

/obj/structure/closet/crate/necropolis/legion/hard/PopulateContents()
	new /obj/item/staff/storm(src)
	new /obj/item/staff/storm(src)
	new /obj/item/staff/storm(src)
	new /obj/item/borg/upgrade/modkit/skull(src)
	new /obj/item/borg/upgrade/modkit/skull(src)
	new /obj/item/crusher_trophy/legion_shard(src)
	new /obj/item/crusher_trophy/legion_shard(src)
	var/obj/structure/closet/crate/necropolis/tendril/T = new /obj/structure/closet/crate/necropolis/tendril //Yup, i know, VERY spaghetti code.
	var/obj/item/L
	for(var/i = 0, i < 5, i++)
		L = T.PopulateContents()
		new L(src)
	qdel(T)