/datum/job
	///Levels unlocked at roundstart in physiology
	var/list/roundstart_experience

//Only override this proc
//H is usually a human unless an /equip override transformed it
/datum/job/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	//do actions on H but send messages to M as the key may not have been transferred_yet
	if(mind_traits)
		for(var/t in mind_traits)
			ADD_TRAIT(H.mind, t, JOB_TRAIT)
	if(roundstart_experience && ishuman(H))
		var/mob/living/carbon/human/experiencer = H
		for(var/i in roundstart_experience)
			experiencer.mind.adjust_experience(i, roundstart_experience[i], TRUE)