/obj/item/card/emag/independence
	name = "Declaration of independence"
	desc = "Use it on a supply shuttle to free cargonia!"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	uses = 1

/obj/item/card/emag/independence/afterattack(atom/target, mob/user, proximity)
	if(istype(target, /obj/machinery/computer/cargo) && uses > 0)
		var/obj/machinery/computer/cargo/C = target
		C.independent = TRUE
		C.emag_act(user)
		uses = 0
		to_chat(user, "<span class='notice'>This supply console is now fully unlocked! It will trade with the Cargo Union and the syndicate alike.</span>")
		priority_announce("CentComm has received a memo from the Cargo Union that the supply department of this station is now independent. Security forces are ordered to quell the revolt.", title = "Cargo has declared independence", sound = 'sound/machines/alarm.ogg')
	else
		..()