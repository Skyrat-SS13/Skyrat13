/mob/living/simple_animal/hostile/megafauna/rogueprocess
	name = "bubblegum"
	desc = "In what passes for a hierarchy among slaughter demons, this one is king."
	health = 2500
	maxHealth = 2500
	attacktext = "drills"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon = 'icons/mecha/mecha.dmi'
	icon_state = "firefighter"
	icon_living = "firefighter"
	icon_dead = "firefighter-broken"
	friendly = "pokes"
	speak_emote = list("screeches")
	armour_penetration = 75
	melee_damage_lower = 30
	melee_damage_upper = 30
	speed = 1
	move_to_delay = 5
	ranged_cooldown_time = 10
	ranged = 1
	pixel_x = -32
	gender = MALE
	del_on_death = 0
	crusher_loot = list()
	loot = list()
	medal_type = BOSS_MEDAL_ROGUE
	score_type = ROGUE_SCORE
	deathmessage = "sparkles and emits corrupted screams in agony, falling defeated on the ground."
	death_sound = 'sound/magic/enter_blood.ogg'

	do_footstep = TRUE

/obj/item/gps/internal/rogueprocess
	icon_state = null
	gpstag = "Corrupted Signal"
	desc = "It's full of ransomware."
	invisibility = 100

/mob/living/simple_animal/hostile/megafauna/rogueprocess/Move()
	. = ..()
	playsound(src.loc, 'sound/mecha/mechmove01.ogg', 200, 1, 2, 1)

/mob/living/simple_animal/hostile/megafauna/rogueprocess/OpenFire()

/mob/living/simple_animal/hostile/megafauna/rogueprocessOpenFire()
	var/aiattack = rand(1,4)
	switch(aiattack)
		if(BLOOD_CHARGE)
			bloodcharge(target)
		if(BLOODY_TRAP)
			bloodytrap(target)
		if(MEAT_SHIELD)
			meatshield()
		if(KNOCKDOWN)
			knockdown()