//Security HEV
/obj/item/clothing/head/helmet/space/hardsuit/security/metrocop
	name = "security HEV suit helmet"
	desc = "This helmet seems like something out of this world... It has been designed by Nanotrasen for their security teams to be used during emergency operations in hazardous environments. This one provides more protection from the environment in exchange for the usual combat protection of a regular security suit."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	icon_state = "hardsuit0-metrocop"
	item_state = "hardsuit0-metrocop"
	hardsuit_type = "metrocop"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 60, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/suit/space/hardsuit/security/metrocop
	name = "security HEV suit"
	desc = "This suit seems like something out of this world... It has been designed by Nanotrasen for their security teams to be used during emergency operations in hazardous environments. This one provides more protection from the environment in exchange for the usual combat protection of a regular security suit."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	icon_state = "hardsuit-metrocop"
	item_state = "hardsuit-metrocop"
	hardsuit_type = "metrocop"
	armor = list("melee" = 50, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 60, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 100)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/metrocop
	resistance_flags = FIRE_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
	mutantrace_variation = STYLE_DIGITIGRADE

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

//Power armor
/obj/item/clothing/head/helmet/space/hardsuit/powerarmor
	name = "Power Armor Helmet MK. I"
	desc = "An advanced helmet attached to a powered exoskeleton suit. Protects well against most forms of harm, but struggles against exotic hazards."
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	icon_state = "hardsuit0-powerarmor-1"
	item_state = "hardsuit0-powerarmor-1"
	hardsuit_type = "powerarmor"
	clothing_flags = THICKMATERIAL //Ouchie oofie my bones
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 5, "fire" = 75, "acid" = 100)
	resistance_flags = ACID_PROOF

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_icon()

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/update_overlays()
	. = ..()
	var/mutable_appearance/glass_overlay = mutable_appearance(icon, "hardsuit0-powerarmor-2")
	if(icon_state == "hardsuit1-powerarmor-1")
		glass_overlay = mutable_appearance(icon, "hardsuit1-powerarmor-2")
	glass_overlay.appearance_flags = RESET_COLOR
	. += glass_overlay

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M = mutable_appearance(icon_file, "hardsuit0-powerarmor-2")
		if(icon_state == "hardsuit1-powerarmor-1")
			M = mutable_appearance(icon_file, "hardsuit1-powerarmor-2")
		M.appearance_flags = RESET_COLOR
		. += M

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		DHUD.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/powerarmor/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		DHUD.remove_hud_from(user)

/obj/item/clothing/suit/space/hardsuit/powerarmor
	name = "Power Armor MK. I"
	desc = "A self-powered exoskeleton suit comprised of flexible Plasteel sheets and advanced components, designed to offer excellent protection while still allowing mobility. Does not protect against Space, and struggles against more exotic hazards."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	icon_state = "hardsuit-powerarmor-1"
	item_state = "hardsuit-powerarmor-1"
	slowdown = -0.05
	clothing_flags = THICKMATERIAL //Not spaceproof. No, it isn't Spaceproof in Rimworld either.
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 20, "bomb" = 40, "bio" = 100, "rad" = 5, "fire" = 75, "acid" = 100) //I was asked to buff this again. Here, fine.
	resistance_flags = ACID_PROOF
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/powerarmor

/obj/item/clothing/suit/space/hardsuit/powerarmor/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_icon()

/obj/item/clothing/suit/space/hardsuit/powerarmor/update_overlays()
	. = ..()
	var/mutable_appearance/black_overlay = mutable_appearance(icon, "hardsuit-powerarmor-2")
	black_overlay.appearance_flags = RESET_COLOR
	. += black_overlay

/obj/item/clothing/suit/space/hardsuit/powerarmor/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M = mutable_appearance(icon_file, "hardsuit-powerarmor-2")
		M.appearance_flags = RESET_COLOR
		. += M

