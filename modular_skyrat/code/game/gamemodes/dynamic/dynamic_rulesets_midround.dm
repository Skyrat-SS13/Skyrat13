/datum/dynamic_ruleset/midround/autotraitor/New()
	protected_roles += "Prisoner"
	protected_roles += "Brig Physician"
	protected_roles += "Blueshield"
	. = ..()
  
/datum/dynamic_ruleset/midround/from_ghosts/blob
	required_enemies = list(3,3,3,3,3,3,3,2,2,2)
	repeatable = FALSE
	property_weights = list("story_potential" = -1, "chaos" = 1, "extended" = -2, "valid" = 1)

//////////////////////////////////////////////
//                                          //
//        TERROR SPIDERS (GHOST)     		//
//                                          //
//////////////////////////////////////////////

/datum/dynamic_ruleset/midround/from_ghosts/terror_spiders
	name = "Terror Spiders Infestation"
	config_tag = "spiders"
	antag_datum = /datum/antagonist/terror_spider
	antag_flag = ROLE_TERROR_SPIDER
	antag_flag_override = ROLE_ALIEN
	enemy_roles = list("Security Officer", "Detective", "Head of Security", "Captain")
	required_enemies = list(3,3,2,2,1,1,1,1,1,0)
	required_candidates = 1
	weight = 3
	cost = 10
	requirements = list(101,101,101,70,50,50,50,50,50,50)
	high_population_requirement = 40
	repeatable_weight_decrease = 2
	repeatable = TRUE
	property_weights = list("story_potential" = -1, "trust" = 1, "chaos" = 2, "extended" = -2, "valid" = 2)
	var/list/vents = list()

/datum/dynamic_ruleset/midround/from_ghosts/terror_spiders/ready()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			if(temp_vent_parent.other_atmosmch.len > 20)
				vents += temp_vent
	if(!vents.len)
		return FALSE
	return ..()

/datum/dynamic_ruleset/midround/from_ghosts/terror_spiders/execute()
	// 50% chance of being incremented by one
	required_candidates += prob(50)
	. = ..()

/datum/dynamic_ruleset/midround/from_ghosts/terror_spiders/generate_ruleset_body(mob/applicant)
	var/obj/vent = pick_n_take(vents)
	var/mob/living/simple_animal/hostile/poison/terror_spider/queen/new_spider = new(vent.loc)
	applicant.transfer_ckey(new_spider, FALSE)
	message_admins("[ADMIN_LOOKUPFLW(new_spider)] has been made into a terror spider by the midround ruleset.")
	log_game("DYNAMIC: [key_name(new_spider)] was spawned as a terror spider by the midround ruleset.")
	return new_spider
