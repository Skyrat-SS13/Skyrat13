/obj/item/organ/liver/robot_ipc
	name = "substance processor"
	icon_state = "liver-c-u"
	attack_verb = list("processed")
	desc = "A machine component, installed in the chest. This grants synthetics the ability to filter and process fluids, such a fuel."
	alcohol_tolerance = 0
	toxTolerance = 0
	toxLethality = 0
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/liver/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	to_chat(owner, "<span class='warning'>Alert: Your substance processor has been damaged. An internal chemical leak is affecting performance.</span>")