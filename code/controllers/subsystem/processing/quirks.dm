//Used to process and handle roundstart quirks
// - Quirk strings are used for faster checking in code
// - Quirk datums are stored and hold different effects, as well as being a vector for applying trait string
PROCESSING_SUBSYSTEM_DEF(quirks)
	name = "Quirks"
	init_order = INIT_ORDER_QUIRKS
	flags = SS_BACKGROUND
	wait = 10
	runlevels = RUNLEVEL_GAME

	var/list/quirks = list()		//Assoc. list of all roundstart quirk datum types; "name" = /path/
	var/list/quirk_names_by_path = list()
	var/list/quirk_points = list()	//Assoc. list of quirk names and their "point cost"; positive numbers are good traits, and negative ones are bad
	var/list/quirk_objects = list()	//A list of all quirk objects in the game, since some may process
	var/list/quirk_blacklist = list() //A list a list of quirks that can not be used with each other. Format: list(quirk1,quirk2),list(quirk3,quirk4)

	//SKYRAT CHANGE
	//yes this is terrible, but i'd rather not deal with creating more useless subsystems
	var/list/all_bloodtypes = list()
	var/list/associated_bodyparts = list()
	var/list/bodypart_child_to_parent = list()
	//

/datum/controller/subsystem/processing/quirks/Initialize(timeofday)
	if(!quirks.len)
		SetupQuirks()
		quirk_blacklist = list(list("Blind","Nearsighted"),list("Jolly","Depression","Apathetic"),list("Ageusia","Deviant Tastes"),list("Ananas Affinity","Ananas Aversion"),list("Alcohol Tolerance","Alcohol Intolerance"),list("Alcohol Intolerance","Drunken Resilience"),list("Speech impediment (r as l)","Speech impediment (l as w)","Speech impediment (r as w)", "Speech impediment (r and l as w)"), list("Do Not Clone", "Do Not Revive")) // Skyrat edit
	//skyrat edit
	//this is awful but it makes my life easier.
	if(!all_bloodtypes.len)
		for(var/datum/species/S in subtypesof(/datum/species))
			all_bloodtypes |= S.exotic_bloodtype
	//this is awful, but byond doesn't let me use bodypart typepaths
	//for the scar configuration in the setup.
	if(!associated_bodyparts.len)
		for(var/i in SSPARTS)
			var/obj/item/bodypart/BP = new i()
			associated_bodyparts[BP.body_zone] = BP
			bodypart_child_to_parent[BP.body_zone] = BP.parent_bodyzone
			BP.moveToNullspace()
	//
	return ..()

/datum/controller/subsystem/processing/proc/atomize_bodypart_heritage(body_zone)
	. = list()
	if(!body_zone)
		return
	var/obj/item/bodypart/BP = SSquirks.associated_bodyparts[body_zone]
	. |= BP.body_zone
	for(var/i in BP.children_zones)
		var/obj/item/bodypart/BoPa = SSquirks.associated_bodyparts[i]
		. |= BoPa.body_zone
		. |= BoPa.children_zones

/datum/controller/subsystem/processing/quirks/proc/SetupQuirks()
// Sort by Positive, Negative, Neutral; and then by name
	var/list/quirk_list = sortList(subtypesof(/datum/quirk), /proc/cmp_quirk_asc)

	for(var/V in quirk_list)
		var/datum/quirk/T = V
		quirks[initial(T.name)] = T
		quirk_points[initial(T.name)] = initial(T.value)
		quirk_names_by_path[T] = initial(T.name)

