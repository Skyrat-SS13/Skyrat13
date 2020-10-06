//Wonder recipes
//NOTE: Wonders are named after their proper keys, the wonder structure handles that code
/datum/crafting_recipe/wonder
	name = "Wonder"
	result = /obj/structure/wonder
	reqs = list(
				/obj/item/bodypart = 2,
				/obj/item/stack/sheet/bone = 2,
				/obj/item/organ/intestines = 1,
				)
	category = CAT_PRIMAL
	always_availible = FALSE

//Crafting recipes do not support singleton names. I had to do stupid.
/datum/crafting_recipe/wonder/proc/update_global_wonder()
	. = FALSE
	for(var/datum/crafting_recipe/wonder/wonderer in GLOB.crafting_recipes)
		if(wonderer.type == src.type)
			wonderer.name = src.name
			return TRUE

/datum/crafting_recipe/wonder/second
	result = /obj/structure/wonder
	reqs = list(
				/obj/item/bodypart/groin = 1,
				/obj/item/bodypart = 2,
				/obj/item/organ/lungs = 1,
				)

/datum/crafting_recipe/wonder/third
	result = /obj/structure/wonder
	reqs = list(
				/obj/item/bodypart/head = 3,
				/obj/item/organ/intestines = 2,
				/obj/item/bodypart = 1,
				)

/datum/crafting_recipe/wonder/fourth
	result = /obj/structure/wonder
	reqs = list(
				/obj/item/organ/tongue = 4,
				/obj/item/organ/intestines = 3,
				/obj/item/stack/sheet/bone = 2,
				)

//Wonder structure
/obj/structure/wonder
	name = "wonder"
	desc = "What a disgusting thing, what type of maniac would make this!?"
	icon = 'modular_skyrat/code/modules/antagonists/dreamer/icons/creations.dmi'
	icon_state = "creation1"
	var/datum/antagonist/dreamer/dream_master
	var/wonder_id = 1
	var/gazed_at = FALSE
	var/key_num = ""
	var/key_text = ""
	resistance_flags = INDESTRUCTIBLE
	max_integrity = INFINITY
	obj_integrity = INFINITY
	integrity_failure = INFINITY
	density = TRUE
	anchored = TRUE

/obj/structure/wonder/examine(mob/user)
	. = ..()
	process()

/obj/structure/wonder/Initialize()
	. = ..()
	playsound(src, 'modular_skyrat/code/modules/antagonists/dreamer/sound/wonder.ogg', 100, 0)
	for(var/mob/living/carbon/human/H in view(src))
		if(is_dreamer(H))
			for(var/datum/antagonist/dreamer/dreammy in H.mind.antag_datums)
				dream_master = dreammy
				icon_state = "creation[clamp(dream_master.current_wonder, 1, 4)]"
				name = "[dream_master.associated_keys[dream_master.current_wonder]] Wonder"
				if(length(dream_master.recipe_progression) >= dream_master.current_wonder)
					H.mind.learned_recipes -= dream_master.recipe_progression[dream_master.current_wonder]
				dream_master.current_wonder++
				if(length(dream_master.recipe_progression) >= dream_master.current_wonder)
					var/wonder = dream_master.recipe_progression[dream_master.current_wonder]
					var/datum/crafting_recipe/wonder/wonderful = new wonder()
					wonderful.name = "[dream_master.associated_keys[dream_master.current_wonder]] Wonder"
					wonderful.update_global_wonder()
					H.mind.teach_crafting_recipe(wonderful.type)
					qdel(wonderful)
				wonder_id = dream_master.current_wonder
				if(length(dream_master.heart_keys) >= wonder_id)
					key_num = dream_master.heart_keys[wonder_id]
				if(length(dream_master.associated_keys) >= wonder_id)
					key_text = dream_master.associated_keys[wonder_id]
				if(wonder_id > 4)
					to_chat(H, "<span class='userdanger'>I must SUM the keys.<br>I am WAKING up!</span>")
					for(var/datum/antagonist/dreamer/droomer in H.mind?.antag_datums)
						droomer.agony(H)
				break
			break
	START_PROCESSING(SSfastprocess, src)

/obj/structure/wonder/process()
	. = ..()
	if(gazed_at)
		STOP_PROCESSING(SSfastprocess, src)
		return
	var/list/viewers = view(src)
	for(var/mob/living/carbon/human/H in viewers)
		if(is_dreamer(H))
			if(H.stat == DEAD)
				continue
			if(gazed_at)
				return
			for(var/mob/living/carbon/human/Y in viewers - H)
				H.blur_eyes(2)
				if(prob(10))
					to_chat(H, "<span class='userdanger'>It is WONDERFUL!</span>")
				continue
			continue
		else
			if(H.stat == DEAD)
				continue
			if(gazed_at)
				return
			var/obj/item/organ/heart/heart = H.getorganslot(ORGAN_SLOT_HEART)
			if(dream_master && heart && (!heart.etching || !(heart.etching in dream_master.heart_keys)))
				heart.etching = "<b>INRL</b> - [key_text] - [key_num]"
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "wonder", /datum/mood_event/saw_wonder)
				H.emote("scream")
				H.playsound_local(get_turf(H), 'modular_skyrat/code/modules/antagonists/dreamer/sound/seen_wonder.ogg', 100, 0)
				H.Paralyze(5 SECONDS)
				gazed_at = TRUE
