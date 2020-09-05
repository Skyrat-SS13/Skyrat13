//makeshift laser rifle
/obj/item/projectile/beam/laser/makeshiftlasrifle
	damage = 20

/obj/item/projectile/beam/laser/makeshiftlasrifle/medium
	name = "medium laser"
	damage = 10

/obj/item/projectile/beam/laser/makeshiftlasrifle/weak
	name = "weak laser"
	damage = 5

//hellfire disabler
/obj/item/projectile/beam/disabler/hellfire
	name = "hellfire disabler beam"
	damage = 32
	light_color = LIGHT_COLOR_ORANGE
	eyeblur = 2

/obj/item/projectile/beam/disabler/hellfire/Initialize()
	. = ..()
	transform *= 2

//captain's laser gun
/obj/item/projectile/beam/laser/hellfire/ultra
	name = "deluxe hellfire laser"
	wound_bonus = 15

/obj/item/projectile/beam/disabler/hellfire/ultra
	name = "deluxe hellfire disabler beam"
	damage = 34
	light_color = LIGHT_COLOR_PURPLE
	eyeblur = 6
