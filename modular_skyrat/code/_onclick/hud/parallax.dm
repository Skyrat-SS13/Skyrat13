/obj/screen/parallax_layer/planet/update_o()
	switch(GLOB.current_mining_map)
		if("lavaland")
			icon_state = "planet"
		if("icemoon")
			icon_state = "icemoon"
		return