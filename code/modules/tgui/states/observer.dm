<<<<<<< HEAD
 /**
  * tgui state: observer_state
  *
  * Checks that the user is an observer/ghost.
 **/
=======
/**
 * tgui state: observer_state
 *
 * Checks that the user is an observer/ghost.
 *
 * Copyright (c) 2020 Aleksej Komarov
 * SPDX-License-Identifier: MIT
 */
>>>>>>> f20f01cc6b... Merge pull request #12853 from LetterN/TGUI-4

GLOBAL_DATUM_INIT(observer_state, /datum/ui_state/observer_state, new)

/datum/ui_state/observer_state/can_use_topic(src_object, mob/user)
	if(isobserver(user))
		return UI_INTERACTIVE
	return UI_CLOSE

