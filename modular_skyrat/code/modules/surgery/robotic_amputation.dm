/datum/surgery/amputation/mechanic
	name = "Mechanic amputation"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_unwrench,
				/datum/surgery_step/open_hatch,
				/datum/surgery_step/pry_off_plating,
				/datum/surgery_step/cut_wires,
				/datum/surgery_step/mechanic_sever_limb)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = AMPUTATE_BODYPARTS //skyrat edit
	requires_bodypart_type = BODYPART_ROBOTIC

/datum/surgery_step/mechanic_sever_limb
	name = "Sever limb"
	implements = list(TOOL_MULTITOOL = 100,
					TOOL_SCREWDRIVER = 100,
					/obj/item/melee/transforming/energy/sword/cyborg/saw = 50,
					/obj/item/melee/arm_blade = 30,
					/obj/item/chainsaw = 30,
					/obj/item/mounted_chainsaw = 30,
					/obj/item/fireaxe = 30,
					/obj/item/hatchet = 35,
					/obj/item/kitchen/knife/butcher = 40)
	time = 64

/datum/surgery_step/mechanic_sever_limb/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	display_results(user, target, "<span class='notice'>You begin to sever [target]'s [parse_zone(target_zone)] by \the [BP.amputation_point]...</span>",
		"[user] begins to sever [target]'s [parse_zone(target_zone)]!",
		"[user] begins to sever [target]'s [parse_zone(target_zone)]!")

/datum/surgery_step/mechanic_sever_limb/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/mob/living/carbon/human/L = target
	var/obj/item/bodypart/BP = target.get_bodypart(target_zone)
	display_results(user, target, "<span class='notice'>You sever [L]'s [parse_zone(target_zone)] from \the [BP.amputation_point].</span>",
		"[user] severs [L]'s [parse_zone(target_zone)]!",
		"[user] severs [L]'s [parse_zone(target_zone)]!")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		target_limb.drop_limb()
	return 1

//skyrat amputation
// Since the groin and chest cannot be amputated... DISEMBOWELMENT! >:)
/datum/surgery/disembowelment/mechanic
	name = "Disembowelment"
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/mechanic_unwrench,
				/datum/surgery_step/open_hatch,
				/datum/surgery_step/pry_off_plating,
				/datum/surgery_step/mechanic_disembowel)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = ALL_BODYPARTS
	requires_bodypart_type = BODYPART_ROBOTIC

/datum/surgery_step/mechanic_disembowel
	name = "Disembowel limb"
	implements = list(TOOL_RETRACTOR = 100, TOOL_HEMOSTAT = 100, TOOL_CROWBAR = 100, TOOL_SHOVEL = 100)
	time = 120

/datum/surgery_step/mechanic_disembowel/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='notice'>You begin to spoon out [target]'s [parse_zone(target_zone)] organs...</span>",
		"[user] begins to spoon out [target]'s [parse_zone(target_zone)] organs!",
		"[user] begins to spoon out [target]'s [parse_zone(target_zone)] organs!")

/datum/surgery_step/mechanic_disembowel/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>You spoon out [target]'s [parse_zone(target_zone)] organs!</span>",
		"[user] spoons out [target]'s [parse_zone(target_zone)] organs!",
		"[user] spoons out [target]'s [parse_zone(target_zone)] organs!")
	if(surgery.operated_bodypart)
		var/obj/item/bodypart/target_limb = surgery.operated_bodypart
		if(!(target_limb.owner))
			return 1
	
	var/obj/item/bodypart/BP = surgery.operated_bodypart
	if(istype(BP))
		BP.disembowel()
	return 1
