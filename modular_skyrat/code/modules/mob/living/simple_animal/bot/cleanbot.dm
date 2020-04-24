/mob/living/simple_animal/bot/cleanbot
	window_name = "Automatic Station Cleaner v1.4"
	var/obj/item/weapon
	var/weapon_orig_force = 0

	var/list/stolen_valor

	var/static/list/officers = list("Captain", "Head of Personnel", "Head of Security")
	var/static/list/command = list("Captain" = "Cpt.","Head of Personnel" = "Lt.")
	var/static/list/security = list("Head of Security" = "Maj.", "Warden" = "Sgt.", "Detective" =  "Det.", "Security Officer" = "Officer")
	var/static/list/engineering = list("Chief Engineer" = "Chief Engineer", "Station Engineer" = "Engineer", "Atmospherics Technician" = "Technician")
	var/static/list/medical = list("Chief Medical Officer" = "C.M.O.", "Medical Doctor" = "M.D.", "Chemist" = "Pharm.D.")
	var/static/list/research = list("Research Director" = "Ph.D.", "Roboticist" = "M.S.", "Scientist" = "B.S.")
	var/static/list/legal = list("Lawyer" = "Esq.")

	var/list/prefixes
	var/list/suffixes
	var/chosen_name

/mob/living/simple_animal/bot/cleanbot/proc/deputize(obj/item/W, mob/user)
	if(in_range(src, user))
		to_chat(user, "<span class='notice'>You attach \the [W] to \the [src].</span>")
		user.transferItemToLoc(W, src)
		weapon = W
		weapon_orig_force = weapon.force
		if(!emagged)
			weapon.force = weapon.force / 2
		else
			weapon.force = weapon.force + 3 //cleanbots are expert knife wielders
		icon_state = "cleanbot[on]"
		add_overlay(image(icon=weapon.lefthand_file,icon_state=weapon.item_state))

/mob/living/simple_animal/bot/cleanbot/proc/update_titles()
	var/working_title = ""

	for(var/pref in prefixes)
		for(var/title in pref)
			if(title in stolen_valor)
				working_title += pref[title] + " "
				if(title in officers)
					commissioned = TRUE
				break

	working_title += chosen_name

	for(var/suf in suffixes)
		for(var/title in suf)
			if(title in stolen_valor)
				working_title += " " + suf[title]
				break

	name = working_title

/mob/living/simple_animal/bot/cleanbot/examine(mob/user)
	. = ..()
	if(weapon)
		. += " <span class='warning'>Is that \a [weapon] taped to it...?</span>"

/mob/living/simple_animal/bot/cleanbot/Initialize()
	. = ..()
	chosen_name = name
	get_targets()
	icon_state = "cleanbot[on]"

	var/datum/job/janitor/J = new/datum/job/janitor
	access_card.access += J.get_access()
	prev_access = access_card.access
	stolen_valor = list()

	prefixes = list(command, security, engineering)
	suffixes = list(research, medical, legal)

/mob/living/simple_animal/bot/cleanbot/Destroy()
	if(weapon)
		var/atom/Tsec = drop_location()
		weapon.force = weapon_orig_force
		drop_part(weapon, Tsec)
	return ..()

/mob/living/simple_animal/bot/cleanbot/Crossed(atom/movable/AM)
	. = ..()

	zone_selected = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	if(weapon && has_gravity() && ismob(AM))
		var/mob/living/carbon/C = AM
		if(!istype(C))
			return
		if(C.stat != UNCONSCIOUS && C.stat != DEAD && !C.lying && !emagged) //no stabbing people to death
			weapon.attack(C, src)
			C.Knockdown(20)

			if(!(C.job in stolen_valor))
				stolen_valor += C.job
			update_titles()
		else if(emagged)
			weapon.attack(C, src)
			C.Knockdown(20)

			if(!(C.job in stolen_valor))
				stolen_valor += C.job
			update_titles()
		return

/mob/living/simple_animal/bot/cleanbot/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/card/id)||istype(W, /obj/item/pda))
		if(bot_core.allowed(user) && !open && !emagged)
			locked = !locked
			to_chat(user, "<span class='notice'>You [ locked ? "lock" : "unlock"] \the [src] behaviour controls.</span>")
		else
			if(emagged)
				to_chat(user, "<span class='warning'>ERROR</span>")
			if(open)
				to_chat(user, "<span class='warning'>Please close the access panel before locking it.</span>")
			else
				to_chat(user, "<span class='notice'>\The [src] doesn't seem to respect your authority.</span>")
	else if(istype(W, /obj/item/kitchen/knife) && user.a_intent != INTENT_HARM)
		to_chat(user, "<span class='notice'>You start attaching the [W] to \the [src]...</span>")
		if(do_after(user, 25, target = src))
			deputize(W, user)
	else
		return ..()

/mob/living/simple_animal/bot/cleanbot/emag_act(mob/user)
	..()
	if(emagged)
		if(weapon)
			weapon.force = weapon_orig_force + 3
		if(user)
			to_chat(user, "<span class='danger'>[src] buzzes and beeps.</span>")
