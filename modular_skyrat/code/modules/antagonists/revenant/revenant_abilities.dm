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

//Harvest; activated ly clicking the target, will try to drain their essence.
/mob/living/simple_animal/revenant/Harvest(mob/living/carbon/human/target)
	if(!castcheck(0))
		return
	if(draining)
		to_chat(src, "<span class='revenwarning'>You are already siphoning the essence of a soul!</span>")
		return
	if(!target.stat)
		to_chat(src, "<span class='revennotice'>[target.p_their(TRUE)] soul is too strong to harvest.</span>")
		if(prob(10))
			to_chat(target, "You feel as if you are being watched.")
		return
	face_atom(target)
	draining = TRUE
	essence_drained += rand(15, 20)
	to_chat(src, "<span class='revennotice'>You search for the soul of [target].</span>")
	if(do_after(src, rand(10, 20), 0, target)) //did they get deleted in that second?
		if(target.ckey)
			to_chat(src, "<span class='revennotice'>[target.p_their(TRUE)] soul burns with intelligence.</span>")
			essence_drained += rand(20, 30)
		if(target.stat != DEAD)
			to_chat(src, "<span class='revennotice'>[target.p_their(TRUE)] soul blazes with life!</span>")
			essence_drained += rand(40, 50)
		else
			to_chat(src, "<span class='revennotice'>[target.p_their(TRUE)] soul is weak and faltering.</span>")
		if(do_after(src, rand(15, 20), 0, target)) //did they get deleted NOW?
			switch(essence_drained)
				if(1 to 30)
					to_chat(src, "<span class='revennotice'>[target] will not yield much essence. Still, every bit counts.</span>")
				if(30 to 70)
					to_chat(src, "<span class='revennotice'>[target] will yield an average amount of essence.</span>")
				if(70 to 90)
					to_chat(src, "<span class='revenboldnotice'>Such a feast! [target] will yield much essence to you.</span>")
				if(90 to INFINITY)
					to_chat(src, "<span class='revenbignotice'>Ah, the perfect soul. [target] will yield massive amounts of essence to you.</span>")
			if(do_after(src, rand(15, 25), 0, target)) //how about now
				if(!target.stat)
					to_chat(src, "<span class='revenwarning'>[target.p_theyre(TRUE)] now powerful enough to fight off your draining.</span>")
					to_chat(target, "<span class='boldannounce'>You feel something tugging across your body before subsiding.</span>")
					draining = 0
					essence_drained = 0
					return //hey, wait a minute...
				to_chat(src, "<span class='revenminor'>You begin siphoning essence from [target]'s soul.</span>")
				if(target.stat != DEAD)
					to_chat(target, "<span class='warning'>You feel a horribly unpleasant draining sensation as your grip on life weakens...</span>")
				reveal(46)
				stun(46)
				target.visible_message("<span class='warning'>[target] suddenly rises slightly into the air, [target.p_their()] skin turning an ashy gray.</span>")
				if(target.anti_magic_check(FALSE, TRUE))
					to_chat(src, "<span class='revenminor'>Something's wrong! [target] seems to be resisting the siphoning, leaving you vulnerable!</span>")
					target.visible_message("<span class='warning'>[target] slumps onto the ground.</span>", \
											   "<span class='revenwarning'>Violet lights, dancing in your vision, receding--</span>")
					draining = FALSE
					return
				var/datum/beam/B = Beam(target,icon_state="drain_life",time=INFINITY)
				if(do_after(src, 46, 0, target)) //As one cannot prove the existance of ghosts, ghosts cannot prove the existance of the target they were draining.
					change_essence_amount(essence_drained, FALSE, target)
					if(essence_drained <= 90 && target.stat != DEAD)
						essence_regen_cap += 5
						to_chat(src, "<span class='revenboldnotice'>The absorption of [target]'s living soul has increased your maximum essence level. Your new maximum essence is [essence_regen_cap].</span>")
					if(essence_drained > 90)
						essence_regen_cap += 15
						perfectsouls++
						to_chat(src, "<span class='revenboldnotice'>The perfection of [target]'s soul has increased your maximum essence level. Your new maximum essence is [essence_regen_cap].</span>")
					to_chat(src, "<span class='revennotice'>[target]'s soul has been considerably weakened and will yield no more essence for the time being.</span>")
					target.visible_message("<span class='warning'>[target] slumps onto the ground.</span>", \
										   "<span class='revenwarning'>Violets lights, dancing in your vision, getting closer..</span>")
					to_chat(target, "<span class='warning'>You feel awfully empty inside, this can't be good.</span>")
					drained_mobs.Add(target)
					//target.death(0)
					target.DefaultCombatKnockdown(150)
					target.adjustStaminaLoss(100)
				else
					to_chat(src, "<span class='revenwarning'>[target ? "[target] has":"[target.p_theyve(TRUE)]"] been drawn out of your grasp. The link has been broken.</span>")
					if(target) //Wait, target is WHERE NOW?
						target.visible_message("<span class='warning'>[target] slumps onto the ground.</span>", \
											   "<span class='revenwarning'>Violets lights, dancing in your vision, receding--</span>")
				qdel(B)
			else
				to_chat(src, "<span class='revenwarning'>You are not close enough to siphon [target ? "[target]'s":"[target.p_their()]"] soul. The link has been broken.</span>")
	draining = FALSE
	essence_drained = 0