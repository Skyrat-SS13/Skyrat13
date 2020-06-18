/obj/item/borg_shapeshifter
	name = "cyborg chameleon projector"
	icon = 'icons/obj/device.dmi'
	icon_state = "shield0"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/friendlyName
	var/savedName
	var/savedIcon
	var/savedBubbleIcon
	var/savedOverride
	var/savedPixelOffset
	var/active = FALSE
	var/activationCost = 300
	var/activationUpkeep = 50
	var/disguise = null
	var/disguise_icon_override = null
	var/disguise_pixel_offset = null
	var/mob/listeningTo
	var/static/list/signalCache = list( // list here all signals that should break the camouflage
			COMSIG_PARENT_ATTACKBY,
			COMSIG_ATOM_ATTACK_HAND,
			COMSIG_MOVABLE_IMPACT_ZONE,
			COMSIG_ATOM_BULLET_ACT,
			COMSIG_ATOM_EX_ACT,
			COMSIG_ATOM_FIRE_ACT,
			COMSIG_ATOM_EMP_ACT,
			)
	var/mob/living/silicon/robot/user // needed for process()
	var/animation_playing = FALSE
	var/list/borgmodels = list(
							"(Standard) Default", 
							"(Standard) Heavy",
							"(Standard) Sleek", 
							"(Standard) Marina",
							"(Standard) Robot",
							"(Standard) Eyebot",
							"(Standard) Bootyborg",
							"(Standard) Protectron",
							"(Standard) Miss m",
							"(Medical) Default",
							"(Medical) Heavy",
							"(Medical) Sleek",
							"(Medical) Marina",
							"(Medical) Droid",
							"(Medical) Eyebot",
							"(Medical) Medihound",
							"(Medical) Medihound Dark",
							"(Medical) Vale",
							"(Engineering) Default",
							"(Engineering) Default - Treads",
							"(Engineering) Loader",
							"(Engineering) Handy",
							"(Engineering) Sleek",
							"(Engineering) Can",
							"(Engineering) Marina",
							"(Engineering) Spider",
							"(Engineering) Heavy",
							"(Engineering) Bootyborg",
							"(Engineering) Protectron",
							"(Engineering) Miss m",
							"(Miner) Lavaland",
							"(Miner) Asteroid",
							"(Miner) Droid",
							"(Miner) Sleek",
							"(Miner) Marina",
							"(Miner) Can",
							"(Miner) Heavy",
							"(Miner) Bootyborg",
							"(Miner) Protectron",
							"(Miner) Miss m",
							"(Service) Waitress",
							"(Service) Butler",
							"(Service) Bro",
							"(Service) Can",
							"(Service) Tophat",
							"(Service) Sleek",
							"(Service) Heavy",
							"(Service) Bootyborg",
							"(Service) Protectron",
							"(Service) Miss m",
							"(Janitor) Default",
							"(Janitor) Marina",
							"(Janitor) Sleek",
							"(Janitor) Can",
							"(Janitor) Bootyborg",
							"(Janitor) Protectron",
							"(Janitor) Miss m")

/obj/item/borg_shapeshifter/Initialize()
	. = ..()
	friendlyName = pick(GLOB.ai_names)

/obj/item/borg_shapeshifter/Destroy()
	listeningTo = null
	return ..()

/obj/item/borg_shapeshifter/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_shapeshifter/equipped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_shapeshifter/attack_self(mob/living/silicon/robot/user)
	if (user && user.cell && user.cell.charge >  activationCost)
		if (isturf(user.loc))
			toggle(user)
		else
			to_chat(user, "<span class='warning'>You can't use [src] while inside something!</span>")
	else
		to_chat(user, "<span class='warning'>You need at least [activationCost] charge in your cell to use [src]!</span>")

