/datum/uplink_item/suits/truedab
	name = "Tactical DAB Suit"
	desc = "Ever found a cheap replica of one of these? Get to wear the real thing! Has slightly better protection than normal riot armor."
	item = /obj/item/storage/box/syndie_kit/truedab
	cost = 8
	exclude_modes = list(/datum/game_mode/nuclear, /datum/game_mode/nuclear/clown_ops)
	restricted_roles = list("Assistant")

/obj/item/storage/box/syndie_kit/truedab
	name = "Desperate Assistance Battleforce Box (DAB2)"
	desc = "DAB suit and helmet. Not the cheap replica!"

/obj/item/storage/box/syndie_kit/truedab/PopulateContents()
	new /obj/item/clothing/suit/assu_suit/realdeal(src)
	new /obj/item/clothing/head/assu_helmet/realdeal(src)

/obj/item/clothing/suit/assu_suit/realdeal
	desc = "Ancient, but still very functional, SWAT armor. On its back, it is written: \"<i>Desperate Assistance Battleforce</i>\". Tacticool-ish <b>and</b> protective!"
	armor = list("melee" = 55, "bullet" = 15, "laser" = 15, "energy" = 30, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 100) //somewhat high energy resistance because harmbatone, 5 points better in melee and boolet and laser than normal riot suit because it's an epic traitor item and NT is a bunch of cheapskates (except with fucking miner armors for some reason??????? bro wtf exo has 55 melee too???)
	allowed = null

/obj/item/clothing/suit/assu_suit/realdeal/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed

/obj/item/clothing/head/assu_helmet/realdeal
	desc = "Ancient, yet functional helmet. It has \"D.A.B.\" written on the front. Helps quite a bit against batons to the head."
	armor = list("melee" = 55, "bullet" = 15, "laser" = 15, "energy" = 30, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 100)
