//Almost copypaste of tend wounds, with some changes
/datum/surgery/robot_healing
	steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/pry_off_plating,
				/datum/surgery_step/cut_wires,
				/datum/surgery_step/robot_heal,
				/datum/surgery_step/mechanic_close)

	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = ALL_BODYPARTS
	replaced_by = /datum/surgery
	requires_bodypart_type = BODYPART_ROBOTIC
	ignore_clothes = TRUE
	var/healing_step_type
	var/antispam = FALSE

/datum/surgery/robot_healing/New(surgery_target, surgery_location, surgery_bodypart)
	..()
	if(healing_step_type)
		steps = list(/datum/surgery_step/mechanic_open,
				/datum/surgery_step/pry_off_plating,
				/datum/surgery_step/cut_wires,
				healing_step_type,
				/datum/surgery_step/mechanic_close)

/datum/surgery_step/robot_heal
	name = "repair body (welder/cable)"
	implements = list(TOOL_WELDER = 100, /obj/item/stack/cable_coil = 100)
	repeatable = TRUE
	time = 15
	var/healsbrute = FALSE
	var/healsburn = FALSE
	var/brutehealing = 0
	var/burnhealing = 0
	var/missinghpbonus = 0 //heals an extra point of damager per X missing damage of type (burn damage for burn healing, brute for brute). Smaller Number = More Healing!
	// WOUND HEALING
	// Associate the woundtype with the maximum severity it can heal
	var/wound_heal_blunt = WOUND_SEVERITY_NONE
	var/wound_heal_burn = WOUND_SEVERITY_NONE
	var/wound_heal_slash = WOUND_SEVERITY_NONE
	var/wound_heal_pierce = WOUND_SEVERITY_NONE

/datum/surgery_step/robot_heal/tool_check(mob/user, obj/item/tool)
	if(implement_type == TOOL_WELDER && !tool.tool_use_check(user, 1))
		return FALSE
	return TRUE

/datum/surgery_step/robot_heal/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/woundtype
	if(implement_type  == TOOL_WELDER)
		healsbrute = TRUE
		healsburn = FALSE
		woundtype = "dents"
	else
		healsbrute = FALSE
		healsburn = TRUE
		woundtype = "wiring"

	if(istype(surgery,/datum/surgery/robot_healing))
		var/datum/surgery/robot_healing/the_surgery = surgery
		if(!the_surgery.antispam)
			display_results(user, target, "<span class='notice'>You attempt to fix some of [target]'s [woundtype].</span>",
		"<span class='notice'>[user] attempts to fix some of [target]'s [woundtype].</span>",
		"<span class='notice'>[user] attempts to fix some of [target]'s [woundtype].</span>")

/datum/surgery_step/robot_heal/initiate(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery, try_to_fail = FALSE)
	if(..())
		while((healsbrute && tool.tool_use_check(user,1)) || (healsburn && tool))
			if(!..())
				break

