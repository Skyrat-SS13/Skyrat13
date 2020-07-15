//syndicate stuff whatever
/obj/item/card/id/syndicate_command/crew_id
	name = "syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	assignment = "Syndicate Operative"
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE)

/obj/item/card/id/syndicate_command/captain_id
	name = "syndicate captain ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	assignment = "Syndicate Ship Captain"
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE)

//skeleton key
/obj/item/card/skeletonkey
	name = "Skeleton Key"
	desc = "An ancient artifact, this key is capable of opening any and every thing."
	icon = 'modular_skyrat/icons/obj/items/skeletonkey.dmi'
	icon_state = "skeletonkey"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	item_flags = NO_MAT_REDEMPTION | NOBLUDGEON
	var/prox_check = TRUE

/obj/item/card/skeletonkey/attack()
	return

/obj/item/card/skeletonkey/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/atom/A = target
	if(!proximity && prox_check || !(isobj(A) || issilicon(A) || isbot(A) || isdrone(A)))
		return
	if(istype(A, /obj/item/storage) && !(istype(A, /obj/item/storage/lockbox) || istype(A, /obj/item/storage/pod)))
		return
	if(istype(A, /obj/machinery/door))
		var/obj/machinery/door/D = A
		D.locked = FALSE
		D.open()
		return
	if(istype(A, /obj/structure/safe))
		var/obj/structure/safe/S = A
		S.open = TRUE
		visible_message("<i><b>The [S] opens magically!!</b></i>")
		return
	if(!A.emag_act(user))
		return

//charliestation stuff
	/obj/item/card/id/away/old
	name = "a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	icon_state = "centcom"

/obj/item/card/id/away/old/sec
	name = "Charlie Station Security Officer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Security Officer\"."
	assignment = "Charlie Station Security Officer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/sci
	name = "Charlie Station Scientist's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Scientist\"."
	assignment = "Charlie Station Scientist"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/eng
	name = "Charlie Station Engineer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Station Engineer\"."
	assignment = "Charlie Station Engineer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE, ACCESS_ENGINE_EQUIP)

/obj/item/card/id/away/old/mine
	name = "Charlie Station Miner's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Miner\"."
	assignment = "Charlie Station Miner"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/med
	name = "Charlie Station Doctor's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Doctor\"."
	assignment = "Charlie Station Doctor"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/old/ass
	name = "Charlie Station Staff Assistant's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Staff Assistant\"."
	assignment = "Charlie Station Staff Assistant"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/old/chaplain
	name = "Charlie Station Chaplain's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Chaplain\"."
	assignment = "Charlie Station Chaplain"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/apc
	name = "APC Access ID"
	desc = "A special ID card that allows access to APC terminals."
	access = list(ACCESS_ENGINE_EQUIP)