/obj/item/borg_shapeshifter/proc/toggle(mob/living/silicon/robot/user)
	if(active)
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, -6)
		to_chat(user, "<span class='notice'>You deactivate \the [src].</span>")
		deactivate(user)
	else
		if(animation_playing)
			to_chat(user, "<span class='notice'>\the [src] is recharging.</span>")
			return
		var/borg_icon = input(user, "Select an icon!", "Robot Icon", null) as null|anything in borgmodels
		if(!borg_icon)
			return FALSE
		switch(borg_icon)
			if("(Standard) Default")
				disguise = "robot"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Standard) Heavy")
				disguise = "heavysd"
				disguise_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			if("(Standard) Sleek")
				disguise = "sleeksd"
				disguise_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			if("(Standard) Marina")
				disguise = "marinasd"
				disguise_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			if("(Standard) Robot")
				disguise = "robot_old"
				disguise_icon_override = 'modular_skyrat/icons/mob/robotssd.dmi'
			if("(Standard) Bootyborg")
				disguise = "bootysd"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Standard) Protectron")
				disguise = "protectron_standard"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Standard) Miss m")
				disguise = "missm_sd"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Medical) Default")
				disguise = "medical"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Medical) Heavy")
				disguise = "heavymed"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Medical) Sleek")
				disguise = "sleekmed"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Medical) Marina")
				disguise = "marinamed"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Medical) Droid")
				disguise = "medical"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Medical) Eyebot")
				disguise = "eyebotmed"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Medical) Medihound")
				disguise = "medihound"
				disguise_icon_override = 'modular_skyrat/icons/mob/widerobot.dmi'
				disguise_pixel_offset = -16
			if("(Medical) Medihound Dark")
				disguise = "medihounddark"
				disguise_icon_override = 'modular_skyrat/icons/mob/widerobot.dmi'
				disguise_pixel_offset = -16
			if("(Medical) Vale")
				disguise = "valemed"
				disguise_icon_override = 'modular_skyrat/icons/mob/widerobot.dmi'
				disguise_pixel_offset = -16
			if("(Engineering) Default")
				disguise = "engineer"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Engineering) Default - Treads")
				disguise = "engie-tread"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Loader")
				disguise = "loaderborg"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Handy")
				disguise = "handyeng"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Sleek")
				disguise = "sleekeng"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Can")
				disguise = "caneng"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Marina")
				disguise = "marinaeng"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Spider")
				disguise = "spidereng"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Heavy")
				disguise = "heavyeng"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Engineering) Bootyborg")
				disguise = "bootyeng"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Engineering) Protectron")
				disguise = "protectron_eng"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Engineering) Miss m")
				disguise = "missm_eng"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Miner) Lavaland")
				disguise = "miner"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Miner) Asteroid")
				disguise = "minerOLD"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Miner) Droid")
				disguise = "miner"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Miner) Sleek")
				disguise = "sleekmin"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Miner) Marina")
				disguise = "marinamin"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Miner) Can")
				disguise = "canmin"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Miner) Heavy")
				disguise = "heavymin"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Miner) Bootyborg")
				disguise = "bootyminer"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Miner) Protectron")
				disguise = "protectron_miner"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Miner) Miss m")
				disguise = "missm_miner"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Service) Waitress")
				disguise = "service_f"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Service) Butler")
				disguise = "service_m"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Service) Bro")
				disguise = "brohat"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Service) Can")
				disguise = "kent"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Service) Tophat")
				disguise = "tophat"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Service) Sleek")
				disguise = "sleekserv"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Service) Heavy")
				disguise = "heavyserv"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Service) Bootyborg")
				disguise = "bootyservice"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Service) Protectron")
				disguise = "protectron_service"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Service) Miss m")
				disguise = "missm_service"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Janitor) Default")
				disguise = "janitor"
				disguise_icon_override = 'icons/mob/robots.dmi'
			if("(Janitor) Marina")
				disguise = "marinajan"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Janitor) Sleek")
				disguise = "sleekjan"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Janitor) Can")
				disguise = "canjan"
				disguise_icon_override = 'modular_citadel/icons/mob/robots.dmi'
			if("(Janitor) Bootyborg")
				disguise = "bootyjanitor"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Janitor) Protectron")
				disguise = "protectron_janitor"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
			if("(Janitor) Miss m")
				disguise = "missm_janitor"
				disguise_icon_override = 'modular_skyrat/icons/mob/moreborgsmodels.dmi'
		animation_playing = TRUE
		to_chat(user, "<span class='notice'>You activate \the [src].</span>")
		playsound(src, 'sound/effects/seedling_chargeup.ogg', 100, TRUE, -6)
		var/start = user.filters.len
		var/X,Y,rsq,i,f
		for(i=1, i<=7, ++i)
			do
				X = 60*rand() - 30
				Y = 60*rand() - 30
				rsq = X*X + Y*Y
			while(rsq<100 || rsq>900)
			user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
		for(i=1, i<=7, ++i)
			f = user.filters[start+i]
			animate(f, offset=f:offset, time=0, loop=3, flags=ANIMATION_PARALLEL)
			animate(offset=f:offset-1, time=rand()*20+10)
		if (do_after(user, 50, target=user) && user.cell.use(activationCost))
			playsound(src, 'sound/effects/bamf.ogg', 100, TRUE, -6)
			to_chat(user, "<span class='notice'>You are now disguised as the Nanotrasen cyborg \"[friendlyName]\".</span>")
			activate(user)
		else
			to_chat(user, "<span class='warning'>The chameleon field fizzles.</span>")
			do_sparks(3, FALSE, user)
			for(i=1, i<=min(7, user.filters.len), ++i) // removing filters that are animating does nothing, we gotta stop the animations first
				f = user.filters[start+i]
				animate(f)
		user.filters = null
		animation_playing = FALSE

/obj/item/borg_shapeshifter/process()
	if (user)
		if (!user.cell || !user.cell.use(activationUpkeep))
			disrupt(user)
	else
		return PROCESS_KILL

/obj/item/borg_shapeshifter/proc/activate(mob/living/silicon/robot/user)
	START_PROCESSING(SSobj, src)
	src.user = user
	savedName = user.name
	savedIcon = user.module.cyborg_base_icon
	savedBubbleIcon = user.bubble_icon //tf is that
	savedOverride = user.module.cyborg_icon_override
	savedPixelOffset = user.module.cyborg_pixel_offset
	user.name = friendlyName
	user.module.cyborg_base_icon = disguise
	user.module.cyborg_icon_override = disguise_icon_override
	user.module.cyborg_pixel_offset = disguise_pixel_offset
	user.bubble_icon = "robot"
	active = TRUE
	user.update_icons()

	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
	RegisterSignal(user, signalCache, .proc/disrupt)
	listeningTo = user

/obj/item/borg_shapeshifter/proc/deactivate(mob/living/silicon/robot/user)
	STOP_PROCESSING(SSobj, src)
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
		listeningTo = null
	do_sparks(5, FALSE, user)
	user.name = savedName
	user.module.cyborg_base_icon = savedIcon
	user.module.cyborg_icon_override = savedOverride
	user.bubble_icon = savedBubbleIcon
	active = FALSE
	user.update_icons()
	user.pixel_x = 0 //this solely exists because of dogborgs. I want anyone who ever reads this code later on to know this. Don't ask me why it's here, doesn't work above update_icons()
	src.user = user

/obj/item/borg_shapeshifter/proc/disrupt(mob/living/silicon/robot/user)
	if(active)
		to_chat(user, "<span class='danger'>Your chameleon field deactivates.</span>")
		deactivate(user)