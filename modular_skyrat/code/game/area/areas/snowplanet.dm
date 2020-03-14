/area/snowplanet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	blob_allowed = FALSE

/area/snowplanet/surface
	name = "Iceland Tundra"
	icon_state = "awaycontent1"
	outdoors = TRUE
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING

/area/snowplanet/surface/outdoors/explored //No ruin spawns
	icon_state = "awaycontent2"

/area/snowplanet/surface/outdoors/unexplored //Near station ruins
	icon_state = "awaycontent3"

/area/snowplanet/surface/outdoors/danger //Bigger ruins further away
	icon_state = "awaycontent4"

/area/snowplanet/surface/outdoors/ruin //Outdoor areas within ruins
	icon_state = "awaycontent12"

/area/snowplanet/underground
	name = "Iceland Caves"
	icon_state = "awaycontent5"
	outdoors = TRUE
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING

/area/snowplanet/underground/outdoors/explored
	icon_state = "awaycontent6"

/area/snowplanet/underground/outdoors/unexplored
	icon_state = "awaycontent7"

/area/snowplanet/underground/outdoors/danger
	icon_state = "awaycontent8"

/area/snowplanet/underground/outdoors/ruin //Outdoor areas within ruins
	icon_state = "awaycontent11"