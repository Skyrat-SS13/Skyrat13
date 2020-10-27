/obj/machinery/computer/arcade
	var/prize = /obj/item/stack/tickets

/obj/machinery/computer/arcade/proc/prizevend(mob/user, var/score)
	SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "arcade", /datum/mood_event/arcade)

	if(prob(1) && prob(1) && prob(1)) //Proper 1 in a million
		new /obj/item/gun/energy/pulse/prize(src)
		SSmedals.UnlockMedal(MEDAL_PULSE, usr.client)

	if(!contents.len)
		var/prize_amount
		if(score)
			prize_amount = score
		else
			prize_amount = rand(10, 30)
		new prize(get_turf(src), prize_amount)
	else
		var/atom/movable/prize = pick(contents)
		visible_message("<span class='notice'>[src] dispenses [prize]!</span>", "<span class='notice'>You hear a chime and a clunk.</span>")
		prize.forceMove(get_turf(src))
