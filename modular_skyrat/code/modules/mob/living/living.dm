/mob/living
	var/datum/gunpoint/gunpointing
	var/list/gunpointed = list()
	var/obj/effect/overlay/gunpoint_effect/gp_effect
	var/list/recent_embeds = list()
	var/embed_timer
	var/list/chem_effects = list()

/mob/living/proc/wield_active_hand()
	return

/mob/living/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_MOB_EXAMINED, .proc/on_examine_atom)

/mob/living/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_MOB_EXAMINED)

/mob/living/proc/on_examine_atom(atom/examined)
	if(!istype(examined) || !client)
		return

	if(get_dist(src, examined) > EYE_CONTACT_RANGE)
		return
	
	visible_message(message = "<span class='notice'>\The [src] examines [examined].</span>", vision_distance = 2)
