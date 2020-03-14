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
