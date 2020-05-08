/obj/item/computermath
	icon = 'modular_skyrat/icons/obj/computermath.dmi'

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
			qdel(src)
			user.put_in_active_hand(CT)
		if("science")
			var/obj/item/computermath/science/ST = new /obj/item/computermath/science(drop_location())
			qdel(src)
			user.put_in_active_hand(ST)

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
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
		if("subtract")
			var/question = "What is [num1] - [num2]?"
			var/solution = num1 - num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSshuttle.points += 1000
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
		if("multiply")
			var/question = "What is [num1] * [num2]?"
			var/solution = num1 * num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSshuttle.points += 1000
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)

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
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
		if("subtract")
			var/question = "What is [num1] - [num2]?"
			var/solution = num1 - num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
		if("multiply")
			var/question = "What is [num1] * [num2]?"
			var/solution = num1 * num2
			var/answer = input(user, question, "Math Problem") as null|num
			if(answer == solution)
				to_chat(user,"Correct")
				SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
			else
				to_chat(user,"Incorrect")
				LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)