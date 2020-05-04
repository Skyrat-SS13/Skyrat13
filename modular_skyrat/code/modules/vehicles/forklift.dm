/obj/vehicle/forklift
	name = "Forklift"
	desc = "Ripleys are for wussies. Real cargonians drive forklifts."
	icon = 'modular_skyrat/icons/obj/vehicles.dmi'
	icon_state = "forklift"
	armor = list("melee" = 40, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 75, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 75)
	move_delay = 2.5
	key_type = /obj/item/card/forkliftoperator
	var/mutable_appearance/overlay
	var/mutable_appearance/underlay
	var/lifting = FALSE //used when lifting stuff. basically impedes the forklift from doing anything until it fully lifts something.
	var/list/lifted //A list of mobs or objects being lifted

/obj/vehicle/forklift/Initialize(mapload)
	..()
	overlay = new mutable_appearance('modular_skyrat/icons/obj/vehicles.dmi', "forkliftover")
	overlays += overlay
	underlay = new mutable_appearance('modular_skyrat/icons/obj/vehicles.dmi', "forkliftunder")
	underlays += underlay

/obj/item/card/forkliftoperator
	name = "Forklift license"
	desc = "Approved by the FDA! (Forklift Drivers Association)."
	icon = 'modular_skyrat/icons/obj/vehicles.dmi'
	icon_state = "forkliftlicense"

/obj/vehicle/forklift/attackby(obj/item/I, mob/living/user, params)
	if((I.type == /obj/item/card/forkliftoperator) && (user.a_intent != INTENT_HARM) && (is_driver(user)))
		if(lifted)
			lift()
		else
			unlift()
	..()

/obj/vehicle/forklift/lift()
	if(!lifting)
		var/list/canbelifted = locate(obj | mob) in get_step(src, src.dir)
		var/mutable_appearance/overunder = overlay
		if(src.dir == NORTH)
			overunder = underlay
		lifting = TRUE
		animate(overunder, pixel_y += 4, 10)
