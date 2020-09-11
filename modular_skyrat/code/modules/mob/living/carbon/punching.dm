//Unarmed combat related stuff
//Pulling up punches: Wield while holding no items to spawn a two-handed required "fist" item
//The fist does 10 brute damage on harm intent, 15 stamina damage on help intent, 10 pain damage on grab intent (bobmed 2) and has
//a chance to daze on disarm intent (but only 5 stamina damage to the target)
//Using the fist in any of these ways drains your stamina buffer, or stamina if it is empty
//You need two functional hands to pull up punches.
/mob/living/carbon/proc/pull_up_punches()
	if((stat == DEAD) || IsUnconscious() || (get_num_hands(TRUE) < 2))
		to_chat(src, "<span class='warning'>You are unable to raise your fists!</span>")
		return
	if(!SEND_SIGNAL(usr, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE))
		to_chat(src, "<span class='warning'>You need combat mode enabled to pull up punches!</span>")
		return
	
	var/obj/item/fist/fisto = new(src)
	if(put_in_active_hand(fisto))
		visible_message("<span class='warning'>\The [src] raises [p_their()] fists!</span>", "<span class='danger'>You raise your fists!</span>")
	else
		to_chat(src, "<span class='warning'>You fail to raise your fists!</span>")

/obj/item/fist
	name = "fist"
	desc = "Used to beat the life out of people."
	icon = 'modular_skyrat/icons/obj/fist.dmi'
	icon_state = "punch"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT
	hitsound = 'sound/effects/hit_punch.ogg'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/fist/attack(mob/living/M, mob/living/user)
	. = ..()
	switch(user.a_intent)
		if(INTENT_HELP) //Stamina damage
			force = 15
			damtype = STAMINA
		if(INTENT_HARM) //Brute damage, knock some teeth out
			force = 10
			damtype = BRUTE
		if(INTENT_GRAB) //Stamina damage (again)
			force = 15
			damtype = STAMINA
		if(INTENT_DISARM) //Low stamina damage, we are trying to disarm/daze the target
			force = 5
			damtype = STAMINA
		else //Something wrong, just go sicko mode
			force = 10
			damtype = BRUTE
	
//Our attack succeeded, let's try to apply extra effects
/obj/item/fist/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(proximity_flag)
		switch(user.a_intent)
			if(INTENT_DISARM)
				if(iscarbon(target) && isliving(user))
					var/mob/living/living_user = user
					var/mob/living/carbon/C = target

					//30% maximum chance to daze depending on the stamina, 12% minimum chance
					var/daze_chance = max(12, 30 * (1 - living_user.staminaloss/200))
					if(prob(daze_chance))
						C.visible_message("<span class='danger'>\The [C] gets dazed by [user]'s strike!</span>",
						"<span class='userdanger'>\The [user] dazes you with a powerful jab!</span>")
						//Daze the target depending on how much stamina they have
						//Maximum of 2.5 seconds, minimum of 1.25 seconds
						var/daze_amount = 2.5 SECONDS - (1.25 SECONDS * (C.staminaloss/200))
						C.Daze(daze_amount)

/obj/item/fist/proc/on_unwield(mob/living/carbon/user) //We just fucking die when unwielded
	user.visible_message("<span class='warning'>\The [user] lowers [user.p_their()] fists.</span>", "<span class='danger'>You lower your fists.</span>")
	if(!QDELETED(src))
		user.dropItemToGround(src)

/obj/item/fist/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)
