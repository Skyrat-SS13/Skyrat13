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

/mob/living/carbon/enable_sprint_mode(update_icon)
	. = ..()
	var/leg_pain = 0
	//First, let's check for missing feet/legs. Missing any at all, we can't sprint.
	for(var/bodypart_check in list(BODY_ZONE_PRECISE_GROIN,
								BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT,
								BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_L_FOOT))
		var/obj/item/bodypart/big_walka = get_bodypart(bodypart_check)
		if(!big_walka)
			to_chat(src, "<span class='danger'>I can't sprint without a [parse_zone(bodypart_check)]!</span>")
			return FALSE
		//If we are not under painkillers, add the pain
		if(big_walka.get_pain() - chem_effects[CE_PAINKILLER] > 0)
			leg_pain += (big_walka.get_pain() - chem_effects[CE_PAINKILLER])
	if(leg_pain >= SHOCK_STAGE_2)
		to_chat(src, "<span class'danger'>It hurts to walk, let alone sprint!</span>")
		return FALSE
