/obj/item/clothing/head/wig
	name = "wig"
	desc = "A bunch of hair without a head attached."
	icon = 'icons/mob/human_face.dmi'	  // default icon for all hairs
	icon_state = "hair_vlong"
	item_state = "pwig"
	flags_inv = HIDEHAIR
	color = "#000"
	var/hairstyle = "Very Long Hair"
	var/adjustablecolor = TRUE //can color be changed manually?

/obj/item/clothing/head/wig/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/clothing/head/wig/update_icon_state()
	var/datum/sprite_accessory/S = GLOB.hair_styles_list[hairstyle]
	if(!S)
		icon = 'icons/obj/clothing/hats.dmi'
		icon_state = "pwig"
	else
		icon = hairstyle
		icon_state = hairstyle

/obj/item/clothing/head/wig/worn_overlays(isinhands = FALSE, file2use)
	. = list()
	if(!isinhands)
		var/datum/sprite_accessory/S = GLOB.hair_styles_list[hairstyle]
		if(!S)
			return
		var/mutable_appearance/M = mutable_appearance(S.icon, S.icon_state,layer = -HAIR_LAYER)
		M.appearance_flags |= RESET_COLOR
		M.color = color
		. += M

/obj/item/clothing/head/wig/attack_self(mob/user)
	var/new_style = input(user, "Select a hairstyle", "Wig Styling")  as null|anything in (GLOB.hair_styles_list - "Bald")
	var/newcolor = adjustablecolor ? input(usr,"","Choose Color",color) as color|null : null
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	if(new_style && new_style != hairstyle)
		hairstyle = new_style
		user.visible_message("<span class='notice'>[user] changes \the [src]'s hairstyle to [new_style].</span>", "<span class='notice'>You change \the [src]'s hairstyle to [new_style].</span>")
	if(newcolor && newcolor != color) // only update if necessary
		add_atom_colour(newcolor, FIXED_COLOUR_PRIORITY)
	update_icon()

/obj/item/clothing/head/wig/random/Initialize(mapload)
	hairstyle = pick(GLOB.hair_styles_list - "Bald") //Don't want invisible wig
	add_atom_colour("#[random_short_color()]", FIXED_COLOUR_PRIORITY)
	. = ..()

/obj/item/clothing/head/wig/natural
	name = "natural wig"
	desc = "A bunch of hair without a head attached. This one changes color to match the hair of the wearer. Nothing natural about that."
	color = "#FFF"
	adjustablecolor = FALSE

/obj/item/clothing/head/wig/natural/Initialize(mapload)
	hairstyle = pick(GLOB.hair_styles_list - "Bald")
	. = ..()

/obj/item/clothing/head/wig/natural/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(ishuman(user) && slot == ITEM_SLOT_HEAD)
		if (color != "#[user.hair_color]") // only update if necessary
			add_atom_colour("#[user.hair_color]", FIXED_COLOUR_PRIORITY)
			update_icon()
		user.update_inv_head()