/obj/structure/closet/crate/mysterycrate
	name = "mystery crate"
	desc = "Try your luck!"
	icon = 'modular_skyrat/icons/obj/tidezombies_machinery.dmi'
	icon_state = "mysteryplush"
	pixel_x = -4
	var/animation_jingle = 'modular_skyrat/sound/tidezombies/mysterycrate.ogg'
	var/kaching = 'modular_skyrat/sound/tidezombies/kaching.ogg'
	var/byebye= 'modular_skyrat/sound/tidezombies/byebye.ogg'
	var/in_use = FALSE //keeps track of whether it is being animated or not
	var/current_cash = 0 //how much robux we have atm, we need cost_per_gun to roll for a gun
	var/uses = 3
	var/cost_per_gun = 10000
	//Possible weapons. Associative list of
	// [path] = [chance]
	//Chance should be between 1 and 100
	var/list/possible_outcomes = list(
		/obj/item/gun/ballistic/automatic/pistol = 75,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 35,
		/obj/item/gun/ballistic/automatic/pistol/makeshift = 50,
		/obj/item/gun/ballistic/automatic/pistol/modular = 50,
		/obj/item/gun/ballistic/automatic/pistol/APS = 30,
		/obj/item/gun/ballistic/automatic/pistol/antitank = 20,
		/obj/item/gun/ballistic/automatic/pistol/deagle = 25,
		/obj/item/gun/ballistic/automatic/pistol/uspm = 65,
		/obj/item/gun/ballistic/automatic/wt550 = 60,
		/obj/item/gun/ballistic/automatic/c20r/unrestricted = 45,
		/obj/item/gun/ballistic/automatic/ar = 40,
		/obj/item/gun/ballistic/automatic/l6_saw/unrestricted = 25,
		/obj/item/gun/ballistic/automatic/gyropistol = 10,
		/obj/item/gun/ballistic/automatic/magrifle = 60,
		/obj/item/gun/ballistic/automatic/m90 = 35, //it has a grenade launcher attached
		/obj/item/gun/ballistic/automatic/mini_uzi = 40,
		/obj/item/gun/ballistic/automatic/proto = 42,
		/obj/item/gun/ballistic/automatic/railgun = 20,
		/obj/item/gun/ballistic/shotgun = 50, //you know why
		/obj/item/gun/ballistic/shotgun/boltaction = 40,
		/obj/item/gun/ballistic/shotgun/canegun = 40,
		/obj/item/gun/ballistic/shotgun/doomed = 40,
		/obj/item/gun/ballistic/shotgun/holorifle = 35,
		/obj/item/gun/ballistic/shotgun/riot = 45,
		/obj/item/gun/ballistic/shotgun/automatic/combat = 25,
		/obj/item/gun/ballistic/shotgun/automatic/dual_tube = 20,
		/obj/item/gun/ballistic/automatic/shotgun/bulldog/unrestricted = 35,
		/obj/item/gun/ballistic/revolver = 35, //two shotter yikes
		/obj/item/gun/ballistic/revolver/detective = 45,
		/obj/item/gun/ballistic/revolver/detective/joker = 20, //WANNA HEAR ANOTHER JOKE, MURRAY?
		/obj/item/gun/ballistic/revolver/golden = 5, //epic lootbox time
		/obj/item/gun/ballistic/revolver/grenadelauncher = 10, //oh no
		/obj/item/gun/ballistic/revolver/mateba = 15,
		/obj/item/gun/ballistic/revolver/nagant = 20,
		/obj/item/gun/ballistic/revolver/russian = 5, //bad luck bro
		/obj/item/gun/ballistic/revolver/reverse = 5, //bad luck again bro
		/obj/item/gun/ballistic/revolver/doublebarrel = 50,
		/obj/item/gun/ballistic/revolver/doublebarrel/contender = 10, //good one bro
		/obj/item/gun/ballistic/revolver/doublebarrel/improvised = 10, //fuck
		/obj/item/gun/ballistic/revolver/doublebarrel/super = 10, //NICE
		/obj/item/gun/ballistic/revolver/doublebarrel/super/upgraded = 3, //VERY NICE
		/obj/item/blunderbuss = 10, //VERY SHIT
		/obj/item/pneumatic_cannon = 10, //MORE SHIT
		/obj/item/pneumatic_cannon/dildo = 5, //PREFBREAK
		/obj/item/pneumatic_cannon/pie = 2, //FUCK
		/obj/item/pneumatic_cannon/pie/selfcharge = 1, //OH GOD THIS IS ACTUALLY REALLY GOOD MATE
		/obj/item/gun/medbeam = 10,
		/obj/item/gun/energy/disabler = 25,
		/obj/item/gun/energy/gravity_gun = 20,
		/obj/item/gun/energy/pickle_gun = 1,
		/obj/item/gun/energy/meteorgun = 1,
		/obj/item/gun/energy/kinetic_accelerator/crossbow = 30,
		/obj/item/gun/energy/kinetic_accelerator/crossbow/large = 35,
		/obj/item/gun/energy/pumpaction/musket = 45,
		/obj/item/gun/energy/pumpaction/blaster = 40,
		/obj/item/gun/energy/pumpaction/defender = 40,
		/obj/item/gun/energy/e_gun/blueshield = 20,
		/obj/item/gun/energy/e_gun/hos = 30,
		/obj/item/gun/energy/e_gun/nuclear = 25,
		/obj/item/gun/energy/e_gun/mini = 10,
		/obj/item/gun/energy/ionrifle = 15,
		/obj/item/gun/energy/laser/captain = 20,
		/obj/item/gun/energy/laser/captain/scattershot = 10,
		/obj/item/gun/energy/laser/carbine = 40,
		/obj/item/gun/energy/laser/LaserAK = 5,
		/obj/item/gun/energy/laser/makeshiftlasrifle = 20,
		/obj/item/gun/energy/laser/rifle = 25,
		/obj/item/gun/energy/laser/retro = 10,
		/obj/item/gun/energy/pulse/prize = 3,
		/obj/item/gun/energy/pulse/carbine = 2,
		/obj/item/gun/energy/pulse/pistol = 1,
		/obj/item/gun/energy/pulse = 1,
		/obj/item/gun/syringe = 25,
		/obj/item/gun/syringe/rapidsyringe = 20,
		/obj/item/gun/syringe/dna = 20,
		/obj/item/gun/syringe/syndicate = 15,
		/obj/item/gun/magic/wand/resurrection = 1,
		/obj/item/gun/magic/wand/fireball = 5,
		/obj/item/gun/magic/staff/honk = 5,
	)
	//Possible weapons associated with their icon and icon_state initially,
	//turned into path associated with image on the generate_images() proc.
	//Generated on spawn, should not worry too much, though this does mean
	//spawning these crates is quite a hefty toll.
	var/list/possible_icons = list()
	//The current image overlay for the funny crate
	var/image/item_overlay = null

