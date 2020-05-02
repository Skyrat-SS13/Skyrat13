/obj/item/strangerock
	icon = 'modular_skyrat/code/modules/research/xenoarch/fossil_and_artifact.dmi'
	name = "Strange Rock"
	desc = "This is a strange rock, it appears to have a relic encased."
	icon_state = "strange"
	item_state = "strange"

	var/chosenitem = null
	var/itemsafedepth = null
	var/itembasedepth = null
	var/itemactualdepth = null
	var/dugdepth = null

/obj/item/strangerock/Initialize()
	var/randomnumber = rand(1,200)
	switch(randomnumber)
		if(1 to 159)
			chosenitem = pick(GLOB.bas_artifact)
			itembasedepth = rand(30,40)
			itemsafedepth = rand(3,6)
			itemactualdepth = rand(itembasedepth - itemsafedepth,itembasedepth)
		if(160 to 199)
			chosenitem = pick(GLOB.adv_artifact)
			itembasedepth = rand(40,60)
			itemsafedepth = rand(6,12)
			itemactualdepth = rand(itembasedepth - itemsafedepth,itembasedepth)
		if(200)
			chosenitem = pick(GLOB.ult_artifact)
			itembasedepth = rand(70,100)
			itemsafedepth = rand(12,14)
			itemactualdepth = rand(itembasedepth - itemsafedepth,itembasedepth)
	..()

/obj/item/strangerock/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm1))
		var/obj/item/xenoarch/clean/hammer/cm1/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm2))
		var/obj/item/xenoarch/clean/hammer/cm2/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm3))
		var/obj/item/xenoarch/clean/hammer/cm3/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm4))
		var/obj/item/xenoarch/clean/hammer/cm4/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm5))
		var/obj/item/xenoarch/clean/hammer/cm5/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm6))
		var/obj/item/xenoarch/clean/hammer/cm6/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/hammer/cm15))
		var/obj/item/xenoarch/clean/hammer/cm15/HM = W
		if(!do_after(user,HM.cleandepth * 5,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		dugdepth += HM.cleandepth
		if(dugdepth > itemactualdepth)
			to_chat(user,"The strange rock crumbles, destroying anything that could have been recovered.")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/clean/brush))
		if(!do_after(user,50,target = src))
			to_chat(user,"You must stand still to clean.")
			return
		if(dugdepth < itemactualdepth)
			dugdepth++
			to_chat(user,"You brush away 1cm of debris.")
			return
		if(dugdepth > itemactualdepth)
			to_chat(user,"You somehow managed to destroy a strange rock with a brush... good job?")
		if(dugdepth == itemactualdepth)
			new chosenitem(get_turf(src))
			to_chat(user,"You uncover an artifact!")
			qdel(src)
			return
	if(istype(W,/obj/item/xenoarch/help/scanner))
		if(!do_after(user,50,target = src))
			to_chat(user,"You must stand still to scan.")
			return
		to_chat(user,"Base Depth: [itembasedepth] centimeters.")
		to_chat(user,"Safe Depth: [itemsafedepth] centimeters.")
	if(istype(W,/obj/item/xenoarch/help/scanneradv))
		if(!do_after(user,50,target = src))
			to_chat(user,"You must stand still to scan.")
			return
		to_chat(user,"Base Depth: [itembasedepth] centimeters.")
		to_chat(user,"Safe Depth: [itemsafedepth] centimeters.")
		to_chat(user,"Item Depth: [itemactualdepth] centimeters.")
		to_chat(user,"Item Scan: [chosenitem].")
	if(istype(W,/obj/item/xenoarch/help/measuring))
		if(!do_after(user,25,target = src))
			to_chat(user,"You must stand still to measure.")
			return
		if(!dugdepth)
			to_chat(user,"This rock has not been touched.")
			return
		to_chat(user,"Current depth dug: [dugdepth] centimeters.")
//

/turf/closed/mineral/strange
	mineralType = /obj/item/strangerock
	spreadChance = 5
	spread = 1
	mineralAmt = 1
	scan_state = "rock_Strange"
/* this is for when we have multiz lavaland. Replace the walls with these.
/turf/closed/mineral/random/volcanic/strangerock
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/volcanic = 3, /turf/closed/mineral/diamond/volcanic = 1, /turf/closed/mineral/gold/volcanic = 8, /turf/closed/mineral/titanium/volcanic = 8,
		/turf/closed/mineral/silver/volcanic = 20, /turf/closed/mineral/plasma/volcanic = 30, /turf/closed/mineral/bscrystal/volcanic = 1, /turf/closed/mineral/gibtonite/volcanic = 2,
		/turf/closed/mineral/iron/volcanic = 95, /turf/closed/mineral/strange = 15)
*/
/turf/closed/mineral/random/volcanic/New()
	mineralSpawnChanceList += list(/turf/closed/mineral/strange = 15)
	. = ..()