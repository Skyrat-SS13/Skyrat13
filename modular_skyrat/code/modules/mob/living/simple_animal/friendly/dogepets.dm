//cheems, the true cargo pet
//note: will probably add hat and fluff functionality later
//note 2: will probably get a better sprite later
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

/mob/living/simple_animal/pet/dog/cheems/Move(atom/newloc, direct)
	. = ..()
	if(.)
		for(var/obj/item/reagent_containers/food/snacks/burger/burbger in view(1, src))
			visible_message("<span class='danger'><b>\The [src]</b> consumes the [burbger]!</span>")
			qdel(burbger)
			revive(full_heal = 1)

/mob/living/simple_animal/pet/dog/cheems/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(.)
		if(istype(I, /obj/item/reagent_containers/food/snacks/burger))
			qdel(I)
			if(stat == DEAD)
				visible_message("<b>\The [src]</b> stands right back up after nibbling the [I]!")
			else 
				visible_message("<b>\The [src]</b> swallows the [I] whole!")
			revive(full_heal = 1)

//cheemgularity
/obj/singularity/cheemgularity
	name = "cheemgularity"
	desc = "Praise cheem."
	icon = 'modular_skyrat/icons/obj/singularity.dmi'
	icon_state = "cheemgulo_s1"

/obj/singularity/cheemgularity/expand(force_size)
	..()
	switch(icon_state)
		if("singularity_s1")
			icon = initial(icon)
			icon_state = "cheemgulo_s1"
		if("singularity_s3")
			icon = 'modular_skyrat/icons/effects/96x96.dmi'
			icon_state = "cheemgulo_s3"
		if("singularity_s5")
			icon = 'modular_skyrat/icons/effects/160x160.dmi'
			icon_state = "cheemgulo_s5"
		if("singularity_s7")
			icon = 'modular_skyrat/icons/effects/224x224.dmi'
			icon_state = "cheemgulo_s7"
		else
			icon_state = "cheemgulo_s1"
			icon = initial(icon)
