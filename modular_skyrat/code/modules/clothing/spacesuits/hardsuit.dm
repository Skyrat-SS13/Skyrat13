//Security HEV
/obj/item/clothing/head/helmet/space/hardsuit/security/metrocop
	name = "security HEV suit helmet"
	desc = "This helmet seems like something out of this world... It has been designed by Nanotrasen for their security teams to be used during emergency operations in hazardous environments. This one provides more protection from the environment in exchange for the usual combat protection of a regular security suit."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	alternate_worn_icon = 'modular_skyrat/icons/mob/head.dmi'
	alternate_worn_icon_muzzled = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	icon_state = "hardsuit0-metrocop"
	item_state = "hardsuit0-metrocop"
	item_color = "metrocop"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 60, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE

/obj/item/clothing/suit/space/hardsuit/security/metrocop
	name = "security HEV suit"
	desc = "This suit seems like something out of this world... It has been designed by Nanotrasen for their security teams to be used during emergency operations in hazardous environments. This one provides more protection from the environment in exchange for the usual combat protection of a regular security suit."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	alternate_worn_icon = 'modular_skyrat/icons/mob/suit.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/suit_digi.dmi'
	icon_state = "hardsuit-metrocop"
	item_state = "hardsuit-metrocop"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 60, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 100)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/metrocop
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_ALL_TAURIC

//Snowflake hardsuit modules
/obj/item/melee/transforming/armblade
	name = "Hardsuit Blade"
	desc = "A pointy, murdery blade that can be attached to your hardsuit."
	force = 0
	force_on = 20
	sharpness = IS_BLUNT
	var/sharpness_on = IS_SHARP
	throwforce = 0
	throwforce_on = 0
	hitsound_on = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 0
	var/armour_penetration_on = 25
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "armblade0"
	icon_state_on = "armblade1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi' //PLACEHOLDER!!!!!
	item_state = null
	var/item_state_on = "energy_katana"
	attack_verb_off = list("bopped")
	total_mass_on = 0.6
	var/obj/item/clothing/suit/space/hardsuit/mastersuit = null
	actions_types = list(/datum/action/item_action/extendoblade)
	var/extendo = FALSE

/datum/action/item_action/extendoblade
	name = "Extend Blade"
	desc = "Extend the hardsuit's blade."

/obj/item/melee/transforming/armblade/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/extendoblade) && mastersuit && !extendo)
		var/mob/living/carbon/human/H = user
		if(H)
			var/obj/item/arm_item = user.get_active_held_item()
			if(arm_item)
				if(!user.dropItemToGround(arm_item))
					to_chat(user, "<span class='warning'>Your [arm_item] interferes with [src]!</span>")
					return
				else
					to_chat(user, "<span class='notice'>You drop [arm_item] to activate [src]!</span>")
			user.put_in_r_hand(src)
			ADD_TRAIT(src, TRAIT_NODROP, "hardsuit")
			playsound(get_turf(user), 'sound/mecha/mechmove03.ogg', 50, 1)
			extendo = !extendo

	else if (istype(action, /datum/action/item_action/extendoblade) && mastersuit && extendo)
		REMOVE_TRAIT(src, TRAIT_NODROP, "hardsuit")
		user.transferItemToLoc(src, mastersuit, TRUE)
		playsound(get_turf(user), 'sound/mecha/mechmove03.ogg', 50, 1)
		extendo = !extendo
		for(var/X in src.actions)
			var/datum/action/A = X
			A.Grant(user)

/obj/item/melee/transforming/armblade/Initialize()
	..()
	AddComponent(/datum/component/butchering, 50, 100, 0, hitsound_on)

/obj/item/melee/transforming/armblade/transform_weapon(mob/living/user, supress_message_text)
	..()
	if(active)
		sharpness = sharpness_on
		armour_penetration = armour_penetration_on
		item_state = item_state_on
	else
		sharpness = initial(sharpness)
		armour_penetration = initial(armour_penetration)
		item_state = initial(item_state)

/obj/item/melee/transforming/armblade/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/batonextend.ogg' : 'sound/items/sheath.ogg', 50, 1)
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "has been extended":"has been concealed"].</span>")

/obj/item/melee/transforming/armblade/attack(mob/living/target, mob/living/carbon/human/user)
	if(!mastersuit)
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a hardsuit.</span>")
		return
	else
		..()

