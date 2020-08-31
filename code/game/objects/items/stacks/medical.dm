#define MODE_MULTIPLE "multiple limbs"
#define MODE_SINGULAR "single limb"

/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'modular_skyrat/icons/obj/stack_objects.dmi'
	amount = 15
	max_amount = 15
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	resistance_flags = FLAMMABLE
	max_integrity = 40
	novariants = FALSE
	item_flags = NOBLUDGEON
	var/self_delay = 50
	var/other_delay = 10
	var/repeating = TRUE
	/// How much brute we heal per application
	var/heal_brute
	/// How much burn we heal per application
	var/heal_burn
	/// How much we heal stamina on application
	var/heal_stamina
	/// How much we reduce bleeding per application on cut wounds
	var/stop_bleeding
	/// How much sanitization to apply to burns on application
	var/sanitization
	/// How much we add to flesh_healing for burn wounds on application
	var/flesh_regeneration
	/// The limb status flags we require to be applicable on a limb
	var/required_status = BODYPART_ORGANIC
	/// What mode we're on (multiple limbs, singular limb)
	var/mode = MODE_MULTIPLE
	/// Cost per limb to apply healing
	var/stackperlimb = 1

/obj/item/stack/medical/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Ctrl-click \the [src] to change it's mode!</span>"
	. += "<span class='notice'>Currently set to <b>[mode]</b> mode.</span>"

/obj/item/stack/medical/CtrlClick(mob/living/user)
	switch(mode)
		if(MODE_MULTIPLE)
			mode = MODE_SINGULAR
		if(MODE_SINGULAR)
			mode = MODE_MULTIPLE
	to_chat(user, "<span class='notice'>You set \the [src] to <b>[mode]</b> mode.")

/obj/item/stack/medical/attack(mob/living/M, mob/user)
	. = ..()
	if(!INTERACTING_WITH(user, M))
		try_heal(M, user)
	else
		to_chat(user, "<span class='warning'>You're already interacting with \the [M]!")

/obj/item/stack/medical/proc/try_heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	if(!M.can_inject(user, TRUE))
		return
	if(M == user)
		if(!silent)
			user.visible_message("<span class='notice'>[user] starts to apply \the [src] on [user.p_them()]self...</span>", "<span class='notice'>You begin applying \the [src] on yourself...</span>")
		if(!do_mob(user, M, self_delay, extra_checks=CALLBACK(M, /mob/living/proc/can_inject, user, TRUE)))
			return
	else if(other_delay)
		if(!silent)
			user.visible_message("<span class='notice'>[user] starts to apply \the [src] on [M].</span>", "<span class='notice'>You begin applying \the [src] on [M]...</span>")
		if(!do_mob(user, M, other_delay, extra_checks=CALLBACK(M, /mob/living/proc/can_inject, user, TRUE)))
			return

	if(heal(M, user))
		log_combat(user, M, "healed", src.name)
		if(repeating && amount > 0)
			try_heal(M, user, TRUE)

/obj/item/stack/medical/proc/heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	return

/obj/item/stack/medical/proc/heal_carbon(mob/living/carbon/C, mob/user, brute, burn, silent = FALSE, affect_children = FALSE, obj/item/bodypart/specific_part)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(specific_part)
		affecting = specific_part
	if(!affecting) //Missing limb?
		if(!silent)
			to_chat(user, "<span class='warning'>[C] doesn't have \a [parse_zone(user.zone_selected)]!</span>")
		return
	if(!(affecting.status & required_status)) //Limb must satisfy these status requirements
		if(!silent)
			to_chat(user, "<span class='warning'>\The [src] won't work on a robotic limb!</span>")
		return
	if(affecting.brute_dam && brute || affecting.burn_dam && burn)
		if(!silent)
			user.visible_message("<span class='green'>[user] applies \the [src] on [C]'s [affecting.name].</span>", "<span class='green'>You apply \the [src] on [C]'s [affecting.name].</span>")
		var/brute2heal = brute
		var/burn2heal = burn
		if(affecting.heal_damage(brute2heal, burn2heal, heal_stamina, FALSE, FALSE, TRUE))
			C.update_damage_overlays()
		use(stackperlimb)
		if(affect_children)
			if(length(affecting.heal_zones))
				var/childcount = 0
				for(var/bodypart in affecting.heal_zones)
					var/obj/item/bodypart/child = C.get_bodypart(bodypart)
					if(!child)
						continue
					heal_carbon(C, user, brute, burn, TRUE, FALSE, child)
					childcount++
					if(childcount >= 2)
						break
		return TRUE
	if(!silent)
		to_chat(user, "<span class='warning'>[C]'s [affecting.name] can not be healed with \the [src]!</span>")

