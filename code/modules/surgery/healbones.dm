/datum/surgery/healbones
	name = "Heal Bones"
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD, BODY_ZONE_CHEST)
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/clamp_bleeders,
				 /datum/surgery_step/rearrangebones, /datum/surgery_step/gelbones, /datum/surgery_step/close)

//rearrange bones
/datum/surgery_step/rearrangebones
	name = "rearrange bones"
	implements = list(TOOL_SETTLER = 90, /obj/item/crowbar = 40)
	time = 20

/datum/surgery_step/rearrangebones/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to rearrange [target]'s [target_zone] bones...</span>",
		"[user] begins to rearrange [target]'s [target_zone] bones.",
		"[user] begins to rearrange [target]'s [target_zone] bones.")

/datum/surgery_step/rearrangebones/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H)
			for(var/obj/item/organ/bone/B in H.getorganszone(target_zone))
				B.damage -= B.maxHealth/2
				display_results(user, H, "<span class='notice'>You rearrange [H]'s [target_zone] bones to their correct spot.</span>",
				"[user] rearranges [H]'s [target_zone] bones to their correct spot.",
				"")
	return TRUE

/datum/surgery_step/rearrangebones/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		display_results(user, target, "<span class='warning'>You screw up, and let a sharp bone puncture [H]'s organs!</span>",
			"<span class='warning'>[user] screws up, causing sharp bone to puncture [H]'s organs!</span>",
			"<span class='warning'>[user] screws up, causing sharp bone to puncture [H]'s organs!</span>")
		H.bleed_rate += 5
		for(var/obj/item/organ/O in H.getorganszone(target_zone))
			H.adjustOrganLoss(O.slot, rand(1,20))
		H.adjustBruteLoss(rand(5, 20))

//gel bones
/datum/surgery_step/gelbones
	name = "gel bones"
	implements = list(TOOL_GEL = 90, /obj/item/stack/medical/ointment = 50, /obj/item/stack/wrapping_paper = 25)
	time = 20

/datum/surgery_step/gelbones/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(tool.type != /obj/item/stack/wrapping_paper)
		display_results(user, target, "<span class='notice'>You begin to pour gel over [target]'s [target_zone] bones...</span>",
			"[user] begins to pour gel over [target]'s [target_zone] bones.",
			"[user] begins to pour gel over [target]'s [target_zone] bones.")
	else
		display_results(user, target, "<span class='notice'>You begin to wrap [target]'s [target_zone] bones together...</span>",
			"[user] begins to wrap [target]'s [target_zone] bones together.",
			"[user] begins to wrap [target]'s [target_zone] bones together.")

/datum/surgery_step/gelbones/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H)
			for(var/obj/item/organ/bone/B in H.getorganszone(target_zone))
				B.damage -= B.maxHealth/2
				var/obj/item/bodypart/BP = H.get_bodypart(target_zone)
				BP.disabled = BODYPART_NOT_DISABLED
				display_results(user, H, "<span class='notice'>You pour gel over [H]'s [target_zone] bones.</span>",
				"[user] pours gel over [H]'s [target_zone] bones.",
				"")
	return TRUE

/datum/surgery_step/gelbones/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		display_results(user, target, "<span class='warning'>You screw up, and let \the [tool] fall on [H]'s [target_zone]!</span>",
			"<span class='warning'>[user] screws up, causing the [tool] to fall on [H]'s [target_zone]!</span>",
			"<span class='warning'>[user] screws up, causing the [tool] to fall on [H]'s [target_zone]!</span>")
		for(var/obj/item/organ/O in H.getorganszone(target_zone))
			H.adjustOrganLoss(O.slot, rand(1,10))
		H.adjustBruteLoss(rand(1, 7))