/obj/item/melee/transforming/armblade/attack_self(mob/living/carbon/user)
	if(!mastersuit)
		to_chat(user, "<span class='notice'>[src] can only be used while attached to a hardsuit.</span>")
		return
	else
		..()

/obj/item/clothing/suit/space/hardsuit
	var/obj/item/melee/transforming/armblade = null

/obj/item/clothing/suit/space/hardsuit/Initialize()
	if(jetpack && ispath(jetpack))
		jetpack = new jetpack(src)
	if(armblade && ispath(armblade))
		armblade = new armblade(src)
	. = ..()

/obj/item/clothing/suit/space/hardsuit/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/tank/jetpack/suit))
		if(jetpack)
			to_chat(user, "<span class='warning'>[src] already has a jetpack installed.</span>")
			return
		if(src == user.get_item_by_slot(SLOT_WEAR_SUIT)) //Make sure the player is not wearing the suit before applying the upgrade.
			to_chat(user, "<span class='warning'>You cannot install the upgrade to [src] while wearing it.</span>")
			return

		if(user.transferItemToLoc(I, src))
			jetpack = I
			to_chat(user, "<span class='notice'>You successfully install the jetpack into [src].</span>")
			return
	else if(istype(I, /obj/item/screwdriver))
		if(!jetpack)
			to_chat(user, "<span class='warning'>[src] has no jetpack installed.</span>")
			return
		if(src == user.get_item_by_slot(SLOT_WEAR_SUIT))
			to_chat(user, "<span class='warning'>You cannot remove the jetpack from [src] while wearing it.</span>")
			return

		jetpack.turn_off(user)
		jetpack.forceMove(drop_location())
		jetpack = null
		to_chat(user, "<span class='notice'>You successfully remove the jetpack from [src].</span>")
		if(!armblade)
			to_chat(user, "<span class='warning'>[src] has no armblade installed.</span>")
			return
		if(src == user.get_item_by_slot(SLOT_WEAR_SUIT))
			to_chat(user, "<span class='warning'>You cannot remove the armblade from [src] while wearing it.</span>")
			return
		armblade.forceMove(drop_location())
		var/obj/item/melee/transforming/armblade/M = armblade
		if(M)
			M.mastersuit = null
		armblade = null
		to_chat(user, "<span class='notice'>You successfully remove the armblade from [src].</span>")
		return
	else if(istype(I, /obj/item/melee/transforming/armblade))
		if(armblade)
			to_chat(user, "<span class='warning'>[src] already has an armblade installed.</span>")
			return
		if(src == user.get_item_by_slot(SLOT_WEAR_SUIT))
			to_chat(user, "<span class='warning'>You cannot install the upgrade to [src] while wearing it.</span>")
			return

		if(user.transferItemToLoc(I, src))
			var/obj/item/melee/transforming/armblade/M = I
			M.mastersuit = src
			src.armblade = M
			to_chat(user, "<span class='notice'>You successfully install the armblade into [src].</span>")
			return
	return ..()

/obj/item/clothing/suit/space/hardsuit/equipped(mob/user, slot)
	..()
	if(jetpack)
		if(slot == SLOT_WEAR_SUIT)
			for(var/X in jetpack.actions)
				var/datum/action/A = X
				A.Grant(user)
	if(armblade)
		if(slot == SLOT_WEAR_SUIT)
			for(var/X in armblade.actions)
				var/datum/action/A = X
				A.Grant(user)

/obj/item/clothing/suit/space/hardsuit/dropped(mob/user)
	..()
	if(jetpack)
		for(var/X in jetpack.actions)
			var/datum/action/A = X
			A.Remove(user)
	if(armblade)
		for(var/X in armblade.actions)
			var/datum/action/A = X
			A.Remove(user)

/datum/techweb_node/syndicate_basic
	id = "syndicate_basic"
	display_name = "Illegal Technology"
	description = "Dangerous research used to create dangerous objects."
	prereq_ids = list("adv_engi", "adv_weaponry", "explosive_weapons")
	design_ids = list("decloner", "borg_syndicate_module", "suppressor", "largecrossbow", "donksofttoyvendor", "donksoft_refill", "syndiesleeper", "armblade")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	hidden = TRUE

/datum/design/armblade
	name = "Hardsuit Extendable Blade"
	desc = "An armblade attachment for hardsuits."
	id = "armblade"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 5000, /datum/material/silver = 5000, /datum/material/diamond = 500, /datum/material/gold = 1500, /datum/material/titanium = 5000)
	build_path = /obj/item/melee/transforming/armblade
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY