/datum/surgery/mechanic_plastic_surgery
	name = "Robotic factory reset"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_unwrench,
				/datum/surgery_step/open_hatch,
				/datum/surgery_step/mechanic_reshape_face,
				/datum/surgery_step/mechanic_close)
	possible_locs = list(BODY_ZONE_HEAD)
	requires_bodypart_type = BODYPART_ROBOTIC

//reshape face
/datum/surgery_step/mechanic_reshape_face
	name = "Perform factory reset"
	implements = list(TOOL_SCREWDRIVER = 100, TOOL_CROWBAR = 65, TOOL_HEMOSTAT = 60, TOOL_DRILL = 30)
	time = 64

/datum/surgery_step/mechanic_reshape_face/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to alter [target]'s appearance...</span>",
		"[user] begins to alter [target]'s appearance.",
		"[user] begins to press into a hole in [target]'s face.")

/datum/surgery_step/mechanic_reshape_face/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(HAS_TRAIT_FROM(target, TRAIT_DISFIGURED, TRAIT_GENERIC))
		REMOVE_TRAIT(target, TRAIT_DISFIGURED, TRAIT_GENERIC)
		display_results(user, target, "<span class='notice'>You successfully restore [target]'s appearance.</span>",
			"[user] successfully restores [target]'s appearance!",
			"[user] finishes the operation on [target]'s face.")
	else
		var/list/names = list()
		if(!isabductor(user))
			for(var/i in 1 to 10)
				names += target.dna.species.random_name(target.gender, TRUE)
		else
			for(var/_i in 1 to 9)
				names += "Subject [target.gender == MALE ? "i" : "o"]-[pick("a", "b", "c", "d", "e")]-[rand(10000, 99999)]"
			names += target.dna.species.random_name(target.gender, TRUE) //give one normal name in case they want to do regular plastic surgery
		var/chosen_name = input(user, "Choose a new name to assign.", "Factory Reset") as null|anything in (names + "Custom")
		if(chosen_name == "Custom")
			chosen_name = input(user, "Input a new custom name.", "Factory Reset") as null|text
			while(chosen_name && reject_bad_name(chosen_name))
				to_chat(user, "<span class='warning'>Unit [target] beeps and rejects the input.</span>")
				chosen_name = input(user, "Input a new custom name.", "Factory Reset") as null|text
		if(!chosen_name)
			return
		var/oldname = target.real_name
		target.real_name = chosen_name
		var/newname = target.real_name	//something about how the code handles names required that I use this instead of target.real_name
		display_results(user, target, "<span class='notice'>You alter [oldname]'s appearance completely, [target.p_they()] is now [newname].</span>",
			"[user] alters [oldname]'s appearance completely, [target.p_they()] is now [newname]!",
			"[user] finishes the operation on [target]'s face.")
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.sec_hud_set_ID()
	return TRUE

/datum/surgery_step/mechanic_reshape_face/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>You screw up, leaving [target]'s appearance disfigured!</span>",
		"[user] screws up, disfiguring [target]'s appearance!",
		"[user] finishes the operation on [target]'s face.")
	ADD_TRAIT(target, TRAIT_DISFIGURED, TRAIT_GENERIC)
	return FALSE
