/datum/reagent/romerol
	name = "Necrotizing Nanites"
	// the REAL zombie powder
	description = "A highly experimental mixture of specially programmed and jailbroken \
	nanomachines, set with the goal of spreading themselves through any viable host they can \
	find. Lord knows what would happen if these got into a corpse..."
	color = "#535452" // RGB (18, 53, 36) <--- Get a load of this guy.
	taste_description = "copper"



/datum/reagent/tranquility
	name = "Gondola Essence"
	description = "A highly mutative liquid of unknown origin."
	color = "#9A6750" //RGB: 154, 103, 80
	taste_description = "inner peace"
	can_synth = FALSE

/datum/reagent/tranquility/reaction_mob(mob/living/L, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)

	if(method == VAPOR || method == TOUCH)
		L.apply_status_effect(STATUS_EFFECT_PACIFY, 10 * reac_volume)
		return

	if(iscarbon(L) && prob(100 * (volume/15)))
		var/mob/living/carbon/C = L
		C.gain_trauma(/datum/brain_trauma/severe/pacifism, TRAUMA_RESILIENCE_LOBOTOMY)

/datum/reagent/gondolatoxin
	name = "Gondola Mutation Toxin"
	description = "An advanced corruptive toxin produced by slimes, but modifed by Gondola juice."
	color = "#9A6750" // rgb: 19, 188, 94
	taste_description = "outer peace"

/datum/reagent/gondolatoxin/reaction_mob(mob/living/L, method=TOUCH, reac_volume)
	if(method != TOUCH)
		L.ForceContractDisease(new /datum/disease/transformation/gondola(), FALSE, TRUE)