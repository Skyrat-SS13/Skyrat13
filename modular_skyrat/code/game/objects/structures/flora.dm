/obj/structure/flora/biolumi
	name = "glowing plants"
	desc = "Several sticks with bulbous, bioluminescent tips."
	icon = 'modular_skyrat/icons/obj/flora/jungleflora.dmi'
	icon_state = "stick"
	gender = PLURAL
	light_range = 15
	light_power = 0.5
	max_integrity = 50
	var/variants = 9
	var/chosen_light
	var/base_icon
	var/list/random_light = list("#6AFF00","#00FFEE", "#D9FF00", "#FFC800")

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

/obj/structure/flora/biolumi/mine
	name = "glowing plant"
	desc = "Glowing sphere encased in jungle leaves."
	icon_state = "mine"
	variants = 4
	random_light = list("#FF0066","#00FFEE", "#D9FF00", "#FFC800")

/obj/structure/flora/biolumi/flower
	name = "glowing flower"
	desc = "Beautiful, bioluminescent flower."
	icon_state = "flower"
	variants = 2
	random_light = list("#6F00FF","#00FFEE", "#D9FF00", "#FF73D5")

/obj/structure/flora/biolumi/lamp
	name = "plant lamp"
	desc = "Bioluminescent plant much in a shape of a street lamp."
	icon_state = "lamp"
	variants = 2
	random_light = list("#6AFF00","#00FFEE", "#D9FF00", "#FFC800")

/obj/structure/flora/biolumi/mine/weaklight
	light_power = 0.3

/obj/structure/flora/biolumi/flower/weaklight
	light_power = 0.3

/obj/structure/flora/biolumi/lamp/weaklight
	light_power = 0.3
