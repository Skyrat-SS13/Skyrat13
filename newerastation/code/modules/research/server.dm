// Apparently upstream decided to port only half of the dynamic server production PR or something?
// No idea. But they disabled it. So uh... I fixed it, by copying the mine proc from a codebase where it works.
// Then I still added the hook because y'know. Gotta stay clean.
/obj/machinery/rnd/server/proc/mine()
	// Cheap way to refresh if we are operational or not.  mine() is run on the tech web
	// subprocess.  This saves us having to run our own subprocess
	refresh_working()
	if(working)
		var/penalty = max((get_env_temp() - temp_tolerance_high), 0) * temp_penalty_coefficient
		var/result = max(base_mining_income - penalty, 0)
		result = newera_process_bc_miner(result)
		return list(TECHWEB_POINT_TYPE_GENERIC = result)
	else
		return list(TECHWEB_POINT_TYPE_GENERIC = 0)

/obj/machinery/rnd/server/proc/newera_process_bc_miner(points)
	var/obj/item/infiltrator_miner/B = (locate(/obj/item/infiltrator_miner) in src.contents)
	if(B && !B.target_reached)
		var/intercepted = points*0.6
		B.on_mine(intercepted)
		return points - intercepted
	return points
