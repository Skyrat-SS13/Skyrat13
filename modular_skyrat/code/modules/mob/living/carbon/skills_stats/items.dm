//Item related code for stats and skills
/obj/item
	var/used_melee_stat = STAT_DATUM(str) //What stat impacts the item's melee force
	var/used_melee_skill = SKILL_DATUM(melee) //What skill impacts the item's melee force
	var/used_ranged_stat = STAT_DATUM(dex) //Ditto but for ranged
	var/used_ranged_skill = SKILL_DATUM(ranged) //Ditto but for ranged
