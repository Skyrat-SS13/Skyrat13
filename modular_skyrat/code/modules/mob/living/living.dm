/mob/living/MobBump(mob/M)
	. = ..()
	if(M.gunpointed.len)
		if(!(world.time % 5))
			to_chat(src, "<span class='warning'>[M] is being held at gunpoint, it's not wise to push him.</span>")
		return 1
	var/mob/living/carbon/C = M
	if(C && C.gunpointed)
		if(!(world.time % 5))
			to_chat(src, "<span class='warning'>[C] is holding someone at gunpoint, you cannot push past.</span>")
		return 1