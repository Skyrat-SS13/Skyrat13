// Terror Spiders - white spider infection
/obj/item/organ/body_egg/terror_eggs
	name = "terror eggs"
	icon = 'icons/effects/effects.dmi'
	icon_state = "eggs"
	slot = ORGAN_SLOT_PARASITES

	var/cycle_num = 0 // # of on_life() cycles completed, never reset
	var/egg_progress = 0 // # of on_life() cycles completed, unlike cycle_num this is reset on each hatch event
	var/egg_progress_per_hatch = 90 // if egg_progress > this, chance to hatch and reset egg_progress
	var/eggs_hatched = 0 // num of hatch events completed
	var/list/types_basic = list(/mob/living/simple_animal/hostile/poison/terror_spider/red, /mob/living/simple_animal/hostile/poison/terror_spider/gray)
	var/list/types_adv = list(/mob/living/simple_animal/hostile/poison/terror_spider/red, /mob/living/simple_animal/hostile/poison/terror_spider/gray, /mob/living/simple_animal/hostile/poison/terror_spider/green)

/obj/item/organ/body_egg/terror_eggs/on_life()
	// Safety first.
	if(!owner)
		return

	// Parasite growth
	cycle_num += 1
	egg_progress += pick(0, 1, 2)
	egg_progress += calc_variable_progress()

	// Once at least one egg has hatched from you, you'll need help to reach medbay.
	if(eggs_hatched >= 1)
		owner.confused = max(owner.confused, 45)

	if(egg_progress > egg_progress_per_hatch)
		egg_progress -= egg_progress_per_hatch
		hatch_egg()

/obj/item/organ/body_egg/terror_eggs/proc/calc_variable_progress()
	var/extra_progress = 0
	if(owner.nutrition > NUTRITION_LEVEL_FULL)
		extra_progress += 1
	var/antibiotics = owner.reagents.get_reagent_amount("spaceacillin")
	if(antibiotics > 50)
		extra_progress -= 0.5
	var/boosters = owner.reagents.get_reagent_amount("salglu_solution")
	if(boosters > 1)
		extra_progress += 1
	return extra_progress

/obj/item/organ/body_egg/terror_eggs/proc/hatch_egg()
	var/infection_completed = FALSE
	var/obj/structure/spider/spiderling/terror_spiderling/S = new(get_turf(owner))
	switch(eggs_hatched)
		if(0) // First spiderling
			S.grow_as = pick(types_basic)
		if(1) // Second
			S.grow_as = pick(types_adv)
		if(2) // Last
			S.grow_as = /mob/living/simple_animal/hostile/poison/terror_spider/princess
			infection_completed = TRUE
	S.immediate_ventcrawl = TRUE
	eggs_hatched++
	to_chat(owner, "<span class='warning'>A strange prickling sensation moves across your skin... then suddenly the whole world seems to spin around you!</span>")
	owner.Paralyze(10)
	if(infection_completed && !QDELETED(src))
		qdel(src)

/obj/item/organ/body_egg/terror_eggs/Remove(var/mob/living/carbon/M, var/special = 0)
	..()
	if(!QDELETED(src))
		qdel(src) // prevent people re-implanting them into others
	return null