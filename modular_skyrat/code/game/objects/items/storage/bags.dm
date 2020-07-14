/obj/item/storage/bag/construction
	name = "construction bag"
	icon = 'modular_skyrat/icons/obj/tools.dmi'
	icon_state = "construction_bag"
	desc = "A bag for storing small construction components."
	resistance_flags = FLAMMABLE

/obj/item/storage/bag/construction/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 100
	STR.max_items = 50
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.insert_preposition = "in"

	STR.can_hold = typecacheof(list(
		/obj/item/stack/ore/bluespace_crystal,
		/obj/item/assembly,
		/obj/item/stock_parts,
		/obj/item/stack/cable_coil,
		/obj/item/circuitboard,
		/obj/item/electronics,
		/obj/item/wallframe/camera
		))

// COURIER BAGS

/obj/item/storage/backpack/courier
	name = "courier bag"
	desc = "It's a bag made for delivery."
	icon = 'modular_skyrat/icons/obj/storage.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/back.dmi'
	icon_state = "courierbag"
	item_state = "courierbag"

/obj/item/storage/backpack/courier/chem
	name = "chemist courier bag"
	desc = "It's a bag made for delivery, for chemists."
	icon_state = "courierbagchem"
	item_state = "courierbagchem"

/obj/item/storage/backpack/courier/med
	name = "medic courier bag"
	desc = "It's a bag made for delivery, for medics."
	icon_state = "courierbagmed"
	item_state = "courierbagmed"

/obj/item/storage/backpack/courier/viro
	name = "virologist courier bag"
	desc = "It's a bag made for delivery, for virologists."
	icon_state = "courierbagviro"
	item_state = "courierbagviro"

/obj/item/storage/backpack/courier/sci
	name = "scientist courier bag"
	desc = "It's a bag made for delivery, for scientists."
	icon_state = "courierbagsci"
	item_state = "courierbagsci"

/obj/item/storage/backpack/courier/com
	name = "command courier bag"
	desc = "It's a bag made for delivery, for command officials."
	icon_state = "courierbagcom"
	item_state = "courierbagcom"

/obj/item/storage/backpack/courier/engi
	name = "Industrial courier bag"
	desc = "Comes with a double reinforced strap to hold bulk materials."
	icon_state = "courierbagengi"
	item_state = "courierbagengi"
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/courier/hydr
	name = "botanist courier bag"
	desc = "It's a bag made for delivery, for botanists."
	icon_state = "courierbaghyd"
	item_state = "courierbaghyd"

/obj/item/storage/backpack/courier/sec
	name = "security courier bag"
	desc = "It's a bag made for delivery, for security officers."
	icon_state = "courierbagsec"
	item_state = "courierbagsec"

/obj/item/storage/backpack/courier/black
	name = "black courier bag"
	desc = "It's a bag made for delivery. This one is black-- how stylish."
	icon_state = "courierbagblack"
	item_state = "courierbagblack"

// POLYCHROMIC BACKPACKS

/obj/item/storage/backpack/courier/polychromic
	name = "polychromic courier bag"
	desc = "Show off your awful tastes with your courier bag."
	icon_state = "courierchrome"
	item_state = "courierchrome"
	var/list/poly_colors = list("#FFFFFF", "#F08080", "#FFFFFF")

/obj/item/storage/backpack/courier/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 3)

/obj/item/storage/backpack/polychromic
	name = "polychromic backpack"
	desc = "Show off your awful tastes with your backpack."
	icon = 'modular_skyrat/icons/obj/storage.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/back.dmi'
	icon_state = "backpackchrome"
	item_state = "backpackchrome"
	var/list/poly_colors = list("#FFFFFF", "#F08080")

/obj/item/storage/backpack/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 2)

/obj/item/storage/backpack/satchel/polychromic
	name = "polychromic satchel"
	desc = "Show off your awful tastes with your satchel."
	icon = 'modular_skyrat/icons/obj/storage.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/back.dmi'
	icon_state = "satchelchrome"
	item_state = "satchelchrome"
	var/list/poly_colors = list("#FFFFFF", "#F08080", "#FFFFFF", "#F08080")

/obj/item/storage/backpack/satchel/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 4)

/obj/item/storage/backpack/duffelbag/polychromic
	name = "polychromic duffel bag"
	desc = "Show off your awful tastes with your duffel bag."
	icon = 'modular_skyrat/icons/obj/storage.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/back.dmi'
	icon_state = "duffelchrome"
	item_state = "duffelchrome"
	var/list/poly_colors = list("#FFFFFF", "#F08080", "#FFFFFF", "#F08080")

/obj/item/storage/backpack/duffelbag/polychromic/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_volume = STORAGE_VOLUME_DUFFLEBAG
	AddElement(/datum/element/polychromic, poly_colors, 4)
