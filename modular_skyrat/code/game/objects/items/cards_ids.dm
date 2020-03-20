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