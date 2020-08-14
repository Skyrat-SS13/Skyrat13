/mob/living/simple_animal/hostile/scp
	name = "SCP"
	desc = "parent SCP"
	maxHealth = 5000
	health = 5000
	move_to_delay = 0
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS

	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	sight = SEE_SELF|SEE_MOBS|SEE_OBJS|SEE_TURFS
	
/mob/living/simple_animal/hostile/scp173/UnarmedAttack(atom/A)
	if(A == src)
		return
	if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
		if(!do_after(src, 5 SECONDS, FALSE, A))
			return
		qdel(A)
	else if(istype(A, /obj/machinery/door))
		var/obj/machinery/door/D = A
		if(!D.density)
			return
		if(D.locked)
			if(!do_after(src, 5 SECONDS, FALSE, D))
				return
			D.locked = FALSE
			return
		if(D.welded)
			if(!do_after(src, 5 SECONDS, FALSE, D))
				return
			D.welded = FALSE
			return
		if(!do_after(src, 5 SECONDS, FALSE, D))
			return
		D.open()
