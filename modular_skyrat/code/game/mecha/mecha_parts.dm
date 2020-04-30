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
/obj/item/mecha_parts/chassis/buzz
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	name = "\improper Buzz chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/buzz

/obj/item/mecha_parts/part/buzz_harness
	name = "\improper Buzz harness"
	desc = "The base of a Buzz mech. Contains power unit, processing core and life support systems."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "buzz_base"

/obj/item/mecha_parts/part/buzz_cockpit
	name = "\improper Buzz cockpit"
	desc = "A Buzz cockpit. Contains a powerful integrated meson scanner and night vision system."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "buzz_cockpit"

/obj/item/mecha_parts/part/buzz_left_arm
	name = "\improper Buzz left arm"
	desc = "A Buzz left arm. Compatible with most civillian grade equipment."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "buzz_l_arm"

/obj/item/mecha_parts/part/buzz_right_arm
	name = "\improper Buzz right arm"
	desc = "A Buzz right arm. Compatible with most civillian grade equipment."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "buzz_r_arm"

/obj/item/mecha_parts/part/buzz_left_leg
	name = "\improper Buzz left leg"
	desc = "A Buzz left leg. Has efficient hydraulics to consume less power for vast periods of space-faring."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "buzz_l_leg"

/obj/item/mecha_parts/part/buzz_right_leg
	name = "\improper Buzz right leg"
	desc = "A Buzz right leg. Has efficient hydraulics to consume less power for vast periods of space-faring."
	icon = 'modular_skyrat/icons/mecha/mech_construct.dmi'
	icon_state = "buzz_r_leg"

//Buzz
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

//Killdozer
/obj/item/mecha_parts/chassis/killdozer
	name = "\improper Killdozer chassis"
	desc = "Sometimes... reasonable men must do unreasonable things."
	construct_type = /datum/component/construction/unordered/mecha_chassis/killdozer

//Circuitboards
/obj/item/circuitboard/mecha/clarke/peripherals
	name = "Clarke Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/clarke/main
	name = "Clarke Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/buzz/peripherals
	name = "Buzz Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/buzz/main
	name = "Buzz Central Control module (Exosuit Board)"
	icon_state = "mainboard"
