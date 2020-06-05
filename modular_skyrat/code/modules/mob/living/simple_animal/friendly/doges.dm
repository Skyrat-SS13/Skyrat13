//cheems, the true cargo pet
//note: will probably add hat and fluff functionality later
//note 2: will probably get a better sprite later
//note 3: ignore note 2 the sprite is actually good now
/mob/living/simple_animal/pet/dog/cheems
	name = "\proper Cheems"
	desc = "Cheems, the most important cargo worker."
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

/mob/living/simple_animal/pet/dog/cheems/Move(atom/newloc, direct)
	. = ..()
	if(.)
		for(var/obj/item/reagent_containers/food/snacks/junk in view(1, src))
			if(liked_food & junk.foodtype)
				visible_message("<span class='danger'><b>\The [src]</b> consumes the [junk]!</span>")
				qdel(junk)
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
						junk.throw_at(get_edge_target_turf(src, pick(GLOB.alldirs)), 21, 6, src)
						say("Disgustimg.")

//walter
/mob/living/simple_animal/pet/dog/walter
	name = "\proper Walter"
	desc = "Walter, the atmospheric technician's loyal pet."
	icon = 'modular_skyrat/icons/mob/doges.dmi'
	icon_state = "walter"
	icon_dead = "walter_dead"
	icon_living = "cheems"
	speak = list("Walter", "I like fire trucks and moster trucks", "I like fusion and hellburn", "Who's Joe?",
				"Why is the supermatter delaminating", "I will beat you to death", "I will inject plasma in the distro loop",
				"I am going to farm tritium", "Why are the vents expelling cum")
	butcher_results = list(/obj/item/clothing/suit/fire/firefighter = 1, /obj/item/clothing/head/hardhat/red = 1)
	faction = list("dog", "doge")
	animal_species = /mob/living/simple_animal/pet/dog
	gold_core_spawnable = FRIENDLY_SPAWN
	//headset so that walter can do rap battles against Poly on the engineering channel
	var/obj/item/radio/headset/ears = null

/mob/living/simple_animal/pet/dog/walter/Initialize()
	. = ..()
	if(.)
		handle_ears()

/mob/living/simple_animal/pet/dog/walter/proc/handle_ears() //i think i was going to use the proc for something else i dunno
	if(ears)
		desc = initial(desc) + "<br><span class='notice'>Click <a href='?src=\ref[src]' style='color:#1E90FF'>here</a> to remove their headset.</span>"
	else
		desc = initial(desc) + "<span class='notice'>They have no headset.</span>"
	return TRUE

/mob/living/simple_animal/pet/dog/walter/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(istype(I, /obj/item/radio/headset) && user.a_intent != INTENT_HARM)
		I.forceMove(src)
		ears = I
		to_chat(user, "<span class='notice'>You put [I] on [src].")
		handle_ears()

/mob/living/simple_animal/pet/dog/walter/radio(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	. = ..()
	if(ears)
		return ears.talk_into(src, message, pick(ears.channels), spans, language)

/mob/living/simple_animal/pet/dog/walter/Topic(href, href_list)
	. = ..()
	if(ears)
		ears.forceMove(usr.loc)
		to_chat(usr, "<span class='notice'>You take off [src]'s [ears].")
		ears = null
		handle_ears()
