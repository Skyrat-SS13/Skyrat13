/*
	Small, mechanically supported physical customisation options.
	Also allows for per-species physical information ('his neck markings are more important than yours').
	No need for dick and tiddy descriptors because we have actual organs for those.
	Ported from Baystation by Bob Joga. Original code by MistakeNot4892.
*/
/datum/mob_descriptor
	var/name                                       // String ident.
	var/chargen_label                              // String ident for chargen.
	var/default_value                              // Initial value for this descriptor.
	var/current_value = 0                      // Used for examining similar properties between different species.
	var/comparative_value_descriptor_equivalent    // String for looking at someone with roughly the same property.
	var/list/standalone_value_descriptors          // String set for initial descriptor text.
	var/list/comparative_value_descriptors_smaller // String set for looking at someone smaller than you.
	var/list/comparative_value_descriptors_larger  // String set for looking at someone larger than you.
	var/list/chargen_value_descriptors             // Used for chargen selection of values in cases where there is a hidden meaning.
	var/skip_species_mention

/datum/mob_descriptor/New()
	if(!chargen_label)
		chargen_label = name
	if(!chargen_value_descriptors)
		chargen_value_descriptors = list()
		for(var/i = 1 to LAZYLEN(standalone_value_descriptors))
			chargen_value_descriptors[standalone_value_descriptors[i]] = i
	default_value = round(LAZYLEN(standalone_value_descriptors) * 0.5, 1)
	..()

/datum/mob_descriptor/proc/get_third_person_message_start(mob/target)
	return "[target.p_they(TRUE)] [target.p_are()]"

/datum/mob_descriptor/proc/get_first_person_message_start()
	return "You are"

/datum/mob_descriptor/proc/get_standalone_value_descriptor(check_value)
	if(isnull(check_value) || istext(check_value))
		check_value = default_value
	if(check_value && LAZYLEN(standalone_value_descriptors) >= check_value)
		return standalone_value_descriptors[check_value]

// Build a species-specific descriptor string.
/datum/mob_descriptor/proc/get_initial_comparison_component(mob/me, mob/other_mob, my_value)
	var/species_text
	if(ishuman(me) && !skip_species_mention)
		var/mob/living/carbon/human/H = me
		var/use_name = "\improper [H.dna.species.name]"
		species_text = " for \a [use_name]"
	. = "[get_third_person_message_start(me)] [get_standalone_value_descriptor(my_value)][species_text]"

/datum/mob_descriptor/proc/get_secondary_comparison_component(mob/me, mob/other_mob, my_value, comparing_value)
	var/variance = abs((my_value)-comparing_value)
	if(variance == 0)
		. = "[.], [get_comparative_value_string_equivalent(me, other_mob, my_value)]"
	else
		variance = variance / LAZYLEN(standalone_value_descriptors)
		if(my_value < comparing_value)
			. = "[.], [get_comparative_value_string_smaller(me, other_mob, variance)]"
		else if(my_value > comparing_value)
			. = "[.], [get_comparative_value_string_larger(me, other_mob, variance)]"

/datum/mob_descriptor/proc/get_comparative_value_descriptor(mob/me, mob/other_mob, my_value)
	. = get_initial_comparison_component(me, other_mob, my_value)

	// Append the same-descriptor comparison text.
	var/comparing_value
	if(ishuman(other_mob))
		var/mob/living/carbon/human/human_other_mob = other_mob
		if(LAZYLEN(human_other_mob.dna.species.descriptors) && !isnull(human_other_mob.dna.species.descriptors[name]) && !isnull(human_other_mob.dna.species.descriptors[name]))
			var/datum/mob_descriptor/obs_descriptor = human_other_mob.dna.species.descriptors[name]
			comparing_value = obs_descriptor.current_value

	if(. && !isnull(comparing_value))
		. = "[.][get_secondary_comparison_component(me, other_mob, my_value, comparing_value)]"

	// We're done, add a full stop.
	. = "[.]. "

/datum/mob_descriptor/proc/get_comparative_value_string_equivalent(mob/me, mob/other_mob, my_value)
	return comparative_value_descriptor_equivalent

/datum/mob_descriptor/proc/get_comparative_value_string_smaller(mob/me, mob/other_mob, my_value)
	var/maxval = LAZYLEN(comparative_value_descriptors_smaller)
	my_value = clamp(round(my_value * maxval), 1, maxval)
	return comparative_value_descriptors_smaller[my_value]

/datum/mob_descriptor/proc/get_comparative_value_string_larger(mob/me, mob/other_mob, my_value)
	var/maxval = LAZYLEN(comparative_value_descriptors_larger)
	my_value = clamp(round(my_value * maxval), 1, maxval)
	return comparative_value_descriptors_larger[my_value]
