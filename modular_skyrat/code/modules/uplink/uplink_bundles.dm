//joker bundle, also i'm gonna do all items here because i'm lazy
/datum/uplink_item/bundles_TC/joker
	name = "Society Box"
	desc = "A crate with a .38 revolver with ammo, special knife and special clothing to enact revenge on society as a whole."
	item = /obj/item/storage/box/hug/angryclown
	cost = 20
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	restricted_roles = list("Clown")

/obj/item/clothing/mask/gas/clown_hat/joker
	name = "\proper Fleck's Mask"
	desc = "I'm the joker, baby! ...This mask is incredibly armored, somehow."
	icon_state = "joker"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/gun/ballistic/revolver/detective/joker
	name = "\proper Smith and Wesson Model 36"
	desc = "Wanna hear another joke, captain?"
	/obj/item/ammo_box/magazine/internal/cylinder/rev38/joker

/obj/item/ammo_box/magazine/internal/cylinder/rev38/joker
	caliber = list("38", "357")
	max_ammo = 5
	ammo_type = /obj/item/ammo_casing/c38/lethal

/obj/item/gun/ballistic/revolver/detective/joker/Initialize()
	..()
	safe_calibers += "357"

/obj/item/kitchen/knife/joker
	name = "sad knife"
	desc = "This knife is full of hate and angst."
	force = 20
	throwforce = 20
	throw_speed = 6

/obj/item/storage/box/hug/angryclown
	name = "arthur's box"
	desc = "Knock knock. Who's there? It's the police ma'am, your son has been hit by a drunk driver. He's dead."

/obj/item/storage/box/hug/angryclown/PopulateContents()
	. = ..()
	new /obj/item/kitchen/knife/joker(src)
	new /obj/item/gun/ballistic/revolver/detective/joker(src)
	new /obj/item/ammo_box/c38/lethal(src)
	new /obj/item/ammo_box/c38/lethal(src)
	new /obj/item/ammo_box/c38/hotshot(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_robustgold(src)
	new /obj/item/clothing/suit/armor(src)
	new /obj/item/clothing/shoes/clown_shoes/combat(src)
	new /obj/item/clothing/under/rank/civilian/clown/green/armored(src)

/obj/item/clothing/under/rank/civilian/clown/green/armored
	name = "armored clown suit"
	desc = "<b>I'LL MAKE YOU HONK ALRIGHT.</b>"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 10, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
