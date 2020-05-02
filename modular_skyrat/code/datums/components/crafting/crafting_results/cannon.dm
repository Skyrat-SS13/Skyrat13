/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon
	name = "cannon"
	desc = "A makeshift cannon. This primitive weapon uses centuries-old technology."
	icon = 'modular_skyrat/icons/obj/vg/vg_items.dmi'
	icon_state = "cannon"
	flags = FPRINT
	var/loaded_item = null
	var/obj/item/loaded_item
	var/obj/item/reagent_containers/beaker/reservoir/boomtank  //shh just take it as a fuel reservoir
	var/sound/firesound = 'sound/effects/explosion3.ogg'
	var/cooldowntime = 50
	var/cooldown = 0
	var/flawless = 0

/obj/item/reagent_containers/beaker/reservoir/Initialize(mapload, vol)
	. = ..()
	vol = 30

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannonInitialize()
	. = ..()
	boomtank = new /obj/item/reagent_containers/beaker/reservoir(src)

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/R = I
		if(/datum/reagent/fuel/L in R.reagents.reagent_list && boomtank)
			R.reagents.trans_id_to(boomtank.reagents, L, L.volume)
			to_chat(user, to_chat(user, "<span class='notice'>You transfer all of [R]'s possible fuel to \the [src].</span>")
		else
			if(R.w_class <= WEIGHT_CLASS_NORMAL && !loaded_item)
				R.forceMove(src)
				loaded_item = R
			else if(loaded_item)
				to_chat(user, to_chat(user, "<span class='warning'>[src] is already loaded!</span>")
			else
				to_chat(user, to_chat(user, "<span class='warning'>[R] is too bulky to be shot!</span>")
	else if(istype(I, /obj/machinery/igniter))
	else if(istype(I, /obj/item/weldingtool))
	else if(istype(I, /obj/item/lighter))
		var/obj/item/lighter/L = I
		if(I.lit)
			addtimer(CALLBACK(src, .proc/Fire, user, get_edge_target_turf(src, dir)), 30)
			visible_message("<span class='danger'>[user] sets the [src]'s wick on fire! Get back!</span>")
	else
		if(I.w_class <= WEIGHT_CLASS_NORMAL && !loaded_item)
				I.forceMove(src)
				loaded_item = I
		else if(loaded_item)
			to_chat(user, to_chat(user, "<span class='warning'>[src] is already loaded!</span>")
		else
			to_chat(user, to_chat(user, "<span class='warning'>[I] is too bulky to be shot!</span>")

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/examine(mob/user)
	. = ..()
	. += "<span class='notice'>[src] has <b>[boomtank.reagents.get_reagent_amount(/datum/reagent/fuel)]</b> units of fuel.</span>"
	. += "<span class='notice'>[src] has <b>[loaded_item ? loaded_item.name : "nothing"]</b> loaded on it.</span>"
	. += "<span class='notice'>[src] can be lit with a lighter, igniter or welding tool.</span>"

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/attack_hand(mob/living/user)
	. = ..()
	if(loaded_item)
		to_chat(user, to_chat(user, "<span class='notice'>You pull [loaded_item] out of \the [src].</span>")
		loaded_item.forceMove(user.loc)
		loaded_item = null
	else if(!loaded_item && boomtank.reagents.total_volume)
		to_chat(user, to_chat(user, "<span class='notice'>You empty \the [src]'s fuel reservoir.</span>")
		R.reagents.remove_all(R.reagents.total_volume)

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/proc/get_target(turf/target, turf/starting)
	var/x_o = (target.x - starting.x)
	var/y_o = (target.y - starting.y)
	var/range_multiplier = 1
	switch(boomtank.reagents.total_volume)
		if(<=10)
			range_multiplier *= 1
		if(>10 && <=20)
			range_multiplier *= 2
		if(>20)
			range_multiplier *= 3
	var/xlimiter = range_multiplier * 7
	var/ylimiter = range_multiplier * 7
	if(x_o > xlimiter)
		x_o = xlimiter
	if(x_o < -xlimiter)
		x_o = -xlimiter
	if(y_o > ylimiter)
		y_o = ylimiter
	if(y_o < -ylimiter)
		y_o = -ylimiter
	var/new_x = clamp((starting.x + max((x_o * range_multiplier), xlimiter)), 0, world.maxx)
	var/new_y = clamp((starting.y + max((y_o * range_multiplier), ylimiter)), 0, world.maxy)
	var/turf/newtarget = locate(new_x, new_y, starting.z)
	return newtarget

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/proc/get_fucked(var/i = 0)
	if(!i)
		return FALSE
	switch(i)
		if(<=10)
			return 0
		if(>10 && <=20)
			return 1
		if(>20)
			return 2

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/proc/explode()
	if(!flawless)
		visible_message("<span class='userdanger'>\The [src]'s barrel gets too pressurized and explodes!</span>")
		loaded_item.forceMove(user.loc)
		loaded_item = null
		explosion(src, -1, -1, 4, 2)
		qdel(src)
		return TRUE
	else
		return FALSE

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/proc/Fire(var/atom/target)
	if(!loaded_item)
		visible_message("<span class='warning'>\The [src] shoots out a puff of smoke! It wasn't loaded!</span>")
		return
	if(!boomtank)
		visible_message("<span class='warning'>\The [src] dribbles out [loaded_item]! It wasn't fueled!</span>")
		loaded_item.forceMove(src.loc)
		loaded_item = null
		return
	if(boomtank && (boomtank.reagents.total_volume < 10))
		visible_message("<span class='warning'>\The [src] dribbles out [loaded_item]! It wasn't fueled enough!</span>")
		loaded_item.forceMove(src.loc)
		loaded_item = null
		return
	var/turf/T = get_target(target, get_turf(src))
	var/howfucked = get_fucked(boomtank.reagents.total_volume)
	playsound(src, firesound, rand(100, 150), 0)
	fire_items(T, user, howfucked)

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/proc/fire_items(turf/target, var/howfucked = 0)
	if(!loaded_item || (R.reagents.total_volume < 10))
		break
	R.reagents.remove_all(R.reagents.total_volume)
	var/obj/item/I
	I = loaded_item
	if(!throw_item(target, I))
		break
	var/chancetogetfucked = 0
	switch(howfucked)
		if(1)
			chancetogetfucked = 15
		if(2)
			changetogetfucked = 30
	if(prob(chancetogetfucked))
		explode()

/obj/vehicle/ridden/wheelchair/wheelchair_assembly/cannon/proc/throw_item(turf/target, obj/item/I)
	if(!istype(I))
		return FALSE
	loaded_item = nul
	I.forceMove(get_turf(src))
	I.throw_at(target, 30, 5, src)
	return TRUE
