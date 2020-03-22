/*
//////////////////////////////////////
Breastopia

	Noticeable.
	Increases resistance.
	Increases stage speed.
	Neutral transmission.
	Critical Level.

BONUS
	Makes the mob grow breast.

//////////////////////////////////////
*/

/datum/symptom/breastopia
	name = "Breast Disaster"
	desc = "The virus synthesizes succubus milk in host's blood."
	stealth = -1
	resistance = 2
	stage_speed = 2
	transmittable = 0
	level = 6
	severity = 1
	symptom_delay_min = 7
	symptom_delay_max = 14
	var/wombat = FALSE
	var/quiet = FALSE
	threshold_desc = list(
		"Resistance 8" = "Twices the amount of succubus.",
		"Stealth 4" = "The symptom remains hidden until active.",
	)

/datum/symptom/breastopia/Start(datum/disease/advance/A)
	if(!..())
		return
	if(A.properties["stealth"] >= 4)
	 quiet = TRUE
	if(A.properties["resistance"] >= 8)
	 wombat = TRUE


/datum/symptom/breastopia/Activate(datum/disease/advance/A)
	if(!..())
		return
	var/mob/living/M = A.affected_mob
	var/list/feelstage12_messages = list("Your chest feels warm.","Your chest feels strangely.","Your chest itches.")
	var/list/feelstage3_messages = list("Your chest sting a little.","Your chest feels hot.","Your chest is wet!")
	switch(A.stage)
	 if(1, 2)
	  if (prob(50) && !quiet)
	   to_chat(M,"<span class='warning'>[pick(feelstage12_messages)]</span>")
	  if (prob(50) && !quiet)
	   M.emote("blush")
	 if(3)
	  if (prob(50) && !quiet)
	   to_chat(M,"<span class='warning'>[pick(feelstage3_messages)]</span>")
	  if (prob(50) && !quiet)
	   M.emote("blush")
	 if(4)
	  if (!(M.client?.prefs.cit_toggles & BREAST_ENLARGEMENT) && (wombat = TRUE))
	   if(M.reagents.total_volume <= (M.reagents.maximum_volume/15)) // no flooding humans with 1000 units of incubus
	    M.reagents.add_reagent(/datum/reagent/fermi/breast_enlarger, 2)
	  else
	   if(M.reagents.total_volume <= (M.reagents.maximum_volume/15))
	    M.reagents.add_reagent(/datum/reagent/fermi/breast_enlarger, 1)
	 if(5)
	  if (!(M.client?.prefs.cit_toggles & BREAST_ENLARGEMENT) && (wombat = TRUE))
	   if(M.reagents.total_volume <= (M.reagents.maximum_volume/30))
	    M.reagents.add_reagent(/datum/reagent/fermi/breast_enlarger, 10)
	  else
	   if(M.reagents.total_volume <= (M.reagents.maximum_volume/30))
	    M.reagents.add_reagent(/datum/reagent/fermi/breast_enlarger, 5)