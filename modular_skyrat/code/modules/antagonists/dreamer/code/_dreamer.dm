//Dreamer antagonist datum
/datum/antagonist/dreamer
	name = "Dreamer"
	roundend_category = "dreamers"
	antagpanel_category = "Dreamer"
	antag_memory = "<b>Recently I've been visited by a lot of VISIONS. They're all about another WORLD, ANOTHER life. I will do EVERYTHING to know the TRUTH, and return to the REAL world.</b><br>"
	threat = 10
	var/list/recipe_progression = list(/datum/crafting_recipe/wonder, /datum/crafting_recipe/wonder/second, /datum/crafting_recipe/wonder/third, /datum/crafting_recipe/wonder/fourth)
	var/list/heart_keys = list()
	var/list/associated_keys = list()
	var/current_wonder = 0
	var/sum_keys = 0
	silent = TRUE

//Transferring body unfucking.
/datum/antagonist/dreamer/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	if(new_body.hud_used)
		give_hallucination_object(new_body)
		if(new_body.hud_used?.dreamer && old_body.hud_used?.dreamer)
			new_body.hud_used.dreamer.waking_up = old_body.hud_used.dreamer.waking_up

/datum/antagonist/dreamer/New()
	. = ..()
	set_keys()

/datum/antagonist/dreamer/proc/set_keys()
	var/list/alphabet = list("A", "B", "C",\
							"D", "E", "F",\
							"G", "H", "I",\
							"J", "K", "L",\
							"M", "N", "O",\
							"P", "Q", "R",\
							"S", "T", "U",\
							"V", "W", "X",\
							"Y", "Z")
	heart_keys = list()
	//We need 4 numbers and four keys
	for(var/i in 1 to 4)
		//Make the number first
		var/randumb = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		while(randumb in heart_keys)
			randumb = "[rand(0,9)][rand(0,9)][rand(0,9)][rand(0,9)]"
		//Make the key second
		var/rantelligent = "[pick(alphabet)][pick(alphabet)][pick(alphabet)][pick(alphabet)]"
		while(rantelligent in associated_keys)
			rantelligent = "[pick(alphabet)][pick(alphabet)][pick(alphabet)][pick(alphabet)]"

		//Stick then in the lists, continue the loop
		heart_keys[randumb] = rantelligent
		associated_keys[rantelligent] = randumb
	
	sum_keys = 0
	for(var/i in heart_keys)
		sum_keys += text2num(i)

/datum/antagonist/dreamer/proc/give_wakeup_call()
	var/datum/objective/dreamer/wakeup = new()
	objectives += wakeup

/datum/antagonist/dreamer/proc/give_hallucination_object(mob/living/carbon/M)
	if(istype(M) && M.hud_used)
		M.hud_used.dreamer = new()
		if(M.client)
			M.hud_used.dreamer.update_for_view(M.client.view)
		M.client?.screen += M.hud_used.dreamer

/datum/antagonist/dreamer/proc/give_stats(mob/living/carbon/M)
	if(!istype(M) || !M.mind)
		return
	var/datum/stats/str/str = GET_STAT(M, str)
	if(istype(str))
		str.level = min(str.level + 10, MAX_STAT)
	var/datum/stats/end/end = GET_STAT(M, end)
	if(istype(end))
		end.level = min(end.level + 10, MAX_STAT)
	var/datum/skills/surgery/surgery = GET_SKILL(M, surgery)
	if(istype(surgery))
		surgery.level = min(surgery.level + 10, MAX_SKILL)

/datum/antagonist/dreamer/proc/grant_first_wonder_recipe(mob/living/carbon/M)
	if(!istype(M))
		return
	current_wonder++
	var/datum/crafting_recipe/wonder/wonderful = new()
	wonderful.name = "[associated_keys[1]] Wonder"
	wonderful.update_global_wonder()
	owner.teach_crafting_recipe(wonderful.type)
	qdel(wonderful)

/datum/antagonist/dreamer/proc/wake_up()
	var/mob/dreamer = owner.current
	dreamer.stop_sound_channel(CHANNEL_HIGHEST_AVAILABLE)
	for(var/datum/objective/objective in objectives)
		objective.completed = TRUE
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			M.playsound_local(get_turf(M), 'modular_skyrat/code/modules/antagonists/dreamer/sound/dreamer_win.ogg', 100, 0)
	SSticker.declare_completion()
	to_chat(world, "<span class='deadsay'><span class='big bold'>The dreamer has awakened!</span></span>")

/datum/antagonist/dreamer/proc/cant_wake_up()
	if(!iscarbon(owner.current))
		return
	to_chat(owner.current, "<span class='deadsay'><span class='big bold'>I CAN'T WAKE UP.</span></span>")
	sleep(20)
	to_chat(owner.current, "<span class='deadsay'><span class='big bold'>ICANTWAKEUP</span></span>")
	sleep(10)
	var/mob/living/carbon/C = owner.current
	var/obj/item/organ/brain/brain = C.getorganslot(ORGAN_SLOT_BRAIN)
	var/obj/item/bodypart/head/head = C.get_bodypart(BODY_ZONE_HEAD)
	if(head)
		head.dismember_wound(WOUND_BURN)
	if(brain)
		qdel(brain)

/datum/antagonist/dreamer/proc/agony(mob/living/carbon/M)
	if(!istype(M))
		return
	var/sound/im_sick = sound('modular_skyrat/code/modules/antagonists/dreamer/sound/dreamt.ogg', TRUE, FALSE, CHANNEL_HIGHEST_AVAILABLE, 100)
	M.playsound_local(turf_source = get_turf(M), S = im_sick, vol = 100, vary = 0)
	M.hud_used?.dreamer?.waking_up = TRUE

/datum/antagonist/dreamer/on_removal()
	. = ..()
	agony(owner.current)
	spawn(40)
		cant_wake_up()

/datum/antagonist/dreamer/Destroy()
	. = ..()
	if(owner?.current)
		owner.current.client?.screen -= owner.current.hud_used?.dreamer
		if(owner.current.hud_used?.dreamer)
			QDEL_NULL(owner.current.hud_used.dreamer)

/datum/antagonist/dreamer/greet()
	. = ..()
	to_chat(owner.current, "<span class='danger'><b>Recently I've been visited by a lot of VISIONS. They're all about another WORLD, ANOTHER life. I will do EVERYTHING to know the TRUTH, and return to the REAL world.</b></span>")
	if(length(objectives))
		owner.announce_objectives()

/datum/antagonist/dreamer/on_gain()
	. = ..()
	give_wakeup_call()
	give_hallucination_object(owner.current)
	give_stats(owner.current)
	grant_first_wonder_recipe(owner.current)
	greet()
