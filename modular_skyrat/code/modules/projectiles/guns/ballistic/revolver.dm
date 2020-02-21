/obj/item/gun/ballistic/revolver/doublebarrel/doublesawn
	name = "smallest shotgun"
	desc = "Shoot this and say bye to your fingers."
	timessawn = 2
	w_class = WEIGHT_CLASS_TINY
	sawn_off = TRUE
	recoil = 3
	force = 0
	icon = 'modular_skyrat/icons/obj/guns/projectile.dmi'
	icon_state = "doublesawn"
	item_state = "gun"
	spread = 12
	unique_reskin = null

/obj/item/gun/ballistic/revolver/doublebarrel/doublesawn/sawoff(user)
	to_chat(user, "<span class='notice'>Shortening this thing even a single milimeter more would be beyond impossible.</span>")
	return

/obj/item/gun/ballistic/revolver/doublebarrel/doublesawn/proc/shoot_live_shot(mob/living/user as mob|obj, pointblank = 0, mob/pbtarget = null, message = 1)
	if(prob(20))
		blowup(user)
	else
		..()

/obj/item/gun/ballistic/revolver/doublebarrel
	var/timessawn = 0

/obj/item/gun/ballistic/revolver/doublebarrel/sawoff(user)
	if(!src.timessawn)
		..()
		src.timessawn += 1
		return
	else
		user.changeNext_move(CLICK_CD_MELEE)
		user.visible_message("[user] begins to shorten \the [src].", "<span class='notice'>You begin to shorten \the [src]...</span>")

		//if there's any live ammo inside the gun, makes it go off
		if(blow_up(user))
			user.visible_message("<span class='danger'>\The [src] goes off!</span>", "<span class='danger'>\The [src] goes off in your face!</span>")
			return

		if(do_after(user, 30, target = src))
			if(sawn_off)
				return
			user.visible_message("[user] shortens \the [src]!", "<span class='notice'>You shorten \the [src].</span>")
			new /obj/item/gun/ballistic/revolver/doublebarrel/doublesawn(src.loc)
			qdel(src)