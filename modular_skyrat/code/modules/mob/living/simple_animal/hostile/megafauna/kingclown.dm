/mob/living/simple_animal/hostile/megafauna/kingclown
	name = "King Clown"
	desc = "An extremely psychotic and mutated clown."
	health = 2500
	maxHealth = 2500
	icon_state = "clown"
	icon_living = "clown"
	icon = 'modular_skyrat/icons/mob/icemoon/kingclown.dmi'
	attacktext = "honks"
	attack_sound = 'sound/items/bikehorn.ogg'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	light_color = "#E4C7C5"
	movement_type = GROUND
	weather_immunities = list("snow")
	speak_emote = list("honks")
	armour_penetration = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	rapid_melee = 0
	speed = 1
	move_to_delay = 10
	ranged = TRUE
	crusher_loot = list()
	loot = list()
	wander = FALSE
	del_on_death = TRUE
	blood_volume = BLOOD_VOLUME_MAXIMUM
	song = sound('modular_skyrat/sound/ambience/lisapebbleman.ogg', 100) // Doubt the creator would care lol
	songlength = 1530
	deathmessage = "falls to the ground, turning into... a banana peel."
	deathsound = "honk"
	medal_type = BOSS_MEDAL_CLOWN
	score_type = CLOWN_SCORE

/obj/item/gps/internal/clown
	icon_state = null
	gpstag = "Honking Signal"
	desc = "Honk!"
	invisibility = 100

/mob/living/simple_animal/hostile/megafauna/kingclown/Initialize()
	. = ..()
	internal = new/obj/item/gps/internal/clown(src)

/mob/living/simple_animal/hostile/megafauna/kingclown/OpenFire()