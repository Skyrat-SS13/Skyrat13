//simple verb to open the fucking menu
/client/verb/bobuxmenu()
	set category = "OOC"
	set name = "Bobux Menu"
	set desc = "Buy bobux rewards. Dab on other players."
	
	if(!SSbobux || !length(SSbobux.all_bobux_rewards))
		to_chat(usr, "<span class='warning'>The bobux subsystem hasn't initialized yet! Please wait a bit.</span>")
		return
	
	SSbobux.ShowChoices(usr)
