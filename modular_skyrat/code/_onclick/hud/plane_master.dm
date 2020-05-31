/obj/screen/plane_master/object
	name = "object plane master"
	plane = OBJECT_PLANE
	appearance_flags = PLANE_MASTER

/obj/screen/plane_master/object/backdrop(mob/mymob)
	if(mymob?.client?.prefs.ambientocclusion)
		add_filter("ambient_occlusion", 0, AMBIENT_OCCLUSION(4, "#04080FAA"))
	else
		remove_filter("ambient_occlusion")
