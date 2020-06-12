/obj/structure/closet/secure_closet/psychologist
	name = "psychologist's cabinent"
	desc = "Used to hold sensitive personnel material."
	req_access = list(ACCESS_PSYCHOLOGY)
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	material_drop = /obj/item/stack/sheet/mineral/wood
	cutting_tool = /obj/item/screwdriver

/obj/structure/closet/secure_closet/psychologist/PopulateContents()
	..()
	new /obj/item/radio/headset/headset_med(src)
	new /obj/item/clothing/under/rank/medical/psychologist(src)
	new /obj/item/clothing/under/rank/medical/psychologist/skirt(src)
	new /obj/item/storage/briefcase(src)
	new /obj/item/toy/plush/mammal/fox (src)
