//Stat defines
#define MIN_STAT 0 //Minimum level for a stat
#define MAX_STAT 20 //Maximum level for a stat
#define START_STAT 10 //Stat level you get by default

//Skill defines
#define MIN_SKILL 0 //Minimum level for a skill
#define MAX_SKILL 10 //Maximum level for a skill
#define START_SKILL 5 //Skill level you get by default
#define SKILL_LVL_REQUIREMENT 100 //XP required to level up skills

//Dice roll defines
//All of them are non-zero integers to make math simpler when necessary
#define DICE_CRIT_SUCCESS 2
#define DICE_SUCCESS 1
#define DICE_FAILURE -1
#define DICE_CRIT_FAILURE -2

//Helpers
#define SKILL(x) /datum/skills/##x
#define STAT(x) /datum/stats/##x

#define GET_STAT(x) mob_stats[STAT(x)]
#define GET_SKILL(x) mob_skills[SKILL(x)]

#define STAT_LEVEL(x) mob_stats[STAT(x)]?.level
#define SKILL_LEVEL(x) mob_skills[SKILL(x)]?.level
