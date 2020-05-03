/obj/item/ancientartifact
	name = "Admin Debug. Parent Artifact"
	desc = "You shouldn't have this."
	icon = 'modular_skyrat/code/modules/research/xenoarch/fossil_and_artifact.dmi'

/obj/item/ancientartifact/Initialize()
	..()

//

/datum/export/artifacts
	cost = 1000 //Big cash
	unit_name = "useless artifact"
	export_types = list(/obj/item/ancientartifact/useless)

/datum/export/artifacts
	cost = 2000 //Big cash
	unit_name = "fossil artifact"
	export_types = list(/obj/item/ancientartifact/faunafossil,/obj/item/ancientartifact/florafossil)

//

/obj/item/ancientartifact/useless
	name = "nonfunctional artifact"
	desc = "this artifact is nonfunctional... perhaps it can be researched or sold."

/obj/item/ancientartifact/useless/Initialize()
	icon_state = pick(list("urn","statuette","instrument","unknown1","unknown2","unknown3"))
	..()

/obj/item/ancientartifact/useless/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/help/research))
		if(!do_after(user,300,target=src))
			to_chat(user,"You must stand still to analyze.")
			return
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 1000))
		to_chat(user,"You successfully researched the artifact. You have gained 1000 research points.")
		qdel(src)

/obj/item/ancientartifact/faunafossil
	name = "fauna fossil"
	desc = "this is a fossil of an animal... seems dead."

/obj/item/ancientartifact/faunafossil/Initialize()
	icon_state = pick(list("bone1","bone2","bone3","bone4"))
	..()

/obj/item/ancientartifact/faunafossil/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/help/research))
		if(!do_after(user,300,target=src))
			to_chat(user,"You must stand still to analyze.")
			return
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 2000))
		to_chat(user,"You successfully researched the artifact. You have gained 1000 research points.")
		qdel(src)

/obj/item/ancientartifact/florafossil
	name = "flora fossil"
	desc = "this is a fossil of a plant... seems dead."

/obj/item/ancientartifact/florafossil/Initialize()
	icon_state = pick(list("plant1","plant2","plant3","plant4"))
	..()

/obj/item/ancientartifact/florafossil/attackby(obj/item/W, mob/user, params)
	if(istype(W,/obj/item/xenoarch/help/research))
		if(!do_after(user,300,target=src))
			to_chat(user,"You must stand still to analyze.")
			return
		SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = 2000))
		to_chat(user,"You successfully researched the artifact. You have gained 1000 research points.")
		qdel(src)