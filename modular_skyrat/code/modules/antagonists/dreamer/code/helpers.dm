/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(is_dreamer(user))
		var/datum/antagonist/dreamer/dreamer
		for(var/datum/antagonist/dreamening in user.mind.antag_datums)
			dreamer = dreamening
		if(!dreamer)
			return
		var/obj/item/organ/heart/heart = getorganslot(ORGAN_SLOT_HEART)
		if(heart && heart.etching && (heart.etching in dreamer.heart_keys))
			. -= "*---------*</span>"
			. += "<span class='warning'>[p_they(TRUE)] know[p_they() != "they" ? "s" : ""] the [dreamer.heart_keys[heart.etching]] key, i'm sure of it!</span>"
			. += "*---------*</span>"

/proc/is_dreamer(mob/living/M)
	return M && M.mind && M.mind.has_antag_datum(/datum/antagonist/dreamer)

/mob/add_memory(msg as text)
	..()
	if(is_dreamer(src))
		var/datum/antagonist/dreamer/dreamer
		for(var/datum/antagonist/dreamer/dreammy in mind.antag_datums)
			dreamer = dreammy
		if(text2num(msg) == dreamer.sum_keys)
			dreamer.wake_up()
