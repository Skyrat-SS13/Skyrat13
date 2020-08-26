/datum/reagent/consumable/ethanol/whiskey
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //let's not force the detective to change his alcohol brand

// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/reagent/consumable/ethanol/synthanol
	name = "Synthanol"
	description = "A runny liquid with conductive capacities. Its effects on synthetics are similar to those of alcohol on organics."
	color = "#1BB1FF"
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC
	boozepwr = 50
	quality = DRINK_NICE
	glass_icon = 'modular_skyrat/icons/obj/drinks.dmi'
	glass_icon_state = "synthanolglass"
	glass_name = "Glass of Synthanol"
	glass_desc = "The equivalent of alcohol for synthetic crewmembers. They'd find it awful if they had tastebuds too."
	taste_description = "motor oil"
	value = 1

/datum/reagent/consumable/ethanol/synthanol/on_mob_life(mob/living/M)
	if(!M.isRobotic())
		holder.remove_reagent(type, 3.6) //gets removed from organics very fast
		if(prob(25))
			var/mob/living/carbon/U = M
			holder.remove_reagent(type, 15)
			U.vomit(5, FALSE, FALSE)
	return ..()

/datum/reagent/consumable/ethanol/synthanol/reaction_mob(mob/living/M, method=TOUCH, volume)
	if(M.isRobotic())
		return
	if(method == INGEST)
		to_chat(M, pick("<span class = 'danger'>That was awful!</span>", "<span class = 'danger'>That was disgusting!</span>"))

/datum/reagent/consumable/ethanol/synthanol/robottears
	name = "Robot Tears"
	description = "An oily substance that an IPC could technically consider a 'drink'."
	color = "#363636"
	boozepwr = 25
	glass_icon_state = "robottearsglass"
	glass_name = "Glass of Robot Tears"
	glass_desc = "No robots were hurt in the making of this drink."
	taste_description = "existential angst"

/datum/reagent/consumable/ethanol/synthanol/trinary
	name = "Trinary"
	description = "A fruit drink meant only for synthetics, however that works."
	color = "#ADB21f"
	boozepwr = 20
	glass_icon_state = "trinaryglass"
	glass_name = "Glass of Trinary"
	glass_desc = "Colorful drink made for synthetic crewmembers. It doesn't seem like it would taste well."
	taste_description = "modem static"

/datum/reagent/consumable/ethanol/synthanol/servo
	name = "Servo"
	description = "A drink containing some organic ingredients, but meant only for synthetics."
	color = "#5B3210"
	boozepwr = 25
	glass_icon_state = "servoglass"
	glass_name = "Glass of Servo"
	glass_desc = "Chocolate - based drink made for IPCs. Not sure if anyone's actually tried out the recipe."
	taste_description = "motor oil and cocoa"

/datum/reagent/consumable/ethanol/synthanol/uplink
	name = "Uplink"
	description = "A potent mix of alcohol and synthanol. Will only work on synthetics."
	color = "#E7AE04"
	boozepwr = 15
	glass_icon_state = "uplinkglass"
	glass_name = "Glass of Uplink"
	glass_desc = "An exquisite mix of the finest liquoirs and synthanol. Meant only for synthetics."
	taste_description = "a GUI in visual basic"

/datum/reagent/consumable/ethanol/synthanol/synthncoke
	name = "Synth 'n Coke"
	description = "The classic drink adjusted for a robot's tastes."
	color = "#7204E7"
	boozepwr = 25
	glass_icon_state = "synthncokeglass"
	glass_name = "Glass of Synth 'n Coke"
	glass_desc = "Classic drink altered to fit the tastes of a robot, contains de-rustifying properties. Bad idea to drink if you're made of carbon."
	taste_description = "fizzy motor oil"

/datum/reagent/consumable/ethanol/synthanol/synthignon
	name = "Synthignon"
	description = "Someone mixed wine and alcohol for robots. Hope you're proud of yourself."
	color = "#D004E7"
	boozepwr = 25
	glass_icon_state = "synthignonglass"
	glass_name = "Glass of Synthignon"
	glass_desc = "Someone mixed good wine and robot booze. Romantic, but atrocious."
	taste_description = "fancy motor oil"

/datum/reagent/consumable/ethanol/balikitwine
	name = "Balikit Wine"
	description = "If you ever wanted to know what being bitten was like..."
	color = "#664300" // rgb: 102, 67, 0
	nutriment_factor = 0
	boozepwr = 60 
	quality = DRINK_FANTASTIC // 4 out of 6
	metabolization_rate = REAGENTS_METABOLISM 
	taste_description = "the need to go to medical"
	glass_icon = 'modular_skyrat/icons/obj/drinks.dmi'
	glass_icon_state = "bagatjiwineglass"
	glass_name = "Balikit Wine"
	glass_desc = "They put it in a decanter."
	value = REAGENT_VALUE_RARE

/datum/reagent/consumable/ethanol/balikitwine/on_mob_life(mob/living/carbon/C)
	var/mob/living/carbon/human/H = C
	if(istype(H) && H.physiology.footstep_type != FOOTSTEP_MOB_CRAWL) // Bit of a hacky way to check if the consumer is a snake taur. Only snektaurs have this though.
		H.adjustToxLoss(2.5*REM) // Bagatji (and all snake taurs) take no ill effects.
		H.adjustStaminaLoss(8*REM)
		H.hallucination += 10
		H.set_drugginess(30)
	return ..()

/datum/reagent/consumable/ethanol/balikitwine/on_mob_metabolize(mob/living/carbon/C) // Custom hallucination weights for this drink
	if(istype(C))
		C.custom_hallucinations = list(/datum/hallucination/chat = 100,
										/datum/hallucination/sounds = 50,
										/datum/hallucination/dangerflash = 15,
										/datum/hallucination/weird_sounds = 15,
										/datum/hallucination/fake_flood = 15,
										/datum/hallucination/husks = 15,
										/datum/hallucination/items = 10,
										/datum/hallucination/fire = 10,
										/datum/hallucination/self_delusion = 5,
										/datum/hallucination/delusion = 5,
										/datum/hallucination/shock = 4,
										/datum/hallucination/death = 4
										)
	return

/datum/reagent/consumable/ethanol/balikitwine/on_mob_end_metabolize(mob/living/carbon/C)
	if(istype(C))
		C.custom_hallucinations = list()
	return
