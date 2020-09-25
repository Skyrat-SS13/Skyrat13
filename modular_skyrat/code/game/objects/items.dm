//Hiding underwear
//Item pickup memes
/obj/item
	hide_underwear_examine = TRUE

//Item pickup text
/obj/item
	var/grabtext
	var/grabsound
	hide_underwear_examine = TRUE

/obj/item/pickup(mob/living/user)
	. = ..()
	if(grabtext)
		var/t = replacetext(grabtext,"user","[user]")
		t = replacetext(t,"src","[src.name]")
		user.visible_message("<span class='danger'>[t]</span>")
	if(grabsound)
		playsound(src,grabsound,50,1)

//Item info element
/obj/item/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/item_info)

//Wielding any item very poggers
/obj/item
	var/can_wield = TRUE
	//Variables we use for the component
	var/ignore_attack_self_wield = TRUE				/// Set to true if the item cannot wield by attack selfing
	var/force_multiplier = 1.2						/// The multiplier applied to force when wielded, does not work with force_wielded, and force_unwielded - defaults to 1.2
	var/force_wielded = 0	 						/// The force of the item when wielded
	var/force_unwielded = 0		 					/// The force of the item when unwielded
	var/wieldsound = FALSE 							/// Play sound when wielded
	var/unwieldsound = FALSE 						/// Play sound when unwielded
	var/attacksound = FALSE							/// Play sound on attack when wielded
	var/require_twohands = FALSE					/// Does it have to be held in both hands
	var/icon_wielded = FALSE						/// The icon that will be used when wielded

/obj/item/Initialize()
	..()
	WieldInitialize()

/obj/item/proc/WieldInitialize()
	var/datum/component/two_handed/TW = GetComponent(/datum/component/two_handed)
	if(can_wield && !TW)
		AddComponent(/datum/component/two_handed, require_twohands, wieldsound, unwieldsound, attacksound,\
					force_multiplier, force_wielded, force_unwielded, icon_wielded, ignore_attack_self_wield)

/obj/item/Destroy()
	. = ..()
	var/datum/component/two_handed/TW = GetComponent(/datum/component/two_handed)
	if(TW)
		qdel(TW)

/obj/item/proc/wield_act(mob/living/carbon/user)
	//Check if we can even wield the item, if not we error out
	var/datum/component/two_handed/TW = GetComponent(/datum/component/two_handed)
	if(!can_wield || !TW)
		to_chat(user, "<span class='warning'>\The [src] cannot be wielded in any way!</span>")
		return
	if(TW.wielded)
		TW.unwield(user, TRUE)
	else
		TW.wield(user)

//Show item infection level
/obj/item/examine_more(mob/user)
	. = ..()
	if(. == DEFAULT_EXAMINE_MORE)
		. = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")
	switch(germ_level)
		if(-INFINITY to 0)
			. += "<span class='info'>\The [src] is sterile.</span>"
		if(0 to GERM_LEVEL_AMBIENT)
			. += "<span class='info'>\The [src] is mildly unsanitized.</span>"
		if(GERM_LEVEL_AMBIENT to WOUND_INFECTION_CRITICAL)
			. += "<span class='info'>\The [src] is unclean.</span>"
		if(WOUND_INFECTION_CRITICAL to WOUND_INFECTION_SEPTIC)
			. += "<span class='info'>\The [src] is terribly dirty.</span>"
