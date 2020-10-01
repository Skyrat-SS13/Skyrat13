/obj/item/organ/kidneys/robot_ipc
	name = "damage overcharge modules"
	desc = "When you have balls of steel, you need kidneys of titanium."
	icon_state = "capacitor-ipc"
	status = ORGAN_ROBOTIC

/obj/item/organ/kidneys/emp_act(severity)
	applyOrganDamage(severity * 10)
