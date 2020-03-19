//Forgotten syndicate ship

/obj/effect/mob_spawn/human/syndicatespace
	name = "Syndicate Ship Crew Member"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	short_desc = "You are a syndicate operative on old ship, stuck in hostile space."
	flavour_text = "Your ship docks after a long time somewhere in hostile space, reporting a malfunction. You are stuck here, with Nanotrasen station nearby. Fix the ship, find a way to power it and follow your captain's orders."
	important_info = "Obey orders given by your captain. DO NOT leave the ship."
	outfit = /datum/outfit/syndicatespace/syndicrew

/datum/outfit/syndicatespace/syndicrew/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

/obj/effect/mob_spawn/human/syndicatespace/special(mob/living/new_spawn)
	new_spawn.grant_language(/datum/language/codespeak, TRUE, TRUE)

/obj/effect/mob_spawn/human/syndicatespace/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()


/obj/effect/mob_spawn/human/syndicatespace/captain
	name = "Syndicate Ship Captain"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	short_desc = "You are the captain of an old ship, stuck in hostile space."
	flavour_text = "Your ship docks after a long time somewhere in hostile space, reporting a malfunction. You are stuck here, with Nanotrasen station nearby. Command your crew and turn your ship into the most protected fortress."
	important_info = "Protect the ship and secret documents in your backpack with your own life. DO NOT leave the ship."
	mob_gender = "male"
	outfit = /datum/outfit/syndicatespace/syndicaptain

/datum/outfit/syndicatespace/syndicaptain/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

/datum/outfit/syndicatespace/syndicrew
	name = "Syndicate Ship Crew Member"
	uniform = /obj/item/clothing/under/syndicate/combat
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault
	id = /obj/item/card/id/syndicate_command/crew_id
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/syndicatespace/syndicaptain
	name = "Syndicate Ship Captain"
	uniform = /obj/item/clothing/under/syndicate/combat
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	glasses = /obj/item/clothing/glasses/night
	mask = /obj/item/clothing/mask/gas/syndicate
	head = /obj/item/clothing/head/HoS/beret/syndicate
	ears = /obj/item/radio/headset/syndicate/alt
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack
	l_pocket = /obj/item/gun/ballistic/automatic/pistol/APS
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault
	id = /obj/item/card/id/syndicate_command/captain_id
	backpack_contents = list(/obj/item/documents/syndicate/red, /obj/item/paper/fluff/ruins/forgottenship/password)
	implants = list(/obj/item/implant/weapons_auth)