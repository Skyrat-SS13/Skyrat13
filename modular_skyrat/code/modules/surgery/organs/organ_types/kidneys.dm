/obj/item/organ/kidneys
	name = "kidneys"
	icon_state = "kidneys"
	gender = PLURAL
	slot = ORGAN_SLOT_KIDNEYS
	zone = BODY_ZONE_PRECISE_GROIN
	low_threshold = 25
	high_threshold = 45
	maxHealth = 70
	relative_size = 15
	//Reagents associated with the damage they deal when metabolized, if the kidney is damaged
	var/list/bad_reagents = list(
		/datum/reagent/consumable/coffee = 0.1,
	)

/obj/item/organ/kidneys/on_life()
	. = ..()
	if(!owner)
		return

	for(var/i in bad_reagents)
		var/bad = owner.reagents.get_reagent_amount(i)
		if(bad)
			if(damage >= low_threshold)
				owner.adjustToxLoss(bad_reagents[i])
			else if(damage >= high_threshold)
				owner.adjustToxLoss(bad_reagents[i] * 3)

	if(damage >= low_threshold)
		if(prob(5) && owner.reagents.get_reagent_amount(/datum/reagent/potassium) < 5)
			owner.reagents.add_reagent(/datum/reagent/potassium, REM*5)
	
	if(damage >= high_threshold)
		if(owner.reagents.get_reagent_amount(/datum/reagent/potassium) < 15)
			owner.reagents.add_reagent(/datum/reagent/potassium, REM*2)

	//If your kidneys aren't working, your body's going to have a hard time cleaning your blood.
	if(!owner.chem_effects[CE_ANTITOX])
		if(prob(33))
			if(damage >= high_threshold)
				owner.adjustToxLoss(0.5)
			if(status & ORGAN_FAILING)
				owner.adjustToxLoss(1)
