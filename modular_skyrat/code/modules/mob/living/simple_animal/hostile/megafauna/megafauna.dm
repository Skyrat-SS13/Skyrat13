/mob/living/simple_animal/hostile/megafauna/SetRecoveryTime(buffer_time, ranged_buffer_time)
	recovery_time = world.time + buffer_time
	ranged_cooldown = world.time + buffer_time
	if(ranged_buffer_time)
		ranged_cooldown = world.time + ranged_buffer_time