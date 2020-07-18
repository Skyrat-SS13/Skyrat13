/datum/reagent/toxin/plasma
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/toxin/acid
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/toxin/chloralhydrate
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Chloral hydrate, tirizene and mute toxin are contents of sleeping pen. Probably up to debate whether synths should or should not be affected by such things, maybe sleepy pen should have a unique chem so chloral won't work on synths

/datum/reagent/toxin/staminatoxin
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/toxin/mutetoxin
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/plasma/on_mob_life(mob/living/carbon/C)
	if(C.isRobotic())
		C.nutrition = min(C.nutrition + 5, NUTRITION_LEVEL_FULL-1)
	..() 