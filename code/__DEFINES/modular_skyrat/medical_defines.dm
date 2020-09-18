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

#define WOUND_NONE 0 // doesn't actually wound
#define WOUND_BLUNT 1 // any brute weapon/attack that doesn't have sharpness. rolls for blunt bone wounds
#define WOUND_SLASH 2 // any brute weapon/attack with sharpness = SHARP_EDGED. rolls for slash wounds
#define WOUND_PIERCE 3 // any brute weapon/attack with sharpness = SHARP_POINTY. rolls for piercing wounds
#define WOUND_BURN	4 // any concentrated burn attack (lasers really). rolls for burning wounds

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

// Thresholds for infection for wounds, once infestation hits each threshold, things get steadily worse
#define WOUND_INFECTION_MODERATE	250 // below this has no ill effects from germs
#define WOUND_INFECTION_SEVERE		330 // then below here, you ooze some pus and suffer minor tox damage, but nothing serious
#define WOUND_INFECTION_CRITICAL	600 // then below here, your limb occasionally locks up from damage and infection and briefly becomes disabled. Things are getting really bad
#define WOUND_INFECTION_SEPTIC		1000 // below here, your skin is almost entirely falling off and your limb locks up more frequently. You are within a stone's throw of septic paralysis and losing the limb
// Above WOUND_INFECTION_SEPTIC, your limb is completely putrid and you start rolling to lose the entire limb by way of paralyzation. After 3 failed rolls (~4-5% each probably), the limb is paralyzed

#define WOUND_SLASH_MAX_BLOODFLOW		8 // how much blood you can lose per tick per slash max. 8 is a LOT of blood for one cut so don't worry about hitting it easily
#define WOUND_PIERCE_MAX_BLOODFLOW		8 // same as above, but for piercing wounds
#define WOUND_SLASH_DEAD_CLOT_MIN		0.02 // dead people don't bleed, but they can clot! this is the minimum amount of clotting per tick on dead people, so even critical cuts will slowly clot in dead people
#define WOUND_PIERCE_DEAD_CLOT_MIN		0.02 // same as above but for piercing wounds
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

// Wound flags
#define MANGLES_SKIN (1<<0)
#define MANGLES_MUSCLE (1<<1)
#define MANGLES_BONE (1<<2)

//Organ status flags
#define ORGAN_ORGANIC   (1<<0)
#define ORGAN_ROBOTIC   (1<<1)
#define ORGAN_NODAMAGE  (1<<2) //not yet implemented

//Bodypart status flags
#define BODYPART_ORGANIC	(1<<0)
#define BODYPART_ROBOTIC	(1<<1)
#define BODYPART_DEAD		(1<<2) //Completely septic and unusable limb
#define BODYPART_SYNTHETIC	(1<<3) //Synthetic bodypart, can't get infected
#define BODYPART_FROZEN		(1<<3) //Cold, doesn't rot
#define BODYPART_NOBLEED	(1<<4)
#define BODYPART_NOEMBED	(1<<5)
#define BODYPART_NOPAIN 	(1<<6)

//Bodypart disabling defines
#define BODYPART_NOT_DISABLED 0
#define BODYPART_DISABLED_DAMAGE 1
#define BODYPART_DISABLED_WOUND 2
#define BODYPART_DISABLED_PAIN 3
#define BODYPART_DISABLED_PARALYSIS 4

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

//Pain-related defines
#define PAIN_EMOTE_MINIMUM 10
#define PAIN_LEVEL_1 0
#define PAIN_LEVEL_2 10
#define PAIN_LEVEL_3 40
#define PAIN_LEVEL_4 70

//Flags for the organ_flags var on /obj/item/organ
#define ORGAN_SYNTHETIC			(1<<0)	//Synthetic organs, or cybernetic organs. Reacts to EMPs and don't deteriorate or heal
#define ORGAN_FROZEN			(1<<1)	//Frozen organs, don't deteriorate
#define ORGAN_FAILING			(1<<2)	//Failing organs perform damaging effects until replaced or fixed
#define ORGAN_DEAD				(1<<3)  //Not only is the organ failing, it is completely septic and spreading it around
#define ORGAN_EXTERNAL			(1<<4)	//Was this organ implanted/inserted/etc, if true will not be removed during species change.
#define ORGAN_VITAL				(1<<5)	//Currently only the brain
#define ORGAN_NO_SPOIL			(1<<6)	//Do not spoil under any circumstances
#define ORGAN_NO_DISMEMBERMENT	(1<<7)	//Immune to disembowelment.
#define ORGAN_EDIBLE			(1<<8)	//is a snack? :D

// Pulse levels, very simplified.
#define PULSE_NONE    0   // So !M.pulse checks would be possible.
#define PULSE_SLOW    1   // <60     bpm
#define PULSE_NORM    2   //  60-90  bpm
#define PULSE_FAST    3   //  90-120 bpm
#define PULSE_2FAST   4   // >120    bpm
#define PULSE_THREADY 5   // Occurs during hypovolemic shock
#define PULSE_MAX_BPM 250 // Highest, readable BPM by machines and humans.
#define GETPULSE_BASIC 0   // Less accurate. (hand, health analyzer, etc.)
#define GETPULSE_ADVANCED 1   // More accurate. (med scanner, sleeper, etc.)

// Shock defines
#define SHOCK_STAGE_1 10
#define SHOCK_STAGE_2 30
#define SHOCK_STAGE_3 40
#define SHOCK_STAGE_4 60
#define SHOCK_STAGE_5 80
#define SHOCK_STAGE_6 120
#define SHOCK_STAGE_7 150
#define SHOCK_STAGE_8 200

//Infection defines
#define GERM_LEVEL_AMBIENT  275 // Maximum germ level you can reach by standing still.
#define GERM_LEVEL_MOVE_CAP 300 // Maximum germ level you can reach by running around.

//Sanitization
#define MAXIMUM_GERM_LEVEL	1000
#define SANITIZATION_SPACE_CLEANER 100
#define SANITIZATION_ANTIBIOTIC 0.1 // CE_ANTIBIOTIC sanitization
#define SANITIZATION_LYING 2

#define INFECTION_LEVEL_ONE   250
#define INFECTION_LEVEL_TWO   500  // infections grow from ambient to two in ~5 minutes
#define INFECTION_LEVEL_THREE 1000 // infections grow from two to three in ~10 minutes

#define WOUND_INFECTION_SANITIZATION_RATE	10 // how quickly sanitization removes infestation and decays per tick
#define WOUND_SANITIZATION_PER_ANTIBIOTIC 1 // Sanitization for each point in the antibiotic chem effect
#define WOUND_SANITIZATION_STERILIZER	100 // How much sterilizer sanitizes a wound
#define WOUND_INFECTION_SEEP_RATE		0.15 // How much we seep gauze per life tick

//How much time it takes for a dead organ to recover
#define ORGAN_RECOVERY_THRESHOLD (5 MINUTES)

//Rejection levels
#define REJECTION_LEVEL_1 1
#define REJECTION_LEVEL_2 50
#define REJECTION_LEVEL_3 200
#define REJECTION_LEVEL_4 500

//Brain damage related defines
#define MINIMUM_DAMAGE_TRAUMA_ROLL 4 //We need to take at least this much brainloss gained at once to roll for traumas, any less it won't roll
#define DAMAGE_LOW_OXYGENATION 1 //Brainloss caused by low blood oxygenation
#define DAMAGE_LOWER_OXYGENATION 2 //Brainloss caused by lower than low blood oxygenation
#define DAMAGE_VERY_LOW_OXYGENATION 3 //The above but even worse
