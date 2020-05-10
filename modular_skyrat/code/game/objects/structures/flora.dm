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

/obj/structure/flora/biolumi
	name = "glowing plants"
	desc = "Several sticks with bulbous, bioluminescent tips."
	icon = 'modular_skyrat/icons/obj/flora/jungleflora.dmi'
	icon_state = "stick"
	gender = PLURAL
	light_range = 1.5
	light_power = 0.5
	max_integrity = 50
	var/variants = 9
	var/chosen_light
	var/base_icon
	var/static/list/random_light = list("#6aff00","#00ffee", "#d9ff00")

/obj/structure/flora/biolumi/Initialize()
	. = ..()
	base_icon = "[initial(icon_state)][rand(1,variants)]"
	icon_state = base_icon
	chosen_light = pick(random_light)
	light_color = chosen_light
	update_icon()

/obj/structure/flora/biolumi/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, "[base_icon]_light", ABOVE_LIGHTING_LAYER, ABOVE_LIGHTING_PLANE)
	if(chosen_light)
		var/obj/effect/overlay/vis/overlay = managed_vis_overlays[1]
		overlay.color = chosen_light