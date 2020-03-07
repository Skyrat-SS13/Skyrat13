/obj/effect/proc_holder/spell/targeted/togglevisibility
	name = "Reveal"
	desc = "Reveal or conceal yourself from the mortals if you wish to speak with them, this does not make you vulnerable."
	charge_max = 30
	panel = "Revenant Abilities"
	clothes_req = 0
	range = -1
	include_user = 1
	action_icon = 'modular_skyrat/icons/mob/actions/actions_revenant.dmi'
	action_icon_state = "reveal"
	action_background_icon_state = "bg_revenant"

/obj/effect/proc_holder/spell/targeted/togglevisibility/cast(list/targets, mob/living/simple_animal/revenant/user = usr)
	if(user.revealed)
		return

	user.visible = !user.visible
	if(user.visible)
		user.set_visibility(user.visible)
		user.visible_message("<span class='notice'>[user] subtly reveals himself...</span>",\
		 "<span class='notice'>You reveal yourself to the mortals.</span>")
	else
		user.set_visibility(user.visible)
		user.visible_message("<span class='notice'>[user] dissipates into nothingness...</span>",\
		 "<span class='notice'>You hide yourself from the mortals.</span>")
	
/obj/effect/proc_holder/spell/aoe_turf/revenant/defile/defile(turf/T)
	for(var/obj/effect/blessing/B in T)
		qdel(B)
		new /obj/effect/temp_visual/revenant(T)

	if(!isplatingturf(T) && !istype(T, /turf/open/floor/engine/cult) && isfloorturf(T) && prob(15))
		var/turf/open/floor/floor = T
		if(floor.intact && floor.floor_tile)
			new floor.floor_tile(floor)
		floor.broken = 0
		floor.burnt = 0
		floor.make_plating(1)
	if(T.type == /turf/closed/wall && prob(15))
		new /obj/effect/temp_visual/revenant(T)
		T.ChangeTurf(/turf/closed/wall/rust)
	if(T.type == /turf/closed/wall/r_wall && prob(10))
		new /obj/effect/temp_visual/revenant(T)
		T.ChangeTurf(/turf/closed/wall/r_wall/rust)
	for(var/obj/effect/decal/cleanable/salt/salt in T)
		new /obj/effect/temp_visual/revenant(T)
		qdel(salt)
	for(var/obj/structure/closet/closet in T.contents)
		closet.open()
	for(var/obj/structure/bodycontainer/corpseholder in T)
		if(corpseholder.connected.loc == corpseholder)
			corpseholder.open()
	for(var/obj/machinery/dna_scannernew/dna in T)
		dna.open_machine()
	for(var/obj/structure/window/window in T)
		if(!istype(window, /obj/structure/window/reinforced))
			window.take_damage(rand(30,80))
			if(window && window.fulltile)
				new /obj/effect/temp_visual/revenant/cracks(window.loc)
		else
			var/maxdmg = rand(30,80)
			if(maxdmg > (window.obj_integrity-20))
				maxdmg = window.obj_integrity-20
			window.take_damage(maxdmg)
			if(window && window.fulltile)
				new /obj/effect/temp_visual/revenant/cracks(window.loc)
	for(var/obj/machinery/light/light in T)
		light.flicker(20) //spooky

/obj/effect/proc_holder/spell/aoe_turf/flicker_lights/revenant
	name = "Flicker Lights"
	desc = "You will trigger a large amount of lights around you to flicker."
	panel = "Revenant Abilities"
	charge_max = 1200
	clothes_req = 0
	range = 14
	action_background_icon_state = "bg_revenant"
	action_icon = 'icons/mob/actions/actions_clockcult.dmi'
	action_icon_state = "Kindle"