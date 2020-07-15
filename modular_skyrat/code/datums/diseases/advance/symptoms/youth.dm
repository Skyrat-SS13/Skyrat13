//only serves to buff a virus, but lowers your character's age
/datum/symptom/youth
	name = "Eternal Youth"
	stealth = 3
	resistance = 4
	stage_speed = 4
	transmittable = -4
	level = 5
	base_message_chance = 100
	symptom_delay_min = 25
	symptom_delay_max = 50

/datum/symptom/youth/Activate(datum/disease/advance/A)
	..()
	if(prob(5))
		var/mob/living/M = A.affected_mob
		if(istype(M, /mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			switch(H.age)
				if(60 to INFINITY)
					to_chat(H, "<span class='notice'>You feel like you're in the olden days.</span>")
				if(40 to 60)
					to_chat(H, "<span class='notice'>Your skin feels a little bit less wrinkly.</span>")
				if(30 to 40)
					to_chat(H, "<span class='notice'>You feel surprisingly refreshed and energized.</span>")
				if(20 to 30)
					to_chat(H, "<span class='notice'>You feel like you're still in your teenage years.</span>")
				else
					to_chat(H, "<span class='notice'>You feel as energetic as an overactive child!</span>")
			H.age = max(H.age - rand(1,2), 18)
	return