/datum/controller/subsystem/processing/quirks/proc/AssignQuirks(mob/living/user, client/cli, spawn_effects, roundstart = FALSE, datum/job/job, silent = FALSE, mob/to_chat_target)
	var/badquirk = FALSE
	var/list/my_quirks = cli.prefs.all_quirks.Copy()
	var/list/cut
	if(job?.blacklisted_quirks)
		cut = filter_quirks(my_quirks, job.blacklisted_quirks)
	for(var/V in my_quirks)
		var/datum/quirk/Q = quirks[V]
		if(Q)
			user.add_quirk(Q, spawn_effects)
		else
			stack_trace("Invalid quirk \"[V]\" in client [cli.ckey] preferences")
			cli.prefs.all_quirks -= V
			badquirk = TRUE
	if(badquirk)
		cli.prefs.save_character()
	if (!silent && LAZYLEN(cut))
		to_chat(to_chat_target || user, "<span class='boldwarning'>Some quirks have been cut from your character because of these quirks conflicting with your job assignment: [english_list(cut)].</span>")
	//SKYRAT CHANGE
	//You might be asking... "bobyot y u do dis in quirk soobsistem it make no sense"
	//i just don't want to create a whole other subsystem, along with a new proc, for doing this one time stuff
	if(cli.prefs.bloodtype)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(cli.prefs.bloodtype in H.dna.species.bloodtypes)
				H.dna.blood_type = cli.prefs.bloodtype
	if(cli.prefs.bloodreagent)
		if(ishuman(user))
			var/datum/reagent/bloop
			var/mob/living/carbon/human/H = user
			if(H.dna.species.bloodreagents.len)
				for(var/i in all_bloodtypes)
					var/datum/reagent/R = i
					if(R.name == cli.prefs.bloodtype)
						bloop = R
				if(bloop)
					H.dna.species.exotic_blood = bloop.type
	if(cli.prefs.bloodtype)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.dna.species.bloodtypes.len)
				H.dna.blood_type = cli.prefs.bloodtype
	if(cli.prefs.bloodcolor)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			if(H.dna.species.rainbowblood)
				H.dna.blood_color = cli.prefs.bloodcolor
	//SKYRAT CHANGE - food preferences
	//Yes, i am using the quirk subsystem to assign food preferences and descriptors. Too bad!
	var/mob/living/carbon/human/H = user
	if(istype(H))
		if(cli.prefs.foodlikes.len)
			H.dna.species.liked_food = 0
			for(var/V in cli.prefs.foodlikes)
				H.dna.species.liked_food |= cli.prefs.foodlikes[V]
		if(cli.prefs.fooddislikes.len)
			H.dna.species.disliked_food = 0
			for(var/V in cli.prefs.fooddislikes)
				H.dna.species.disliked_food |= cli.prefs.fooddislikes[V]
	//Yes, i am using the quirk subsystem to assign scars. Too bad!
	if(istype(H))
		for(var/i in cli.prefs.cosmetic_scars)
			if(H.get_bodypart(i))
				for(var/y in cli.prefs.cosmetic_scars[i])
					var/datum/scar/S = new()
					S.permanent = TRUE
					if(cli.prefs.cosmetic_scars[i][y]["desc"] && (cli.prefs.cosmetic_scars[i][y]["desc"] != "None"))
						S.pref_apply(H.get_bodypart(i), y, cli.prefs.cosmetic_scars[i][y]["desc"], cli.prefs.cosmetic_scars[i][y]["severity"])
		if(LAZYLEN(cli.prefs.body_descriptors) && LAZYLEN(H.dna.species.descriptors))
			for(var/entry in H.dna.species.descriptors)
				if(cli.prefs.body_descriptors[entry])
					var/datum/mob_descriptor/descriptor = H.dna.species.descriptors[entry]
					descriptor.current_value = cli.prefs.body_descriptors[entry]
	//Let's update the gene tools, in case the client uses metric (is based)
	if(cli.prefs.toggles & METRIC_OR_BUST)
		for(var/obj/item/organ/genital/genetool in H.internal_organs)
			genetool.update()
	//

/datum/controller/subsystem/processing/quirks/proc/quirk_path_by_name(name)
	return quirks[name]

/datum/controller/subsystem/processing/quirks/proc/quirk_points_by_name(name)
	return quirk_points[name]

/datum/controller/subsystem/processing/quirks/proc/quirk_name_by_path(path)
	return quirk_names_by_path[path]

/datum/controller/subsystem/processing/quirks/proc/total_points(list/quirk_names)
	. = 0
	for(var/i in quirk_names)
		. += quirk_points_by_name(i)

/datum/controller/subsystem/processing/quirks/proc/filter_quirks(list/our_quirks, list/blacklisted_quirks)
	var/list/cut = list()
	var/list/banned_names = list()
	var/pointscut = 0
	for(var/i in blacklisted_quirks)
		var/name = quirk_name_by_path(i)
		if(name)
			banned_names += name
	var/list/blacklisted = our_quirks & banned_names
	if(length(blacklisted))
		for(var/i in blacklisted)
			our_quirks -= i
			cut += i
			pointscut += quirk_points_by_name(i)
	if (pointscut != 0)
		for (var/i in shuffle(our_quirks))
			if (quirk_points_by_name(i) < pointscut || (pointscut < 0) ? quirk_points_by_name(i) <= 0 : quirk_points_by_name(i) >= 0)
				continue
			else
				our_quirks -= i
				cut += i
				pointscut += quirk_points_by_name(i)
			if (pointscut >= 0)
				break
	/*	//Code to automatically reduce positive quirks until balance is even.
	var/points_used = total_points(our_quirks)
	if(points_used > 0)
		//they owe us points, let's collect.
		for(var/i in our_quirks)
			var/points = quirk_points_by_name(i)
			if(points > 0)
				cut += i
				our_quirks -= i
				points_used -= points
			if(points_used <= 0)
				break
	*/

	//Nah, let's null all non-neutrals out.
	if (pointscut < 0)// only if the pointscutting didn't work.
		if(cut.len)
			for(var/i in our_quirks)
				if(quirk_points_by_name(i) != 0)
					//cut += i		-- Commented out: Only show the ones that triggered the quirk purge.
					our_quirks -= i

	return cut
