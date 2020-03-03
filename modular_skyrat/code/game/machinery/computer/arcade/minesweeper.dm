/obj/machinery/computer/arcade/minesweeper/explode_EVERYTHING()
	var/mob/living/user = usr
	to_chat(user, "<span class='boldwarning'>You feel a great sense of dread wash over you, as if you just unleashed armageddon upon yourself!</span>")
	message_admins("[key_name_admin(user)] failed an emagged Minesweeper arcade and has exploded at [AREACOORD(user)]!")
	explosion(loc, 1, 2, rand(1,5), rand(1,10))