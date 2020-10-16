//Special attacks (kicking and biting)
/mob/living/carbon
	var/special_attack = SPECIAL_ATK_NONE

//Verb for switching between none, kick and bite
/mob/verb/kick_bite()
	set name = "Kick/Bite"
	set category = "IC"
	set desc = "Kicking or biting, or none of them."

	if(!ishuman(src))
		to_chat(src, "<span class='warning'>My inhuman form is incapable of doing special attacks.</span>")
		return

	var/mob/living/carbon/human/H = src
	switch(H.special_attack)
		if(SPECIAL_ATK_NONE)
			H.special_attack = SPECIAL_ATK_KICK
			to_chat(src, "<span class='notice'>I will now try to kick my targets.</span>")
		if(SPECIAL_ATK_KICK)
			H.special_attack = SPECIAL_ATK_BITE
			to_chat(src, "<span class='notice'>I will now try to bite my targets.</span>")
		if(SPECIAL_ATK_BITE)
			H.special_attack = SPECIAL_ATK_NONE
			to_chat(src, "<span class='notice'>I will now attack my targets normally.</span>")
