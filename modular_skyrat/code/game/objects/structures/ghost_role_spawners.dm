//Ancient cryogenic sleepers. Players become NT crewmen from a hundred year old space station, now on the verge of collapse.
/obj/effect/mob_spawn/human/oldsec
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a security uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a security officer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a security officer working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/security/officer
	shoes = /obj/item/clothing/shoes/jackboots
	id = /obj/item/card/id/away/old/sec
	r_pocket = /obj/item/restraints/handcuffs
	l_pocket = /obj/item/assembly/flash/handheld
	job_description = "Oldstation Crew"
	assignedrole = "Ancient Crew Security"

/obj/effect/mob_spawn/human/oldsec/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldeng
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an engineering uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "an engineer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	job_description = "Oldstation Crew"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are an engineer working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. The last thing \
	you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/engineering/engineer
	shoes = /obj/item/clothing/shoes/workboots
	id = /obj/item/card/id/away/old/eng
	gloves = /obj/item/clothing/gloves/color/yellow/
	l_pocket = /obj/item/tank/internals/emergency_oxygen
	assignedrole = "Ancient Crew Engineer"

/obj/effect/mob_spawn/human/oldeng/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldsci
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a science uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a scientist working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/away/old/sci
	l_pocket = /obj/item/laser_pointer
	assignedrole = "Ancient Crew Scientist"
	job_description = "Oldstation Crew"

/obj/effect/mob_spawn/human/oldsci/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldmine
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a mining uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a shaft miner"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a  working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/cargo/miner
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/workboots/mining
	id = /obj/item/card/id/away/old/mine
	l_pocket = /obj/item/reagent_containers/hypospray/medipen/survival
	r_pocket = /obj/item/storage/bag/ore
	assignedrole = "Ancient Crew Miner"
	job_description = "Oldstation Crew"

/obj/effect/mob_spawn/human/oldmine/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldmed
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise doctor scrubs uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a doctor"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a doctor working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. \
	The last thing you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	shoes = /obj/item/clothing/shoes/sneakers/white
	id = /obj/item/card/id/away/old/med
	l_hand = /obj/item/storage/firstaid/regular
	l_pocket = /obj/item/stack/medical/bruise_pack
	r_pocket = /obj/item/stack/medical/ointment
	assignedrole = "Ancient Crew Medical Doctor"
	job_description = "Oldstation Crew"

/obj/effect/mob_spawn/human/oldmed/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldass
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an assistant uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "an assistant"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	job_description = "Oldstation Crew"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a staff assistant working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. The last thing \
	you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/misc/staffassistant
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/away/old/ass
	gloves = /obj/item/clothing/gloves/color/fyellow/
	assignedrole = "Ancient Crew Assistant"

/obj/effect/mob_spawn/human/oldass/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldchap
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a chaplain uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a chaplain"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	job_description = "Oldstation Crew"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	short_desc = "You are a chaplain working for Nanotrasen, stationed onboard a state of the art research station."
	flavour_text = "You vaguely recall rushing into a cryogenics pod due to an oncoming radiation storm. The last thing \
	you remember is the station's Artificial Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling swells in your gut as you climb out of your pod. At least you still have your trusty bible and null rod, \
	may your deity protect you from any harm."
	important_info = "Work as a team with your fellow survivors and do not abandon them."
	uniform = /obj/item/clothing/under/rank/civilian/chaplain
	shoes = /obj/item/clothing/shoes/sneakers/black
	id = /obj/item/card/id/away/old/chaplain
	assignedrole = "Ancient Crew Chaplain"

