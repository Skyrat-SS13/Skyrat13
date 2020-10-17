#define PROGRESSBAR_HEIGHT 6

/datum/progressbar
	var/goal = 1
	var/image/bar
	var/shown = 0
	var/mob/user
	var/client/client
	var/listindex

/datum/progressbar/New(mob/User, goal_number, atom/target)
	. = ..()
	if (!istype(target))
		CRASH("Invalid target given")
	if (goal_number)
		goal = goal_number
	bar = image('modular_skyrat/icons/effects/loadingcircle.dmi', target, "progress-0", HUD_LAYER)
	bar.plane = HUD_PLANE
	bar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	bar.color = "#00FF7F"
	user = User
	if(user)
		client = user.client

	LAZYINITLIST(user.progressbars)
	LAZYINITLIST(user.progressbars[bar.loc])
	var/list/bars = user.progressbars[bar.loc]
	bars.Add(src)
	listindex = bars.len
	bar.pixel_y = 8 + (PROGRESSBAR_HEIGHT * (listindex - 1))
	bar.pixel_x = 12

/datum/progressbar/proc/update(progress)
	if (!user || !user.client)
		shown = 0
		return
	if (user.client != client)
		if (client)
			client.images -= bar
		if (user.client)
			user.client.images += bar

	progress = clamp(progress, 0, goal)
	bar.icon_state = "progress-[round((progress / goal) * 10, 1)]"
	if (!shown)
		user.client.images += bar
		shown = 1

/datum/progressbar/proc/shiftDown()
	--listindex
	bar.pixel_y -= PROGRESSBAR_HEIGHT

/datum/progressbar/Destroy()
	for(var/I in user.progressbars[bar.loc])
		var/datum/progressbar/P = I
		if(P != src && P.listindex > listindex)
			P.shiftDown()

	var/list/bars = user.progressbars[bar.loc]
	bars.Remove(src)
	if(!bars.len)
		LAZYREMOVE(user.progressbars, bar.loc)

	if (client)
		client.images -= bar
	qdel(bar)
	. = ..()

#undef PROGRESSBAR_HEIGHT
