/mob/living/carbon/human/var/auto_hiss = FALSE

/mob/living/carbon/human/proc/toggle_hiss()
	toggle_speech_mod(/datum/speech_mod/auto_hiss)

/mob/living/carbon/human/verb/toggle_auto_hiss()
	set name = "Toggle Auto-Hiss"
	set category = "IC"
	
	toggle_hiss()