/obj/item/clothing/suit/space/hardsuit/powerarmor/emp_act()
	. = ..()
	var/mob/living/carbon/human/user = src.loc
	playsound(src.loc, 'modular_skyrat/sound/misc/suitmalf.ogg', 60, 1, 10)
	if (ishuman(user) && (user.wear_suit == src))
		to_chat(user, "<span class='danger'>The motors on your armor cease to function, causing the full weight of the suit to weigh on you all at once!</span>")
		user.emote("scream")
		user.take_overall_damage(stamina=250)
		user.take_overall_damage(brute=20)
	if(prob(1))
		playsound(src.loc, 'sound/effects/fuse.ogg', 60, 1, 10)
		visible_message("<span class ='warning'>The power module on the [src] begins to smoke, glowing with an alarming warmth! Get away from it, now!")
		addtimer(CALLBACK(src, .proc/detonate),50)
	else
		visible_message("<span class ='warning'>The power module on the [src] briefly flickers, before humming to life once more.</span>")
		return

/obj/item/clothing/suit/space/hardsuit/powerarmor/proc/detonate()
	visible_message("<span class ='danger'>The power module of the [src] overheats, causing it to destabilize and explode!")
	explosion(src.loc,0,0,3,flame_range = 3)
	qdel(src)
	return

//HEV Mark IV (RD hardsuit)
/obj/item/clothing/head/helmet/space/hardsuit/rd/hev
	name = "HEV Suit Mark IV helmet"
	desc = "A Hazardous Environment Helmet. It fits snug over the suit and has a heads-up display for researchers. The flashlight seems broken, fitting considering this was made before the start of the milennium."
	icon_state = "hev"
	icon = 'modular_skyrat/icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/head.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/head_muzzled.dmi'
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list("melee" = 30, "bullet" = 15, "laser" = 20, "energy" = 30, "bomb" = 100, "bio" = 100, "rad" = 75, "fire" = 75, "acid" = 80)
	var/explosion_detection_dist = 21
	var/scan_reagents = TRUE
	actions_types = list(/datum/action/item_action/toggle_research_scanner)
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/suit/space/hardsuit/rd/hev
	name = "HEV Suit Mark IV"
	desc = "A Hazardous Environment suit, often called the Hazard suit. It was designed to protect scientists from the blunt trauma, radiation, energy discharge that hazardous materials might produce or entail. Fits you like a glove. The automatic medical system seems to be functional."
	icon = 'modular_skyrat/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/suit_digi.dmi'
	icon_state = "hev"
	item_state = "hev"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT //Same as an emergency firesuit. Not ideal for extended exposure.
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/gun/energy/wormhole_projector,
	/obj/item/hand_tele, /obj/item/aicard)
	armor = list("melee" = 30, "bullet" = 15, "laser" = 20, "energy" = 30, "bomb" = 100, "bio" = 100, "rad" = 75, "fire" = 75, "acid" = 80)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/rd/hev
	slowdown = 0
	var/heal_threshold = 5
	var/injection_amount = 10
	var/injection_cooldown_time = 1200 //2 minutes before injecting again
	var/injection_cooldown
	var/annoy_cooldown_time = 600
	var/annoyed = FALSE
	var/datum/reagent/startingreagent = /datum/reagent/medicine/epinephrine
	var/obj/item/reagent_containers/container
	var/beaker_type = /obj/item/reagent_containers/glass/beaker/large
	var/mob/living/carbon/human/freeman
	var/currentwearerhealth
	var/oldwearerhealth
	var/flatlined
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/space/hardsuit/rd/hev/Initialize()
	. = ..()
	START_PROCESSING(SSobj,src)
	var/obj/item/reagent_containers/R = new beaker_type(src)
	R.reagents.add_reagent(startingreagent, R.reagents.maximum_volume)
	container = R

