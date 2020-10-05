#define MODE_MULTIPLE "multiple limbs"
#define MODE_SINGULAR "single limb"

/obj/item/stack/medical/gauze/splint
	name = "medical splints"
	singular_name = "medical splint"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "splint"
	desc = "Oofie ouchie my bones."
	self_delay = 75
	other_delay = 30
	amount = 15
	max_amount = 15
	custom_price = 150
	absorption_rate = 0.1
	absorption_capacity = 1
	splint_factor = 0.175
	custom_price = PRICE_EXPENSIVE
	novariants = TRUE
	merge_type = /obj/item/stack/medical/gauze/splint

/obj/item/stack/medical/gauze/splint/tribal
	name = "tribal splints"
	singular_name = "tribal splint"
	icon_state = "tribal_splint"
	desc = "Ooga booga rock crush bone."
	self_delay = 90
	other_delay = 45
	absorption_rate = 0.10
	absorption_capacity = 3.5
	splint_factor = 0.65
	novariants = TRUE
	merge_type = /obj/item/stack/medical/gauze/splint/tribal

/obj/item/stack/medical/gauze/splint/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/nanopaste
	name = "nanite paste"
	singular_name = "nanite paste"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "nanopaste"
	desc = "A paste composed of silicon and healing nanites. Very efficient tool to heal robotic limbs."
	novariants = TRUE
	self_delay = 60
	other_delay = 30
	heal_brute = 20
	heal_burn = 20
	required_status = BODYPART_ROBOTIC
	merge_type = /obj/item/stack/medical/nanopaste

/obj/item/stack/medical/nanopaste/heal(mob/living/M, mob/user, silent, obj/item/bodypart/specific_part) //lmao i stole bruise pack code
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
		else if(!(critter.mob_biotypes & MOB_ROBOTIC))
			if(!silent)
				to_chat(user, "<span class='warning'>[M] is not robotic!</span>")
			return FALSE
		if(!silent)
			user.visible_message("<span class='green'>[user] applies \the [src] on [M].</span>", "<span class='green'>You apply \the [src] on [M].</span>")
		M.heal_bodypart_damage(heal_brute)
		use(stackperlimb)
		return TRUE
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, heal_burn, FALSE, (mode == MODE_MULTIPLE ? TRUE : FALSE))
	if(!silent)
		to_chat(user, "<span class='warning'>You can't heal [M] with \the [src]!</span>")

/obj/item/stack/medical/nanopaste/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/fixovein
	name = "fix o' vein"
	singular_name = "fix o' vein"
	desc = "A tube filled with fibrous cabling, perfectly able to replace damaged veins."
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "fixovein"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount = 10
	max_amount = 10
	self_delay = 80
	other_delay = 40
	grind_results = list(/datum/reagent/medicine/fibrin = 10, /datum/reagent/medicine/coagulant = 10)
	novariants = TRUE
	merge_type = /obj/item/stack/medical/fixovein

/obj/item/stack/medical/fixovein/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 300

#undef MODE_MULTIPLE
#undef MODE_SINGULAR
