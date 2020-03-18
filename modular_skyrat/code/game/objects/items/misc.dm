/obj/item/clothing/suit/armor/hazard
	name = "armored hazard vest"
	desc = "A hazard vest with metal plate taped on it. It offers minor protection against kinetic damage."
	icon = 'modular_skyrat/icons/obj/clothing/armor.dmi'
	alternate_worn_icon = 'modular_skyrat/icons/mob/suit.dmi'
	alternate_worn_icon_digi = 'modular_skyrat/icons/mob/suit_digi.dmi'
	icon_state = "makeshiftarmor"
	item_state = "makeshiftarmor"
	w_class = 3
	blood_overlay_type = "armor"
	armor = list(melee = 25, bullet = 10, laser = 0, energy = 0, bomb = 5, bio = 0, rad = 0)

/obj/item/shield/trayshield
	name = "tray shield"
	desc = "A makeshift shield that won't last for long."
	icon = 'modular_skyrat/icons/obj/weapons.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/righthand.dmi'
	icon_state = "trayshield"
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_HUGE
	attack_verb = list("shoved", "bashed")
	block_chance = 40
	var/damage_received = 0 //Amount of damage the shield has received
	var/max_damage = 100 //Amount of max damage the trayshield can withstand

/obj/item/shield/trayshield/examine(mob/user)
	..()
	var/a = max(0, max_damage - damage_received)
	if(a <= max_damage/4) //20
		to_chat(user, "It's falling apart.")
	else if(a <= max_damage/2) //40
		to_chat(user, "It's badly damaged.")
	else if(a < max_damage)
		to_chat(user, "It's slightly damaged.")

/obj/item/shield/trayshield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 4, attack_type = MELEE_ATTACK)
	if(..())
		if(damage < 4)
			damage = 4
		if(istype(hitby, /obj/item/projectile))
			var/obj/item/projectile/P
			if(P.nodamage || !damage)
				damage = 0
		damage_received += damage
		if(damage_received >= max_damage)
			if(ishuman(owner))
				var/mob/living/carbon/human/H = owner
				H.visible_message("<span class='danger'>[H]'s [src] breaks!</span>", "<span class='userdanger'>Your [src] breaks!</span>")
				playsound(H, 'sound/effects/bang.ogg', 30, 1)
				H.dropItemToGround(src, 1)
				qdel(src)
		else
			var/sound/hitsound = list('sound/items/trayhit1.ogg', 'sound/items/trayhit2.ogg')
			playsound(loc, pick(hitsound), 50, 1)
		return TRUE
	return FALSE