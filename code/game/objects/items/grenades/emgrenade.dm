/obj/item/grenade/empgrenade
	name = "classic EMP grenade"
	desc = "It is designed to wreak havoc on electronic systems."
	icon_state = "emp"
	item_state = "emp"

/obj/item/grenade/empgrenade/prime(mob/living/lanced_by)
	//skyrat edit
	. = ..()
	//
	update_mob()
	empulse(src, 4, 10)
	/* skyrat edit
	qdel(src)
	*/
	qdel(src)