/obj/effect/mob_spawn/human/oldchap/create(ckey, name) //makes them holy and creates their bible and null rod on spawn
	var/mob/living/M = new mob_type(get_turf(src)) //living mobs only
	if(!random)
		M.real_name = mob_name ? mob_name : M.name
		if(!mob_gender)
			mob_gender = pick(MALE, FEMALE)
		M.gender = mob_gender
	if(faction)
		M.faction = list(faction)
	if(disease)
		M.ForceContractDisease(new disease)
	if(death)
		M.death(1) //Kills the new mob

	M.adjustOxyLoss(oxy_damage)
	M.adjustBruteLoss(brute_damage)
	M.adjustFireLoss(burn_damage)
	M.color = mob_color
	equip(M)

	if(ckey)
		M.ckey = ckey
		if(show_flavour)
			var/output_message = "<span class='big bold'>[short_desc]</span>"
			if(flavour_text != "")
				output_message += "\n<span class='bold'>[flavour_text]</span>"
			if(important_info != "")
				output_message += "\n<span class='userdanger'>[important_info]</span>"
			to_chat(M, output_message)
		var/datum/mind/MM = M.mind
		var/datum/antagonist/A
		if(antagonist_type)
			A = MM.add_antag_datum(antagonist_type)
		if(objectives)
			if(!A)
				A = MM.add_antag_datum(/datum/antagonist/custom)
			for(var/objective in objectives)
				var/datum/objective/O = new/datum/objective(objective)
				O.owner = MM
				A.objectives += O
		if(assignedrole)
			M.mind.assigned_role = assignedrole
		special(M, name)
		MM.name = M.real_name
		M.mind.isholy = TRUE
		new /obj/item/nullrod(M.loc)
		new /obj/item/storage/book/bible/booze(M.loc)
		new /obj/item/choice_beacon/holy(M.loc)
	if(uses > 0)
		uses--
	if(!permanent && !uses)
		qdel(src)

/obj/effect/mob_spawn/human/oldchap/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/robot
	mob_type = /mob/living/silicon/robot
	assignedrole = "Ghost Role"

/obj/effect/mob_spawn/robot/Initialize()
	. = ..()

/obj/effect/mob_spawn/robot/equip(mob/living/silicon/robot/R)
	. = ..()

/obj/effect/mob_spawn/robot/ghostcafe
	name = "Cafe Robotic Storage"
	uses = -1
	icon = 'modular_skyrat/icons/obj/machines/robot_storage.dmi'
	icon_state = "robostorage"
	mob_name = "a cafe robot"
	roundstart = FALSE
	anchored = TRUE
	density = FALSE
	death = FALSE
	assignedrole = "Cafe Robot"
	short_desc = "You are a Cafe Robot!"
	flavour_text = "Who could have thought? This awesome local cafe accepts cyborgs too!"
	skip_reentry_check = TRUE
	banType = ROLE_GHOSTCAFE
	mob_type = /mob/living/silicon/robot/modules/roleplay

/obj/effect/mob_spawn/robot/ghostcafe/special(mob/living/silicon/robot/new_spawn)
	if(new_spawn.client)
		new_spawn.updatename(new_spawn.client)
		new_spawn.gender = NEUTER
		var/area/A = get_area(src)
		new_spawn.AddElement(/datum/element/ghost_role_eligibility, free_ghosting = TRUE)
		new_spawn.AddElement(/datum/element/dusts_on_catatonia)
		new_spawn.AddElement(/datum/element/dusts_on_leaving_area,list(A.type, /area/hilbertshotel, /area/centcom/holding/cafe, /area/centcom/holding/cafewar, /area/centcom/holding/cafebotany,
		/area/centcom/holding/cafebuild, /area/centcom/holding/cafevox, /area/centcom/holding/cafedorms, /area/centcom/holding/cafepark))
		ADD_TRAIT(new_spawn, TRAIT_SIXTHSENSE, GHOSTROLE_TRAIT)
		ADD_TRAIT(new_spawn, TRAIT_EXEMPT_HEALTH_EVENTS, GHOSTROLE_TRAIT)
		ADD_TRAIT(new_spawn, TRAIT_NO_MIDROUND_ANTAG, GHOSTROLE_TRAIT) //The mob can't be made into a random antag, they are still eligible for ghost roles popups.
		to_chat(new_spawn,"<span class='boldwarning'>Ghosting is free!</span>")
		var/datum/action/toggle_dead_chat_mob/D = new(new_spawn)
		D.Grant(new_spawn)
