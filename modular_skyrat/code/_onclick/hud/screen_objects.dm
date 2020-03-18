/obj/screen/skills
	name = "skills"
	icon = 'modular_skyrat/icons/mob/screen_midnight.dmi'
	icon_state = "skills"
	screen_loc = ui_skill_menu

/obj/screen/skills/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.mind.print_levels(H)