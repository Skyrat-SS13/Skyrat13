/turf/closed/wall/plastic
	name = "plastic wall"
	desc = "A wall with plastic plating. Cheap..."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticwall.dmi'
	icon_state = "wall"
	sheet_type = /obj/item/stack/sheet/plastic
	girder_type = /obj/structure/girder/plastic
	explosion_block = 0
	canSmoothWith = list(/turf/closed/wall/plastic, /obj/structure/falsewall/plastic)

/obj/structure/falsewall/plastic
	name = "plastic wall"
	desc = "A wall with plastic plating. Cheap..."
	icon = 'modular_skyrat/code/game/objects/structures/plasticusage/plasticwall.dmi'
	icon_state = "fwall"
	mineral = /obj/item/stack/sheet/plastic
	walltype = /turf/closed/wall/plastic
	canSmoothWith = list(/obj/structure/falsewall/plastic, /turf/closed/wall/plastic)
	girder_type = /obj/structure/girder/plastic/displaced