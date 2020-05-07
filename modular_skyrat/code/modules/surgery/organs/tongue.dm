/obj/item/organ/tongue/lizard/
	modifies_speech = FALSE

/obj/item/organ/tongue/lizard/handle_speech(datum/source, list/speech_args)

/obj/item/organ/tongue/zombie
	name = "rotting tongue"
	desc = "Between the decay and the fact that it's just lying there you doubt a tongue has ever seemed less sexy."
	icon_state = "tonguezombie"
	say_mod = "moans"
	taste_sensitivity = 32
	maxHealth = 65 //Stop! It's already dead...!
	modifies_speech = TRUE

/obj/item/organ/tongue/zombie/handle_speech(datum/source, list/speech_args)
	var/list/message_list = splittext(speech_args[SPEECH_MESSAGE], " ")
	var/maxchanges = max(round(message_list.len / 1.5), 2)

	for(var/i = rand(maxchanges / 2, maxchanges), i > 0, i--)
		var/insertpos = rand(1, message_list.len - 1)
		var/inserttext = message_list[insertpos]

		if(!(copytext(inserttext, -3) == "..."))//3 == length("...")
			message_list[insertpos] = inserttext + "..."

		if(prob(20) && message_list.len > 3)
			message_list.Insert(insertpos, "[pick("grrgh", "raagh", "uughh", "rrrrgh")]...")

	speech_args[SPEECH_MESSAGE] = jointext(message_list, " ")

/obj/item/organ/tongue/alien/xenohybrid
	name = "xenomorph hybrid tongue"
	modifies_speech = FALSE

/obj/item/organ/tongue/robot_ipc
	name = "robotic voicebox"
	desc = "A voice synthesizer that can interface with organic lifeforms."
	status = ORGAN_ROBOTIC
	icon_state = "tonguerobot"
	say_mod = "beeps"
	attack_verb = list("beeped", "booped")
	modifies_speech = TRUE
	taste_sensitivity = 25 // not as good as an organic tongue
	maxHealth = 100 //RoboTongue!
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/robot_ipc/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT 