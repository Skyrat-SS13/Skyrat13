//reeeeeeee gib oldie icon
/obj/item/gun/energy/laser/Initialize()
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
		cell.give(cell.maxcharge)
		to_chat(user, "<span class='notice'>You feed [I] to [src], recharging it.</span>")
	else if(istype(I, /obj/item/stack/ore/plasma))
		I.use(1)
		cell.give(cell.maxcharge/2)
		to_chat(user, "<span class='notice'>You feed [I] to [src], recharging it.</span>")
	else
		..()

/obj/item/gun/energy/watcherprojector/use(amount)
	return cell.use(amount * 100)

/obj/item/gun/energy/watcherprojector/update_icon()
	return

//improvised laser rifle, partially stolen from hippie
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
	shaded_charge = FALSE //Does this gun uses a stateful charge bar for more detail?
	var/upgraded_cell = FALSE //Do we have a upgraded cell?
	var/upgraded_firerate = FALSE //Do we have an upgraded trigger gard?
	var/upgraded_rifleing = FALSE //Is the barrel much more refined?
	var/upgraded_energycosts = FALSE //Does it have shots at a lesser cost?
	var/maxcellcharge = 1500 //little worse than a laser carbine initially
	recoil = 1
	fire_delay = 30
	spread = 15

/obj/item/gun/energy/laser/makeshiftlasrifle/update_overlays()
	. = ..()
	cut_overlay(overlays, TRUE)
	if(upgraded_rifleing)
		var/mutable_appearance/rifling_overlay = mutable_appearance(icon, "rifling_overlay")
		rifling_overlay.appearance_flags = RESET_COLOR
		rifling_overlay.layer = (FLOAT_LAYER-4)
		add_overlay(rifling_overlay, TRUE)
		. += rifling_overlay
	if(upgraded_cell)
		var/mutable_appearance/cell_overlay
		if(cell)
			cell_overlay = mutable_appearance(icon, "cell_overlay")
		else
			cell_overlay = mutable_appearance(icon, "cell_overlay_no_cell")
		cell_overlay.appearance_flags = RESET_COLOR
		cell_overlay.layer = (FLOAT_LAYER-3)
		add_overlay(cell_overlay, TRUE)
		. += cell_overlay
	if(upgraded_firerate)
		var/mutable_appearance/firerate_overlay = mutable_appearance(icon, "firerate_overlay")
		firerate_overlay.appearance_flags = RESET_COLOR
		firerate_overlay.layer = (FLOAT_LAYER-2)
		add_overlay(firerate_overlay, TRUE)
		. += firerate_overlay
	if(upgraded_energycosts)
		var/mutable_appearance/energy_overlay = mutable_appearance(icon, "energy_overlay")
		energy_overlay.appearance_flags = RESET_COLOR
		energy_overlay.layer = (FLOAT_LAYER-1)
		add_overlay(energy_overlay, TRUE)
		. += energy_overlay

/obj/item/gun/energy/laser/makeshiftlasrifle/examine(mob/user)
	. = ..()
	if(upgraded_rifleing)
		. += "It has upgraded rifling.<br>"
	if(upgraded_cell)
		. += "It has an additional power cell.<br>"
	if(upgraded_firerate)
		. += "It has an updated trigger guard.<br>"
	if(upgraded_energycosts)
		. += "It has a capacitor installed.<br>"
	var/chargepercent
	if(cell)
		chargepercent = (cell.charge/cell.maxcharge * 100)
	. += "<span class='info><b>[cell ? " The cell charge is at [chargepercent]%":" It has no main power cell."]</b></span>"

/obj/item/gun/energy/laser/makeshiftlasrifle/AltClick(mob/living/carbon/user)
	. = ..()
	playsound(user, 'sound/items/Screwdriver.ogg', 35)
	var/obj/item/stock_parts/cell/thecell = cell
	thecell.forceMove(user.loc)
	user.put_in_active_hand(thecell)
	cell = null
	update_icon()

