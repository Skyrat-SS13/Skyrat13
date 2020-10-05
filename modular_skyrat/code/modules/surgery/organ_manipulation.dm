/datum/surgery_step/manipulate_organs
	implements = list(/obj/item/organ = 100,
					/obj/item/organ_storage = 100,
					/obj/item/stack/medical/bruise_pack = 100,
					/obj/item/stack/medical/ointment = 100,
					/obj/item/stack/medical/mesh = 100,
					/obj/item/stack/medical/aloe = 100,
					/obj/item/stack/medical/suture = 100,
					/obj/item/stack/medical/nanopaste = 100,
					/obj/item/reagent_containers = 100,
					/obj/item/pen = 100,
					/obj/item/mmi = 100)
	var/heal_amount = 40
	var/disinfect_amount = 20

/datum/surgery_step/manipulate_organs/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/mmi/mmi = null
	I = null
	var/hasnecroticorgans = FALSE
	for(var/obj/item/organ/O in target.getorganszone(target_zone))
		if(O.damage >= (O.maxHealth - O.maxHealth/10)  && !(O.status == ORGAN_ROBOTIC))
			hasnecroticorgans = TRUE
	if(istype(tool, /obj/item/organ_storage))
		if(!tool.contents.len)
			to_chat(user, "<span class='notice'>There is nothing inside [tool]!</span>")
			return -1
		I = tool.contents[1]
		if(!isorgan(I))
			to_chat(user, "<span class='notice'>You cannot put [I] into [target]'s [parse_zone(target_zone)]!</span>")
			return -1
		tool = I
	if(istype(tool, /obj/item/mmi/posibrain))
		var/obj/item/mmi/posibrain/posibraine = tool
		var/obj/item/organ/brain/ipc_positron/posi = posibraine.brain
		if(!posi)
			posi = new(posibraine)
			posi.brainmob = posibraine.brainmob
			posibraine.brain = posi
		mmi = posibraine
		tool = mmi.brain
		I = tool
		var/datum/surgery/organ_manipulation/OM = surgery
		if(istype(OM))
			OM.mmi = mmi
	else if(istype(tool, /obj/item/mmi))
		mmi = tool
		tool = mmi.brain
		var/datum/surgery/organ_manipulation/OM = surgery
		if(istype(OM))
			OM.mmi = mmi
	if(isorgan(tool))
		current_type = "insert"
		I = tool
		if(target_zone != I.zone || target.getorganslot(I.slot))
			to_chat(user, "<span class='notice'>There is no room for [I] in [target]'s [parse_zone(target_zone)]!</span>")
			return -1
		var/obj/item/organ/meatslab = tool
		if(!meatslab.useable)
			to_chat(user, "<span class='warning'>[I] seems to have been chewed on, you can't use this!</span>")
			return -1
		display_results(user, target, "<span class='notice'>You begin to insert [tool] into [target]'s [parse_zone(target_zone)]...</span>",
			"[user] begins to insert [tool] into [target]'s [parse_zone(target_zone)].",
			"[user] begins to insert something into [target]'s [parse_zone(target_zone)].")

	else if(implement_type in implements_extract)
		current_type = "extract"
		var/list/organs = target.getorganszone(target_zone)
		if(!organs.len)
			to_chat(user, "<span class='notice'>There are no removable organs in [target]'s [parse_zone(target_zone)]!</span>")
			return -1
		else
			for(var/obj/item/organ/O in organs)
				O.on_find(user)
				organs -= O
				organs[O.name] = O
			I = input("Remove which organ?", "Surgery", null, null) as null|anything in organs
			if(I && user && target && user.Adjacent(target) && user.get_active_held_item() == tool)
				I = organs[I]
				if(!I)
					return -1
				display_results(user, target, "<span class='notice'>You begin to extract [I] from [target]'s [parse_zone(target_zone)]...</span>",
					"[user] begins to extract [I] from [target]'s [parse_zone(target_zone)].",
					"[user] begins to extract something from [target]'s [parse_zone(target_zone)].")
			else
				return -1
	else if(istype(tool, /obj/item/stack/medical/bruise_pack) || istype(tool, /obj/item/stack/medical/ointment) || istype(tool, /obj/item/stack/medical/mesh) || istype(tool, /obj/item/stack/medical/suture))
		var/obj/item/stack/medical/M = tool
		var/list/organs = target.getorganszone(target_zone)
		for(var/obj/item/organ/O in organs)
			if(O.damage <= 5)
				organs -= O
				continue
			O.on_find(user)
			organs -= O
			if(O.status & ORGAN_ROBOTIC)
				continue
			organs[O.name] = O
		if(!length(organs))
			display_results(user, target, "<span class='notice'>There are no damaged organic organs in the [parse_zone(target_zone)]!</span>",
				"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no damaged organic organs at all.",
				"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no damaged organic organs at all.")
			return -1
		current_type = "heal"
		if(M.use(2))
			display_results(user, target, "<span class='notice'>You begin to heal the organs in [target]'s [parse_zone(target_zone)]...</span>",
							"[user] begins to heal [target]'s the organs in [parse_zone(target_zone)]...",
							"[user] begins to heal [target]'s the organs in [parse_zone(target_zone)]...")
		else
			to_chat(user, "<span class='warning'>[M] does not have enough stacks to be used on a surgery!</span>")
			return -1
	else if(istype(tool, /obj/item/stack/medical/nanopaste))
		var/obj/item/stack/medical/M = tool
		var/list/organs = target.getorganszone(target_zone)
		for(var/obj/item/organ/O in organs)
			if(O.damage <= 5)
				organs -= O
				continue
			O.on_find(user)
			organs -= O
			if(O.status & BODYPART_ORGANIC)
				continue
			organs[O.name] = O
		if(!length(organs))
			display_results(user, target, "<span class='notice'>There are no damaged robotic organs in the [parse_zone(target_zone)]!</span>",
				"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no damaged robotic organs at all.",
				"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no damaged robotic organs at all.")
			return -1
		current_type = "heal_robotic"
		if(M.use(2))
			display_results(user, target, "<span class='notice'>You begin to heal the robotic organs in [target]'s [parse_zone(target_zone)]...</span>",
							"[user] begins to heal [target]'s the robotic organs in [parse_zone(target_zone)]...",
							"[user] begins to heal [target]'s the robotic organs in [parse_zone(target_zone)]...")
		else
			to_chat(user, "<span class='warning'>[M] does not have enough stacks to be used on a surgery!</span>")
			return -1
	else if(istype(tool, /obj/item/reagent_containers))
		var/list/organs = target.getorganszone(target_zone)
		for(var/obj/item/organ/O in organs)
			O.on_find(user)
			if(O.damage <= 10)
				organs -= O
		if(!length(organs))
			display_results(user, target, "<span class='notice'>There are no damaged organs in the [parse_zone(target_zone)]!</span>",
				"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no damaged organs at all.",
				"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no damaged organs at all.")
			return -1
		current_type = "heal"
		var/obj/item/reagent_containers/R = tool
		var/text2add = istype(R, /obj/item/reagent_containers/pill) ? "To top it off, you ended up wasting \the [R] for no good reason.":""
		if(R.reagents.total_volume && length(organs))
			if(R.reagents.has_reagent(/datum/reagent/medicine/silver_sulfadiazine, 50) || R.reagents.has_reagent(/datum/reagent/medicine/styptic_powder, 25) || R.reagents.has_reagent(/datum/reagent/medicine/synthflesh, 15))
				if(R.reagents.remove_reagent(/datum/reagent/medicine/silver_sulfadiazine, 50, ignore_pH = TRUE) || R.reagents.remove_reagent(/datum/reagent/medicine/styptic_powder, 25, ignore_pH = TRUE) || R.reagents.remove_reagent(/datum/reagent/medicine/synthflesh, 15, ignore_pH = TRUE))
					display_results(user, target, "<span class='notice'>You begin to heal the organs in [target]'s [parse_zone(target_zone)]...</span>",
									"[user] begins to heal [target]'s the organs in [target]'s [parse_zone(target_zone)]...",
									"[user] begins to heal [target]'s the organs in [target]'s [parse_zone(target_zone)]...")
				else
					to_chat(user, "<span class='warning'>[R] does not have enough healing reagents or can't transfer it's reagents![text2add]</span>")
					if(istype(R, /obj/item/reagent_containers/pill))
						qdel(R)
					return -1
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
			else if((R.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine, 10) || R.reagents.has_reagent(/datum/reagent/space_cleaner, 40) || R.reagents.has_reagent(/datum/reagent/medicine/spaceacillin, 15)) && hasnecroticorgans)
				current_type = "disinfect"
				if(R.reagents.remove_reagent(/datum/reagent/space_cleaner/sterilizine, 10, ignore_pH = TRUE) || R.reagents.remove_reagent(/datum/reagent/space_cleaner, 40, ignore_pH = TRUE) || R.reagents.remove_reagent(/datum/reagent/medicine/spaceacillin, 15, ignore_pH = TRUE))
					display_results(user, target, "<span class='notice'>You begin to disinfect \the organs in [target]'s [parse_zone(target_zone)]...</span>",
									"[user] begins to disinfect [target]'s \the organs in [target]'s [parse_zone(target_zone)]...",
									"[user] begins to disinfect [target]'s \the organs in [target]'s [parse_zone(target_zone)]...")
				else
					to_chat(user, "<span class='warning'>[R] does not have enough healing reagents or can't transfer it's reagents![text2add]</span>")
					if(istype(R, /obj/item/reagent_containers/pill))
						qdel(R)
					return -1
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
			else if((R.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine, 10) || R.reagents.has_reagent(/datum/reagent/space_cleaner, 40) || R.reagents.has_reagent(/datum/reagent/medicine/spaceacillin, 15)) && !hasnecroticorgans)
				to_chat(user, "<span class='warning'>[target] does not have any necrotic organs![text2add]</span>")
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
				return -1
			else
				to_chat(user, "<span class='warning'>[R] does not have enough healing reagents![text2add]</span>")
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
				return -1
		else
			if(!R.reagents.total_volume)
				to_chat(user, "<span class='warning'>[R] does not have ANY healing reagents![text2add]</span>")
				text2add = ""
			if(!length(organs))
				to_chat(user, "<span class='warning'>[R] does not have ANY damaged organs on their [parse_zone(target_zone)]![text2add]</span>")
			if(istype(R, /obj/item/reagent_containers/pill))
				qdel(R)
			return -1
	else if(istype(tool, /obj/item/pen) && user.a_intent == INTENT_HELP)
		var/list/organlist = target.getorganszone(target_zone)
		var/list/organs = target.getorganszone(target_zone)
		for(var/obj/item/organ/O in organs)
			O.on_find(user)
			organs -= O
			organs[O.name] = O
		var/choice = input(user, "What organ do you want to etch on?", "Malpractice", null) as null|anything in organlist
		if(choice)
			var/obj/item/organ/malpracticed = organlist[choice]
			if(istype(malpracticed))
				malpracticed.attackby(tool, user)
		return -1

