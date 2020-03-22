/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user , proximity)
	. = ..()
	if(busy)
		return
	if(!proximity)
		return
	if(!target.reagents)
		return

	var/mob/living/L
	if(isliving(target))
		L = target
		if(!L.can_inject(user, 1))
			return

	// chance of monkey retaliation
	if(ismonkey(target) && prob(MONKEY_SYRINGE_RETALIATION_PROB))
		var/mob/living/carbon/monkey/M
		M = target
		M.retaliate(user)

	switch(mode)
		if(SYRINGE_DRAW)

			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, "<span class='notice'>The syringe is full.</span>")
				return

			if(L) //living mob
				var/drawn_amount = reagents.maximum_volume - reagents.total_volume
				if(target != user && user.a_intent != INTENT_HARM)
					target.visible_message("<span class='danger'>[user] is trying to take a blood sample from [target]!</span>", \
									"<span class='userdanger'>[user] is trying to take a blood sample from [target]!</span>")
					busy = TRUE
					if(!do_mob(user, target, extra_checks=CALLBACK(L, /mob/living/proc/can_inject,user,1)))
						busy = FALSE
						return
					if(reagents.total_volume >= reagents.maximum_volume)
						return
				busy = FALSE
				else
					if(iscarbon(target))
						var/mob/living/carbon/C = target
						C.visible_message("<span class='danger'>[user] stabbed [C] with \the [src]!</span>", \
										"<span class='userdanger'>[user] has stabbed [C] with \the [src]!</span>")
						C.apply_damage(damage = 5,damagetype = BRUTE, def_zone = C.get_bodypart(check_zone(user.zone_selected)), blocked = FALSE, forced = FALSE)
						if(reagents.total_volume >= reagents.maximum_volume)
							return
						if(!CALLBACK(L, /mob/living/proc/can_inject,user,1))
							return
				if(L.transfer_blood_to(src, drawn_amount))
					user.visible_message("[user] forcefully takes a blood sample from [L].")
				else
					to_chat(user, "<span class='warning'>You are unable to draw any blood from [L]!</span>")

			else //if not mob
				if(!target.reagents.total_volume)
					to_chat(user, "<span class='warning'>[target] is empty!</span>")
					return

				if(!target.is_drawable())
					to_chat(user, "<span class='warning'>You cannot directly remove reagents from [target]!</span>")
					return

				var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this) // transfer from, transfer to - who cares?

				to_chat(user, "<span class='notice'>You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units.</span>")
			if (round(reagents.total_volume, 0.1) >= reagents.maximum_volume)
				mode=!mode
				update_icon()

		if(SYRINGE_INJECT)
			// Always log attemped injections for admins
			var/contained = reagents.log_list()
			log_combat(user, target, "attempted to inject", src, addition="which had [contained]")

			if(!reagents.total_volume)
				to_chat(user, "<span class='notice'>[src] is empty.</span>")
				return

			if(!L && !target.is_injectable()) //only checks on non-living mobs, due to how can_inject() handles
				to_chat(user, "<span class='warning'>You cannot directly fill [target]!</span>")
				return

			if(target.reagents.total_volume >= target.reagents.maximum_volume)
				to_chat(user, "<span class='notice'>[target] is full.</span>")
				return

			if(L) //living mob
				if(!L.can_inject(user, TRUE))
					return
				if(L != user)
					if(user.a_intent != INTENT_HARM)
						L.visible_message("<span class='danger'>[user] is trying to inject [L]!</span>", \
												"<span class='userdanger'>[user] is trying to inject [L]!</span>")
						if(!do_mob(user, L, extra_checks=CALLBACK(L, /mob/living/proc/can_inject,user,1)))
							return
						if(!reagents.total_volume)
							return
						if(L.reagents.total_volume >= L.reagents.maximum_volume)
							return
						L.visible_message("<span class='danger'>[user] injects [L] with the syringe!", \
										"<span class='userdanger'>[user] injects [L] with the syringe!</span>")
					else
						if(iscarbon(target))
							var/mob/living/carbon/C = target
							C.visible_message("<span class='danger'>[user] stabs [L] with \the [src]!</span>", \
													"<span class='userdanger'>[user] stabs [L] with the [src]!</span>")
							C.apply_damage(damage = 5,damagetype = BRUTE, def_zone = C.get_bodypart(check_zone(user.zone_selected)), blocked = FALSE, forced = FALSE)
							if(!CALLBACK(L, /mob/living/proc/can_inject,user,1))
								return
							if(!reagents.total_volume)
								return
							if(C.reagents.total_volume >= L.reagents.maximum_volume)
								return
							C.visible_message("<span class='danger'>[user] forcefully injects [L] with the syringe!", \
												"<span class='userdanger'>[user] injects [L] forcefully with the syringe!</span>")

				if(L != user)
					log_combat(user, L, "injected", src, addition="which had [contained]")
				else
					L.log_message("injected themselves ([contained]) with [src.name]", LOG_ATTACK, color="orange")
			var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)
			reagents.reaction(L, INJECT, fraction)
			reagents.trans_to(target, amount_per_transfer_from_this)
			to_chat(user, "<span class='notice'>You inject [amount_per_transfer_from_this] units of the solution. The syringe now contains [reagents.total_volume] units.</span>")
			if (reagents.total_volume <= 0 && mode==SYRINGE_INJECT)
				mode = SYRINGE_DRAW
				update_icon()