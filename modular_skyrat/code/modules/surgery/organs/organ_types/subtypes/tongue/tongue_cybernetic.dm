
/obj/item/organ/tongue/cybernetic
	name = "cybernetic tongue"
	desc = "A state of the art robotic tongue that can detect the pH of anything drank."
	icon_state = "tonguecybernetic"
	taste_sensitivity = 10
	maxHealth = 60 //It's robotic!
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/tongue/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	var/errormessage = list("Runtime in tongue.dm, line 39: Undefined operation \"zapzap ow my tongue\"", "afhsjifksahgjkaslfhashfjsak", "-1.#IND", "Graham's number", "inside you all along", "awaiting at least 1 approving review before merging this taste request")
	owner.say("The pH is appropriately [pick(errormessage)].", forced = "EMPed synthetic tongue")

/obj/item/organ/tongue/cybernetic/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_SPANS] |= SPAN_ROBOT
