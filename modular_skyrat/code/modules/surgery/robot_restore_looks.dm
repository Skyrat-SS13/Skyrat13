/datum/surgery/robot_restore_looks
	name = "Restore robotic limb looks"
	steps = list(
	/datum/surgery_step/weld_plating,
	/datum/surgery_step/restore_paintjob)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)
	requires_bodypart_type = 0
	desc = "A procedure that welds the robotic limbs back into the patient's preferred state aswell as re-applying their paintjob."

/datum/surgery/robot_restore_looks/can_start(mob/user, mob/living/patient, obj/item/tool)
	. = ..()
	if(.)
		var/mob/living/carbon/C = patient
		for(var/obj/item/bodypart/BP in C.bodyparts)
			if(BP.status & BODYPART_ROBOTIC)
				return TRUE
		return FALSE

/datum/surgery_step/restore_paintjob
	name = "Spray paint"
	implements = list(
		/obj/item/toy/crayon/spraycan = 100)
	time = 58

/datum/surgery_step/restore_paintjob/tool_check(mob/user, obj/item/tool, mob/living/carbon/target)
	var/obj/item/toy/crayon/spraycan/sc = tool
	if(sc.is_capped)
		to_chat(user, "<span class='warning'>Take the cap off first!</span>")
		return FALSE
	if(sc.charges < 10)
		to_chat(user, "<span class='warning'>Not enough paint in the can!</span>")
		return FALSE
	return TRUE

/datum/surgery_step/restore_paintjob/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/toy/crayon/spraycan/sc = tool
	sc.use_charges(user, 10, FALSE)
	sc.audible_message("<span class='notice'>You hear spraying.</span>")
	playsound(target.loc, 'sound/effects/spray.ogg', 5, 1, 5)
	if(target?.dna?.species)
		for(var/obj/item/bodypart/O in target.bodyparts)
			if(O.status == BODYPART_ROBOTIC)
				O.icon = target.dna.species.icon_limbs
				O.render_like_organic = TRUE
				O.synthetic = TRUE
				if(O.body_zone == BODY_ZONE_L_LEG || O.body_zone == BODY_ZONE_R_LEG)
					if(!target.dna.features["legs"] == "Plantigrade")
						O.use_digitigrade = FULL_DIGITIGRADE
				O.update_limb(O,target)
		if(isipcperson(target) && target.dna?.species?.mutant_bodyparts)
			var/continues = input(user, "Do you wish to repaint the unit's chassis model?", "Additional Changes") as null|anything in list("Yes", "No")
			if(continues == "Yes")
				var/new_ipc_chassis = input(user, "Choose a new chassis", "New Chassis") as null|anything in GLOB.ipc_chassis_list
				if(new_ipc_chassis)
					target.dna.species.mutant_bodyparts["ipc_chassis"] = new_ipc_chassis
		else if(issynthliz(target) && target.dna?.species?.mutant_bodyparts)
			var/continues = input(user, "Do you wish to set the unit's appearances to synthlizard defaults?", "Additional Changes") as null|anything in list("Yes", "No")
			if(continues == "Yes")
				target.dna.species.mutant_bodyparts["ipc_antenna"] = "Synthetic Lizard - Antennae"
				target.dna.species.mutant_bodyparts["mam_tail"] = "Synthetic Lizard"
				target.dna.species.mutant_bodyparts["mam_snouts"] = "Synthetic Lizard - Snout"
				target.dna.species.mutant_bodyparts["legs"] = "Digitigrade"
				target.dna.species.mutant_bodyparts["mam_body_markings"] = "Synthetic Lizard - Plates"
		if(target.dna?.species?.mutant_bodyparts)
			var/continues = input(user, "Do you wish to set the reassign the unit's gender?", "Additional Changes") as null|anything in list("Yes", "No")
			if(continues == "Yes")
				var/new_gender = input(user, "Choose a new gender", "New Gender") as null|anything in list(MALE, FEMALE, NEUTER, PLURAL)
				if(new_gender)
					target.set_gender(new_gender, TRUE)
		target.update_body()
	return TRUE

/datum/surgery_step/restore_paintjob/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to spray paint on [target]...</span>",
			"[user] begins to spray paint on [target]'s [parse_zone(target_zone)].",
			"[user] begins to spray paint on [target]'s [parse_zone(target_zone)].")
