//cheems, the true cargo pet
//note: will probably add hat and fluff functionality later
//note 2: will probably get a better sprite later
//note 3: ignore note 2 the sprite is actually good now
//note 4: i only slightly edited the sprites, credits go to Dawn at https://community.playstarbound.com/threads/fluffy-dogs-other-alternative-dog-sprites-update-8-pug-time.109948/ :)
/mob/living/simple_animal/pet
	var/list/mecha_speak = list() //Gets added when riding a mech buddy.

/mob/living/simple_animal/pet/dog/cheems
	name = "\proper Cheems"
	desc = "Cheemsburbger..."
	icon = 'modular_skyrat/icons/mob/doges.dmi'
	icon_state = "cheems"
	icon_dead = "cheems_dead"
	icon_living = "cheems"
	speak = list("Burbger...", "McDomnald...", "Whompper...", "Bimg Mac...", "Whemre are the miners?", "Revolutiom!",\
				"Pizza cramte.", "Collemctable hats...", "Research mining tech stupid sciemtists!", "Where's my rimpley?",\
				"Shomtgun crate.", "Free cargo!", "No horny.")

	butcher_results = list(/obj/item/reagent_containers/food/snacks/burger/cheese = 5)
	faction = list("dog", "doge")
	animal_species = /mob/living/simple_animal/pet/dog
	gold_core_spawnable = FRIENDLY_SPAWN
	var/liked_food = JUNKFOOD | SUGAR | FRIED | DAIRY
	//finally, cheems telecomms
	var/obj/item/radio/headset/ears = null
	//finally, shomtgun
	var/obj/item/gun/shomtgun

/mob/living/simple_animal/pet/dog/cheems/Initialize()
	. = ..()
	handle_fluff()

/mob/living/simple_animal/pet/dog/cheems/proc/handle_fluff()
	desc = initial(desc)
	if(ears)
		desc += "<span class='notice'>Click <a href='?src=[REF(src)];headset=1' style='color:#1E90FF'>here</a> to remove their headset.</span>"
	else
		desc = initial(desc) + "<span class='notice'>They have no headset.</span>"
	if(shomtgun)
		desc += "<span class='notice'>Click <a href='?src=[REF(src)];kidswithguns=1' style='color:#1E90FF'>here</a> to remove their [lowertext(shomtgun.name)].</span>"
	update_overlays()
	return TRUE

/mob/living/simple_animal/pet/dog/cheems/update_overlays()
	. = ..()
	cut_overlays()
	if(shomtgun)
		. += mutable_appearance('modular_skyrat/icons/mob/doges.dmi', "shomtgun")

/mob/living/simple_animal/pet/dog/cheems/Topic(href, href_list)
	. = ..()
	if(.)
		if(href_list["headset"] && ears)
			ears.forceMove(get_turf(src))
			to_chat(usr, "<span class='notice'>You take off [src]'s [ears].</span>")
			ears = null
		else if(href_list["kidswithguns"] && shomtgun)
			shomtgun.forceMove(get_turf(src))
			to_chat(usr, "<span class='notice'>You take off [src]'s [shomtgun].</span>")
			shomtgun = null
	
/mob/living/simple_animal/pet/dog/cheems/Moved()
	. = ..()
	var/should_heal = FALSE
	var/count = 0
	var/obj/item/junk_text
	for(var/obj/item/reagent_containers/food/snacks/junk in loc)
		count++
		if(count >= 5)
			break
		if((stat == CONSCIOUS) && liked_food & junk.foodtype)
			qdel(junk)
			should_heal = TRUE
		junk_text = junk
	if(count)
		visible_message("<span class='danger'><b>\The [src]</b> consumes [count > 1 ? "all the junk food he can" : junk_text]!</span>")
	if(should_heal)
		revive(full_heal = 1)
	if(shomtgun)
		playsound(src, 'modular_skyrat/sound/effects/kidswithgunsbutnokidsandnoguns.ogg', 30, 0)

/mob/living/simple_animal/pet/dog/cheems/MouseDrag(over_object, src_location, over_location, src_control, over_control, params)
	. = ..()
	if(usr.canUseTopic(src, TRUE, FALSE, FALSE) && shomtgun && over_object)
		shomtgun.process_fire(over_object, src, TRUE, null, BODY_ZONE_HEAD)
		var/obj/item/gun/ballistic/shotgun/shommmtgun = shomtgun
		if(istype(shommmtgun))
			shommmtgun.pump(src, TRUE)
		return TRUE