/datum/surgery_step/robot_heal/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/umsg = "You succeed in fixing some of [target]'s damage" //no period, add initial space to "addons"
	var/tmsg = "[user] fixes some of [target]'s damage" //see above
	var/urhealedamt_brute = 0
	if(healsbrute)
		urhealedamt_brute = brutehealing
		tool.use_tool(target, user, 0, volume=50, amount=1)
	var/urhealedamt_burn = 0
	if(healsburn)
		urhealedamt_burn = burnhealing
		if(tool)
			tool.use(1)
	if(missinghpbonus)
		if(target.stat != DEAD)
			urhealedamt_brute += round((target.getBruteLoss()/ missinghpbonus),0.1)
			urhealedamt_burn += round((target.getFireLoss()/ missinghpbonus),0.1)
		else //less healing bonus for the dead since they're expected to have lots of damage to begin with (to make TW into defib not TOO simple)
			urhealedamt_brute += round((target.getBruteLoss()/ (missinghpbonus*5)),0.1)
			urhealedamt_burn += round((target.getFireLoss()/ (missinghpbonus*5)),0.1)
	if(!get_location_accessible(target, target_zone))
		urhealedamt_brute *= 0.55
		urhealedamt_burn *= 0.55
		umsg += " as best as you can while they have clothing on"
		tmsg += " as best as they can while [target] has clothing on"
	target.heal_bodypart_damage(urhealedamt_brute,urhealedamt_burn, only_organic = FALSE, only_robotic = TRUE)
	var/obj/item/bodypart/affected = target.get_bodypart(target_zone)
	if(istype(affected))
		if(wound_heal_blunt > WOUND_SEVERITY_NONE)
			for(var/i in affected.wounds)
				var/datum/wound/W = i
				if((W.wound_type = WOUND_LIST_BLUNT_MECHANICAL) && (wound_heal_blunt >= W.severity))
					display_results(user, target, "<span class='notice'>You repair the [lowertext(W.name)] on [target]'s [affected.name].</span>",
						"[user] repairs the [lowertext(W.name)] on [target]'s [affected.name].",
						"[user] tinkers with [target]'s internals.")
					W.remove_wound()
		if(wound_heal_burn > WOUND_SEVERITY_NONE)
			for(var/i in affected.wounds)
				var/datum/wound/W = i
				if((W.wound_type = WOUND_LIST_BURN_MECHANICAL) && (wound_heal_burn >= W.severity))
					display_results(user, target, "<span class='notice'>You repair the [lowertext(W.name)] on [target]'s [affected.name].</span>",
						"[user] repairs the [lowertext(W.name)] on [target]'s [affected.name].",
						"[user] tinkers with [target]'s internals.")
					W.remove_wound()
		if(wound_heal_slash > WOUND_SEVERITY_NONE)
			for(var/i in affected.wounds)
				var/datum/wound/W = i
				if((W.wound_type = WOUND_LIST_SLASH_MECHANICAL) && (wound_heal_slash >= W.severity))
					display_results(user, target, "<span class='notice'>You repair the [lowertext(W.name)] on [target]'s [affected.name].</span>",
						"[user] repairs the [lowertext(W.name)] on [target]'s [affected.name].",
						"[user] tinkers with [target]'s internals.")
					W.remove_wound()
		if(wound_heal_pierce > WOUND_SEVERITY_NONE)
			for(var/i in affected.wounds)
				var/datum/wound/W = i
				if((W.wound_type = WOUND_LIST_PIERCE_MECHANICAL) && (wound_heal_pierce >= W.severity))
					display_results(user, target, "<span class='notice'>You repair the [lowertext(W.name)] on [target]'s [affected.name].</span>",
						"[user] repairs the [lowertext(W.name)] on [target]'s [affected.name].",
						"[user] tinkers with [target]'s internals.")
					W.remove_wound()
	display_results(user, target, "<span class='notice'>[umsg].</span>",
		"[tmsg].",
		"[tmsg].")
	if(istype(surgery, /datum/surgery/robot_healing))
		var/datum/surgery/robot_healing/the_surgery = surgery
		the_surgery.antispam = TRUE
	return TRUE

/datum/surgery_step/robot_heal/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, "<span class='warning'>You screwed up!</span>",
		"<span class='warning'>[user] screws up!</span>",
		"<span class='notice'>[user] fixes some of [target]'s damage.</span>", TRUE)
	var/urdamageamt_brute = 0
	if(healsbrute)
		urdamageamt_brute = brutehealing * 0.8
	var/urdamageamt_burn = 0
	if(healsburn)
		urdamageamt_burn = burnhealing * 0.8
	if(missinghpbonus)
		urdamageamt_brute += round((target.getBruteLoss()/ (missinghpbonus*2)),0.1)
		urdamageamt_burn += round((target.getFireLoss()/ (missinghpbonus*2)),0.1)

	target.take_bodypart_damage(urdamageamt_brute, urdamageamt_burn)
	return FALSE

/***************************TYPES***************************/
/datum/surgery/robot_healing/basic
	name = "Repair robotic limbs (basic)"
	healing_step_type = /datum/surgery_step/robot_heal/basic
	desc = "A surgical procedure that provides repairs and maintenance to robotic limbs. Is slightly more efficient when the patient is severely damaged."
	replaced_by = null

/***************************STEPS***************************/

/datum/surgery_step/robot_heal/basic
	name = "repair damage"
	brutehealing = 10
	burnhealing = 10
	missinghpbonus = 15 

/datum/surgery_step/robot_heal/blunt
	name = "repair joints"
	brutehealing = 0
	burnhealing = 0
	missinghpbonus = 0
	wound_heal_blunt = WOUND_SEVERITY_CRITICAL

/datum/surgery_step/robot_heal/burn
	name = "repair heat warping"
	brutehealing = 0
	burnhealing = 0
	missinghpbonus = 0
	wound_heal_burn = WOUND_SEVERITY_CRITICAL

/datum/surgery_step/robot_heal/slash
	name = "repair cut hydraulics"
	brutehealing = 0
	burnhealing = 0
	missinghpbonus = 0
	wound_heal_slash = WOUND_SEVERITY_CRITICAL

/datum/surgery_step/robot_heal/pierce
	name = "repair pierced hydraulics"
	brutehealing = 0
	burnhealing = 0
	missinghpbonus = 0
	wound_heal_pierce = WOUND_SEVERITY_CRITICAL
