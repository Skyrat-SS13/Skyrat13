/obj/structure/flora/rock
	var/obj/item/stack/mineResult = /obj/item/stack/ore/glass/basalt

/obj/structure/flora/rock/attackby(obj/item/W, mob/user, params)
	if(mineResult && (!(flags_1 & NODECONSTRUCT_1)))
		if(W.tool_behaviour == TOOL_MINING)
			to_chat(user, "<span class='notice'>You start mining...</span>")
			if(W.use_tool(src, user, 40, volume=50))
				to_chat(user, "<span class='notice'>You finish mining the rock.</span>")
				new mineResult(get_turf(src), 20)
				SSblackbox.record_feedback("tally", "pick_used_mining", 1, W.type)
				qdel(src)
			return
	return ..()