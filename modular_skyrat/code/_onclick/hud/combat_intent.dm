/obj/screen/combat_intent
	name = "combat intent"
	icon = 'modular_skyrat/icons/mob/combat_intents.dmi'
	icon_state = CI_DEFAULT
	var/expanded = FALSE
	var/mutable_appearance/switch_appearance

/obj/screen/combat_intent/Initialize()
	. = ..()
	switch_appearance = mutable_appearance('modular_skyrat/icons/mob/combat_style.dmi', "combat_style", layer, plane)
	switch_appearance.pixel_y = pixel_y + 32
	switch_appearance.pixel_x = pixel_x - 16

/obj/screen/combat_intent/Click(location, control, params)
	. = ..()
	var/mob/living/carbon/user = usr
	if(!expanded)
		expanded = TRUE
	else
		var/list/PL = params2list(params)
		var/icon_x = text2num(PL["icon-x"])
		var/icon_y = text2num(PL["icon-y"])
		switch(icon_x)
			if(0 to 32)
				switch(icon_y)
					if(33 to 39)
						user.switch_combat_intent(CI_FEINT)
					if(40 to 46)
						user.switch_combat_intent(CI_DUAL)
					if(47 to 53)
						user.switch_combat_intent(CI_GUARD)
					if(54 to 60)
						user.switch_combat_intent(CI_DEFEND)
					if(61 to 67)
						user.switch_combat_intent(CI_STRONG)
					if(68 to 74)
						user.switch_combat_intent(CI_FURIOUS)
					if(75 to 81)
						user.switch_combat_intent(CI_AIMED)
					if(82 to 88)
						user.switch_combat_intent(CI_WEAK)
					else
						expanded = FALSE
	update_icon_state()
	update_overlays()

/obj/screen/combat_intent/update_icon_state()
	. = ..()
	if(hud?.mymob && iscarbon(hud.mymob))
		var/mob/living/carbon/owner = hud.mymob
		icon_state = owner.combat_intent

/obj/screen/combat_intent/update_overlays()
	. = ..()
	cut_overlays()
	if(expanded && switch_appearance)
		add_overlay(switch_appearance)
