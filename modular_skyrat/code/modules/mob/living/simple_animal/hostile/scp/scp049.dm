/mob/living/simple_animal/hostile/scp/scp049
	name = "SCP 049"
	desc = "Pestilence. It is among us."
	icon = 'modular_skyrat/icons/mob/scp/scp049.dmi'
	icon_state = "scp049"
	icon_living = "scp049"
	
/mob/living/simple_animal/hostile/scp/scp049/movement_delay()
	return -1
	
/mob/living/simple_animal/hostile/scp/scp049/UnarmedAttack(atom/A)
	. = ..()
	if(isliving(A))
		var/mob/living/L = A
		if(L.stat == DEAD)
			if(ishuman(L))
				var/mob/living/carbon/human/H = A
				if(!do_after(src, 5 SECONDS, target = H))
					return
				try_to_zombie_infect(H)
			return
		L.death()
		playsound(loc, pick('modular_skyrat/sound/scp/NeckSnap1.ogg', 'modular_skyrat/sound/scp/NeckSnap2.ogg'), 50, 1, -1)
		visible_message("<span class='warning'>[src] cures [L] of their pestilence!</span>")

/mob/living/simple_animal/hostile/scp/scp049/attacked_by(obj/item/I, mob/living/user, attackchain_flags, damage_multiplier)
	if(istype(I, /obj/item/zombie_hand))
		to_chat(user, "<span class='warning'>You are not allowed to hurt your master!</span>")
		return
	else
		return ..()
	