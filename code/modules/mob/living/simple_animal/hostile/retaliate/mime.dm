/mob/living/simple_animal/hostile/retaliate/mime
	name = "Mime"
	desc = "*wave"
	icon = 'icons/mob/mime_mobs.dmi'
	icon_state = "mime"
	icon_living = "mime"
	icon_dead = "mime_dead"
	icon_gib = "mime_gib"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	turns_per_move = 5
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "robusts"
	response_harm_simple = "robust"
	speak = list("...", "..!", "..?")
	emote_see = list("says", "says")
	speak_chance = 0
	a_intent = INTENT_HARM
	maxHealth = 75
	health = 75
	speed = 1
	harm_intent_damage = 8
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_sound = 'sound/effects/hit_punch.ogg'
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	del_on_death = 1

	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 270
	maxbodytemp = 370
	unsuitable_atmos_damage = 10
	footstep_type = FOOTSTEP_MOB_SHOE
	var/attack_reagent

/mob/living/simple_animal/hostile/retaliate/mime/handle_temperature_damage()
	if(bodytemperature < minbodytemp)
		adjustBruteLoss(10)
		throw_alert("temp", /obj/screen/alert/cold, 2)
	else if(bodytemperature > maxbodytemp)
		adjustBruteLoss(15)
		throw_alert("temp", /obj/screen/alert/hot, 3)
	else
		clear_alert("temp")

/mob/living/simple_animal/hostile/retaliate/mime/attack_hand(mob/living/carbon/human/M)
	..()
	playsound(src.loc, 'sound/effects/hit_punch.ogg', 50, TRUE)

/mob/living/simple_animal/hostile/retaliate/mime/AttackingTarget()
	. = ..()
	if(attack_reagent && . && isliving(target))
		var/mob/living/L = target
		if(L.reagents)
			L.reagents.add_reagent(attack_reagent, rand(1,5))

/mob/living/simple_animal/hostile/retaliate/mime/thesilent
	name = "The Silent"
	desc = "A faceless being of unknown origin. You can swear it's tracking you somehow."
	icon_state = "the silent"
	icon_living = "the silent"
	move_resist = INFINITY
	response_help_continuous = "stares down"
	response_help_simple = "stare down"
	response_disarm_continuous = "carefully moves aside"
	response_disarm_simple = "carefully move aside"
	response_harm_continuous = "defies"
	response_harm_simple = "defies"
	emote_see = list("resonates", "says")
	speak_chance = 0
	maxHealth = 400
	health = 400
	speed = 4
	pixel_x = -16
	harm_intent_damage = 15
	melee_damage_lower = 15
	melee_damage_upper = 20
	attack_sound = 'sound/effects/curseattack.ogg'
	attack_verb_continuous = "glares at"
	attack_verb_simple = "glare at"
	obj_damage = 30
	environment_smash = ENVIRONMENT_SMASH_WALLS

/mob/living/simple_animal/hostile/retaliate/mime/thesilent/Initialize()
	. = ..()
