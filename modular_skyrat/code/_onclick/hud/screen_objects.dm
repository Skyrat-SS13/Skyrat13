/obj/screen/human/pain
	name = "pain"
	icon_state = "pain0"
	screen_loc = ui_pain

/obj/screen/human/pain/Click(location, control, params)
	var/mob/living/carbon/C = usr
	if(istype(C))
		C.print_pain()
