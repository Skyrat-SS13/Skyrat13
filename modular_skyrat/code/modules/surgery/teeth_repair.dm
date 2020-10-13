//British repair
/datum/surgery/teeth_repair
	name = "Teeth Repair"
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/insert_teeth,
				/datum/surgery_step/close)
	target_mobtypes = list(/mob/living/carbon/human,
						/mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_PRECISE_MOUTH)

/datum/surgery/teeth_repair/can_start(mob/living/user, mob/living/carbon/target)
	if(..())
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(check_zone(user.zone_selected))
		return (targeted_bodypart.max_teeth && targeted_bodypart.get_teeth_amount() < targeted_bodypart.max_teeth)

//Insert teeth
/datum/surgery_step/insert_teeth
	name = "Fix teeth"
	implements = list(/obj/item/stack/teeth = 100)
	time = 40

/datum/surgery_step/insert_teeth/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to put the [tool] inside [target]'s mouth...</span>",
		"[user] begins to fix [target]'s teeth.",
		"[user] begins to perform surgery on [target]'s mouth.")

/datum/surgery_step/insert_teeth/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/teeth_part = target.get_bodypart(check_zone(user.zone_selected))
	var/obj/item/stack/our_teeth = tool
	var/obj/item/stack/target_teeth = teeth_part.teeth_object
	if(target_teeth)
		target_teeth.merge(our_teeth)
	else
		our_teeth.forceMove(teeth_part)
		teeth_part.teeth_object = our_teeth
	teeth_part.update_teeth()
	display_results(user, target, "<span class='notice'>You succeed in fixing [target]'s teeth.</span>",
		"[user] successfully fixes [target]'s teeth!",
		"[user] completes the surgery on [target]'s mouth.")
	return TRUE

/datum/surgery_step/insert_teeth/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/teeth_part = target.get_bodypart(check_zone(user.zone_selected))
	if(teeth_part.get_teeth_amount())
		if(target.chem_effects[CE_PAINKILLER] < 30)
			target.emote("scream")
		var/obj/item/stack/teeth = teeth_part.teeth_object
		teeth.forceMove(get_turf(target))
		teeth_part.teeth_object = null
		teeth_part.update_teeth()
		display_results(user, target, "<span class='warning'>You accidentally rip out [target]'s teeth!</span>",
			"<span class='warning'>[user] accidentally rips [target]'s teeth out!</span>",
			"<span class='warning'>[user] accidentally rips [target]'s teeth out!</span>")
	return FALSE
