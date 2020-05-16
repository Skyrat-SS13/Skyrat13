//cheems, the true cargo pet
//note: will probably add hat and fluff functionality later
//note 2: will probably get a better sprite later
/mob/living/simple_animal/pet/dog/cheems
	name = "Cheems"
	desc = "Cheemsburbger..."
	icon = 'modular_skyrat/icons/mob/cheems.dmi'
	icon_state = "cheems"
	icon_dead = "cheemsdead"
	icon_living = "cheems"
	speak = list("Burbger...", "McDonald...", "Whopper.", "Bimg Mac.", "Whemre are the miners?", "Revolutiom!",\
				"Pizza cramte.", "Collemctable hats...", "Research mining tech stupid sciemtists.", "I want a rimpley.")
	butcher_results = list(/obj/item/reagent_containers/food/snacks/burger/cheese = 5)
	faction = list("dog", "doge")
	animal_species = /mob/living/simple_animal/pet/dog
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/dog/cheems/examine(mob/user)
	. = ..()
	. += "<br>"
	var/burbgeramount = round((health/maxHealth) * 50)
	for(var/i = 0, i >= burbgeramount, i++)
		. += "[icon2html('icons/obj/food/burgerbread.dmi', user, "cheeseburgeralt")]"

/mob/living/simple_animal/pet/dog/cheems/Move(atom/newloc, direct)
	. = ..()
	if(.)
		for(var/obj/item/reagent_containers/food/snacks/burger/burbger in view(1, src))
			visible_message("<span class='danger'><b>[src] consumes the [burbger]!</b></span>")
			qdel(burbger)
			adjustHealth(-maxHealth)

//cheemgularity
/obj/singularity/consume(atom/A)
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
