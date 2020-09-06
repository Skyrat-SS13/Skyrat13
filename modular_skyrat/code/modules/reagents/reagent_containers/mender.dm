//Auto-mender, ported from goonstation. Of course, it works differently here, since it embeds.
/obj/item/reagent_containers/mender
	name = "Mk. I Auto-mender"
	desc = "A small electronic device designed to apply healing chemicals over time."
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "mender"
	volume = 50
	embedding = list("pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE, "embed_chance" = 70, "fall_chance" = 0)
	possible_transfer_amounts = list(0.5,1,2)
	var/lesser = FALSE
	var/icon_inactive = "mender"
	var/icon_active = "mender-active"
	var/application_method = TOUCH
	var/mob/living/carbon/attached_mob
	var/mutable_appearance/chem_overlay
	container_flags = APTFT_VERB | APTFT_ALTCLICK

/obj/item/reagent_containers/mender/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Ctrl-click to change reagent application method.</span>"
	. += "<span class='notice'>\The [src] is currently applying reagents via [application_method == TOUCH ? "touch" : "injection"].</span>"

/obj/item/reagent_containers/mender/on_reagent_change(changetype)
	. = ..()
	update_overlays()

/obj/item/reagent_containers/mender/CtrlClick(mob/user)
	var/mob/living/userr = user
	if(!istype(userr) || !userr.canUseTopic(src, TRUE))
		return
	if(application_method == TOUCH)
		application_method = INJECT
	else
		application_method = TOUCH
	to_chat(user, "<span class='notice'>\The [src] will now apply via [application_method == TOUCH ? "touch" : "injection"].</span>")

/obj/item/reagent_containers/mender/Initialize(mapload, vol)
	..()
	if(lesser && reagents)
		reagents.reagents_holder_flags = AMOUNT_VISIBLE
	else if(reagents)
		reagents.reagents_holder_flags = OPENCONTAINER
	RegisterSignal(src, COMSIG_ITEM_ON_EMBED_REMOVAL, .proc/on_embed_removal)
	update_icon()
	update_overlays()

/obj/item/reagent_containers/mender/update_icon()
	. = ..()
	if(attached_mob)
		icon_state = icon_active
	else
		icon_state = icon_inactive
	update_overlays()

/obj/item/reagent_containers/mender/update_overlays()
	. = ..()
	cut_overlay(chem_overlay)
	chem_overlay = null
	var/chem_color = "#FFFFFF"
	if(reagents?.total_volume)
		chem_color = mix_color_from_reagents(reagents.reagent_list)
	if(attached_mob)
		chem_overlay = mutable_appearance(icon, "mender-overlay-active", color = chem_color)
	else
		chem_overlay = mutable_appearance(icon, "mender-overlay", color = chem_color)

	if(chem_overlay)
		var/mutable_appearance/broje = mutable_appearance(icon, "mender-fluid", color = chem_color)
		chem_overlay.add_overlay(broje)
	
	if(chem_overlay)
		add_overlay(chem_overlay)

/obj/item/reagent_containers/mender/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ITEM_ON_EMBED_REMOVAL)

/obj/item/reagent_containers/mender/attack(mob/M, mob/user, def_zone)
	. = ..()
	if(!reagents.total_volume)
		to_chat(user, "<span class='warning'>\The [src] is empty!</span>")
		return
	if(!iscarbon(M))
		to_chat(user, "<span class='warning'>\The [src] cannot embed itself to \the [M]!</span>")
		return
	if(INTERACTING_WITH(user, M))
		to_chat(user, "<span class='warning'>You are already interacting with \the [M]!</span>")
		return
	var/delay_mod = (user == M ? 2 : 1)
	var/mob/living/carbon/C = M
	var/obj/item/bodypart/sticky_bp = C.get_bodypart(user.zone_selected)
	if(!sticky_bp)
		to_chat(user, "<span class='warning'>\The [M] has no [parse_zone(user.zone_selected)]!</span>")
		return
	if(length(sticky_bp.embedded_objects))
		to_chat(user, "<span class='warning'>\The [M] already has something stuck to [M.p_their()] [sticky_bp.name]!</span>")
		return
	user.visible_message("<span class='notice'>\The [user] tries to stick \the [src] onto [M]'s [sticky_bp.name]...</span>")
	if(!do_mob(user, M, delay_mod * 3 SECONDS))
		to_chat(user, "<span class='notice'>You fail to stick \the [src] to \the [M].</span>")
		return
	tryEmbed(target = sticky_bp, silent = TRUE)

/obj/item/reagent_containers/mender/embedded(atom/embedded_target)
	if(iscarbon(embedded_target))
		attached_mob = embedded_target
		update_overlays()
		START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/mender/proc/on_embed_removal()
	attached_mob = null
	update_overlays()

/obj/item/reagent_containers/mender/process()
	if(!reagents?.total_volume || !attached_mob)
		STOP_PROCESSING(SSobj, src)
		attached_mob.remove_embedded_object(src)
		return
	reagents.reaction(attached_mob, application_method, amount_per_transfer_from_this, FALSE)
	reagents.trans_to(attached_mob, application_method)
	reagents.remove_any(amount_per_transfer_from_this)
	playsound(attached_mob, pick('modular_skyrat/sound/effects/mender.ogg', 'modular_skyrat/sound/effects/mender2.ogg'), 50, 1)

//CMO automender, with extended capacity
/obj/item/reagent_containers/mender/cmo
	name = "Mk. II Auto-mender"
	desc = "An advanced model of the Deforest Co. Auto-mender, with extended reagent capacity and application power."
	volume = 100
	possible_transfer_amounts = list(0.25,0.5,1,2,4)
	icon_inactive = "mender-cmo"
	icon_active = "mender-cmo-active"

//Subtype used for adding auto-menders to medkits etc
/obj/item/reagent_containers/mender/lesser
	name = "Emergency Auto-mender"
	desc = "A cheap, low-quality and mass-produced auto-mender. Cannot load new reagents, and is only capable of holding 35u of reagents."
	volume = 35
	lesser = TRUE
