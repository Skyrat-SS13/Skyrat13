//Useless organ that does literally nothing
/obj/item/organ/innards
	name = "innards"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "mysteryorgan1"
	desc = "What the hell is this?"
	gender = PLURAL
	slot = ORGAN_SLOT_INNARDS
	zone = BODY_ZONE_PRECISE_GROIN
	low_threshold = 10
	high_threshold = 20
	maxHealth = 25
	relative_size = 5

/obj/item/organ/innards/Initialize()
	. = ..()
	icon_state = "mysteryorgan[rand(1,10)]"
