SUBSYSTEM_DEF(logging)
	name = "Logging"
	wait = 6000 //fires once every ten minutes.
	var/list/new_logs_href = list("Logs from logging subsystem:")
	var/list/new_logs_say = list("Logs from logging subsystem:")
	var/list/new_logs_attack = list("Logs from logging subsystem:")

/datum/controller/subsystem/logging/fire()
	update_logs()

/datum/controller/subsystem/logging/proc/update_href_logs()
	if(new_logs_href.len == 1)
		return
	WRITE_LOG(GLOB.world_href_log, new_logs_href.Join("\n"))
	new_logs_href = list("Logs from logging subsystem:")

/datum/controller/subsystem/logging/proc/update_say_logs()
	if(new_logs_say.len == 1)
		return
	if (CONFIG_GET(flag/log_say))
		WRITE_LOG(GLOB.world_game_log, new_logs_say.Join("\n"))
		new_logs_say = list("Logs from logging subsystem:")

/datum/controller/subsystem/logging/proc/update_attack_logs()
	if(new_logs_attack.len == 1)
		return
	if (CONFIG_GET(flag/log_attack))
		WRITE_LOG(GLOB.world_attack_log, new_logs_attack.Join("\n"))
		new_logs_attack = list("Logs from logging subsystem:")

/datum/controller/subsystem/logging/proc/update_logs()
	update_href_logs()
	update_say_logs()
	update_attack_logs()

/datum/controller/subsystem/logging/Shutdown()
	update_logs()

/datum/controller/subsystem/logging/proc/logging_href(string)
	new_logs_href += "([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]) HREF: [string]"
	if(new_logs_href.len > 250)
		update_href_logs()

/datum/controller/subsystem/logging/proc/logging_say(string)
	new_logs_say += "([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]) SAY: [string]"
	if(new_logs_say.len > 250)
		update_say_logs()

/datum/controller/subsystem/logging/proc/logging_attack(string)
	new_logs_attack += "([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]) ATTACK: [string]"
	if(new_logs_attack.len > 250)
		update_attack_logs()