/obj/item/stack/medical/bruise_pack
	name = "bruise pack"
	singular_name = "bruise pack"
	desc = "A therapeutic gel pack and bandages designed to treat blunt-force trauma."
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	heal_brute = 40
	self_delay = 40
	other_delay = 20
	amount = 12
	max_amount = 12
	grind_results = list(/datum/reagent/medicine/styptic_powder = 10)

/obj/item/stack/medical/bruise_pack/one
	amount = 1

/obj/item/stack/medical/bruise_pack/heal(mob/living/M, mob/user, silent = FALSE)
	if(M.stat == DEAD)
		if(!silent)
			to_chat(user, "<span class='warning'>[M] is dead! You can not help [M.p_them()].</span>")
		return
	if(isanimal(M))
		var/mob/living/simple_animal/critter = M
		if (!(critter.healable))
			if(!silent)
				to_chat(user, "<span class='warning'>You cannot use \the [src] on [M]!</span>")
			return FALSE
		else if (critter.health >= critter.maxHealth)
			if(!silent)
				to_chat(user, "<span class='notice'>[M] is at full health.</span>")
			return FALSE
		if(!silent)
			user.visible_message("<span class='green'>[user] applies \the [src] on [M].</span>", "<span class='green'>You apply \the [src] on [M].</span>")
		M.heal_bodypart_damage((heal_brute/2))
		use(stackperlimb)
		return TRUE
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, heal_burn, FALSE, (mode == MODE_MULTIPLE ? TRUE : FALSE))
	if(!silent)
		to_chat(user, "<span class='warning'>You can't heal [M] with \the [src]!</span>")

