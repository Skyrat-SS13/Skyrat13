/// Is the material from an ore? currently unused but exists atm for categorizations sake
#define MAT_CATEGORY_ORE "ore capable"

/// Hard materials, such as iron or metal
#define MAT_CATEGORY_RIGID "rigid material"

/// Flag for atoms, this flag ensures it isn't re-colored by materials. Useful for snowflake icons such as default toolboxes.
#define MATERIAL_COLOR (1<<0)
#define MATERIAL_ADD_PREFIX (1<<1)
#define MATERIAL_EFFECTS (1<<2)
#define MATERIAL_AFFECT_STATISTICS (1<<3)

#define MAT_COST_WITH_COEFF(cost,coeff) (CEILING(cost*coeff,CEILING(50*coeff,5))) //Skyrat Change. Materials OCD update.