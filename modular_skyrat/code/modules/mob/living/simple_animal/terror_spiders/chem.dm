// Terror Spider, Black, Deadly Venom
/datum/reagent/terror_black_toxin
	name = "Black Terror venom"
	description = "An incredibly toxic venom injected by the Black Widow spider."
	color = "#CF3600"
	metabolization_rate = 0.1

/datum/reagent/terror_black_toxin/on_mob_life(mob/living/M)
	if(volume < 30)
		// bitten once, die very slowly. Easy to survive a single bite - just go to medbay.
		// total damage: 1/tick, human health 150 until crit, = 150 ticks, = 300 seconds = 5 minutes to get to medbay.
		M.adjustToxLoss(1, FALSE)
	else if(volume < 60)
		// bitten twice, die slowly. Get to medbay.
		// total damage: 2/tick, human health 150 until crit, = 75 ticks, = 150 seconds = 2.5 minutes to get some medical treatment.
		M.adjustToxLoss(2, FALSE)
		M.adjust_blurriness(3)
	else if(volume < 90)
		// bitten thrice, die quickly, severe muscle cramps make movement very difficult. Even calling for help probably won't save you.
		// total damage: 4, human health 150 until crit, = 37.5 ticks, = 75s = 1m15s until death
		M.adjustToxLoss(4, FALSE) // a bit worse than coiine
		M.adjust_blurriness(6)
		M.confused = max(M.confused, 6)
	else
		// bitten 4 or more times, whole body goes into shock/death
		// total damage: 8, human health 150 until crit, = 18.75 ticks, = 37s until death
		M.adjustToxLoss(8, FALSE)
		M.adjust_blurriness(6)
		M.Paralyze(5, FALSE)
	return ..()