/obj/item/stack/medical/bruise_pack/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is bludgeoning [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/stack/medical/gauze
	name = "medical gauze"
	desc = "A roll of elastic cloth, perfect for stabilizing all kinds of wounds, from cuts and burns, to broken bones. "
	gender = PLURAL
	singular_name = "medical gauze"
	icon_state = "gauze"
	self_delay = 50
	other_delay = 20
	amount = 15
	max_amount = 15
	custom_price = PRICE_EXPENSIVE
	absorption_rate = 0.25
	absorption_capacity = 5
	splint_factor = 0.35
	custom_price = PRICE_REALLY_CHEAP

// gauze is only relevant for wounds, which are handled in the wounds themselves
/obj/item/stack/medical/gauze/try_heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	var/obj/item/bodypart/limb = M.get_bodypart(check_zone(user.zone_selected))
	if(specific_part)
		limb = specific_part
	if(!limb)
		if(!silent)
			to_chat(user, "<span class='notice'>There's nothing there to bandage!</span>")
		return
	
	if(!LAZYLEN(limb.wounds))
		if(!silent)
			to_chat(user, "<span class='notice'>There's no wounds that require bandaging on [user==M ? "your" : "[M]'s"] [limb.name]!</span>") // good problem to have imo
		return
	
	var/gauzeable_wound = FALSE
	for(var/i in limb.wounds)
		var/datum/wound/W = i
		if(W.accepts_gauze)
			gauzeable_wound = TRUE
			break
	if(!gauzeable_wound)
		if(!silent)
			to_chat(user, "<span class='notice'>There's no wounds that require bandaging on [user==M ? "your" : "[M]'s"] [limb.name]!</span>") // good problem to have imo
		return

	if(limb.current_gauze && (limb.current_gauze.absorption_capacity * 0.8 > absorption_capacity)) // ignore if our new wrap is < 20% better than the current one, so someone doesn't bandage it 5 times in a row
		if(!silent)
			to_chat(user, "<span class='warning'>The bandage currently on [user==M ? "your" : "[M]'s"] [limb.name] is still in good condition!</span>")
		return

	if(!silent)
		user.visible_message("<span class='warning'>[user] begins wrapping the wounds on [M]'s [limb.name] with [src]...</span>", "<span class='warning'>You begin wrapping the wounds on [user == M ? "your" : "[M]'s"] [limb.name] with [src]...</span>")
	var/time_mod = 1
	if(!do_after(user, (user == M ? self_delay : other_delay) * time_mod, target=M))
		return

	if(!silent)
		user.visible_message("<span class='green'>[user] applies [src] to [M]'s [limb.name].</span>", "<span class='green'>You bandage the wounds on [user == M ? "yourself" : "[M]'s"] [limb.name].</span>")
	limb.apply_gauze(src)
	if(mode == MODE_MULTIPLE)
		var/childcount = 0
		for(var/bodypart in limb.heal_zones)
			var/obj/item/bodypart/child = M.get_bodypart(bodypart)
			if(!child)
				continue
			try_heal(M, user, silent, child, TRUE)
			childcount++
			if(childcount >= 2)
				break

/obj/item/stack/medical/gauze/twelve
	amount = 12

/obj/item/stack/medical/gauze/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		if(get_amount() < 2)
			to_chat(user, "<span class='warning'>You need at least two gauzes to do this!</span>")
			return
		new /obj/item/stack/sheet/cloth(user.drop_location())
		user.visible_message("<span class='notice'>[user] cuts [src] into pieces of cloth with [I].</span>", \
					 "<span class='notice'>You cut [src] into pieces of cloth with [I].</span>", \
					 "<span class='hear'>You hear cutting.</span>")
		use(2)
	else if(I.is_drainable() && I.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine))
		if(!I.reagents.has_reagent(/datum/reagent/space_cleaner/sterilizine, 5))
			to_chat(user, "<span class='warning'>There's not enough sterilizine in [I] to sterilize [src]!</span>")
			return
		user.visible_message("<span class='notice'>[user] pours the contents of [I] onto [src], sterilizing it.</span>", "<span class='notice'>You pour the contents of [I] onto [src], sterilizing it.</span>")
		I.reagents.remove_reagent(/datum/reagent/space_cleaner/sterilizine, 5)
		new /obj/item/stack/medical/gauze/adv/one(user.drop_location())
		use(1)
	else
		return ..()

/obj/item/stack/medical/gauze/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] begins tightening \the [src] around [user.p_their()] neck! It looks like [user.p_they()] forgot how to use medical supplies!</span>")
	return OXYLOSS

/obj/item/stack/medical/gauze/improvised
	name = "improvised gauze"
	singular_name = "improvised gauze"
	desc = "A roll of cloth roughly cut from something that does a decent job of stabilizing wounds, but less efficiently so than real medical gauze."
	self_delay = 60
	other_delay = 30
	absorption_rate = 0.15
	absorption_capacity = 4

/obj/item/stack/medical/gauze/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/gauze/adv
	name = "sterilized medical gauze"
	desc = "A roll of elastic sterilized cloth that is extremely effective at stopping bleeding, heals minor wounds and cleans them."
	singular_name = "sterilized medical gauze"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "adv_gauze"
	heal_brute = 6
	self_delay = 40
	other_delay = 15
	absorption_rate = 0.4
	absorption_capacity = 6

/obj/item/stack/medical/gauze/adv/one
	amount = 1

/obj/item/stack/medical/suture
	name = "suture"
	desc = "Basic sterile sutures used to seal up cuts and lacerations and stop bleeding."
	gender = PLURAL
	singular_name = "suture"
	icon_state = "suture"
	self_delay = 30
	other_delay = 10
	amount = 15
	max_amount = 15
	repeating = TRUE
	heal_brute = 10
	stop_bleeding = 0.6
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)

/obj/item/stack/medical/suture/one
	amount = 1

/obj/item/stack/medical/suture/five
	amount = 5

/obj/item/stack/medical/suture/emergency
	name = "emergency suture"
	desc = "A value pack of cheap sutures, not very good at repairing damage, but still decent at stopping bleeding."
	heal_brute = 5
	amount = 5
	max_amount = 5

/obj/item/stack/medical/suture/medicated
	name = "medicated suture"
	icon_state = "suture_purp"
	desc = "A suture infused with drugs that speed up wound healing of the treated laceration."
	heal_brute = 15
	stop_bleeding = 0.75
	grind_results = list(/datum/reagent/medicine/polypyr = 2)

/obj/item/stack/medical/suture/one
	amount = 1

/obj/item/stack/medical/suture/heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	. = ..()
	if(M.stat == DEAD)
		if(!silent)
			to_chat(user, "<span class='warning'>[M] is dead! You can not help [M.p_them()].</span>")
		return
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, heal_burn, FALSE, (mode == MODE_MULTIPLE ? TRUE : FALSE))
	if(isanimal(M))
		var/mob/living/simple_animal/critter = M
		if (!(critter.healable))
			if(!silent)
				to_chat(user, "<span class='warning'>You cannot use \the [src] on [M]!</span>")
			return FALSE
		else if (critter.health >= critter.maxHealth)
			if(!silent)
				to_chat(user, "<span class='notice'>[M] is at full health.</span>")
			return FALSE
		if(!silent)
			user.visible_message("<span class='green'>[user] applies \the [src] on [M].</span>", "<span class='green'>You apply \the [src] on [M].</span>")
		M.heal_bodypart_damage(heal_brute)
		use(stackperlimb)
		return TRUE

	to_chat(user, "<span class='warning'>You can't heal [M] with \the [src]!</span>")

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Basic burn ointment, rated effective for second degree burns with proper bandaging, though it's still an effective stabilizer for worse burns. Not terribly good at outright healing burns though."
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount = 12
	max_amount = 12
	self_delay = 40
	other_delay = 20
	amount = 12
	max_amount = 12
	heal_burn = 5
	flesh_regeneration = 2.5
	sanitization = 0.25
	grind_results = list(/datum/reagent/medicine/silver_sulfadiazine = 10)

/obj/item/stack/medical/ointment/one
	amount = 1

/obj/item/stack/medical/ointment/heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	if(M.stat == DEAD)
		if(!silent)
			to_chat(user, "<span class='warning'>[M] is dead! You can not help [M.p_them()].</span>")
		return
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, heal_burn, FALSE, (mode == MODE_MULTIPLE ? TRUE : FALSE))
	if(!silent)
		to_chat(user, "<span class='warning'>You can't heal [M] with \the [src]!</span>")

/obj/item/stack/medical/ointment/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is squeezing \the [src] into [user.p_their()] mouth! [user.p_do(TRUE)]n't [user.p_they()] know that stuff is toxic?</span>")
	return TOXLOSS

/obj/item/stack/medical/mesh
	name = "regenerative mesh"
	desc = "A bacteriostatic mesh used to dress burns."
	gender = PLURAL
	singular_name = "regenerative mesh"
	icon_state = "regen_mesh"
	self_delay = 30
	other_delay = 10
	amount = 15
	heal_burn = 10
	max_amount = 15
	repeating = TRUE
	sanitization = 0.75
	flesh_regeneration = 3
	var/is_open = TRUE ///This var determines if the sterile packaging of the mesh has been opened.
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)

