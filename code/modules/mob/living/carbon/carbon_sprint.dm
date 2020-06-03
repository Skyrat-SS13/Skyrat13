/// Sprint buffer ///
/mob/living/carbon/doSprintLossTiles(tiles)
	doSprintBufferRegen(FALSE)		//first regen.
	if(sprint_buffer)
		var/use = min(tiles, sprint_buffer)
		//SKYRAT CHANGE - asthma quirk
		if(HAS_TRAIT(src, TRAIT_ASTHMATIC))
			use *= 2
		//
		sprint_buffer -= use
		tiles -= use
	update_hud_sprint_bar()
	if(!tiles || (tiles < 0))		//we had enough, we're done! //skyrat change - asthma
		return
	adjustStaminaLoss(tiles * sprint_stamina_cost)		//use stamina to cover deficit.
	//SKYRAT CHANGE - asthma quirk
	if(HAS_TRAIT(src, TRAIT_ASTHMATIC))
		if(prob(tiles * 5))
			adjustOxyLoss(rand(1 * tiles,5 * tiles), TRUE)
			if(prob(25))
				to_chat(src, "<span class='danger'><i>You struggle to breathe.</i></span>")
	//

/mob/living/carbon/proc/doSprintBufferRegen(updating = TRUE)
	var/diff = world.time - sprint_buffer_regen_last
	sprint_buffer_regen_last = world.time
	//SKYRAT CHANGE - asthma
	if(!HAS_TRAIT(src, TRAIT_ASTHMATIC))
		sprint_buffer = min(sprint_buffer_max, sprint_buffer + sprint_buffer_regen_ds * diff)
	else
		sprint_buffer = min(sprint_buffer_max, sprint_buffer + (sprint_buffer_regen_ds/2) * diff)
	//
	if(updating)
		update_hud_sprint_bar()
