//Skyrat changes - certain abilities depend on the mecha lock
/datum/action/innate/mecha/mech_toggle_phasing/Activate()
	if(!owner || !chassis || chassis.occupant != owner)
		return
	if(chassis.securitylevelrestriction && (GLOB.security_level < chassis.securitylevelrestriction))
		to_chat(chassis.occupant, "<span class='danger'>The mech is currently locked and can't phase.</span>")
		return
	chassis.phasing = !chassis.phasing
	button_icon_state = "mech_phasing_[chassis.phasing ? "on" : "off"]"
	chassis.occupant_message("<font color=\"[chassis.phasing?"#00f\">En":"#f00\">Dis"]abled phasing.</font>")
	UpdateButtonIcon()