/obj/item/stack/medical/mesh/one
	amount = 1

/obj/item/stack/medical/mesh/five
	amount = 5

/obj/item/stack/medical/mesh/advanced
	name = "advanced regenerative mesh"
	desc = "An advanced mesh made with aloe extracts and sterilizing chemicals, used to treat burns."
	gender = PLURAL
	singular_name = "advanced regenerative mesh"
	icon_state = "aloe_mesh"
	heal_burn = 15
	grind_results = list(/datum/reagent/consumable/aloejuice = 1)

/obj/item/stack/medical/mesh/advanced/one
	amount = 1

/obj/item/stack/medical/mesh/Initialize()
	. = ..()
	if(amount == max_amount)	 //only seal full mesh packs
		is_open = FALSE
		update_icon()

/obj/item/stack/medical/mesh/advanced/update_icon_state()
	if(!is_open)
		icon_state = "aloe_mesh_closed"
	else
		return ..()

/obj/item/stack/medical/mesh/update_icon_state()
	if(!is_open)
		icon_state = "regen_mesh_closed"
	else
		return ..()

/obj/item/stack/medical/mesh/heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	. = ..()
	if(M.stat == DEAD)
		if(!silent)
			to_chat(user, "<span class='warning'>[M] is dead! You can not help [M.p_them()].</span>")
		return
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, heal_burn, FALSE, (mode == MODE_MULTIPLE ? TRUE : FALSE))
	if(!silent)
		to_chat(user, "<span class='warning'>You can't heal [M] with \the [src]!</span>")


/obj/item/stack/medical/mesh/try_heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	if(!is_open)
		if(!silent)
			to_chat(user, "<span class='warning'>You need to open [src] first.</span>")
		return
	. = ..()

/obj/item/stack/medical/mesh/AltClick(mob/living/user)
	if(!is_open)
		to_chat(user, "<span class='warning'>You need to open [src] first.</span>")
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_hand(mob/user)
	if(!is_open && user.get_inactive_held_item() == src)
		to_chat(user, "<span class='warning'>You need to open [src] first.</span>")
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_self(mob/user)
	if(!is_open)
		is_open = TRUE
		to_chat(user, "<span class='notice'>You open the sterile mesh package.</span>")
		update_icon()
		playsound(src, 'sound/items/poster_ripped.ogg', 20, TRUE)
		return
	. = ..()

