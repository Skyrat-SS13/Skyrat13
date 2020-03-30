/client/proc/adminchangeminingmap()
	set category = "Server"
	set name = "Change Mining Map"
	if(SSticker.current_state < GAME_STATE_PREGAME)
		to_chat(src, "<span class='interface'>Please wait until after the server is done setting up.</span>")
		return
	var/chosenmap = input("Choose the next mining map", "Change Mining Map")  as null|anything in GLOB.mining_maps
	if (!chosenmap)
		return
	GLOB.next_mining_map = chosenmap
	var/datum/map_config/VM = load_map_config()
	SSmapping.changemap(VM)
	message_admins("[key_name_admin(usr)] set the next mining map to [chosenmap]")
	log_admin("[key_name(usr)] set the next mining map to [chosenmap]")