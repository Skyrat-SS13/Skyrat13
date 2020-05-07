/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/stack_objects.dmi'
	amount = 12
	max_amount = 12
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	resistance_flags = FLAMMABLE
	max_integrity = 40
	novariants = FALSE
	item_flags = NOBLUDGEON
	var/self_delay = 50

/obj/item/stack/medical/attack(mob/living/M, mob/user)
	. = ..()
	if(!M.can_inject(user, TRUE))
		return
	if(M == user)
		user.visible_message("<span class='notice'>[user] starts to apply \the [src] on [user.p_them()]self...</span>", "<span class='notice'>You begin applying \the [src] on yourself...</span>")
		if(!do_mob(user, M, self_delay, extra_checks=CALLBACK(M, /mob/living/proc/can_inject, user, TRUE)))
			return
	if(heal(M, user))
		log_combat(user, M, "healed", src.name)
		use(1)


/obj/item/stack/medical/proc/heal(mob/living/M, mob/user)
	return

/obj/item/stack/medical/proc/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	var/datum/species/carbonspecies = C.dna.species //Skyrat addtion
	if(!affecting) //Missing limb?
		to_chat(user, "<span class='warning'>[C] doesn't have \a [parse_zone(user.zone_selected)]!</span>")
		return FALSE
	if(affecting.status == BODYPART_ORGANIC) //Limb must be organic to be healed - RR
		if(!istype(carbonspecies, /datum/species/synth) && (affecting.brute_dam && brute || affecting.burn_dam && burn)) //Skyrat edit -- synths cant heal via normal means
			user.visible_message("<span class='green'>[user] applies \the [src] on [C]'s [affecting.name].</span>", "<span class='green'>You apply \the [src] on [C]'s [affecting.name].</span>")
			if(affecting.heal_damage(brute, burn))
				C.update_damage_overlays()
			return TRUE
		to_chat(user, "<span class='notice'>[C]'s [affecting.name] can not be healed with \the [src].</span>")
		return FALSE
	to_chat(user, "<span class='notice'>\The [src] won't work on a [carbonspecies == /datum/species/synth ? "synthetic" : "robotic"] limb!</span>")  //Skyrat edit
	return FALSE

/obj/item/stack/medical/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "pouch")

/obj/item/stack/medical/bruise_pack
	name = "bruise pack"
	singular_name = "bruise pack"
	desc = "A therapeutic gel pack and bandages designed to treat blunt-force trauma."
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	var/heal_brute = 20
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/styptic_powder = 10)

/obj/item/stack/medical/bruise_pack/heal(mob/living/M, mob/user)
	if(M.stat == DEAD)
		to_chat(user, "<span class='notice'> [M] is dead. You can not help [M.p_them()]!</span>")
		return
	if(isanimal(M))
		var/mob/living/simple_animal/critter = M
		if (!(critter.healable))
			to_chat(user, "<span class='notice'> You cannot use \the [src] on [M]!</span>")
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, "<span class='notice'> [M] is at full health.</span>")
			return FALSE
		user.visible_message("<span class='green'>[user] applies \the [src] on [M].</span>", "<span class='green'>You apply \the [src] on [M].</span>")
		if(AmBloodsucker(M))
			return
		M.heal_bodypart_damage((heal_brute/2))
		return TRUE
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, 0)
	to_chat(user, "<span class='notice'>You can't heal [M] with the \the [src]!</span>")

/obj/item/stack/medical/bruise_pack/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is bludgeoning [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/stack/medical/gauze
	name = "medical gauze"
	desc = "A roll of elastic cloth that is extremely effective at stopping bleeding, heals minor wounds."
	gender = PLURAL
	singular_name = "medical gauze"
	icon_state = "gauze"
	var/stop_bleeding = 1800
	var/heal_brute = 5
	self_delay = 10

/obj/item/stack/medical/gauze/heal(mob/living/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!H.bleedsuppress && H.bleed_rate) //so you can't stack bleed suppression
			H.suppress_bloodloss(stop_bleeding)
			to_chat(user, "<span class='notice'>You stop the bleeding of [M]!</span>")
			H.adjustBruteLoss(-(heal_brute))
			return TRUE
	to_chat(user, "<span class='notice'>You can not use \the [src] on [M]!</span>")

/obj/item/stack/medical/gauze/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		if(get_amount() < 2)
			to_chat(user, "<span class='warning'>You need at least two gauzes to do this!</span>")
			return
		new /obj/item/stack/sheet/cloth(user.drop_location())
		user.visible_message("[user] cuts [src] into pieces of cloth with [I].", \
					 "<span class='notice'>You cut [src] into pieces of cloth with [I].</span>", \
					 "<span class='italics'>You hear cutting.</span>")
		use(2)
	else
		return ..()

/obj/item/stack/medical/gauze/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] begins tightening \the [src] around [user.p_their()] neck! It looks like [user.p_they()] forgot how to use medical supplies!</span>")
	return OXYLOSS

/obj/item/stack/medical/gauze/improvised
	name = "improvised gauze"
	singular_name = "improvised gauze"
	desc = "A roll of cloth roughly cut from something that can stop bleeding, but does not heal wounds."
	stop_bleeding = 900
	heal_brute = 0