/mob/living/simple_animal/pet/dog/cheems/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(.)
		if(istype(I, /obj/item/radio/headset) && user.a_intent != INTENT_HARM)
			I.forceMove(src)
			ears = I
			to_chat(user, "<span class='notice'>You put \the [I] on [src].</span>")
			handle_fluff()
		
		else if((istype(I, /obj/item/gun/ballistic/shotgun) || istype(I, /obj/item/gun/ballistic/revolver/doublebarrel)) && (user.a_intent != INTENT_HARM))
			I.forceMove(src)
			shomtgun = I
			to_chat(user, "<span class='notice'>You put \the [I] on [src]'s neck.</span>")
			playsound(src, 'modular_skyrat/sound/effects/kidswithgunsbutnokidsandnoguns.ogg', 100, 0)
			handle_fluff()
		
		else if(istype(I, /obj/item/reagent_containers/food/snacks))
			var/obj/item/reagent_containers/food/snacks/junk = I
			if(liked_food & junk.foodtype)
				if(stat == DEAD)
					visible_message("<span class='notice'><b>\The [src]</b> stands right back up after nibbling the [I]!</span>")
					junk.bitecount++
				else
					visible_message("<span class='notice'><b>\The [src]</b> swallows the [I] whole!</span>")
					qdel(junk)
				playsound(src, 'sound/weapons/bite.ogg', 75)
				revive(full_heal = 1)
			else
				if(stat != DEAD)
					if(user.dropItemToGround(junk))
						junk.bitecount++
						visible_message("<span class='warning'><b>\The [src]</b> spits the [junk]!</span>")
						junk.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), 21, 6, src)
						say("Disgustimg.")

/mob/living/simple_animal/pet/dog/cheems/blue
	name = "anomalous cheems"
	desc = "It's Cheems. But blue and almighty."
	health = 5000 //the weak must fear the strong
	speak = list("I am cheemsus", "I am god", "Comsume", "Bow bemfore me")
	var/obj/effect/immovablerod/vored

/mob/living/simple_animal/pet/dog/cheems/blue/Initialize()
	. = ..()
	add_atom_colour("#00FFFF")

/mob/living/simple_animal/pet/dog/cheems/blue/death(gibbed)
	. = ..()
	gibbed = TRUE
	if(vored)
		visible_message("<span class='danger'><b>\The [src]</b> expels out \the <b>[vored]</b>!</span>")
		vored.forceMove(get_turf(src))
		vored.rodify(get_turf(src), get_edge_target_turf(src, dir))

//cheemgularity
/* disabled for now because error: maximum number of internal arrays exceeded (65535)
/obj/singularity/proc/consume(atom/A)
	var/gain = A.singularity_act(current_size, src)
	src.energy += gain
	if(istype(A, /obj/machinery/power/supermatter_crystal) && !consumedSupermatter)
		desc = "[initial(desc)] It glows fiercely with inner fire."
		name = "supermatter-charged [initial(name)]"
		consumedSupermatter = 1
		set_light(10)
	if(istype(A, /mob/living/simple_animal/pet/dog/cheems))
		new /obj/singularity/cheemgularity(get_turf(src))
		qdel(src)

/obj/singularity/cheemgularity
	name = "cheemgularity"
	desc = "Praise cheem."
	icon = 'modular_skyrat/icons/obj/singularity.dmi'
	icon_state = "cheemgulo_s1"

/obj/singularity/cheemgularity/expand(force_size)
	..()
	switch(force_size)
		if(STAGE_ONE to STAGE_TWO)
			icon = initial(icon)
			icon_state = "cheemgulo_s1"
		if(STAGE_TWO to STAGE_THREE)
			icon = 'modular_skyrat/icons/effects/96x96.dmi'
			icon_state = "cheemgulo_s3"
		if(STAGE_THREE to STAGE_FOUR)
			icon = 'modular_skyrat/icons/effects/160x160.dmi'
			icon_state = "cheemgulo_s5"
		if(STAGE_FOUR to STAGE_FIVE)
			icon = 'modular_skyrat/icons/effects/224x224.dmi'
			icon_state = "cheemgulo_s7"
		if(STAGE_FIVE to STAGE_SIX)
			icon = 'modular_skyrat/icons/effects/288x288.dmi'
			icon_state = "cheemgulo_s9"
		if(STAGE_SIX)
			icon = 'modular_skyrat/icons/effects/352x352.dmi'
			icon_state = "cheemgulo_s11"
*/
