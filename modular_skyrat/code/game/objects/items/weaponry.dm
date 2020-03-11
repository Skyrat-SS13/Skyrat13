/obj/item/switchblade/crafted
	icon_state = "switchblade_ms"
	desc = "A concealable spring-loaded knife."
	force = 2
	throwforce = 3
	extended_force = 15
	extended_throwforce = 18
	extended_icon_state = "switchblade_ext_ms"
	retracted_icon_state = "switchblade_ms"

/obj/item/switchblade/crafted/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/stack/sheet/mineral/silver))
		icon_state = extended ? "switchblade_ext_msf" : "switchblade_msf"
		extended_icon_state = "switchblade_ext_msf"
		retracted_icon_state = "switchblade_msf"
		icon_state = "switchblade_msf"
		to_chat(user, "<span class='notice'>You use part of the silver to improve your Switchblade. Stylish!</span>")