/obj/item/clothing/suit/space/hardsuit/rd/hev/process()
	if(freeman)
		oldwearerhealth = currentwearerhealth
		currentwearerhealth = (100 - (freeman.getBruteLoss() + freeman.getFireLoss() + freeman.getOxyLoss() + freeman.getToxLoss() + freeman.getCloneLoss())) //found no sensible way to get the "real" user health
		if(freeman.stat == DEAD && !flatlined)
			playsound(freeman, 'modular_skyrat/sound/halflife/flatline.wav', 50, 0)
			flatlined = TRUE
		if(!annoyed)
			if((currentwearerhealth <= heal_threshold) && !flatlined)
				playsound(freeman, 'modular_skyrat/sound/halflife/health_critical.wav', 50, 0)
				sleep(40)
				annoyed = TRUE
			if((oldwearerhealth > currentwearerhealth) && (currentwearerhealth >= heal_threshold) && !flatlined)
				playsound(freeman, 'modular_skyrat/sound/halflife/health_dropping.wav', 50, 0)
				sleep(40)
				annoyed = TRUE
			if((freeman.getToxLoss() >= 15) && !flatlined)
				playsound(freeman, 'modular_skyrat/sound/halflife/blood_toxins.wav', 50, 0)
				sleep(40)
				annoyed = TRUE
			if((freeman.getFireLoss() >= 35) && !flatlined)
				playsound(freeman, 'modular_skyrat/sound/halflife/heat_damage.wav', 50, 0)
				sleep(40)
				annoyed = TRUE
			if((freeman.blood_volume <= (BLOOD_VOLUME_OKAY - 36)) && !HAS_TRAIT(freeman, NOBLOOD) && !flatlined)
				playsound(freeman, 'modular_skyrat/sound/halflife/blood_loss.wav', 50, 0)
				sleep(30)
				annoyed = TRUE
			if(annoyed)
				addtimer(CALLBACK(src, .proc/unannoy), annoy_cooldown_time)
		if((currentwearerhealth <= heal_threshold) && ((world.time > injection_cooldown) || !injection_cooldown) && !flatlined)
			if(container)
				if(container.reagents.trans_to(freeman, injection_amount))
					playsound(freeman, 'modular_skyrat/sound/halflife/administering_medical.wav', 50, 0)
					sleep(40)
					playsound(freeman, 'modular_skyrat/sound/halflife/medshot4.wav', 50, 0)
					injection_cooldown = injection_cooldown_time + world.time
				else
					playsound(freeman, 'modular_skyrat/sound/halflife/innsuficient_medical.wav', 50, 0)
					injection_cooldown = injection_cooldown_time + world.time

/obj/item/clothing/suit/space/hardsuit/rd/hev/proc/unannoy()
	annoyed = FALSE

/obj/item/clothing/suit/space/hardsuit/rd/hev/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/screwdriver))
		playsound(src, 'sound/items/Screwdriver.ogg', 25, 0)
		container.forceMove(get_turf(user))
		container = null
		to_chat(user, "<span class='notice'>You remove [src]'s reagent container.</span>")
	else if(istype(I, /obj/item/reagent_containers) && !container)
		var/obj/item/reagent_containers/R = I
		playsound(src, 'sound/items/Screwdriver.ogg', 25, 0)
		R.forceMove(src)
		to_chat(user, "<span class='notice'>You install [R] into [src].</span>")
	else
		..()

/obj/item/clothing/suit/space/hardsuit/rd/hev/equipped(mob/user, slot)
	..()
	if(ishuman(user) && slot == SLOT_WEAR_SUIT)
		playsound(user, 'modular_skyrat/sound/halflife/hev_logon.ogg', 50, 0)
		freeman = user
		flatlined = FALSE

/obj/item/clothing/suit/space/hardsuit/rd/hev/dropped(mob/user, slot)
	. = ..()
	if(ishuman(user))
		playsound(user, 'modular_skyrat/sound/halflife/deactivated.wav', 50, 0)
		freeman = null
		flatlined = FALSE

//mineing suit for minecrafting
/obj/item/clothing/head/helmet/space/hardsuit/mining
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/gun/energy/plasmacutter)
