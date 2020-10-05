//Dreamer antagonist datum
/datum/antagonist/dreamer
	name = "Dreamer"
	roundend_category = "Dreamer"
	antag_memory = "<b>Recently I've been visited by a lot of VISIONS. They're all about another WORLD, ANOTHER life. I will do EVERYTHING to know the TRUTH, and return to the REAL world.</b>"
	threat = 10
	var/list/recipe_progression = list(/datum/crafting_recipe/wonder, /datum/crafting_recipe/wonder/second, /datum/crafting_recipe/wonder/third, /datum/crafting_recipe/wonder/fourth)
	var/list/heart_keys = list()
	var/list/associated_keys = list()
	var/current_wonder = 0
	var/sum_keys = 0

/datum/antagonist/dreamer/New()
	. = ..()
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

/datum/antagonist/dreamer/greet()
	. = ..()
	to_chat(owner.current, "<b>Recently I've been visited by a lot of VISIONS. They're all about another WORLD, ANOTHER life. I will do EVERYTHING to know the TRUTH, and return to the REAL world.</b>")
	if(length(objectives))
		owner.announce_objectives()

/datum/antagonist/dreamer/on_gain()
	. = ..()
	for(var/datum/stats/stat in owner.mob_stats)
		if(istype(stat, /datum/stats/end) || istype(stat, /datum/stats/str))
			stat.level = min(stat.level + 10, MAX_STAT)
	for(var/datum/skills/surgery/surgery in owner.mob_skills)
		surgery.level = min(surgery.level + 10, MAX_SKILL)
	owner.teach_crafting_recipe(/datum/crafting_recipe/wonder)
	give_wakeup_call()
	give_hallucination_object(owner.current)

/datum/antagonist/dreamer/proc/wake_up()
	to_chat(world, "<span class='userdanger'>The dreamer has awakened!</span>")
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			M.playsound_local(get_turf(M), 'modular_skyrat/code/modules/antagonists/dreamer/sound/killer_win.ogg', 100, 0)
	SSticker.declare_completion()