/obj/structure/closet/crate/mysterycrate/Initialize(mapload)
	. = ..()
	for(var/i in possible_outcomes)
		var/obj/item/I = new i()
		possible_icons[i] = list(I.icon, I.icon_state)
		qdel(I)
	generate_images()

/obj/structure/closet/crate/mysterycrate/examine(mob/user)
	. = ..()
	. += "<span class='warning'>\The [src] has <b>[uses]</b> uses left, each use costing <b>[cost_per_gun]</b> credits.</span>"

/obj/structure/closet/crate/mysterycrate/update_icon()
	. = ..()
	cut_overlays()
	if(item_overlay)
		add_overlay(item_overlay)

/obj/structure/closet/crate/mysterycrate/proc/generate_images()
	for(var/i in possible_icons)
		var/image/eemage = image(possible_icons[i][1], src, possible_icons[i][2], layer, SOUTH)
		eemage.pixel_x = 6
		possible_icons[i] = eemage

/obj/structure/closet/crate/mysterycrate/attack_hand(mob/user)
	if(uses <= 0)
		..()
	else
		if(!in_use && (current_cash >= cost_per_gun) && uses)
			current_cash -= cost_per_gun
			roll_for_gun()
		else if(!in_use && uses)
			to_chat(user, "<span class='warning'>\The [src] needs at least [cost_per_gun] credits to roll for an item!</span>")
		else
			to_chat(user, "<span class='warning'>\The [src] is rolling for an item already!</span>")

/obj/structure/closet/crate/mysterycrate/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/holochip))
		var/obj/item/holochip/H = W
		current_cash += H.credits
		qdel(H)
		playsound(src, kaching, 100, 0)
	else if(istype(W, /obj/item/stack/spacecash))
		var/obj/item/stack/spacecash/S = W
		current_cash += S.value
		qdel(S)
		playsound(src, kaching, 100, 0)
	else
		..()

/obj/structure/closet/crate/mysterycrate/proc/roll_for_gun()
	uses--
	in_use = TRUE
	var/randumb
	icon_state = "mysteryplushopen"
	opened = TRUE
	playsound(src, animation_jingle, 100, 0)
	update_icon()
	for(var/i in 1 to 32)
		randumb = pickweight(possible_outcomes, 1)
		item_overlay = possible_icons[randumb]
		update_icon()
		sleep(i >= 32 ? 6 : 2)
	icon_state = initial(icon_state)
	opened = FALSE
	item_overlay = null
	in_use = FALSE
	update_icon()
	var/turf/T = get_step(src, SOUTH)
	new randumb(T)
	if(!uses)
		QDEL_IN(src, 6 SECONDS)
		playsound(src, byebye, 100, 0)

/obj/structure/closet/crate/mysterycrate/Destroy()
	. = ..()
	new /obj/item/toy/plush/lizardplushie(src.loc)
