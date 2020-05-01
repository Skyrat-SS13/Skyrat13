/obj/item/strangerock
	icon = 'modular_skyrat/code/modules/research/xenoarch/fossil_and_artifact.dmi'
	icon_state = "strange"
	item_state = "strange"

	var/chosenitem = null
	var/itemsafedepth = null
	var/itembasedepth = null
	var/itemactualdepth = null
	var/dugdepth = null

/obj/item/strangerock/Initialize()
	..()














//

/turf/closed/mineral/strange
	mineralType = /obj/item/strangerock
	spreadChance = 5
	spread = 1
	mineralAmt = 1
	scan_state = "rock_Strange"
/* this is for when we have multiz lavaland
/turf/closed/mineral/random/volcanic/strangerock
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/volcanic = 3, /turf/closed/mineral/diamond/volcanic = 1, /turf/closed/mineral/gold/volcanic = 8, /turf/closed/mineral/titanium/volcanic = 8,
		/turf/closed/mineral/silver/volcanic = 20, /turf/closed/mineral/plasma/volcanic = 30, /turf/closed/mineral/bscrystal/volcanic = 1, /turf/closed/mineral/gibtonite/volcanic = 2,
		/turf/closed/mineral/iron/volcanic = 95, /turf/closed/mineral/strange = 15)
*/
/turf/closed/mineral/random/volcanic/New()
	mineralSpawnChanceList += list(/turf/closed/mineral/strange = 15)
	. = ..()