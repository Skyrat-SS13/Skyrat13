GLOBAL_LIST_INIT(chem_effect_caps, list(
	CE_PAINKILLER = 125,
))

//Add a chemical effect
/mob/living/carbon/proc/add_chem_effect(effect, magnitude = 1)
	if(effect in chem_effects)
		chem_effects[effect] += magnitude
		if(GLOB.chem_effect_caps[effect])
			chem_effects[effect] = min(GLOB.chem_effect_caps[effect], chem_effects[effect])
	else
		chem_effects[effect] = magnitude
		if(GLOB.chem_effect_caps[effect])
			chem_effects[effect] = min(GLOB.chem_effect_caps[effect], chem_effects[effect])

/mob/living/carbon/proc/add_up_to_chem_effect(effect, magnitude = 1)
	if(effect in chem_effects)
		chem_effects[effect] = max(magnitude, chem_effects[effect])
		if(GLOB.chem_effect_caps[effect])
			chem_effects[effect] = min(GLOB.chem_effect_caps[effect], chem_effects[effect])
	else
		chem_effects[effect] = magnitude
		if(GLOB.chem_effect_caps[effect])
			chem_effects[effect] = min(GLOB.chem_effect_caps[effect], chem_effects[effect])

/mob/living/carbon/proc/remove_chem_effect(effect, magnitude = 1)
	if(effect in chem_effects)
		chem_effects[effect] = max(0, chem_effects[effect] - magnitude)
