#define INFINITE -1

/obj/item/limbsurgeon //autosurgeon is shit and does not support limbs, i had to do it to 'em
	name = "limb autosurgeon"
	desc = "A device that automatically removes an old limb and inserts a new one into the user without the hassle of extensive surgery. It has a slot to insert limbs and a screwdriver slot for removing accidentally added items."
	icon = 'icons/obj/device.dmi'
	icon_state = "autoimplanter"
	item_state = "nothing"
	w_class = WEIGHT_CLASS_SMALL
	var/obj/item/bodypart/storedbodypart
	var/bodypart_type = /obj/item/bodypart
	var/uses = INFINITE
	var/starting_bodypart

/obj/item/limbsurgeon/Initialize(mapload)
	. = ..()
	if(starting_bodypart)
		insert_bodypart(new starting_bodypart(src))

/obj/item/limbsurgeon/proc/insert_bodypart(var/obj/item/bodypart/I)
	storedbodypart = I
	I.forceMove(src)
	name = "[initial(name)] ([storedbodypart.name])"

/obj/item/limbsurgeon/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, "<span class='warning'>[src] has already been used. The tools are dull and won't reactivate.</span>")
		return
	else if(!storedbodypart)
		to_chat(user, "<span class='notice'>[src] currently has no bodypart stored.</span>")
		return
	var/mob/living/carbon/C = user
	if(C)
		storedbodypart.replace_limb(C)
		user.visible_message("<span class='notice'>[user] presses a button on [src], and you hear a short mechanical noise.</span>", "<span class='notice'>You feel a sharp sting as [src] plunges into your body.</span>")
		playsound(get_turf(user), 'sound/weapons/circsawhit.ogg', 50, 1)
		storedbodypart = null
		name = initial(name)
		if(uses != INFINITE)
			uses--
		if(!uses)
			desc = "[initial(desc)] Looks like it's been used up."
	else
		user.visible_message("<span class='notice'>[user] presses a button on [src], and nothing happens.</span>") //bro you're not carbon how tf you gonna replace that limb bro

#undef INFINITE
