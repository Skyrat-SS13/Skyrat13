<<<<<<< HEAD
 /**
  * tgui state: conscious_state
  *
  * Only checks if the user is conscious.
 **/
=======
/**
 * tgui state: conscious_state
 *
 * Only checks if the user is conscious.
 *
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4

GLOBAL_DATUM_INIT(conscious_state, /datum/ui_state/conscious_state, new)

/datum/ui_state/conscious_state/can_use_topic(src_object, mob/user)
	if(user.stat == CONSCIOUS)
		return UI_INTERACTIVE
	return UI_CLOSE
