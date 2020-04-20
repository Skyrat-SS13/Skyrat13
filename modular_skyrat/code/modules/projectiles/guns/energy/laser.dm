/obj/item/gun/energy/laser/New()
	. = ..()
	if(src.type == /obj/item/gun/energy/laser)
		icon = 'modular_skyrat/icons/obj/guns/energy.dmi'

//watcher projector. stolen from hippie.
/obj/item/gun/energy/watcherprojector
	name = "watcher projector"
	desc = "A spiny, gruesome tool which reproduces the icy beam of a watcher, shattering rock and freezing individuals."
	icon_state = "watcherprojector"
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	item_state = "watcherprojector"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/watcher)
	attack_verb = list("bashed", "stared down", "whacked", "smashed")
	force = 10
	can_charge = 0
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/energy/watcherprojector/examine(mob/user)
	. = ..()
	if(cell)
		. +="<span class='notice'>[src]'s diamond core is [round(cell.percent())]% energized.</span>"

/obj/item/gun/energy/watcherprojector/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sheet/mineral/plasma))
		I.use(1)
		cell.give(1000)
		to_chat(user, "<span class='notice'>You feed [I] to [src], recharging it.</span>")
	else if(istype(I, /obj/item/stack/ore/plasma))
		I.use(1)
		cell.give(500)
		to_chat(user, "<span class='notice'>You feed [I] to [src], recharging it.</span>")
	else
		..()

/obj/item/gun/energy/watcherprojector/use(amount)
	return cell.use(amount * 100)

/obj/item/gun/energy/watcherprojector/update_icon()
	return

/obj/item/ammo_casing/energy/plasma/watcher
	projectile_type = /obj/item/projectile/plasma/watcher
	select_name = "freezing blast shot"
	fire_sound = 'sound/weapons/pierce.ogg'
	delay = 15
	e_cost = 100

/obj/item/projectile/plasma/watcher
	name = "freezing blast"
	icon_state = "ice_2"
	damage = 2.5
	flag = "energy"
	damage_type = BURN
	range = 4 //terrible range
	mine_range = 0
	var/temperature = -100
	dismemberment = FALSE

/obj/item/projectile/plasma/watcher/on_hit(atom/target, blocked = 0)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.adjust_bodytemperature(((100-blocked)/100)*(temperature - L.bodytemperature)) // the new body temperature is adjusted by 100-blocked % of the delta between body temperature and the bullet's effect temperature

/obj/item/ammo_box/magazine/m10mm/rifle
	max_ammo = 7

//improvised laser rifle
/obj/item/gun/energy/laser/makeshiftlasrifle
	name = "makeshift laser rifle"
	desc = "A makeshift rifle that shoots lasers. Lacks factory precision, but can rapidly alternate power cells."
	icon_state = "lasrifle"
	item_state = "makeshiftlas"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/laser/makeshiftlasrifle, /obj/item/ammo_casing/energy/laser/makeshiftlasrifle/weak, /obj/item/ammo_casing/energy/laser/makeshiftlasrifle/medium)
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	can_charge = TRUE
	charge_sections = 1
	ammo_x_offset = 2
	shaded_charge = FALSE //if this gun uses a stateful charge bar for more detail
	var/upgraded = 0
	var/maxcellcharge = 2500 //jesus that's still a lot of shots.
	fire_delay = 7.5
	spread = 30

/obj/item/ammo_casing/energy/laser/makeshiftlasrifle
	e_cost = 1000 //The amount of energy a cell needs to expend to create this shot.
	projectile_type = /obj/item/projectile/beam/laser/makeshiftlasrifle
	select_name = "strong"
	variance = 2

/obj/item/projectile/beam/laser/makeshiftlasrifle
	damage = 20

/obj/item/ammo_casing/energy/laser/makeshiftlasrifle/weak
	e_cost = 100 //The amount of energy a cell needs to expend to create this shot.
	projectile_type = /obj/item/projectile/beam/laser/makeshiftlasrifle/weak
	select_name = "weak"
	fire_sound = 'sound/weapons/laser2.ogg'

/obj/item/projectile/beam/laser/makeshiftlasrifle/weak
	name = "weak laser"
	damage = 5

/obj/item/ammo_casing/energy/laser/makeshiftlasrifle/medium
	e_cost = 300
	projectile_type = /obj/item/projectile/beam/laser/makeshiftlasrifle/medium
	select_name = "medium"
	fire_sound = 'sound/weapons/laser2.ogg'

/obj/item/projectile/beam/laser/makeshiftlasrifle/medium
	name = "medium laser"
	damage = 12.5

/obj/item/gun/energy/laser/makeshiftlasrifle/AltClick(mob/living/carbon/user)
	..()
	playsound(user, 'sound/items/Screwdriver.ogg', 35)
	var/obj/item/stock_parts/cell/thecell = cell
	cell = null
	thecell.forceMove(user.loc)
	user.put_in_l_hand(thecell)

/obj/item/gun/energy/laser/makeshiftlasrifle/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/stock_parts/cell) && !cell)
		var/obj/item/stock_parts/cell/C = I
		if(C.maxcharge <= maxcellcharge)
			playsound(user, 'sound/items/Screwdriver.ogg', 35)
			C.forceMove(src)
			cell = C
		else
			to_chat(user, "<span class='warning'>Using a cell with this much power on this pile of crap would break it!</span>")
	if(istype(I, /obj/item/stack/sheet/plasteel) && !upgraded)
		var/obj/item/stack/sheet/plasteel/oursteel = I
		if(oursteel.use(3))
			new /obj/item/gun/energy/laser/makeshiftlasrifle/adv(user.loc)
			qdel(src)
		else
			to_chat(user, "<span class='notice'>There's not enough plasteel to upgrade the [src]!</span>")
	else if(istype(I, /obj/item/stack/sheet/plasteel) && upgraded)
		to_chat(user, "<span class='notice'>\the [src] is already upgraded!</span>")

/obj/item/gun/energy/laser/makeshiftlasrifle/adv
	name = "plasteel makeshift laser rifle"
	desc = "A makeshift rifle that shoots lasers. Lacks factory precision, but can rapidly alternate power cells. This one has been upgraded."
	icon_state = "adv_lasermakeshift"
	upgraded = 1
	shaded_charge = 1
	charge_sections = 4
	automatic_charge_overlays = TRUE
	maxcellcharge = 5000
	ammo_x_offset = 2
	fire_delay = 3.5
	spread = 15
	obj_flags = UNIQUE_RENAME

//laser musket
/obj/item/gun/energy/pumpaction/musket
	name = "laser musket"
	desc = "Another settlment needs your help."
	icon = 'modular_skyrat/icons/obj/guns/lasermusket.dmi'
	icon_state = "musket"
	item_state = "musket"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	shaded_charge = FALSE
	w_class = WEIGHT_CLASS_BULKY
	cell_type = /obj/item/stock_parts/cell/pumpaction/musket
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun, /obj/item/ammo_casing/energy/disabler)
	obj_flags = UNIQUE_RENAME

/obj/item/stock_parts/cell/pumpaction/musket
	name = "laser musket internal cell"
	maxcharge = 1250 //better than the warden's shotgun cell lmao
