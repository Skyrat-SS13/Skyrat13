//Jukebox searching
/obj/machinery/jukebox/Topic(href, href_list)
	if(..())
		return
	add_fingerprint(usr)
	switch(href_list["action"])
		if("toggle")
			if (QDELETED(src))
				return
			if(!active)
				if(stop > world.time)
					to_chat(usr, "<span class='warning'>Error: The device is still resetting from the last activation, it will be ready again in [DisplayTimeText(stop-world.time)].</span>")
					playsound(src, 'sound/misc/compiler-failure.ogg', 50, 1)
					return
				if(!istype(selection))
					to_chat(usr, "<span class='warning'>Error: Severe user incompetence detected.</span>")
					playsound(src, 'sound/misc/compiler-failure.ogg', 50, 1)
					return
				if(!activate_music())
					to_chat(usr, "<span class='warning'>Error: Generic hardware failure.</span>")
					playsound(src, 'sound/misc/compiler-failure.ogg', 50, 1)
					return
				updateUsrDialog()
			else if(active)
				stop = 0
				updateUsrDialog()
		if("select")
			if(active)
				to_chat(usr, "<span class='warning'>Error: You cannot change the song until the current one is over.</span>")
				return

			var/list/available = list()
			var/search = input(usr, "Input what track you are looking for. Not inputing means every song will be displayed.", "Search") as null|text
			for(var/datum/track/S in SSjukeboxes.songs)
				if(!search)
					available[S.song_name] = S
				else
					if(findtext(S.song_name, search))
						available[S.song_name] = S

			var/selected = input(usr, "Choose your song", "Track:") as null|anything in available
			if(QDELETED(src) || !selected || !istype(available[selected], /datum/track))
				return
			selection = available[selected]
			updateUsrDialog()
