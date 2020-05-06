//////////////////////////////
//////Custom Mech Parts //////
//////////////////////////////

// Skyrat change - Mecha Chassis can have a security level attached. This is used to limit combat mech actions
// To certain security levels.
/obj/item/mecha_parts/chassis
	var/shouldberestricted = FALSE //Maybe a bit redundant. It's just a boolean checked when attacked by an ID card. If true, the ID card will fiddle with restriction, otherwise it won't.
	var/securitylevelrestriction = null //Does this mech only work fully depending on the security level? If so, at which level will it work?
	var/savedrestriction = null //Used to save restrictions, for locking/unlocking the chassis or mecha with an armory access ID card.

/obj/item/mecha_parts/chassis/emag_act()
	. = ..()
	obj_flags |= EMAGGED
	shouldberestricted = FALSE
	securitylevelrestriction = null 
	savedrestriction = null


/obj/item/mecha_parts/chassis/examine(mob/user)
	. = ..()
	if(shouldberestricted)
		. +=  "It's locked to [securitylevelrestriction ? NUM2SECLEVEL(securitylevelrestriction) : "no"] security level."

/obj/item/mecha_parts/chassis/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/card/id) && shouldberestricted)
		var/obj/item/card/id/id = I
		if(ACCESS_ARMORY in id.access)
			to_chat(user, securitylevelrestriction ? "<span class='notice'>You lock \the [src] for security level based use.</span>" : "<span class='notice'>You unlock \the [src] from security level based use.</span>")]
			if(securitylevelrestriction)
				savedrestriction = securitylevelrestriction
				securitylevelrestriction = null
			else 
				securitylevelrestriction = savedrestriction
				savedrestriction = null

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

//Killdozer
/obj/item/mecha_parts/chassis/killdozer
	name = "\improper Killdozer chassis"
	desc = "Sometimes... reasonable men must do unreasonable things."
	construct_type = /datum/component/construction/unordered/mecha_chassis/killdozer
