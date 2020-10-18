//Stat defines
#define MIN_STAT 1 //Minimum level for a stat
#define MAX_STAT 20 //Maximum level for a stat
#define START_STAT 10 //Stat level you get by default

//Skill defines
#define MIN_SKILL 1 //Minimum level for a skill
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
#define JOB_SKILLPOINTS_HORRENDOUS 1
#define JOB_SKILLPOINTS_WORTHLESS 5
#define JOB_SKILLPOINTS_NOVICE 7
#define JOB_SKILLPOINTS_AVERAGE 10
#define JOB_SKILLPOINTS_TRAINED 12
#define JOB_SKILLPOINTS_EXPERT 16
#define JOB_SKILLPOINTS_LEGENDARY 20

//Job stat point allocation
#define JOB_STATPOINTS_HORRENDOUS 1
#define JOB_STATPOINTS_WORTHLESS 5
#define JOB_STATPOINTS_NOVICE 7
#define JOB_STATPOINTS_AVERAGE 10
#define JOB_STATPOINTS_TRAINED 12
#define JOB_STATPOINTS_EXPERT 16
#define JOB_STATPOINTS_LEGENDARY 20

//Helpers
#define SKILL_DATUM(x) /datum/skills/##x
#define STAT_DATUM(x) /datum/stats/##x

#define GET_STAT(mindmob, x) mindmob.mind?.mob_stats[STAT_DATUM(x)]
#define GET_SKILL(mindmob, x) mindmob.mind?.mob_skills[SKILL_DATUM(x)]

#define STAT_LEVEL(mindmob, x) mindmob.mind?.mob_stats[STAT_DATUM(x)]?.level
#define SKILL_LEVEL(mindmob, x) mindmob.mind?.mob_skills[SKILL_DATUM(x)]?.level

#define GET_STAT_LEVEL(mindmob, x) STAT_LEVEL(mindmob, x)
#define GET_SKILL_LEVEL(mindmob, x) SKILL_LEVEL(mindmob, x)
