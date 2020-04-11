/mob/living/proc/flash_message_indicator(var/state)
	INVOKE_ASYNC(GLOBAL_PROC, /proc/flick_overlay_view, image('modular_skyrat/icons/mob/message_indicator.dmi', src, state,FLY_LAYER), src, 30)