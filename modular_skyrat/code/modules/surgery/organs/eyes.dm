/obj/item/organ/eyes/robotic/glow/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = FALSE)
    RegisterSignal(M,COMSIG_LIVING_STATUS_UNCONSCIOUS,.proc/deactivate)
    . = ..()
	// makes High lum eyes depower upon conciousness loss
