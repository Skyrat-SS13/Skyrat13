/mob/living/silicon/robot
	var/hasShrunk = FALSE

/mob/living/silicon/robot/modules/roleplay
	lawupdate = FALSE
	scrambledcodes = TRUE // Roleplay borgs aren't real
	set_module = /obj/item/robot_module/roleplay

/mob/living/silicon/robot/modules/roleplay/Initialize()
	. = ..()
	cell = new /obj/item/stock_parts/cell/infinite(src, 30000)
	laws = new /datum/ai_laws/roleplay()

/mob/living/silicon/robot/modules/roleplay/binarycheck()
	return 0 //Roleplay borgs aren't truly borgs
