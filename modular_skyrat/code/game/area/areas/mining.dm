/**********************Mine areas**************************/

/area/mine
	flora_allowed = TRUE

/area/mine/explored
	flora_allowed = FALSE

/area/mine/unexplored
	tunnel_allowed = TRUE

/**********************Lavaland Areas**************************/

/area/lavaland
	flora_allowed = TRUE

/area/lavaland/surface/outdoors/unexplored //monsters and ruins spawn here
	tunnel_allowed = TRUE
	mob_spawn_allowed = TRUE

/area/lavaland/surface/outdoors/unexplored/danger //megafauna will also spawn here
	megafauna_spawn_allowed = TRUE

/area/lavaland/surface/outdoors/explored
	flora_allowed = FALSE

/**********************Ice Moon Areas**************************/

/area/icemoon
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	flora_allowed = TRUE
	blob_allowed = FALSE

/area/icemoon/surface
	name = "Icemoon"
	icon_state = "explored"
	always_unpowered = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	requires_power = TRUE
	ambientsounds = MINING

/area/icemoon/underground
	name = "Icemoon Caves"
	outdoors = TRUE
	always_unpowered = TRUE
	requires_power = TRUE
	poweralm = FALSE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	ambientsounds = MINING

/area/icemoon/underground/unexplored // mobs and megafauna and ruins spawn here
	name = "Snow Planet Caves"
	icon_state = "unexplored"
	tunnel_allowed = TRUE
	mob_spawn_allowed = TRUE
	megafauna_spawn_allowed = TRUE

/area/icemoon/underground/explored
	name = "Snow Planet Underground"
	flora_allowed = FALSE

/area/icemoon/surface/outdoors
	name = "Snow Planet Wastes"
	outdoors = TRUE

/area/icemoon/surface/outdoors/unexplored //monsters and ruins spawn here
	icon_state = "unexplored"
	tunnel_allowed = TRUE
	mob_spawn_allowed = TRUE

/area/icemoon/surface/outdoors/unexplored/danger
	icon_state = "danger"

/area/icemoon/surface/outdoors/explored
	name = "Snow Planet Explored"
	flora_allowed = FALSE