/datum/surgery_step/manipulate_organs/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	I = null
	if(istype(tool, /obj/item/organ_storage))
		if(!tool.contents.len)
			to_chat(user, "<span class='notice'>There is nothing inside [tool]!</span>")
			return -1
		I = tool.contents[1]
		if(!isorgan(I))
			to_chat(user, "<span class='notice'>You cannot put [I] into [target]'s [parse_zone(target_zone)]!</span>")
			return -1
		tool = I
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

	else if(istype(tool, /obj/item/stack/medical/bruise_pack) || istype(tool, /obj/item/stack/medical/ointment))
		var/obj/item/stack/medical/M = tool
		if(M.use(3))
			current_type = "heal"
			var/list/organlist = target.getorganszone(target_zone)
			if(!organlist.len)
				display_results(user, target, "<span class='notice'>There are no organs in the [parse_zone(target_zone)]!</span>",
					"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no organs at all.",
					"[user] begins to heal [target]'s [parse_zone(target_zone)], only to be met with no organs at all.")
				return -1
			display_results(user, target, "<span class='notice'>You begin to heal the organs in [target]'s [parse_zone(target_zone)]...</span>",
							"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...",
							"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...")
		else
			to_chat(user, "<span class='warning'>[M] does not have enough stacks to be used on a surgery!</span>")
			return -1
	else if(istype(tool, /obj/item/reagent_containers))
		current_type = "heal"
		var/obj/item/reagent_containers/R = tool
		var/text2add = istype(R, /obj/item/reagent_containers/pill) ? "To top it off, you ended up wasting \the [R] for no good reason.":""
		if(R.reagents.total_volume)
			if(R.reagents.has_reagent(/datum/reagent/medicine/synthflesh, 10))
				if(R.reagents.remove_reagent(/datum/reagent/medicine/synthflesh, 10, ignore_pH = TRUE))
					display_results(user, target, "<span class='notice'>You begin to heal the organs in [target]'s [parse_zone(target_zone)]...</span>",
									"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...",
									"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...")
				else
					to_chat(user, "<span class='warning'>[R] does not have enough healing reagents or can't transfer it's reagents![text2add]</span>")
					if(istype(R, /obj/item/reagent_containers/pill))
						qdel(R)
					return -1
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
			else if(R.reagents.has_reagent(/datum/reagent/medicine/styptic_powder, 20))
				if(R.reagents.remove_reagent(/datum/reagent/medicine/styptic_powder, 20, ignore_pH = TRUE))
					display_results(user, target, "<span class='notice'>You begin to heal the organs in [target]'s [parse_zone(target_zone)]...</span>",
										"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...",
										"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...")
				else
					to_chat(user, "<span class='warning'>[R] does not have enough healing reagents or can't transfer it's reagents![text2add]</span>")
					if(istype(R, /obj/item/reagent_containers/pill))
						qdel(R)
					return -1
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
			else if(R.reagents.has_reagent(/datum/reagent/medicine/silver_sulfadiazine, 40))
				if(R.reagents.remove_reagent(/datum/reagent/medicine/silver_sulfadiazine, 40, ignore_pH = TRUE))
					display_results(user, target, "<span class='notice'>You begin to heal the organs in [target]'s [parse_zone(target_zone)]...</span>",
									"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...",
									"[user] begins to heal [target]'s [parse_zone(target_zone)] organs...")
				else
					to_chat(user, "<span class='warning'>[R] does not have enough healing reagents or can't transfer it's reagents![text2add]</span>")
					if(istype(R, /obj/item/reagent_containers/pill))
						qdel(R)
					return -1
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
			else
				to_chat(user, "<span class='warning'>[R] does not have enough healing reagents![text2add]</span>")
				if(istype(R, /obj/item/reagent_containers/pill))
					qdel(R)
				return -1
		else
			to_chat(user, "<span class='warning'>[R] does not have ANY healing reagents![text2add]</span>")
			if(istype(R, /obj/item/reagent_containers/pill))
				qdel(R)
			return -1

/datum/surgery_step/manipulate_organs/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(current_type == "insert")
		if(istype(tool, /obj/item/organ_storage))
			I = tool.contents[1]
			tool.icon_state = initial(tool.icon_state)
			tool.desc = initial(tool.desc)
			tool.cut_overlays()
			tool = I
		else
			I = tool
		user.temporarilyRemoveItemFromInventory(I, TRUE)
		I.Insert(target)
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
		var/list/organshealed = list()
		for(var/obj/item/organ/O in target.getorganszone(target_zone))
			if(O.damage > (O.maxHealth - O.maxHealth/10))
				to_chat(user, "<span class='warning'>Sadly, the [target]'s [O] was too damaged to be healed.</span>")
			else
				O.damage = 0
				organshealed += O
				to_chat(user, "<span class='warning'>You have successfully healed [target]'s [O].</span>")
		if(organshealed.len)
			display_results(user, target, "<span class='notice'>You have succesfully healed [target]'s [parse_zone(target_zone)]'s organs.</span>",
				"[user] has healed [target]'s [parse_zone(target_zone)]'s organs!",
				"[user] has healed [target]'s [parse_zone(target_zone)]'s organs!")
		else
			display_results(user, target, "<span class='notice'>You have partially healed [target]'s [parse_zone(target_zone)]'s organs.</span>",
				"[user] has healed part of [target]'s [parse_zone(target_zone)]'s organs!",
				"[user] has healed part of [target]'s [parse_zone(target_zone)]'s organs!")
	return 0