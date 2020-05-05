/datum/reagent/romerol
	name = "Necrotizing Nanites"
	// the REAL zombie powder
	description = "A highly experimental mixture of specially programmed and jailbroken \
	nanomachines, set with the goal of spreading themselves through any viable host they can \
	find. Lord knows what would happen if these got into a corpse..."
	color = "#535452" // RGB (18, 53, 36) <--- Get a load of this guy.
	taste_description = "copper"

/datum/reagent/blood/on_new(list/data)
	if(istype(data))
		SetViruses(src, data)
		color = bloodtype_to_color(data["blood_type"])
		if(data["blood_type"] == "SY")
			name = "Synthetic Blood"
			taste_description = "oil"

		if(data["blood_type"] == "X*")
			name = "Xenomorph Blood"
			taste_description = "acidic heresy"
			shot_glass_icon_state = "shotglassgreen"
			pH = 2.5

		if(data["blood_type"] == "HF")
			name = "Hydraulic Fluid"
			taste_description = " oil"
			pH = 9.75

		if(data["blood_type"] == "BUG")
			name = "Insect Blood"
			taste_description = "grease"
			pH = 7.25

		if(data["blood_type"] == "L")
			name = "Lizard Blood"
			taste_description = "something spicy"
			pH = 6.85

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


/datum/reagent/fuel
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/oil
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/stable_plasma
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/pax
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/water
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/hellwater
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/syndicateadrenals
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/stable_plasma/on_mob_life(mob/living/carbon/C)
	if(C.isRobotic())
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

/datum/reagent/fuel/on_mob_life(mob/living/carbon/C)
	if(C.isRobotic())
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..()

/datum/reagent/oil/on_mob_life(mob/living/carbon/C)
	if(C.isRobotic() && C.blood_volume < (BLOOD_VOLUME_NORMAL*C.blood_ratio))
		C.blood_volume += 0.5
	..() 