/obj/item/stack/medical/gauze/adv
	name = "sterilized medical gauze"
	desc = "A roll of elastic sterilized cloth that is extremely effective at stopping bleeding, heals minor wounds and cleans them."
	singular_name = "sterilized medical gauze"
	self_delay = 5

/obj/item/stack/medical/gauze/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Used to treat those nasty burn wounds."
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	var/heal_burn = 20
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/silver_sulfadiazine = 10)

/obj/item/stack/medical/ointment/heal(mob/living/M, mob/user)
	if(M.stat == DEAD)
		to_chat(user, "<span class='notice'> [M] is dead. You can not help [M.p_them()]!</span>")
		return
	if(iscarbon(M))
		return heal_carbon(M, user, 0, heal_burn)
	if(AmBloodsucker(M))
		return
	to_chat(user, "<span class='notice'>You can't heal [M] with the \the [src]!</span>")

/obj/item/stack/medical/ointment/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is squeezing \the [src] into [user.p_their()] mouth! [user.p_do(TRUE)]n't [user.p_they()] know that stuff is toxic?</span>")
	return TOXLOSS

/obj/item/stack/medical/splint
	name = "medical splints"
	singular_name = "medical splint"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "splint"
	desc = "Oofie ouchie my bones."
	novariants = TRUE
	self_delay = 100
	amount = 5
	max_amount = 5

/obj/item/stack/medical/splint/heal(mob/living/M, mob/user)
	if(ishuman(M))
		return heal_carbon(M, user)

/obj/item/stack/medical/splint/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		var/obj/item/bodypart/affecting = H.get_bodypart(user.zone_selected)

		if(!(affecting.body_zone in list(BODY_ZONE_R_ARM, BODY_ZONE_PRECISE_R_HAND, BODY_ZONE_L_ARM, BODY_ZONE_PRECISE_L_HAND,\
								BODY_ZONE_R_LEG, BODY_ZONE_PRECISE_R_FOOT, BODY_ZONE_L_LEG, BODY_ZONE_PRECISE_L_FOOT)))
			to_chat(user, "<span class='danger'>You can't apply a splint there!</span>")
			return FALSE

		if(affecting.status == BODYPART_ROBOTIC)
			to_chat(user, "<span class='danger'>[H]'s [affecting] can't be broken, it's robotic!</span>")
			return FALSE

		if(affecting.status & BODYPART_SPLINTED)
			to_chat(user, "<span class='danger'>[H]'s [affecting] is already splinted!</span>")
			if(alert(user, "Would you like to remove the splint from [H]'s [affecting]?", "Splint removal.", "Yes", "No") == "Yes")
				affecting.status &= ~BODYPART_SPLINTED
				H.handle_splints()
				to_chat(user, "<span class='notice'>You remove the splint from [H]'s [affecting].</span>")
			return FALSE

		user.visible_message("<span class='notice'>[user] applies [src] to [H]'s [affecting].</span>", \
								"<span class='notice'>You apply [src] to [H]'s [affecting].</span>")

		affecting.status_flags |= BODYPART_SPLINTED
		affecting.splinted_count = world.time
		H.handle_splints()
		return TRUE
	return FALSE

/obj/item/stack/medical/splint/tribal
	name = "tribal splints"
	singular_name = "tribal splint"
	icon_state = "tribal_splint"
	desc = "Ooga booga rock crush bone."
	self_delay = 200

/obj/item/stack/medical/nanopaste
	name = "nanite paste"
	singular_name = "nanite paste"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "nanopaste"
	desc = "A paste composed of silicon and healing nanites. Very efficient tool to heal robotic limbs."
	novariants = TRUE
	self_delay = 60
	var/heal_brute = 20
	var/heal_burn = 20

/obj/item/stack/medical/nanopaste/heal(mob/living/M, mob/user)
	if(ishuman(M))
		return heal_carbon(M, user)

/obj/item/stack/medical/nanopaste/heal_carbon(mob/living/carbon/C, mob/user, brute, burn)
	if(!iscarbon(C))
		return FALSE
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, "<span class='warning'>[C] doesn't have \a [parse_zone(user.zone_selected)]!</span>")
		return FALSE

	var/datum/species/carbonspecies = C.dna.species
	if((affecting.status == BODYPART_ROBOTIC) || (carbonspecies == /datum/species/synth)) //It's fucking nanite paste. It can't heal organics.
		if(affecting.brute_dam && brute || affecting.burn_dam && burn)
			user.visible_message("<span class='green'>[user] applies \the [src] on [C]'s [affecting.name].</span>", "<span class='green'>You apply \the [src] on [C]'s [affecting.name].</span>")
			if(affecting.heal_damage(heal_brute, heal_burn))
				C.update_damage_overlays()
			return TRUE
		to_chat(user, "<span class='notice'>[C]'s [affecting.name] can not be healed with \the [src].</span>")
		return FALSE
	to_chat(user, "<span class='notice'>\The [src] won't work on a non-robotic limb!</span>")
	return FALSE
