//Painkillers
#define PAINKILLER_MINERSSALVE	"PAINKILLER - MINERS SALVE"
#define PAINKILLER_MORPHINE 	"PAINKILLER - MORPHINE"

//Wound stuff
#define WOUND_DAMAGE_EXPONENT	1.4

#define WOUND_MINIMUM_DAMAGE		5 // an attack must do this much damage after armor in order to roll for being a wound (incremental pressure damage need not apply)
#define WOUND_MAX_CONSIDERED_DAMAGE	35 // any damage dealt over this is ignored for damage rolls unless the target has the frail quirk (35^1.4=145)
#define DISMEMBER_MINIMUM_DAMAGE	10 // an attack must do this much damage after armor in order to be eliigible to dismember a suitably mushed bodypart
#define DISEMBOWEL_MINIMUM_DAMAGE	18 // an attack must do this much damage after armor in order to be eliigible to disembowel a suitably mushed bodypart

#define WOUND_SEVERITY_NONE		0
#define WOUND_SEVERITY_TRIVIAL	1 // for jokey/meme wounds like stubbed toe, no standard messages/sounds or second winds
#define WOUND_SEVERITY_MODERATE	2
#define WOUND_SEVERITY_SEVERE	3
#define WOUND_SEVERITY_CRITICAL	4
#define WOUND_SEVERITY_LOSS		5 // theoretical total limb loss, like dismemberment for cuts
#define WOUND_SEVERITY_PERMANENT 6 // for wounds, severe or not, that cannot be removed via normal means (e.g just amputate the limb affected)

#define WOUND_BLUNT 0 // any brute weapon/attack that doesn't have sharpness. rolls for blunt bone wounds
#define WOUND_SLASH 1 // any brute weapon/attack with sharpness = SHARP_EDGED. rolls for slash wounds
#define WOUND_PIERCE 2 // any brute weapon/attack with sharpness = SHARP_POINTY. rolls for piercing wounds
#define WOUND_BURN	3 // any concentrated burn attack (lasers really). rolls for burning wounds
#define WOUND_INTERNALBLEED 4 // currently only caused by exposure to space

// The ones below will be implemented in the future, but dont exist atm
#define WOUND_TOXIN 4
#define WOUND_RADIATION 5 //arguably could just use the cellular wound thing, but i'm an asshole and want cancer/tumors to be a separate thing
#define WOUND_CELLULAR 6
#define WOUND_STAMINA 7
#define WOUND_ORGAN 8

// How much determination reagent to add each time someone gains a new wound in [/datum/wound/proc/second_wind()]
#define WOUND_DETERMINATION_MODERATE	2
#define WOUND_DETERMINATION_SEVERE		5
#define WOUND_DETERMINATION_CRITICAL	7.5
#define WOUND_DETERMINATION_LOSS		10
#define WOUND_DETERMINATION_PERMANENT	10

#define WOUND_DETERMINATION_MAX			10 // the max amount of determination you can have

// Set wound_bonus on an item or attack to this to disable checking wounding for the attack
#define CANT_WOUND -100

// List in order of highest severity to lowest (if the wound is rolled for normally - there are edge cases like incisions)
#define WOUND_LIST_INTERNAL_BLEEDING list(/datum/wound/internalbleed/critical, /datum/wound/internalbleed/severe, /datum/wound/internalbleed/moderate)
#define WOUND_LIST_INCISION	list(/datum/wound/slash/critical/incision)
#define WOUND_LIST_INCISION_MECHANICAL	list(/datum/wound/mechanical/slash/critical/incision)
#define WOUND_LIST_BLUNT		list(/datum/wound/blunt/critical, /datum/wound/blunt/severe, /datum/wound/blunt/moderate/jaw, /datum/wound/blunt/moderate/ribcage, /datum/wound/blunt/moderate/hips, /datum/wound/blunt/moderate)
#define WOUND_LIST_BLUNT_MECHANICAL list(/datum/wound/mechanical/blunt/critical, /datum/wound/mechanical/blunt/severe, /datum/wound/mechanical/blunt/moderate)
#define WOUND_LIST_SLASH		list(/datum/wound/slash/critical, /datum/wound/slash/severe, /datum/wound/slash/moderate)
#define WOUND_LIST_SLASH_MECHANICAL		list(/datum/wound/mechanical/slash/critical, /datum/wound/mechanical/slash/severe, /datum/wound/mechanical/slash/moderate)
#define WOUND_LIST_LOSS			list(/datum/wound/loss, /datum/wound/slash/loss)
#define WOUND_LIST_DISEMBOWEL			list(/datum/wound/disembowel, /datum/wound/slash/critical/incision/disembowel, /datum/wound/mechanical/slash/critical/incision/disembowel)
#define WOUND_LIST_PIERCE		list(/datum/wound/pierce/critical, /datum/wound/pierce/severe, /datum/wound/pierce/moderate)
#define WOUND_LIST_PIERCE_MECHANICAL		list(/datum/wound/mechanical/pierce/critical, /datum/wound/mechanical/pierce/severe, /datum/wound/mechanical/pierce/moderate)
#define WOUND_LIST_BURN		list(/datum/wound/burn/critical, /datum/wound/burn/severe, /datum/wound/burn/moderate)
#define WOUND_LIST_BURN_MECHANICAL		list(/datum/wound/mechanical/burn/critical, /datum/wound/mechanical/burn/severe, /datum/wound/mechanical/burn/moderate)

