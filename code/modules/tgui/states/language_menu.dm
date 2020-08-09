<<<<<<< HEAD
 /**
  * tgui state: language_menu_state
  */
=======
/**
 * tgui state: language_menu_state
 *
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4

GLOBAL_DATUM_INIT(language_menu_state, /datum/ui_state/language_menu, new)

/datum/ui_state/language_menu/can_use_topic(src_object, mob/user)
	. = UI_CLOSE
	if(check_rights_for(user.client, R_ADMIN))
		. = UI_INTERACTIVE
	else if(istype(src_object, /datum/language_menu))
		var/datum/language_menu/LM = src_object
		if(LM.language_holder.get_atom() == user)
			. = UI_INTERACTIVE
