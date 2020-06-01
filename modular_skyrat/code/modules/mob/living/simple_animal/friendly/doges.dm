//cheems, the true cargo pet
//note: will probably add hat and fluff functionality later
//note 2: will probably get a better sprite later
//note 3: ignore note 2 the sprite is actually good now
/mob/living/simple_animal/pet/dog/cheems
	name = "\proper Cheems"
	desc = "Cheemsburbger..."
	icon = 'modular_skyrat/icons/mob/doges.dmi'
	icon_state = "cheems"
	icon_dead = "cheemsdead"
	icon_living = "cheems"
	speak = list("Burbger...", "McDomnald...", "Whompper...", "Bimg Mac...", "Whemre are the miners?", "Revolutiom!",\
				"Pizza cramte.", "Collemctable hats...", "Research mining tech stupid sciemtists!", "Where's my rimpley?",\
				"Shomtgun crate.", "Free cargo!", "No horny.")
	butcher_results = list(/obj/item/reagent_containers/food/snacks/burger/cheese = 5)
	faction = list("dog", "doge")
	animal_species = /mob/living/simple_animal/pet/dog
	gold_core_spawnable = FRIENDLY_SPAWN
	var/liked_food = JUNKFOOD | SUGAR | FRIED | DAIRY

/mob/living/simple_animal/pet/dog/cheems/Move(atom/newloc, direct)
	. = ..()
	if(.)
		for(var/obj/item/reagent_containers/food/snacks/junk in view(1, src))
			if(liked_food & junk.foodtype)
				visible_message("<span class='danger'><b>\The [src]</b> consumes the [junk]!</span>")
				qdel(burbger)
				revive(full_heal = 1)

/mob/living/simple_animal/pet/dog/cheems/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(.)
		if(istype(I, /obj/item/reagent_containers/food/snacks))
			var/obj/item/reagent_containers/food/snacks/junk = I
			if(liked_food & junk.foodtype)
				if(stat == DEAD)
					visible_message("<b>\The [src]</b> stands right back up after nibbling the [I]!")
					junk.bitecount++
				else 
					visible_message("<b>\The [src]</b> swallows the [I] whole!")
					qdel(junk)
				playsound(src, 'sound/weapons/bite.ogg', 75)
				revive(full_heal = 1)
			else
				if(stat != DEAD)
					if(user.dropItemToGround(junk))
						visible_message("<b>\The [src]</b> spits the [junk]!")
						junk.safe_throw_at(get_edge_target_turf(src, get_dir(src, user)), 21, 6, src)
						say("Disgustimg.")

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