/obj/item/gun/energy/laser/makeshiftlasrifle/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/stock_parts/cell) && !cell && !istype(I, /obj/item/stock_parts/cell/computer)) //We do not want computer cells in are gun
		var/obj/item/stock_parts/cell/C = I
		if(C.maxcharge <= maxcellcharge)
			playsound(user, 'sound/items/Screwdriver.ogg', 35)
			C.forceMove(src)
			cell = C
			update_icon()
		else
			to_chat(user, "<span class='warning'>Using a cell with this much power on this pile of crap would break it!</span>")
	else if(istype(I, /obj/item/stock_parts/cell/computer/super) && !upgraded_cell) //We want to upgrade are cell
		var/obj/item/stock_parts/cell/computer/super/T = I
		upgraded_cell = TRUE
		maxcellcharge *= 2
		update_overlays()
		to_chat(user, "<span class='notice'>You install the [T] on [src], doubling it's max charge.</span>")
		qdel(T)
		update_icon()
	else if(istype(I, /obj/item/stock_parts/cell/computer/super) && upgraded_cell)
		to_chat(user, "<span class='notice'>There's already a second cell installed in [src]!</span>")
		return
	else if(istype(I, /obj/item/assembly/timer) && !upgraded_firerate) //We want to upgrade are fire rate
		var/obj/item/assembly/timer/T = I
		qdel(T)
		upgraded_firerate = TRUE
		fire_delay /= 2
		update_overlays()
		to_chat(user, "<span class='notice'>You upgrade the trigguer guard of [src], making it fire faster.</span>")
		update_icon()
	else if(istype(I, /obj/item/assembly/timer) && upgraded_firerate)
		to_chat(user, "<span class='notice'>There's already a timer in [src]!</span>")
	else if(istype(I,  /obj/item/pipe/bluespace) && !upgraded_rifleing) //We want to lower the spread
		var/obj/item/pipe/bluespace/T = I
		qdel(T)
		upgraded_rifleing = TRUE
		spread /= 2
		update_overlays()
		to_chat(user, "<span class='notice'>You upgrade the rifling of [src].</span>")
		update_icon()
	else if(istype(I,  /obj/item/pipe/bluespace) && upgraded_rifleing)
		to_chat(user, "<span class='notice'>There rifling on [src] already!</span>")
	else if(istype(I, /obj/item/stock_parts/capacitor/quadratic) && !upgraded_energycosts)
		for(var/obj/item/ammo_casing/energy/laser/L in ammo_type)
			L.e_cost /= 2
		upgraded_energycosts = TRUE
		to_chat(user, "<span class='notice'>You connect the [I] to [src], making every shot less costly.</span>")
		update_overlays()
	else if(istype(I, /obj/item/stock_parts/capacitor/quadratic) && upgraded_energycosts)
		to_chat(user, "<span class='notice'>[src] already has a [I]!</span>")
	else
		..()

/obj/item/gun/energy/laser/makeshiftlasrifle/update_icon()
	if(cell && cell.charge)
		icon_state = "[initial(icon_state)]-1"
	else if(cell && !cell.charge)
		icon_state = "[initial(icon_state)]-0"
	else if(!cell)
		icon_state = "[initial(icon_state)]-nocell"
	update_overlays()

/obj/item/gun/energy/laser/makeshiftlasrifle/CheckParts(list/parts_list)
	var/obj/item/stock_parts/cell/partcell = locate() in parts_list
	if(partcell)
		parts_list -= partcell
		if(partcell.maxcharge <= maxcellcharge)
			qdel(cell)
			partcell.forceMove(src)
			cell = partcell
		else
			qdel(partcell)
	return ..()

//laser musket
/obj/item/gun/energy/pumpaction/musket
	name = "laser musket"
	desc = "Another settlment needs your help."
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	icon_state = "musket"
	item_state = "musket"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	shaded_charge = FALSE
	w_class = WEIGHT_CLASS_BULKY
	cell_type = /obj/item/stock_parts/cell/pumpaction/musket
	ammo_type = list(/obj/item/ammo_casing/energy/laser/hos, /obj/item/ammo_casing/energy/disabler)
	obj_flags = UNIQUE_RENAME
	fire_delay = 10
	spread = 7.5
	recoil = 1

/obj/item/stock_parts/cell/pumpaction/musket
	name = "laser musket internal cell"
	maxcharge = 800 //20 disabler shots or 8 lethal shots... not too incredible

//captain's laser gun
/obj/item/gun/energy/laser/captain
	name = "\improper Y-10 MultiPhase Energy Gun"
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/guns_righthand.dmi'
	icon_state = "caplaser"
	item_state = "hoslaser"
	desc = "This is an antique prototype of a high-quality, silver-engraved laser gun - the predecessor to the X-01 MultiPhase Energy Gun, made with the intent of being a cheaper, but not cheap, alternative for militia around the sector. All craftsmanship is of the highest quality. It is decorated with assistant leather and chrome. The object menaces with spikes of energy. On the item is an image of Space Station 13. The station is exploding."
	force = 10
	ammo_x_offset = 3
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/captain = TRUE, /obj/item/ammo_casing/energy/disabler/captain = TRUE)
	selfcharge = EGUN_SELFCHARGE
	modifystate = TRUE
	can_flashlight = TRUE
	can_bayonet = TRUE
	custom_light_icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	custom_light_state = "caplaser_bayonet"
	custom_light_color = "#d30000" //ANGRY BLOOD RED >:)
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
