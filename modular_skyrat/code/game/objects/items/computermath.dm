/obj/item/computermath
	icon = 'modular_skyrat/icons/obj/computermath.dmi'
	var/baldied = FALSE //Should it spawn baldi with enough wrong answers?
	var/baldicount = 2 //Number of baldis an emagged calculator can spawn
	var/wronglimit = 3
	var/wrongcounter = 0 //3 wrong answers on an emagged calculator will create an angry baldi

/obj/item/computermath/Initialize()
	..()

/obj/item/computermath/default
	name = "Unassigned Problem Computer"
	desc = "This Problem Computer has not been assigned yet. Earn points by solving math problems."
	icon_state = "defaulttab"

	var/static/radial_cargo = image(icon = 'modular_skyrat/icons/obj/computermath.dmi', icon_state = "cargotab")
	var/static/radial_science = image(icon = 'modular_skyrat/icons/obj/computermath.dmi', icon_state = "sciencetab")

	var/static/list/radial_options = list("cargo" = radial_cargo, "science" = radial_science)

/obj/item/computermath/default/attack_self(mob/user)
	var/choice = show_radial_menu(user, src, radial_options)
	switch(choice)
		if("cargo")
			var/obj/item/computermath/cargo/CT = new /obj/item/computermath/cargo(drop_location())
			CT.baldied = baldied
			qdel(src)
			user.put_in_active_hand(CT)
		if("science")
			var/obj/item/computermath/science/ST = new /obj/item/computermath/science(drop_location())
			ST.baldied = baldied
			qdel(src)
			user.put_in_active_hand(ST)

/obj/item/computermath/emag_act()
	to_chat(usr, "<span style='font-family: Comic Sans MS, Comic Sans, cursive;font-size: 45px;color: #ff0000;font-weight: bold'>I GET ANGRIER FOR EVERY PROBLEM YOU \
					GET WRONG</span>")
	baldied = TRUE
	obj_flags |= EMAGGED

/obj/item/computermath/cargo
	name = "Cargo Problem Computer"
	desc = "Earn points by solving math problems."
	icon_state = "cargotab"

/obj/item/computermath/cargo/attack_self(mob/user)
	var/operator = pick("add","subtract","multiply")
	var/num1 = rand(-999,999)
	var/num2 = rand(-999,999)
	var/mob/living/LM = user
	switch(operator)
		if("add")
			var/question = "What is [num1] + [num2]?"
			var/solution = num1 + num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSshuttle.points += 1000
				if(baldied)
					wrongcounter = max(wrongcounter - 1, 0)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(150, TRUE, TRUE)
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
				if(baldied)
					wrongcounter = min(wrongcounter + 1, wronglimit)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(-150, TRUE, TRUE)
		if("subtract")
			var/question = "What is [num1] - [num2]?"
			var/solution = num1 - num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSshuttle.points += 1000
				if(baldied)
					wrongcounter = max(wrongcounter - 1, 0)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(150, TRUE, TRUE)
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
				if(baldied)
					wrongcounter = min(wrongcounter + 1, wronglimit)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(-150, TRUE, TRUE)
		if("multiply")
			var/question = "What is [num1] * [num2]?"
			var/solution = num1 * num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSshuttle.points += 1000
				if(baldied)
					wrongcounter = max(wrongcounter - 1, 0)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(150, TRUE, TRUE)
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
				if(baldied)
					wrongcounter = min(wrongcounter + 1, wronglimit)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(-150, TRUE, TRUE)
	if(baldied)
		vibe_check(LM)

/obj/item/computermath/science
	name = "Science Problem Computer"
	desc = "Earn points by solving math problems."
	icon_state = "sciencetab"

/obj/item/computermath/science/attack_self(mob/user)
	var/operator = pick("add","subtract","multiply")
	var/num1 = rand(-999,999)
	var/num2 = rand(-999,999)
	var/mob/living/LM = user
	switch(operator)
		if("add")
			var/question = "What is [num1] + [num2]?"
			var/solution = num1 + num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
				if(baldied)
					wrongcounter = max(wrongcounter - 1, 0)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(150, TRUE, TRUE)
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
				if(baldied)
					wrongcounter = min(wrongcounter + 1, wronglimit)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(-150, TRUE, TRUE)
		if("subtract")
			var/question = "What is [num1] - [num2]?"
			var/solution = num1 - num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
				if(baldied)
					wrongcounter = max(wrongcounter - 1, 0)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(150, TRUE, TRUE)
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
				if(baldied)
					wrongcounter = min(wrongcounter + 1, wronglimit)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(-150, TRUE, TRUE)
		if("multiply")
			var/question = "What is [num1] * [num2]?"
			var/solution = num1 * num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
				if(baldied)
					wrongcounter = max(wrongcounter - 1, 0)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(150, TRUE, TRUE)
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
				if(baldied)
					wrongcounter = min(wrongcounter + 1, wronglimit)
					for(var/mob/living/simple_animal/hostile/baldi/B in GLOB.mob_living_list)
						B.adjustBruteLoss(-150, TRUE, TRUE)
	if(baldied)
		vibe_check(LM)

/obj/item/computermath/proc/vibe_check(mob/living/checked)
	if(baldied)
		if((wrongcounter >= wronglimit) && baldicount)
			baldicount = max(baldicount - 1, 0)
			wrongcounter = 0
			to_chat(checked, "<span style='font-family: Comic Sans MS, Comic Sans, cursive;font-size: 45px;color: #ff0000;font-weight: bold'>I HEAR MATH THAT BAD</span>")
			playsound(src.loc, 'modular_skyrat/sound/baldi/BAL_Screech.wav', 40, 0, 10)
			var/mob/living/simple_animal/hostile/baldi/boldi = new /mob/living/simple_animal/hostile/baldi(get_turf(checked))
			boldi.GiveTarget(checked)
