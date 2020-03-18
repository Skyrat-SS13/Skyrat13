//holorifle boolet
/obj/item/storage/belt/bandolier/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 21
	STR.display_numerical_stacking = TRUE
	STR.set_holdable(list(
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_casing/microfusion
		))