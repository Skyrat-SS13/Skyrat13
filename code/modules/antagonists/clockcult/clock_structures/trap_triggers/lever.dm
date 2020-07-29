//Lever: Do I really need to explain this?
/obj/structure/destructible/clockwork/trap/trigger/lever
	name = "lever"
	desc = "A fancy lever made of wood and capped with brass."
	clockwork_desc = "A fancy lever.that activates when pulled."
	max_integrity = 75
	icon_state = "lever"

<<<<<<< HEAD
/obj/structure/destructible/clockwork/trap/trigger/lever/attack_hand(mob/living/user)
=======
/obj/structure/destructible/clockwork/trap/trigger/lever/on_attack_hand(mob/living/user, act_intent = user.a_intent, unarmed_attack_flags)
>>>>>>> 81a7542aa6... Merge pull request #12834 from silicons/clickcd_experimental
	. = ..()
	if(.)
		return
	user.visible_message("<span class='notice'>[user] pulls [src]!</span>", "<span class='notice'>You pull [src]. It clicks, then lifts back upwards.</span>")
	if(wired_to.len)
		audible_message("<i>You hear gears clanking.</i>")
	playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
	activate()
