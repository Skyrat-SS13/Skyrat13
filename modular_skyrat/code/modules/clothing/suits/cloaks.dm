/obj/item/clothing/neck/cloak/secinstructor
	name = "security instructor's cloak"
	desc = "This is an instructor cloak for the security department , they must be ready to teach!"
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	icon_state = "seci"
	item_state = "seci"

/obj/item/clothing/neck/cloak/cargoinstructor
	name = "cargo instructor's cloak"
	desc = "This is an instructor cloak for the cargo department , they must be ready to teach!"
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	icon_state = "cargoi"
	item_state = "cargoi"

/obj/item/clothing/neck/cloak/medinstructor
	name = "medical instructor's cloak"
	desc = "This is an instructor cloak for the medical department , they must be ready to teach!"
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	icon_state = "medi"
	item_state = "medi"

/obj/item/clothing/neck/cloak/engiinstructor
	name = "engineering instructor's cloak"
	desc = "This is an instructor cloak for the engineering department , they must be ready to teach!"
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	icon_state = "engi"
	item_state = "engi"

/obj/item/clothing/neck/cloak/sciinstructor
	name = "research instructor's cloak"
	desc = "This is an instructor cloak for the science department , they must be ready to teach!"
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	icon_state = "scii"
	item_state = "scii"

/obj/item/clothing/neck/cloak/alt
	name = "cloak"
	desc = "A ragged up white cloak."
	icon = 'modular_skyrat/icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/neck.dmi'
	icon_state = "cloak"
	item_state = "qmcloak"

/obj/item/clothing/neck/cloak/alt/boatcloak
	name = "boatcloak"
	desc = "A simple, short-ish boatcloak. Doesn't make you look magnificient, unless you're First Sergeant."
	icon_state = "boatcloak"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/cloak/alt/boatcloak/command
	name = "command boatcloak"
	desc = "A boatcloak with gold ribbon. Might make some lance corporal tear up at it's elegance."
	icon_state = "boatcloak_com"
	body_parts_covered = CHEST|LEGS|ARMS

/obj/item/clothing/neck/cloak/alt/polychromic
	name = "polychromic cloak"
	desc = "A ragged up cloak."
	icon_state = "cloak"
	var/list/poly_colors = list("#FFFFFF", "#676767", "#4C4C4C")

/obj/item/clothing/neck/cloak/alt/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 3)

/obj/item/clothing/neck/cloak/alt/boatcloak/polychromic
	name = "polychromic boatcloak"
	desc = "A polychromic, short-ish boatcloak."
	icon_state = "boatcloak"
	var/list/poly_colors = list("#FCFCFC", "#454F5C", "#CCCEE2")

/obj/item/clothing/neck/cloak/alt/boatcloak/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 3)
