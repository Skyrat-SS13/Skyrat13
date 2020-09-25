/obj/item/organ/intestines/robot_ipc
	name = "cybernetic intestines"
	icon_state = "capacitor-ipc"
	desc = "Even cyborgs deserve a throne."
	status = ORGAN_ROBOTIC

/obj/item/organ/intestines/robot_ipc/emp_act(severity)
	applyOrganDamage(severity * 10)
