//Stat defines
#define MIN_STAT 1 //Minimum level for a stat
#define MAX_STAT 20 //Maximum level for a stat
#define START_STAT 5 //Stat level you get by default

//Skill defines
#define MIN_SKILL 0 //Minimum level for a skill
#define MAX_SKILL 20 //Maximum level for a skill
#define START_SKILL 1 //Skill level you get by default
#define SKILL_LVL_REQUIREMENT 100 //XP required to level up skills

//Dice roll defines
//All of them are non-zero integers to make math simpler when necessary
#define DICE_CRIT_SUCCESS 2
#define DICE_SUCCESS 1
#define DICE_FAILURE -1
#define DICE_CRIT_FAILURE -2

//Job skill point allocation
#define JOB_SKILLPOINTS_HORRENDOUS 20
#define JOB_SKILLPOINTS_WORTHLESS 25
#define JOB_SKILLPOINTS_NOVICE 30
#define JOB_SKILLPOINTS_AVERAGE 35
#define JOB_SKILLPOINTS_TRAINED 40
#define JOB_SKILLPOINTS_EXPERT 50
#define JOB_SKILLPOINTS_LEGENDARY 60

//Job stat point allocation
#define JOB_STATPOINTS_HORRENDOUS 1
#define JOB_STATPOINTS_WORTHLESS 5
#define JOB_STATPOINTS_NOVICE 10
#define JOB_STATPOINTS_AVERAGE 15
#define JOB_STATPOINTS_TRAINED 20
#define JOB_STATPOINTS_EXPERT 25
#define JOB_STATPOINTS_LEGENDARY 35

//Helpers
#define SKILL(x) /datum/skills/##x
#define STAT(x) /datum/stats/##x

#define GET_STAT(x) mob_stats[STAT(x)]
#define GET_SKILL(x) mob_skills[SKILL(x)]

#define STAT_LEVEL(x) mob_stats[STAT(x)]?.level
#define SKILL_LEVEL(x) mob_skills[SKILL(x)]?.level
