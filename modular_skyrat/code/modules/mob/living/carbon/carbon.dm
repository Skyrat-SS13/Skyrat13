//skyrat meme
/mob/living/carbon/proc/create_bodyparts()
	var/l_hand_index_next = -1
	var/r_hand_index_next = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/O = new X()
		O.owner = src
		bodyparts.Remove(X)
		bodyparts.Add(O)
		if(O.body_part == HAND_LEFT)
			l_hand_index_next += 2
			O.held_index = l_hand_index_next //1, 3, 5, 7...
			hand_bodyparts += O
		else if(O.body_part == HAND_RIGHT)
			r_hand_index_next += 2
			O.held_index = r_hand_index_next //2, 4, 6, 8...
			hand_bodyparts += O

/mob/living/carbon/Move(atom/newloc, direct = 0)
	. = ..()
	if(gunpointing)
		var/dir = get_dir(get_turf(gunpointing.source),get_turf(gunpointing.target))
		if(dir)
			setDir(dir)

