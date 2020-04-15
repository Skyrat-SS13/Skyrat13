/obj/effect/spawner/blocker
	name = "blocking object"
	desc = "Places a blocking object then deletes itself."
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "talk_stop"

/obj/effect/spawner/blocker/Initialize(mapload)

	if(prob(10))
		return INITIALIZE_HINT_QDEL

	var/list/possible_outcomes = list(
		/obj/structure/barricade/security = 1,
		/obj/structure/barricade/wooden = 10,
		/obj/structure/bookcase/random = 1,
		/obj/structure/closet/cardboard = 1,
		/obj/structure/door_assembly/door_assembly_mai = 1,
		/obj/structure/falsewall = 5,
		/obj/structure/foamedmetal = 3,
		/obj/structure/grille = 10,
		/obj/structure/grille/broken = 3,
		/obj/structure/mineral_door/iron = 3,
		/obj/structure/mineral_door/wood = 1,
		/obj/structure/plasticflaps = 1,
		/obj/effect/spawner/structure/window = 4,
		/obj/effect/spawner/structure/window/reinforced = 2,
		/obj/effect/spawner/structure/window/hollow = 2,
		/obj/effect/spawner/structure/window/hollow/reinforced = 1
	)

	var/outcome = pickweight(possible_outcomes)

	var/turf/T = get_turf(src)

	if(ispath(outcome,/turf/))
		for(var/turf/closed/C in range(2, src))
			T.PlaceOnTop(C.type)
			return INITIALIZE_HINT_QDEL
		T.PlaceOnTop(outcome)
	else if(ispath(outcome,/atom/movable/))
		new outcome(T)

	return INITIALIZE_HINT_QDEL