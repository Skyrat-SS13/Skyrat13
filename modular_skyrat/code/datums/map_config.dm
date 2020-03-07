GLOBAL_LIST_INIT(mining_maps, list("lavaland" = 0, "icemoon" = 1, "random" = 0))
GLOBAL_VAR_INIT(current_mining_map, "lavaland")
GLOBAL_VAR_INIT(next_mining_map, "lavaland")

/datum/map_config
	minetype = "lavaland"

/datum/map_config/MakeNextMap()
	return config_filename == "data/next_map.json" || fcopy(config_filename, "data/next_map.json")
	var/success = config_filename == "data/next_map.json" || fcopy(config_filename, "data/next_map.json")
	var/json = file("data/next_map.json")
	json = file2text(json)
	json = json_decode(json)
	json["minetype"] = GLOB.next_mining_map
	json = json_encode(json)
	fdel("data/next_map.json")
	json = text2file(json, "data/next_map.json")
	return success