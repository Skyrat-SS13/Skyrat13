/datum/martial_art/berserk
	name = "Berserk"
	id = MARTIALART_BERSERK
	allow_temp_override = TRUE
	var/duration = 600
/datum/martial_art/berserk/badmin
	name = "Badmin Berserk"
	duration = 288000 //literally eight fucking hours

/datum/martial_art/berserk/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!istype(H) || !H.mind)
		return FALSE
	if(H.mind.martial_art)
		if(HAS_TRAIT(H, TRAIT_PACIFISM))
			var/list/P = H.status_traits["pacifism"]
			for(var/i = 0, i == P.len, i++)
				REMOVE_TRAIT(H, TRAIT_PACIFISM, P[i])
			for(var/datum/quirk/nonviolent/N in H.roundstart_quirks)
				N.remove()
			to_chat(H, "<span class='userdanger'>You don't care about fucking pacifism anymore! You just want to fucking punch shit to a pulp!</span>")
	addtimer(CALLBACK(src, .proc/remove, H), duration)


/mob/living/carbon/human/proc/berserk_help()
	set name = "Meditate in anger"
	set desc = "Remember how to punch shit proper."
	set category = "Berserk"

	to_chat(usr, "<b><i>You retreat inward and recall the teachings of the berserker...</i></b>")
	to_chat(usr, "<span class='notice'>Disarm</span>: Literally disarms the opponent. If unable to disarm, simply punches them hard and stuns them instead. Aim at the arm for best results.")
	to_chat(usr, "<span class='notice'>Harm</span>: Punch the opponent hard, dealing a lot of brute damage and also damaging organs. Gibs dead/critical opponents, healing you with the power of BLOOD.")
	to_chat(usr, "<span class='notice'>Grab</span>: Punches the opponent at lightspeed, throwing them away from you.")

/datum/martial_art/berserk/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/def_zone = A.zone_selected
	if(ishuman(D) && (def_zone == BODY_ZONE_R_ARM || def_zone == BODY_ZONE_L_ARM))
		var/obj/item/bodypart/bodyp= D.get_bodypart(def_zone)
		if(bodyp)
			bodyp.dismember()
			A.visible_message("<span class='danger'>[A] literally disarms [D]!</span>")
		else
			A.visible_message("<span class='danger'>[A] only gets enraged by the fact that he can't rip and tear the [D]'s [def_zone], and punches them hard!</span>")
			playsound(A.loc, 'sound/misc/crunch.ogg', 100, TRUE)
			playsound(A.loc, 'sound/misc/crack.ogg', 100, TRUE)
			D.apply_damage(damage = 15,damagetype = BRUTE, def_zone = def_zone, blocked = FALSE, forced = FALSE)
			D.DefaultCombatKnockdown(25, override_stamdmg = 0)
			D.adjustStaminaLoss(15)
			D.drop_all_held_items()
	else
		A.visible_message("<span class='danger'>[A] only gets enraged by the fact that he can't rip and tear the [D]'s [def_zone], and punches them hard!</span>")
		playsound(A.loc, 'sound/misc/crunch.ogg', 100, TRUE)
		playsound(A.loc, 'sound/misc/crack.ogg', 100, TRUE)
		D.apply_damage(damage = 15,damagetype = BRUTE, def_zone = def_zone, blocked = FALSE, forced = FALSE)
		D.DefaultCombatKnockdown(25, override_stamdmg = 0)
		D.adjustStaminaLoss(15)
		D.drop_all_held_items()

/datum/martial_art/berserk/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/def_zone = A.zone_selected
	if(ishuman(D))
		for(var/obj/item/organ/O in D)
			if(O.zone == def_zone)
				O.applyOrganDamage(7)
			else
				continue
		A.visible_message("<span class='danger'>[A] punches [D] HARD!!</span>")
		playsound(A.loc, 'sound/misc/crunch.ogg', 100, TRUE)
		playsound(A.loc, 'sound/misc/crack.ogg', 100, TRUE)
		D.apply_damage(damage = 25,damagetype = BRUTE, def_zone = def_zone, blocked = FALSE, forced = FALSE)
		if(D.health <= 0)
			A.visible_message("<span class='danger'>[A] rips [D] apart!</span>")
			D.gib()
			A.heal_overall_damage(50, 50, 100, FALSE, FALSE, updating_health = TRUE)

/datum/martial_art/berserk/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/def_zone = A.zone_selected
	if(ishuman(D))
		A.visible_message("<span class='danger'>[A] grabs [D] and throws them away!!</span>")
		playsound(A.loc, 'sound/misc/crunch.ogg', 100, TRUE)
		playsound(A.loc, 'sound/misc/crack.ogg', 100, TRUE)
		D.apply_damage(damage = 10,damagetype = BRUTE, def_zone = def_zone, blocked = FALSE, forced = FALSE)
		var/throwtarget = get_edge_target_turf(A, get_dir(A, D))
		D.safe_throw_at(throwtarget, 15, 5, A)
