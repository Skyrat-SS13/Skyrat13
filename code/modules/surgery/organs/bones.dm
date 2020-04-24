#define BONE_DAM_THRESHOLD_LOW 25
#define BONE_DAM_THRESHOLD_MEDIUM 50
#define BONE_DAM_THRESHOLD_HIGH 75
#define BONE_DAM_THRESHOLD_HIGHEST 100
#define BONE_DAM_PROB 10

/obj/item/organ/bone
	name = "bone"
	desc = "It's... a bone. An unidentifiable bone."
	zone = BODY_ZONE_CHEST
	icon_state = "bone"

/obj/item/organ/bone/skull
	name = "skull"
	desc = "Serves as gothic decoration. Or, you know, protection for your brain."
	zone = BODY_ZONE_HEAD
	icon_state = "skull"

/obj/item/organ/bone/ribcage
	name = "ribcage"
	desc = "This sure ain't McRibs."
	zone = BODY_ZONE_CHEST
	icon_state = "ribcage"

/obj/item/organ/bone/rhumerus
	name = "right humerus"
	desc = "Whoever lost this, sure must have been in an humerus situation."
	zone = BODY_ZONE_R_ARM
	icon_state = "rhumerus"

/obj/item/organ/bone/lhumerus
	name = "left humerus"
	desc = "Whoever lost this, sure must have been in an humerus situation."
	zone = BODY_ZONE_L_ARM
	icon_state = "lhumerus"

/obj/item/organ/bone/rfemur
	name = "right femur"
	desc = "Helps you walk, when it's inside you."
	zone = BODY_ZONE_R_LEG
	icon_state = "rfemur"

/obj/item/organ/bone/lfemur
	name = "left femur"
	desc = "Helps you walk, when it's inside you."
	zone = BODY_ZONE_L_LEG
	icon_state = "lfemur"