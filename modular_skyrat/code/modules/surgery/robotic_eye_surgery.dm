/datum/surgery/eye_surgery/mechanic
	name = "Mechanic eye surgery"
	steps = list(/datum/surgery_step/mechanic_open,
			/datum/surgery_step/mechanic_unwrench,
			/datum/surgery_step/open_hatch,
			/datum/surgery_step/mechanic_fix_eyes,
			/datum/surgery_step/mechanic_close)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_EYES)
	requires_bodypart_type = BODYPART_ROBOTIC //Skyrat change
//fix eyes
/datum/surgery_step/mechanic_fix_eyes
	name = "Fix eyes"
	implements = list(TOOL_SCREWDRIVER = 100, TOOL_HEMOSTAT = 45, /obj/item/pen = 25)
	time = 64

/datum/surgery/mechanic_eye_surgery/can_start(mob/user, mob/living/carbon/target, obj/item/tool)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	if(!E)
		to_chat(user, "It's hard to do surgery on someone's eyes when [target.p_they()] [target.p_do()]n't have any.")
		return FALSE
	return TRUE

/datum/surgery_step/mechanic_fix_eyes/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to fix [target]'s eyes...</span>",
		"[user] begins to fix [target]'s eyes.",
		"[user] begins to perform surgery on [target]'s eyes.")

/datum/surgery_step/mechanic_fix_eyes/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/organ/eyes/E = target.getorganslot(ORGAN_SLOT_EYES)
	display_results(user, target, "<span class='notice'>You succeed in fixing [target]'s eyes.</span>",
		"[user] successfully fixes [target]'s eyes!",
		"[user] completes the surgery on [target]'s eyes.")
	target.cure_blind(list(EYE_DAMAGE))
	target.set_blindness(0)
	target.cure_nearsighted(list(EYE_DAMAGE))
	target.blur_eyes(35)	//this will fix itself slowly.
	E.setOrganDamage(0)
	return TRUE

/datum/surgery_step/mechanic_fix_eyes/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorgan(/obj/item/organ/brain))
		display_results(user, target, "<span class='warning'>You accidentally stab [target] right in the brain!</span>",
			"<span class='warning'>[user] accidentally stabs [target] right in the brain!</span>",
			"<span class='warning'>[user] accidentally stabs [target] right in the brain!</span>")
		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 70)
	else
		display_results(user, target, "<span class='warning'>You accidentally stab [target] right in the brain! Or would have, if [target] had a brain.</span>",
			"<span class='warning'>[user] accidentally stabs [target] right in the brain! Or would have, if [target] had a brain.</span>",
			"<span class='warning'>[user] accidentally stabs [target] right in the brain!</span>")
	return FALSE
