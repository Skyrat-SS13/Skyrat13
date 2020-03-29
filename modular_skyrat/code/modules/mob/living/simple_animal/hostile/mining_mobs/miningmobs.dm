/mob/living/simple_animal/hostile/asteroid
	var/glorykill = FALSE //CAN THIS MOTHERFUCKER BE SNAPPED IN HALF FOR HEALTH?
	var/glorymessageshand = list() //WHAT THE FUCK ARE THE MESSAGES SAID BY THIS CUNT WHEN HE'S GLORY KILLED WITH AN EMPTY HAND?
	var/glorymessagescrusher = list() //SAME AS ABOVE BUT CRUSHER
	var/glorymessagespka = list() //SAME AS ABOVE THE ABOVE BUT PKA
	var/glorymessagespkabayonet = list() //SAME AS ABOVE BUT WITH A HONKING KNIFE ON THE FUCKING THING
	var/gloryhealth = 10

/mob/living/simple_animal/hostile/asteroid/Life()
	..()
	if(health <= maxHealth/10 && !glorykill)
		glorykill = TRUE
		glory()

/mob/living/simple_animal/hostile/asteroid/proc/glory()
	desc += "<br><b>[src] is staggered and can be glory killed!</b>"
	animate(src, color = "#00FFFF", time = 5)

/mob/living/simple_animal/hostile/asteroid/AltClick(mob/living/carbon/slayer)
	if(glorykill)
		if(do_after(slayer, 3, src))
			var/message
			if(!get_active_held_item() || (!istype(get_active_held_item(), /obj/item/twohanded/kinetic_crusher) && !istype(get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator)))
				message = pick(glorymessageshand)
			else if(istype(get_active_held_item(), /obj/item/twohanded/kinetic_crusher))
				message = pick(glorymessagescrusher)
			else if(istype(get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator))
				message = pick(glorymessagespka)
				var/obj/item/gun/energy/kinetic_accelerator/KA = get_active_held_item()
				if(KA && KA.bayonet)
					message = pick(glorymessagespka | glorymessagespkabayonet)
			if(message)
				visible_message("<span class='danger'>[slayer] [message]</span>")
			slayer.heal_overall_damage(gloryhealth,gloryhealth)
			playsound(src.loc, death_sound, 150, TRUE, -1)
			crusher_drop_mod *= 2
			gib()
		else
			to_chat(slayer, "<span class='danger'>You fail to glory kill [src]!</span>")