// Thresholds for infection for burn wounds, once infestation hits each threshold, things get steadily worse
#define WOUND_INFECTION_MODERATE	4 // below this has no ill effects from infection
#define WOUND_INFECTION_SEVERE		8 // then below here, you ooze some pus and suffer minor tox damage, but nothing serious
#define WOUND_INFECTION_CRITICAL	12 // then below here, your limb occasionally locks up from damage and infection and briefly becomes disabled. Things are getting really bad
#define WOUND_INFECTION_SEPTIC		20 // below here, your skin is almost entirely falling off and your limb locks up more frequently. You are within a stone's throw of septic paralysis and losing the limb
// Above WOUND_INFECTION_SEPTIC, your limb is completely putrid and you start rolling to lose the entire limb by way of paralyzation. After 3 failed rolls (~4-5% each probably), the limb is paralyzed

#define WOUND_BURN_SANITIZATION_RATE 0.15 // how quickly sanitization removes infestation and decays per tick
#define WOUND_SLASH_MAX_BLOODFLOW		8 // how much blood you can lose per tick per slash max. 8 is a LOT of blood for one cut so don't worry about hitting it easily
#define WOUND_PIERCE_MAX_BLOODFLOW		8 // same as above, but for piercing wounds
#define WOUND_INTERNAL_MAX_BLOODFLOW	10 // same as above, but for internal bleeding
#define WOUND_SLASH_DEAD_CLOT_MIN		0.05 // dead people don't bleed, but they can clot! this is the minimum amount of clotting per tick on dead people, so even critical cuts will slowly clot in dead people
#define WOUND_PIERCE_DEAD_CLOT_MIN		0.05 // same as above but for piercing wounds
#define WOUND_BONE_HEAD_TIME_VARIANCE 	20 // if we suffer a bone wound to the head that creates brain traumas, the timer for the trauma cycle is +/- by this percent (0-100)

// The following are for persistent scar save formats
// Do note that cosmetic scars don't use this format.
#define SCAR_SAVE_VERS				1 // The version number of the scar we're saving
#define SCAR_SAVE_ZONE				2 // The body_zone we're applying to on granting
#define SCAR_SAVE_DESC				3 // The description we're loading
#define SCAR_SAVE_PRECISE_LOCATION	4 // The precise location we're loading
#define SCAR_SAVE_SEVERITY			5 // The severity the scar had

// increment this number when you update the persistent scarring format in a way that invalidates previous saved scars (new fields, reordering, etc)
// saved scars with a version lower than this will be discarded
#define SCAR_CURRENT_VERSION 1

// General dismemberment now requires 3 things for a limb to be dismemberable:
//	1. Skin is mangled: At least a moderate slash or pierce wound
// 	2. Muscle is mangled: A critical slash or pierce wound
// 	3. Bone is mangled: At least a severe bone wound on that limb
// see [/obj/item/bodypart/proc/get_mangled_state()] for more information
#define BODYPART_MANGLED_NONE	0
#define BODYPART_MANGLED_SKIN	(1<<0)
#define BODYPART_MANGLED_MUSCLE (1<<1)
#define BODYPART_MANGLED_BONE	(1<<2)
#define BODYPART_MANGLED_BOTH 	(BODYPART_MANGLED_SKIN | BODYPART_MANGLED_MUSCLE | BODYPART_MANGLED_BONE)

