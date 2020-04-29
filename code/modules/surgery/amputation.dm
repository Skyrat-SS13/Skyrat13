/datum/surgery/amputation
	name = "Amputation"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/saw, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/sever_limb)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND,\
						BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,\
						BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOOT,\
						BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT,\
						BODY_ZONE_HEAD)
	requires_bodypart_type = 0

/datum/surgery_step/sever_limb
	name = "sever limb"
	implements = list(TOOL_SCALPEL = 100, TOOL_SAW = 100, /obj/item/melee/transforming/energy/sword/cyborg/saw = 100, /obj/item/melee/arm_blade = 80, /obj/item/twohanded/required/chainsaw = 80, /obj/item/mounted_chainsaw = 80, /obj/item/twohanded/fireaxe = 50, /obj/item/hatchet = 40, /obj/item/kitchen/knife/butcher = 25)
	time = 64

/datum/surgery_step/sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to sever [target]'s [parse_zone(target_zone)]...</span>",
		"[user] begins to sever [target]'s [parse_zone(target_zone)]!",
		"[user] begins to sever [target]'s [parse_zone(target_zone)]!")

/datum/surgery_step/sever_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/mob/living/carbon/human/L = target
	display_results(user, target, "<span class='notice'>You sever [L]'s [parse_zone(target_zone)].</span>",
		"[user] severs [L]'s [parse_zone(target_zone)]!",
		"[user] severs [L]'s [parse_zone(target_zone)]!")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
	return 1

// Since the groin and chest cannot be amputated... DISEMBOWELMENT! >:)
/datum/surgery/disembowelment
	name = "Disembowelment"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/saw, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/disembowel)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
	requires_bodypart_type = 0

/datum/surgery_step/disembowel
	name = "sever limb"
	implements = list(TOOL_RETRACTOR = 100, TOOL_HEMOSTAT = 100, TOOL_CROWBAR = 100, TOOL_SHOVEL = 100)
	time = 120

/datum/surgery_step/disembowel/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to spoon out [target]'s [parse_zone(target_zone)] organs...</span>",
		"[user] begins to spoon out [target]'s [parse_zone(target_zone)] organs!",
		"[user] begins to spoon out [target]'s [parse_zone(target_zone)] organs!")

/datum/surgery_step/disembowel/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/mob/living/carbon/human/L = target
	display_results(user, target, "<span class='warning'>You spoon out [target]'s [parse_zone(target_zone)] organs!</span>",
		"[user] spoons out [target]'s [parse_zone(target_zone)] organs!",
		"[user] spoons out [target]'s [parse_zone(target_zone)] organs!")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		if(!(target_limb.owner))
			return 1
		var/organ_spilled = 0 //yes i copypasted dismemberment.dm code
		var/turf/T = get_turf(L)
		L.bleed(50)
		playsound(get_turf(L), 'sound/misc/splort.ogg', 80, 1)
		for(var/X in L.internal_organs)
			var/obj/item/organ/O = X
			var/org_zone = check_zone(O.zone)
			if(org_zone != target_zone)
				continue
			O.Remove()
			O.forceMove(T)
			organ_spilled = 1
		var/obj/item/bodypart/chest/funzone = get_bodypart(target_zone)
		if(funzone)
			if(funzone.cavity_item)
				cavity_item.forceMove(T)
				cavity_item = null
				organ_spilled = 1
		if(organ_spilled)
			C.visible_message("<span class='danger'><B>[C]'s internal organs spill out onto the floor!</B></span>")
	return 1