/datum/surgery_step/manipulate_organs/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(current_type == "insert")
		var/obj/item/mmi/mmi
		var/datum/surgery/organ_manipulation/OM = surgery
		if(istype(OM.mmi))
			mmi = OM.mmi
			tool = mmi.brain
			I = mmi.brain
			mmi.eject_brain()
		if(istype(tool, /obj/item/organ_storage))
			I = tool.contents[1]
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = I
		else
			I = tool
		user.temporarilyRemoveItemFromInventory(I, TRUE)
		if(!I.Insert(target) && mmi) //if we can't insert, fuck, we already kinda fucked the brain over
			var/obj/item/organ/brain/newbrain = I
			var/mob/living/brain/B = newbrain.brainmob
			//mmis don't have a proc for transferring a brain proper
			mmi.brainmob = B
			newbrain.brainmob = null
			if(istype(B))
				B.forceMove(mmi)
				B.container = mmi
				if(!(newbrain.organ_flags & ORGAN_FAILING)) // the brain organ hasn't been beaten to death.
					B?.stat = CONSCIOUS //we manually revive the brain mob
					GLOB.dead_mob_list -= B
					GLOB.alive_mob_list += B

				B.reset_perspective()
			newbrain.forceMove(mmi)
			mmi.brain = newbrain
			mmi.brain.organ_flags |= ORGAN_FROZEN
			
			if(!istype(mmi, /obj/item/mmi/posibrain))
				mmi.name = "Man-Machine Interface: [B.real_name]"
			mmi.update_icon()
		else if(istype(mmi, /obj/item/mmi/posibrain))
			QDEL_NULL(mmi)
		else if(mmi)
			mmi.update_icon()
		display_results(user, target, "<span class='notice'>You insert [tool] into [target]'s [parse_zone(target_zone)].</span>",
			"[user] inserts [tool] into [target]'s [parse_zone(target_zone)]!",
			"[user] inserts something into [target]'s [parse_zone(target_zone)]!")

	else if(current_type == "extract")
		if(I && I.owner == target)
			display_results(user, target, "<span class='notice'>You successfully extract [I] from [target]'s [parse_zone(target_zone)].</span>",
				"[user] successfully extracts [I] from [target]'s [parse_zone(target_zone)]!",
				"[user] successfully extracts something from [target]'s [parse_zone(target_zone)]!")
			log_combat(user, target, "surgically removed [I.name] from", addition="INTENT: [uppertext(user.a_intent)]")
			I.Remove()
			I.forceMove(get_turf(target))
		else
			display_results(user, target, "<span class='notice'>You can't extract anything from [target]'s [parse_zone(target_zone)]!</span>",
				"[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!",
				"[user] can't seem to extract anything from [target]'s [parse_zone(target_zone)]!")
	else if(current_type == "heal")
		var/healedatall = FALSE
		var/fully_healed = FALSE
		for(var/obj/item/organ/O in target.getorganszone(target_zone))
			if((O.damage < (O.maxHealth - O.maxHealth/10)) && !(O.status & ORGAN_ROBOTIC))
				O.applyOrganDamage(-heal_amount)
				healedatall = TRUE
				fully_healed = TRUE
		for(var/obj/item/organ/O in target.getorganszone(target_zone))
			if(O.damage)
				fully_healed = FALSE
		if(fully_healed)
			display_results(user, target, "<span class='notice'>You have succesfully healed [target]'s [parse_zone(target_zone)] organs.</span>",
				"[user] has successfully healed [target]'s [parse_zone(target_zone)] organs!",
				"[user] has successfully healed [target]'s [parse_zone(target_zone)] organs!")
		else if(healedatall)
			display_results(user, target, "<span class='notice'>You have partially healed [target]'s [parse_zone(target_zone)] organs.</span>",
				"[user] has partially healed [target]'s [parse_zone(target_zone)] organs!",
				"[user] has partially healed [target]'s [parse_zone(target_zone)] organs!")
		else
			display_results(user, target, "<span class='warning'>You have failed to heal [target]'s [parse_zone(target_zone)] organs.</span>",
				"[user] has failed to heal [target]'s [parse_zone(target_zone)] organs!",
				"[user] has failed to heal [target]'s [parse_zone(target_zone)] organs!")
	else if(current_type == "heal_robotic")
		var/healedatall = FALSE
		var/fully_healed = FALSE
		for(var/obj/item/organ/O in target.getorganszone(target_zone))
			if((O.damage < (O.maxHealth - O.maxHealth/10)) && !(O.status & ORGAN_ORGANIC))
				O.applyOrganDamage(-heal_amount)
				healedatall = TRUE
				fully_healed = TRUE
		for(var/obj/item/organ/O in target.getorganszone(target_zone))
			if(O.damage)
				fully_healed = FALSE
		if(fully_healed)
			display_results(user, target, "<span class='notice'>You have succesfully healed [target]'s [parse_zone(target_zone)] robotic organs.</span>",
				"[user] has successfully healed [target]'s [parse_zone(target_zone)] robotic organs!",
				"[user] has successfully healed [target]'s [parse_zone(target_zone)] robotic organs!")
		else if(healedatall)
			display_results(user, target, "<span class='notice'>You have partially healed [target]'s [parse_zone(target_zone)] robotic organs.</span>",
				"[user] has partially healed [target]'s [parse_zone(target_zone)] robotic organs!",
				"[user] has partially healed [target]'s [parse_zone(target_zone)] robotic organs!")
		else
			display_results(user, target, "<span class='warning'>You have failed to heal [target]'s [parse_zone(target_zone)] robotic organs.</span>",
				"[user] has failed to heal [target]'s [parse_zone(target_zone)] robotic organs!",
				"[user] has failed to heal [target]'s [parse_zone(target_zone)] robotic organs!")
	else if(current_type == "disinfect")
		var/disinfectedatall = FALSE
		for(var/obj/item/organ/O in target.getorganszone(target_zone))
			if(O.damage >= (O.maxHealth - O.maxHealth/10) && !(O.status & ORGAN_ROBOTIC))
				O.applyOrganDamage(-disinfect_amount)
				disinfectedatall = TRUE
		if(disinfectedatall)
			display_results(user, target, "<span class='notice'>You have succesfully disinfected [target]'s [parse_zone(target_zone)] organs.</span>",
				"[user] has disinfected [target]'s [parse_zone(target_zone)] organs!",
				"[user] has disinfected [target]'s [parse_zone(target_zone)] organs!")
		else
			display_results(user, target, "<span class='danger'>You were unable to fix [target]'s [parse_zone(target_zone)] organs.</span>",
				"[user] couldn't disinfect [target]'s [parse_zone(target_zone)] organs!",
				"[user] couldn't disinfect [target]'s [parse_zone(target_zone)] organs!")
	return TRUE
