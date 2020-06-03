//Security levels
#define SEC_LEVEL_GREEN	1
#define SEC_LEVEL_BLUE	2
//Skyrat change start
#define SEC_LEVEL_VIOLET 3
#define SEC_LEVEL_ORANGE 4
#define SEC_LEVEL_AMBER 5
#define SEC_LEVEL_RED	6
#define SEC_LEVEL_DELTA	7
//Skyrat change stop

//Macro helpers.
#define SECLEVEL2NUM(text)	(GLOB.all_security_levels.Find(text))
#define NUM2SECLEVEL(num)	(ISINRANGE(num, 1, length(GLOB.all_security_levels)) ? GLOB.all_security_levels[num] : null)
