//Evil faxes
/obj/item/paper/evilfax
	name = "CentCom Reply"
	info = ""
	var/mytarget = null
	var/myeffect = null
	var/used = FALSE
	var/countdown = 60
	var/activate_on_timeout = FALSE

/obj/item/paper/evilfax/examine(var/mob/user, var/forceshow = FALSE, var/forcestars = FALSE, var/infolinks = FALSE, var/view = TRUE)
	if(user == mytarget)
		if(istype(user, /mob/living/carbon))
			var/mob/living/carbon/C = user
			evilpaper_specialaction(C)
			. = ..()
		else
			// This should never happen, but just in case someone is adminbussing
			evilpaper_selfdestruct()
	else
		if(mytarget)
			to_chat(user,"<span class='notice'>This page appears to be covered in some sort of bizzare code. The only bit you recognize is the name of [mytarget]. Perhaps [mytarget] can make sense of it?</span>")
		else
			evilpaper_selfdestruct()

/obj/item/paper/evilfax/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/paper/evilfax/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(mytarget && !used)
		var/mob/living/carbon/target = mytarget
		var/datum/disease/D = new /datum/disease/transformation/corgi(0)
		D.infect(target)
	return ..()

/obj/item/paper/evilfax/process()
	if(!countdown)
		if(mytarget)
			if(activate_on_timeout)
				evilpaper_specialaction(mytarget)
			else
				message_admins("[mytarget] ignored an evil fax until it timed out.")
		else
			message_admins("Evil paper '[src]' timed out, after not being assigned a target.")
		used = TRUE
		evilpaper_selfdestruct()
	else
		countdown--

/obj/item/paper/evilfax/proc/evilpaper_specialaction(target)
	addtimer(CALLBACK(src, .proc/handle_specialaction, target), 30)

/obj/item/paper/evilfax/proc/handle_specialaction(var/mob/living/carbon/target)
	if(istype(target,/mob/living/carbon))
		if(myeffect == "Borgification")
			var/datum/disease/D = new /datum/disease/transformation/robot(0)
			D.infect(target)
			to_chat(target,"<span class='userdanger'>You seem to comprehend the AI a little better. Why are your muscles so stiff?</span>")
		else if(myeffect == "Corgification")
			var/datum/disease/D = new /datum/disease/transformation/corgi(0)
			D.infect(target)
			to_chat(target,"<span class='userdanger'>You hear distant howling as the world seems to grow bigger around you. Boy, that itch sure is getting worse!</span>")
		else if(myeffect == "Death By Fire")
			to_chat(target,"<span class='userdanger'>You feel hotter than usual. Maybe you should lowe-wait, is that your hand melting?</span>")
			var/turf/open/fire_spot = get_turf(target)
			new /obj/effect/hotspot(fire_spot)
			target.adjustFireLoss(150) // hard crit, the burning takes care of the rest.
		else if(myeffect == "Demotion Notice")
			priority_announce("[mytarget] is hereby demoted to the rank of Assistant. Process this demotion immediately. Failure to comply with these orders is grounds for termination.","CC Demotion Order")
		else
			message_admins("Evil paper [src] was activated without a proper effect set! This is a bug.")
	used = TRUE
	evilpaper_selfdestruct()

/obj/item/paper/evilfax/proc/evilpaper_selfdestruct()
	visible_message("<span class='danger'>[src] spontaneously catches fire, and burns up!</span>")
	qdel(src)
