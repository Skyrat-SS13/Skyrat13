/obj/item/stack/sticky_tape
	name = "sticky tape"
	singular_name = "sticky tape"
	desc = "Used for sticking to things for sticking said things to people."
	icon = 'modular_skyrat/icons/obj/tapes.dmi'
	icon_state = "tape_w"
	var/prefix = "sticky"
	item_flags = NOBLUDGEON
	amount = 5
	max_amount = 5
	resistance_flags = FLAMMABLE
	grind_results = list(/datum/reagent/cellulose = 5)

	var/list/conferred_embed = EMBED_HARMLESS
	var/overwrite_existing = FALSE
	w_class = WEIGHT_CLASS_TINY
	splint_factor = 0.8

//used for taping people's mouths shut
/obj/item/stack/sticky_tape/proc/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = ""
	to_chat(source, "<span class='warning'>You try to speak, but \the [src] prevents you!</span>")

/obj/item/stack/sticky_tape/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!istype(target, /obj/item))
		if(iscarbon(target) && user.a_intent == INTENT_GRAB && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
			var/mob/living/carbon/C = target
			var/obj/item/bodypart/head/shoeonhead = C.get_bodypart(BODY_ZONE_HEAD)
			if(istype(shoeonhead) && C.wear_mask)
				C.visible_message(message = "<span class='danger'>[user] tries to tape [C]'s mouth closed with \the [src]!</span>", self_message = "<span class='userdanger'>[user] tries to tape your mouth closed with \the [src]!</span>", ignored_mobs = list(user))
				to_chat(user, "<span class='warning'>You try to gag [C] with \the [src]!</span>")
				if(do_after_mob(user, C, 4 SECONDS))
					shoeonhead.get_stickied(src, user)
				else
					to_chat(user, "<span class='warning'>You fail to gag \the [C] with \the [src].</span>")
		return
	
	var/obj/item/I = target

	if(I.embedding && I.embedding == conferred_embed)
		to_chat(user, "<span class='warning'>[I] is already coated in [src]!</span>")
		return

	user.visible_message("<span class='notice'>[user] begins wrapping [I] with [src].</span>", "<span class='notice'>You begin wrapping [I] with [src].</span>")

	if(do_after(user, 30, target=I))
		I.embedding = conferred_embed
		I.updateEmbedding()
		to_chat(user, "<span class='notice'>You finish wrapping [I] with [src].</span>")
		use(1)
		I.name = "[prefix] [I.name]"

		if(istype(I, /obj/item/grenade))
			var/obj/item/grenade/sticky_bomb = I
			sticky_bomb.sticky = TRUE

/obj/item/stack/sticky_tape/super
	name = "super sticky tape"
	singular_name = "super sticky tape"
	desc = "Quite possibly the most mischevious substance in the galaxy. Use with extreme lack of caution."
	icon_state = "tape_y"
	prefix = "super sticky"
	conferred_embed = EMBED_HARMLESS_SUPERIOR

/obj/item/stack/sticky_tape/pointy
	name = "pointy tape"
	singular_name = "pointy tape"
	desc = "Used for sticking to things for sticking said things inside people."
	icon_state = "tape_evil"
	prefix = "pointy"
	conferred_embed = EMBED_POINTY

/obj/item/stack/sticky_tape/pointy/super
	name = "super pointy tape"
	singular_name = "super pointy tape"
	desc = "You didn't know tape could look so sinister. Welcome to Space Station 13."
	icon_state = "tape_spikes"
	prefix = "super pointy"
	conferred_embed = EMBED_POINTY_SUPERIOR

/obj/item/stack/sticky_tape/surgical
	name = "surgical tape"
	singular_name = "surgical tape"
	desc = "Made for patching broken bones back together alongside bone gel, not for playing pranks."
	//icon_state = "tape_spikes"
	prefix = "surgical"
	conferred_embed = list("embed_chance" = 30, "pain_mult" = 0, "jostle_pain_mult" = 0, "ignore_throwspeed_threshold" = TRUE)
	splint_factor = 0.4
	custom_price = 500

/obj/item/stack/sticky_tape/infinite //endless tape that applies far faster, for maximum honks
	name = "endless sticky tape"
	desc = "This roll of sticky tape somehow has no end."
	endless = TRUE
	apply_time = 10
