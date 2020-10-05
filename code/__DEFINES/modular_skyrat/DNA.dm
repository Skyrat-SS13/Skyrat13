//Our modular 'species_traits' defines, starting from 50 in case citadel adds more
#define REVIVESBYHEALING 50 // Will revive on heal when healing, based on a species var
#define NOHUSK			51 // Can't be husked.
#define ROBOTIC_LIMBS	52 //limbs start out as robotic; but also use organic icons. If you want to use the default ones, you'll have to use on_species_gain. IT DOESNT SET THEM TO SYNTHETIC LEGS, that is also done on_species_gain
#define CAN_SCAR		53
#define HAS_BONE		54
#define HAS_FLESH		55
#define HAS_SKIN		56

//Defines for processing reagents, for synths, IPC's and Vox
#define PROCESS_ORGANIC (1<<0)		//Only processes reagents with "ORGANIC" or "ORGANIC | SYNTHETIC"
#define PROCESS_SYNTHETIC (1<<1)		//Only processes reagents with "SYNTHETIC" or "ORGANIC | SYNTHETIC"

// Reagent type flags, defines the types of mobs this reagent will affect
#define REAGENT_ORGANIC (1<<0)
#define REAGENT_SYNTHETIC (1<<1)
