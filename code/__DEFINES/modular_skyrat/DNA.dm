//Our modular 'species_traits' defines, starting from 50 in case citadel adds more
#define REVIVESBYHEALING 50 // Will revive on heal when healing, based on a species var
#define NOHUSK			51 // Can't be husked.
#define ROBOTIC_LIMBS	52 //limbs start out as robotic; but also use organic icons. If you want to use the default ones, you'll have to use on_species_gain. IT DOESNT SET THEM TO SYNTHETIC LEGS, that is also done on_species_gain
#define CAN_SCAR		53
#define HAS_BONE		54
#define HAS_FLESH		55
#define HAS_SKIN		56
#define NOPAIN			57
#define NOINFECTION		58
#define NOAPPENDIX		59
#define NOKIDNEYS		60
#define NOINTESTINES	61
#define NOSPLEEN		62

// Defines for processing reagents, for synths, IPC's and Vox
#define PROCESS_ORGANIC (1<<0)		//Only processes reagents with "ORGANIC" or "ORGANIC | SYNTHETIC"
#define PROCESS_SYNTHETIC (1<<1)		//Only processes reagents with "SYNTHETIC" or "ORGANIC | SYNTHETIC"

// Reagent type flags, defines the types of mobs this reagent will affect
#define REAGENT_ORGANIC (1<<0)
#define REAGENT_SYNTHETIC (1<<1)

// Organ slots
#define ORGAN_SLOT_PARASITES "parasite"
#define ORGAN_SLOT_ALCOHOL_GLAND "alcohol_gland"
#define ORGAN_SLOT_INTESTINES "intestines"
#define ORGAN_SLOT_KIDNEYS "kidneys"
#define ORGAN_SLOT_SPLEEN "spleen"
#define ORGAN_SLOT_INNARDS "innards"

////organ defines
#define STANDARD_ORGAN_THRESHOLD 	100
#define STANDARD_ORGAN_HEALING 		(1/(10 MINUTES / (2 SECONDS)))		//designed to heal organs fully when left on a mob for ~10 minutes
#define STANDARD_ORGAN_DECAY		(1/(15 MINUTES / (2 SECONDS)))		//designed to fail organs when left to decay for ~15 minutes. 2 SECOND is SSmobs tickrate.
#define MIN_ORGAN_DECAY_INFECTION	2
#define MAX_ORGAN_DECAY_INFECTION	6
