#define HEADBUTT_COMBO "GH"
#define VIOLENT_KICK_COMBO "HD"

/datum/martial_art/fists_of_caine
	name = "Fists of Caine"
	id = MARTIALART_FISTSOFCAINE
	allow_temp_override = FALSE
	help_verb = /mob/living/carbon/human/proc/fists_of_caine_help
	pugilist = TRUE

/datum/martial_art/fists_of_caine/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(findtext(streak,HEADBUTT_COMBO))
		streak = ""
		if (!CHECK_MOBILITY(D, MOBILITY_STAND) || !CHECK_MOBILITY(A, MOBILITY_STAND))
			return FALSE
		headbutt(A,D)
		return TRUE
	if(findtext(streak,VIOLENT_KICK_COMBO))
		streak = ""
		if (!CHECK_MOBILITY(D, MOBILITY_STAND) || !CHECK_MOBILITY(A, MOBILITY_STAND))
			return FALSE
		violentKick(A,D)
		return TRUE
	return FALSE

/datum/martial_art/fists_of_caine/proc/checkfordensity(turf/T,mob/M)
	if (T.density)
		return FALSE
	for(var/obj/O in T)
		if(!O.CanPass(M,T))
			return FALSE
	return TRUE

/datum/martial_art/fists_of_caine/proc/headbutt(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = (damage_roll(A,D))
	var/headarmor = 0
	var/obj/item/I = D.get_item_by_slot(SLOT_HEAD)
	if(I)
		headarmor = I.armor.melee
	var/knockdown_duration = (50 - headarmor) * 3
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	D.visible_message("<span class='warning'>[A] headbutts [D], knocking them out cold!</span>", \
						  "<span class='userdanger'>[A] headbutts you, knocking you out cold!</span>")
	D.apply_damage(damage, BRUTE, BODY_ZONE_HEAD)
	A.apply_damage(damage, BRUTE, BODY_ZONE_HEAD)
	D.Sleeping(knockdown_duration)
	log_combat(A, D, "headbutt (Fists of Caine)")
	return TRUE

/datum/martial_art/fists_of_caine/proc/violentKick(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/damage = (damage_roll(A,D)*0.5)
	if(CHECK_MOBILITY(D, MOBILITY_STAND))
		var/turf/H = get_step(A, get_dir(A,D))
		A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		D.visible_message("<span class='warning'>[A] kicks [D] in the chest, knocking them away!</span>", \
						  "<span class='userdanger'>[A] kicks you in the chest, forcing you to step away!</span>")
		playsound(get_turf(A), 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
		D.apply_damage(damage, BRUTE, BODY_ZONE_CHEST)
		D.DefaultCombatKnockdown(60, override_hardstun = 1, override_stamdmg = damage)
		if(checkfordensity(H, D))
			D.forceMove(H)
		log_combat(A, D, "violently kicked (Fists of Caine)")
		return TRUE
	return TRUE

/datum/martial_art/fists_of_caine/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return TRUE
	return ..()

/datum/martial_art/fists_of_caine/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("H",D)
	if(check_streak(A,D))
		return TRUE
	return ..()

/datum/martial_art/fists_of_caine/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	add_to_streak("G",D)
	if(check_streak(A,D))
		return TRUE
	return ..()

/datum/martial_art/fists_of_caine/on_projectile_hit(mob/living/carbon/human/A, obj/item/projectile/P, def_zone)
	. = ..()
	if(A.incapacitated(FALSE, TRUE)) //NO STUN
		return BULLET_ACT_HIT
	if(!CHECK_ALL_MOBILITY(A, MOBILITY_USE|MOBILITY_STAND)) //NO UNABLE TO USE, NO DODGING ON THE FLOOR
		return BULLET_ACT_HIT
	if(A.dna && A.dna.check_mutation(HULK)) //NO HULK
		return BULLET_ACT_HIT
	if(!isturf(A.loc)) //NO MOTHERFLIPPIN MECHS!
		return BULLET_ACT_HIT
	if(prob(50))
		A.visible_message("<span class='danger'>[A] dodges the projectile cleanly!</span>", "<span class='userdanger'>You dodge out of the way of the projectile!</span>")
		playsound(get_turf(A), pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
		return BULLET_ACT_FORCE_PIERCE

/mob/living/carbon/human/proc/fists_of_caine_help()
	set name = "Remember Techniques"
	set desc = "Remember the techniques of havoc of your bloodline."
	set category = "Fists of Caine"

	to_chat(usr, "<b><i>You recall how to use the techniques of Fists of Caine...</i></b>")

	to_chat(usr, "<span class='notice'>Headbutt</span>: Grab Harm. Slam your head into your opponents, knocking them out cold and causing some damage to both of you. Both you and target need to be standing.")
	to_chat(usr, "<span class='notice'>Violent Kick</span>: Harm Disarm. Kick your opponent in the chest, knocking them away. Both you and target need to be standing.")

/datum/martial_art/fists_of_caine/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	ADD_TRAIT(H, TRAIT_NOGUNS, FISTS_OF_CAINE_TRAIT)

/datum/martial_art/fists_of_caine/on_remove(mob/living/carbon/human/H)
	. = ..()
	REMOVE_TRAIT(H, TRAIT_NOGUNS, FISTS_OF_CAINE_TRAIT)