// What kind of biology we have, and what wounds we can suffer, mostly relies on the HAS_FLESH and HAS_BONE species traits on human species
#define BIO_INORGANIC	0 // golems, cannot suffer any wounds
#define BIO_BONE	(1<<0) // skeletons and plasmemes, can only suffer bone wounds, only needs mangled bone to be able to dismember
#define BIO_FLESH	(1<<1) // slimepeople can only suffer slashing, piercing, and burn wounds
#define BIO_SKIN	(1<<2) // literally nothing right now
#define BIO_FULL	(BIO_BONE | BIO_FLESH | BIO_SKIN) // standard humanoids, can suffer all wounds, needs mangled bone and flesh to dismember

//Organ status flags
#define ORGAN_ORGANIC   (1<<0)
#define ORGAN_ROBOTIC   (1<<1)
#define ORGAN_NODAMAGE  (1<<2) //not yet implemented

//Bodypart status flags
#define BODYPART_ORGANIC	(1<<0)
#define BODYPART_ROBOTIC	(1<<1)
#define BODYPART_NOBLEED	(1<<2)
#define BODYPART_NOEMBED	(1<<3)
#define BODYPART_HARDDISMEMBER	(1<<4)

//Bodypart disabling defines
#define BODYPART_NOT_DISABLED 0
#define BODYPART_DISABLED_DAMAGE 1
#define BODYPART_DISABLED_WOUND 2
#define BODYPART_DISABLED_PARALYSIS 3

//Maximum number of brain traumas wounds to the head can cause
#define TRAUMA_LIMIT_WOUND 2

//Bodypart defines
#define ALL_BODYPARTS list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
#define TORSO_BODYPARTS list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
#define AMPUTATE_BODYPARTS list(BODY_ZONE_HEAD, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
#define LIMB_AND_HEAD_BODYPARTS list(BODY_ZONE_HEAD, BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
#define LIMB_BODYPARTS list(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
#define EXTREMITY_BODYPARTS list(BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_PRECISE_L_HAND, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_PRECISE_L_FOOT)
#define HEAD_BODYPARTS list(BODY_ZONE_HEAD, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_PRECISE_EYES)
#define ORGAN_BODYPARTS list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)

#define SSPARTS	list(/obj/item/bodypart/head, /obj/item/bodypart/chest, /obj/item/bodypart/groin, /obj/item/bodypart/r_arm, /obj/item/bodypart/r_hand, /obj/item/bodypart/l_arm, /obj/item/bodypart/l_hand, /obj/item/bodypart/r_leg, /obj/item/bodypart/r_foot, /obj/item/bodypart/l_leg, /obj/item/bodypart/l_foot)

#define ALIEN_BODYPARTS_PATH list(/obj/item/bodypart/chest/alien, /obj/item/bodypart/groin/alien, /obj/item/bodypart/head/alien, /obj/item/bodypart/l_arm/alien, /obj/item/bodypart/l_hand/alien, /obj/item/bodypart/r_arm/alien, /obj/item/bodypart/r_hand/alien, /obj/item/bodypart/r_leg/alien, /obj/item/bodypart/r_foot/alien, /obj/item/bodypart/l_leg/alien, /obj/item/bodypart/l_foot/alien)
#define BODYPARTS_PATH list(/obj/item/bodypart/chest, /obj/item/bodypart/groin, /obj/item/bodypart/head, /obj/item/bodypart/l_arm, /obj/item/bodypart/l_hand, /obj/item/bodypart/r_arm, /obj/item/bodypart/r_hand,/obj/item/bodypart/l_leg, /obj/item/bodypart/l_foot, /obj/item/bodypart/r_leg, /obj/item/bodypart/r_foot)
#define MONKEY_BODYPARTS_PATH list(/obj/item/bodypart/head/monkey, /obj/item/bodypart/chest/monkey, /obj/item/bodypart/groin/monkey, /obj/item/bodypart/l_arm/monkey, /obj/item/bodypart/l_hand/monkey, /obj/item/bodypart/r_arm/monkey, /obj/item/bodypart/r_hand/monkey, /obj/item/bodypart/l_leg/monkey, /obj/item/bodypart/l_foot/monkey, /obj/item/bodypart/r_leg/monkey, /obj/item/bodypart/r_foot/monkey)
#define LARVA_BODYPARTS_PATH list(/obj/item/bodypart/chest/larva, /obj/item/bodypart/head/larva)

//Defines related to apparent consciousness, when you examine someone
#define LOOKS_CONSCIOUS	0
#define LOOKS_SLEEPY	1
#define LOOKS_UNCONSCIOUS 2
#define LOOKS_VERYUNCONSCIOUS 3
#define LOOKS_DEAD		4
