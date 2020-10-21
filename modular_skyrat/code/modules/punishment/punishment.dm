//Sometimes, fraglist aint enough
GLOBAL_LIST_INIT(fraggots, world.file2list('config/fraggots.txt'))

/mob
	var/fraggot = FALSE

/mob/transfer_ckey(mob/new_mob, send_signal)
	. = ..()
	if(ckey in GLOB.fraggots)
		fraggot = TRUE
		new_mob.fraggot = TRUE
	//Announce to every player but the fraggot
	for(var/client/C in (GLOB.clients - client))
		to_chat(C, "<span class='warning'><span class='bigbold'>[emoji_parse(":killher:")][new_mob] IS A FRAGGOT! KILL HER! KILL HER![emoji_parse(":killher:")]</span>")

/mob/living/Life(seconds, times_fired)
	. = ..()
	//Fragots effects
	if(fraggot)
		//Earrape
		if(prob(5))
			var/bees = pick('modular_skyrat/sound/fraggot/p1.ogg', 'modular_skyrat/sound/fraggot/p1.ogg')
			playsound_local(get_turf(src), bees, 200)
		//Chat spam
		if(prob(25))
			to_chat(src, "<span class='userdanger'>BIG CHUNGUS LOLOLOLOLLLLOLOLOLO!!!!</span>")
		if(prob(25))
			to_chat(src, "<span class='userdanger'>BIG CHUNGUS LOLOLOLOLLLLOLOLOLO!!!!</span>")
		if(prob(25))
			to_chat(src, "<span class='userdanger'>BIG CHUNGUS LOLOLOLOLLLLOLOLOLO!!!!</span>")
		if(prob(25))
			to_chat(src, "<span class='userdanger'>BIG CHUNGUS LOLOLOLOLLLLOLOLOLO!!!!</span>")
		//Screaming
		if(prob(10))
			agony_scream()
		//One man one jar lol
		if(prob(5))
			src << link("https://cdn.discordapp.com/attachments/757793833605136396/768548480485818408/1man1jar.mp4")

//Killing fraggots gives you bobux
/mob/living/death(gibbed)
	. = ..()
	if(fraggot)
		for(var/mob/M in range(7, src))
			if(M.client?.prefs)
				M.client.prefs.adjust_bobux(1, "<span class='bobux'>You have seen a fraggot die! +1 bobux!</span>")
