//////////////////////////////
//////Custom Mech Parts //////
//////////////////////////////

///////// Power Armor (Not actually a mech but meh)

/obj/item/mecha_parts/chassis/powerarmor
	name = "\improper Power Armor Chassis"
	desc = "A heavy steel frame, utilized in the construction of a suit of powered armor."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_skeleton"
	w_class = WEIGHT_CLASS_HUGE
	construct_type = /datum/component/construction/unordered/mecha_chassis/powerarmor

/obj/item/mecha_parts/part/powerarmor_torso
	name = "\improper Power Armor Torso"
	desc = "A torso comprised of advanced components, armored with flexible plasteel sheets."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_chest"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/mecha_parts/part/powerarmor_left_arm
	name = "\improper Power Armor Left Arm"
	desc = "A powered arm component, armored with plasteel and strengthened with integrated pseudometallic bio-enhancing servos."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_arm_L"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/mecha_parts/part/powerarmor_right_arm
	name = "\improper Power Armor Right Arm"
	desc = "A powered arm component, armored with plasteel and strengthened with integrated pseudometallic bio-enhancing servos."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_arm_R"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/mecha_parts/part/powerarmor_left_leg
	name = "\improper Power Armor Left Leg"
	desc = "A powered leg component, armored with plasteel and enhanced with integrated kinetic-absorbing materials to give a minor spring in the user's step."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_leg_L"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/mecha_parts/part/powerarmor_right_leg
	name = "\improper Power Armor Right Leg"
	desc = "A powered leg component, armored with plasteel and enhanced with integrated kinetic-absorbing materials to give a minor spring in the user's step."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_leg_R"
	w_class = WEIGHT_CLASS_HUGE

/obj/item/mecha_parts/part/powerarmor_helmet
	name = "\improper Power Armor Helmet"
	desc = "An advanced, head-covering helmet desinged to offer maximum comfort and protection. Must be installed into a proper suit of Power Armor in order to be used, as it is quite heavy."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "pwrarmor_helmet"
	w_class = WEIGHT_CLASS_HUGE

//Clarke
/obj/item/mecha_parts/chassis/clarke
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	name = "\improper Clarke chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/clarke

/obj/item/mecha_parts/part/clarke_torso
	name = "\improper Clarke torso"
	desc = "A torso part of Clarke. Contains power unit, processing core and life support systems."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "clarke_harness"

/obj/item/mecha_parts/part/clarke_head
	name = "\improper Clarke head"
	desc = "A Clarke head. Contains an integrated diagnostic HUD scanner."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "clarke_head"

/obj/item/mecha_parts/part/clarke_left_arm
	name = "\improper Clarke left arm"
	desc = "A Clarke left arm. Data and power sockets are compatible with most exosuit tools."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "clarke_l_arm"

/obj/item/mecha_parts/part/clarke_right_arm
	name = "\improper Clarke right arm"
	desc = "A Clarke right arm. Data and power sockets are compatible with most exosuit tools."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "clarke_r_arm"

//Circuitboards
/obj/item/circuitboard/mecha/clarke/peripherals
	name = "Clarke Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/clarke/main
	name = "Clarke Central Control module (Exosuit Board)"
	icon_state = "mainboard"