/obj/item/stack/medical/mesh/advanced
	name = "advanced regenerative mesh"
	desc = "An advanced mesh made with aloe extracts and sterilizing chemicals, used to treat burns."
	gender = PLURAL
	singular_name = "advanced regenerative mesh"
	icon_state = "aloe_mesh"
	heal_burn = 15
	sanitization = 1.25
	flesh_regeneration = 3.5
	grind_results = list(/datum/reagent/consumable/aloejuice = 5)

/obj/item/stack/medical/mesh/advanced/one
	amount = 1

/obj/item/stack/medical/mesh/advanced/update_icon_state()
	if(!is_open)
		icon_state = "aloe_mesh_closed"
	else
		return ..()

/obj/item/stack/medical/aloe
	name = "aloe cream"
	desc = "A healing paste you can apply on wounds."

	icon_state = "aloe_paste"
	self_delay = 20
	other_delay = 10
	novariants = TRUE
	amount = 15
	max_amount = 15
	var/heal = 3
	grind_results = list(/datum/reagent/consumable/aloejuice = 1)

/obj/item/stack/medical/aloe/heal(mob/living/M, mob/user, silent = FALSE, obj/item/bodypart/specific_part)
	. = ..()
	if(M.stat == DEAD)
		if(!silent)
			to_chat(user, "<span class='warning'>[M] is dead! You can not help [M.p_them()].</span>")
		return FALSE
	if(iscarbon(M))
		return heal_carbon(M, user, heal, heal, FALSE, (mode == MODE_MULTIPLE ? TRUE : FALSE))
	if(isanimal(M))
		var/mob/living/simple_animal/critter = M
		if (!(critter.healable))
			if(!silent)
				to_chat(user, "<span class='warning'>You cannot use \the [src] on [M]!</span>")
			return FALSE
		else if (critter.health >= critter.maxHealth)
			if(!silent)
				to_chat(user, "<span class='notice'>[M] is at full health.</span>")
			return FALSE
		if(!silent)
			user.visible_message("<span class='green'>[user] applies \the [src] on [M].</span>", "<span class='green'>You apply \the [src] on [M].</span>")
		M.heal_bodypart_damage(heal, heal)
		use(stackperlimb)
		return TRUE

	if(!silent)
		to_chat(user, "<span class='warning'>You can't heal [M] with the \the [src]!</span>")

/*
The idea is for these medical devices to work like a hybrid of the old brute packs and tend wounds,
they heal a little at a time, have reduced healing density and does not allow for rapid healing while in combat.
However they provice graunular control of where the healing is directed, this makes them better for curing work-related cuts and scrapes.

The interesting limb targeting mechanic is retained and i still believe they will be a viable choice, especially when healing others in the field.
*/

/obj/item/stack/medical/bone_gel
	name = "bone gel"
	singular_name = "bone gel"
	desc = "A potent medical gel that, when applied to a damaged bone in a proper surgical setting, triggers an intense melding reaction to repair the wound. Can be directly applied alongside surgical sticky tape to a broken bone in dire circumstances, though this is very harmful to the patient and not recommended."

	icon = 'icons/obj/surgery.dmi'
	icon_state = "bone-gel"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

	amount = 10
	max_amount = 10
	self_delay = 60
	other_delay = 40
	grind_results = list(/datum/reagent/medicine/styptic_powder = 10, /datum/reagent/potassium = 10, /datum/reagent/space_cleaner/sterilizine = 10)
	novariants = TRUE

/obj/item/stack/medical/bone_gel/attack(mob/living/M, mob/user)
	to_chat(user, "<span class='warning'>Bone gel can only be used on fractured limbs!</span>")
	return

/obj/item/stack/medical/bone_gel/suicide_act(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.visible_message("<span class='suicide'>[C] is squirting all of \the [src] into [C.p_their()] mouth! That's not proper procedure! It looks like [C.p_theyre()] trying to commit suicide!</span>")
		if(do_after(C, 2 SECONDS))
			C.emote("scream")
			for(var/i in C.bodyparts)
				var/obj/item/bodypart/bone = i
				var/datum/wound/blunt/severe/oof_ouch = new
				oof_ouch.apply_wound(bone)
				var/datum/wound/blunt/critical/oof_OUCH = new
				oof_OUCH.apply_wound(bone)

			for(var/i in C.bodyparts)
				var/obj/item/bodypart/bone = i
				bone.receive_damage(brute=60)
			use(1)
			return (BRUTELOSS)
		else
			C.visible_message("<span class='suicide'>[C] screws up like an idiot and still dies anyway!</span>")
			return (BRUTELOSS)

/obj/item/stack/medical/bone_gel/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

#undef MODE_MULTIPLE
#undef MODE_SINGULAR
