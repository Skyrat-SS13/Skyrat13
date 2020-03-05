/obj/item/bodypart
	var/render_like_organic = FALSE // TRUE is for when you want a BODYPART_ROBOTIC to pretend to be a BODYPART_ORGANIC.
	var/synthetic = FALSE //Synthetic bodyparts can have patches applied but are harder to repair by conventional means

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/heal_damage(brute, burn, stamina, only_robotic = FALSE, only_organic = TRUE, updating_health = TRUE)

	if(only_robotic && status != BODYPART_ROBOTIC) //This makes organic limbs not heal when the proc is in Robotic mode.
		return

	if(only_organic && status != BODYPART_ORGANIC) //This makes robolimbs not healable by chems.
		return

	brute_dam	= round(max(brute_dam - brute, 0), DAMAGE_PRECISION)
	burn_dam	= round(max(burn_dam - burn, 0), DAMAGE_PRECISION)
	stamina_dam = round(max(stamina_dam - stamina, 0), DAMAGE_PRECISION)
	if(owner && updating_health)
		owner.updatehealth()
	if(owner.dna && owner.dna.species && (REVIVESBYHEALING in owner.dna.species.species_traits))
		if(owner.health > owner.dna.species.revivesbyhealreq && !owner.hellbound)
			owner.revive(0)
			owner.cure_husk(0) // If it has REVIVESBYHEALING, it probably can't be cloned. No husk cure.
	consider_processing()
	update_disabled()
	return update_bodypart_damage_state()