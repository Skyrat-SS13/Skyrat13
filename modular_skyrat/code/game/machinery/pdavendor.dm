/obj/machinery/vending/pdavendor
	icon = 'modular_skyrat/icons/obj/machines/computer.dmi'
	icon_state = "pdaterm"
	icon_vend = "pdaterm-purchase"
	icon_deny = "pdaterm-problem"
	products = list(/obj/item/pda = 20,
					/obj/item/modular_computer/tablet/preset/cheap = 10)
	contraband = list(/obj/item/pda/neko = 1)
	premium = list(/obj/item/pda/clear = 1)
	product_ads = "PDAs here!;Slick and informative!;Grab another?;Got a penpal?"
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	refill_canister = /obj/item/vending_refill/pdavendor
	resistance_flags = FIRE_PROOF
	default_price = 500
	extra_price = 1000
	payment_department = NO_FREEBIES
	var/list/colorlist = list()

/obj/machinery/vending/pdavendor/Initialize(mapload)
	. = ..()
	var/list/blocked = list(
		/obj/item/pda/ai/pai,
		/obj/item/pda/ai,
		/obj/item/pda/heads,
		/obj/item/pda/clear,
		/obj/item/pda/syndicate,
		/obj/item/pda/chameleon,
		/obj/item/pda/chameleon/broken,
		/obj/item/pda/lieutenant)

	for(var/A in typesof(/obj/item/pda) - blocked)
		var/obj/item/pda/P = A
		var/PDA_name = initial(P.name)
		colorlist += PDA_name
		colorlist[PDA_name] = list(initial(P.icon_state), initial(P.desc), initial(P.overlays_offsets), initial(P.overlays_icons))

/obj/machinery/vending/pdavendor/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/pda))
		var/mob/living/carbon/human/H = user
		var/datum/bank_account/BA = H.get_bank_account()
		if(BA.account_balance < 100)
			playsound(loc, 'sound/machines/synth_no.ogg', 50, 1, -1)
			visible_message("<span class='warning'>Insufficient Funds. Requires 100 credits.</span>", null, null, 5, null, null, null, null, TRUE)
			return
		BA.account_balance -= 100
		var/obj/item/pda/Z = W
		var/choice = input(user, "Select the new skin!", "PDA Painting") as null|anything in colorlist
		if(!choice || !in_range(src, user))
			return
		var/list/P = colorlist[choice]
		Z.icon_state = P[1]
		Z.desc = P[2]
		Z.overlays_offsets = P[3]
		Z.overlays_icons = P[4]
		Z.set_new_overlays()
		Z.update_icon()

/obj/item/vending_refill/pdavendor
	icon_state = "refill_engi"
