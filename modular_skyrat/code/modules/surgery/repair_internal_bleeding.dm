/////INTERNAL BLEEDING FIXING SURGERIES//////

//the step numbers of each of these two, we only currently use the first to switch back and forth due to advancing after finishing steps anyway
#define REALIGN_INNARDS 1
#define WELD_VEINS		2

///// Repair puncture wounds
/datum/surgery/repair_internal_bleeding
	name = "Vascular Repair"
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/repair_innards/internal,
				/datum/surgery_step/seal_veins/internal,
				/datum/surgery_step/vaccuum_bleeding,
				/datum/surgery_step/close) // repeat between steps 2 and 3 until healed
	target_mobtypes = list(/mob/living/carbon)
	possible_locs = ALL_BODYPARTS
	requires_real_bodypart = TRUE
	targetable_wound = /datum/wound/internalbleed

/datum/surgery/repair_internal_bleeding/can_start(mob/living/user, mob/living/carbon/target)
	. = ..()
	if(.)
		var/obj/item/bodypart/targeted_bodypart = target.get_bodypart(user.zone_selected)
		var/datum/wound/bleeding = targeted_bodypart.get_wound_type(targetable_wound)
		return (bleeding && bleeding.blood_flow > 0)

//SURGERY STEPS

///// realign the blood vessels so we can reweld them
/datum/surgery_step/repair_innards/internal
	puncture_or_slash = "internal bleeding"

/datum/surgery_step/repair_innards/internal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	. = ..()
	var/datum/wound/internalbleed/W = surgery.operated_wound
	if(W)
		W.regeneration += 0.75

/datum/surgery_step/repair_innards/internal/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	. = ..()
	var/datum/wound/internalbleed/W = surgery.operated_wound
	if(W)
		W.regeneration = max(W.regeneration - 0.75, 0)

///// Sealing the vessels back together
/datum/surgery_step/seal_veins/internal
	puncture_or_slash = "internal bleeding"

/datum/surgery_step/seal_veins/internal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results)
	..()
	var/datum/wound/bleeding = surgery.operated_wound
	if(bleeding?.blood_flow > 0)
		surgery.status = REALIGN_INNARDS

///// Vaccuuming of the pooled blood
/datum/surgery_step/vaccuum_bleeding
	name = "remove pooled blood"
	implements = list(/obj/item/stack/medical/gauze = 100, /obj/item/bedsheet = 65)
	time = 6 SECONDS

/datum/surgery_step/vaccuum_bleeding/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to carefully staunch the pooled blood in [target]'s [parse_zone(user.zone_selected)]...</span>",
		"<span class='notice'>[user] begins to carefully staunch the pooled blood in [target]'s [parse_zone(user.zone_selected)] with [tool].</span>",
		"<span class='notice'>[user] begins to carefully staunch the pooled blood in [target]'s [parse_zone(user.zone_selected)].</span>")

/datum/surgery_step/vaccuum_bleeding/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	display_results(user, target, "<span class='notice'>You successfully staunch the blood in [target]'s [parse_zone(target_zone)].</span>",
		"<span class='notice'>[user] successfully staunches the blood in [target]'s [parse_zone(target_zone)] with [tool]!</span>",
		"<span class='notice'>[user] successfully staunches the blood in  [target]'s [parse_zone(target_zone)]!</span>")
	log_combat(user, target, "staunched internal bleeding in", addition="INTENT: [uppertext(user.a_intent)]")

/datum/surgery_step/vaccuum_bleeding/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, var/fail_prob = 0)
	. = ..()
	display_results(user, target, "<span class='danger'>You spread around the pooled blood in [target]'s [parse_zone(target_zone)]!</span>",
		"<span class='danger'>[user] spreads around the pooled blood in [target]'s [parse_zone(target_zone)]!</span>",
		"<span class='danger'>[user] spreads around the pooled blood in [target]'s [parse_zone(target_zone)]!</span>")
	var/mob/living/carbon/C = target
	if(istype(C))
		C.bleed(12)

#undef REALIGN_INNARDS
#undef WELD_VEINS
