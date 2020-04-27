/obj/item/organ/bone
	name = "bone"
	desc = "It's... a bone. An unidentifiable bone."
	zone = BODY_ZONE_CHEST
	icon_state = "bone"
	var/dam_threshold_low = 25
	var/dam_threshold_medium = 50
	var/dam_threshold_high = 75
	var/dam_threshold_highest = 100

/obj/item/organ/bone/skull
	name = "skull"
	desc = "Serves as gothic decoration. Or, you know, protection for your brain."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_SKULL
	icon_state = "skull"

/obj/item/organ/bone/ribcage
	name = "ribcage"
	desc = "This sure ain't McRibs."
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_RIBCAGE
	icon_state = "ribcage"

/obj/item/organ/bone/rhumerus
	name = "right humerus"
	desc = "Whoever lost this, sure must have been in an humerus situation."
	zone = BODY_ZONE_R_ARM
	slot = ORGAN_SLOT_RHUMERUS
	icon_state = "rhumerus"

/obj/item/organ/bone/lhumerus
	name = "left humerus"
	desc = "Whoever lost this, sure must have been in an humerus situation."
	zone = BODY_ZONE_L_ARM
	slot = ORGAN_SLOT_LHUMERUS
	icon_state = "lhumerus"

/obj/item/organ/bone/rfemur
	name = "right femur"
	desc = "Helps you walk, when it's inside you."
	zone = BODY_ZONE_R_LEG
	slot = ORGAN_SLOT_RFEMUR
	icon_state = "rfemur"

/obj/item/organ/bone/lfemur
	name = "left femur"
	desc = "Helps you walk, when it's inside you."
	zone = BODY_ZONE_L_LEG
	slot = ORGAN_SLOT_LFEMUR
	icon_state = "lfemur"
