/datum/surgery/embalming //Fast and easy way to husk bodys
	name = "Embalming"
	desc = "A surgical procedure that prevents a corpse from producing miasma."
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/embalming,
				/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = TORSO_BODYPARTS //skyrat edits
	requires_bodypart_type = BODYPART_ORGANIC //Skyrat change

//skyrat change start
/datum/surgery/embalming/can_start(mob/user, mob/living/target, obj/item/tool)
  . = ..()
  if(target.stat != DEAD)
    return FALSE
//skyrat change stop

/datum/surgery_step/embalming
	name = "Embalming body"
	implements = list(TOOL_HEMOSTAT = 100, TOOL_SCREWDRIVER = 35)
	chems_needed = list(/datum/reagent/drying_agent, /datum/reagent/space_cleaner/sterilizine)
	require_all_chems = FALSE

/datum/surgery_step/embalming/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] starts to embalm [target]'s body.", "<span class='notice'>You start embalming [target]'s body.</span>")

/datum/surgery_step/embalming/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] embalms [target]'s body.", "<span class='notice'>You succeed in embalming [target]'s body.</span>")
	ADD_TRAIT(target, TRAIT_HUSK, MAGIC_TRAIT) //Husk's prevent body smell
	return TRUE

/datum/surgery_step/embalming/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message("[user] screws up!", "<span class='warning'>You screwed up!</span>")
	ADD_TRAIT(target, TRAIT_NOCLONE, MAGIC_TRAIT) //That body is ruined, but still gives miasma
	return FALSE
