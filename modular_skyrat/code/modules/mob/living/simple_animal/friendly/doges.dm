//cheems, the true cargo pet
//note: will probably add hat and fluff functionality later
//note 2: will probably get a better sprite later
//note 3: ignore note 2 the sprite is actually good now
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

/mob/living/simple_animal/pet/dog/cheems/Initialize()
	. = ..()
	handle_ears()

/mob/living/simple_animal/pet/dog/cheems/proc/handle_ears()
	if(ears)
		desc = initial(desc) + "<br><span class='notice'>Click <a href='?src=\ref[src]' style='color:#1E90FF'>here</a> to remove their headset.</span>"
	else
		desc = initial(desc) + "<span class='notice'>They have no headset.</span>"
	return TRUE

/mob/living/simple_animal/pet/dog/cheems/Topic(href, href_list)
	
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
		junktext = junk
	if(count)
		visible_message("<span class='danger'><b>\The [src]</b> consumes [count > 1 ? "all the junk food he can" : junk_text]!</span>")
	if(should_heal)
		revive(full_heal = 1)

/mob/living/simple_animal/pet/dog/cheems/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(.)
		if(istype(I, /obj/item/radio/headset) && user.a_intent != INTENT_HARM)
			I.forceMove(src)
			ears = I
			to_chat(user, "<span class='notice'>You put [I] on [src].</span>")
			handle_ears()
		
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
	var/obj/effect/immovable_rod/vored

/mob/living/simple_animal/pet/dog/cheems/blue/Initialize()
	. = ..()
	add_atom_colour("#00FFFF")

/mob/living/simple_animal/pet/dog/cheems/blue/death()
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
