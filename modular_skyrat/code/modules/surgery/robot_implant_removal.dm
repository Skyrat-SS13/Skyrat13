//extract implant
/datum/surgery_step/mechanic_extract_implant
	name = "extract implant"
	implements = list(TOOL_CROWBAR = 100,
					TOOL_HEMOSTAT = 65)
	time = 64
	var/obj/item/implant/I = null

/datum/surgery_step/mechanic_extract_implant/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/O in target.implants)
		I = O
		break
	if(I)
		display_results(user, target, "<span class='notice'>You begin to extract [I] from [target]'s [target_zone]...</span>",
			"[user] begins to extract [I] from [target]'s [target_zone].",
			"[user] begins to extract something from [target]'s [target_zone].")
	else
		display_results(user, target, "<span class='notice'>You look for an implant in [target]'s [target_zone]...</span>",
			"[user] looks for an implant in [target]'s [target_zone].",
			"[user] looks for something in [target]'s [target_zone].")

/datum/surgery_step/mechanic_extract_implant/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(I)
		display_results(user, target, "<span class='notice'>You successfully remove [I] from [target]'s [target_zone].</span>",
			"[user] successfully removes [I] from [target]'s [target_zone]!",
			"[user] successfully removes something from [target]'s [target_zone]!")
		I.removed(target)

		var/obj/item/implantcase/case
		for(var/obj/item/implantcase/ic in user.held_items)
			case = ic
			break
		if(!case)
			case = locate(/obj/item/implantcase) in get_turf(target)
		if(case && !case.imp)
			case.imp = I
			I.forceMove(case)
			case.update_icon()
			display_results(user, target, "<span class='notice'>You place [I] into [case].</span>",
				"[user] places [I] into [case]!",
				"[user] places it into [case]!")
		else
			qdel(I)

	else
		to_chat(user, "<span class='warning'>You can't find anything in [target]'s [target_zone]!</span>")
	return 1

/datum/surgery/implant_removal/mechanic
	name = "implant removal"
	requires_bodypart_type = BODYPART_ROBOTIC
	steps = list(
		/datum/surgery_step/mechanic_open,
		/datum/surgery_step/open_hatch,
		/datum/surgery_step/mechanic_unwrench,
		/datum/surgery_step/mechanic_extract_implant,
		/datum/surgery_step/mechanic_wrench,
		/datum/surgery_step/mechanic_close)
