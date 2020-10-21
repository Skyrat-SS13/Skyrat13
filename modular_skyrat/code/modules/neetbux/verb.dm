//simple verb to open the fucking menu
/client/verb/neetmenu()
	set category = "OOC"
	set name = "Neetbux Menu"
	set desc = "Buy neetbux rewards. Dab on other players."
	
	if(!SSneetbux || !length(SSneetbux.all_neetbux_rewards))
		to_chat(usr, "<span class='warning'>The neetbux subsystem hasn't initialized yet! Please wait a bit.</span>")
		return
	
	SSneetbux.ShowChoices(usr)
