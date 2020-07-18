//Do we have skrell? No. Did i include this anyway because we MIGHT have them in the future? Yes.
/datum/mob_descriptor/headtail_length
	name = "headtail length"
	chargen_label = "headtails (gender)"
	skip_species_mention = TRUE
	standalone_value_descriptors = list(
		"short",
		"long"
		)
	chargen_value_descriptors = list(
		"short (male)" =  1,
		"long (female)" = 2
		)

/datum/mob_descriptor/headtail_length/get_first_person_message_start()
	. = "Your headtails are"

/datum/mob_descriptor/headtail_length/get_third_person_message_start(mob/target)
	. = "[target.p_their(TRUE)] headtails are"

/datum/mob_descriptor/headtail_length/get_comparative_value_string_equivalent(my_value, mob/me, mob/other_mob)
	. = "indicating [other_mob.p_they()] [other_mob.p_are()] [my_value == 1 ? "male" : "female"] like you"

/datum/mob_descriptor/headtail_length/get_comparative_value_string_smaller(value, mob/me, mob/other_mob)
	. = "indicating [other_mob.p_they()] [other_mob.p_are()] male"

/datum/mob_descriptor/headtail_length/get_comparative_value_string_larger(value, mob/me, mob/other_mob)
	. = "indicating [other_mob.p_they()] [other_mob.p_are()] female"
