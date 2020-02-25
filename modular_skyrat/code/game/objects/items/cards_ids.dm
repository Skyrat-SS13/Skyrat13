/obj/item/card/emag/independence
	name = "Declaration of independence"
	desc = "Use it on a supply shuttle to free cargonia!"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	uses = 1

/obj/item/card/emag/independence/afterattack(atom/target, mob/user, proximity)
	if(proximity)
		if(istype(target, /obj/machinery/computer/cargo))
			var/obj/machinery/computer/cargo/C = target
			C.independent = TRUE
			C.emag_act(user)
			priority_announce("The Cargo Union has declared the supply department independent of NT! All trades will now be done with them!", title = "Declaration of Independence", sound = "intercept", "Priority" , "Cargo Union")
		else
			..()
	else
		..()