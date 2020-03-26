//MAKE RAPIER GREAT AGAIN
/obj/item/melee/rapier
	name = "plastitanium rapier"
	desc = "A impossibly thin blade made of plastitanium with a tip coated in diamonds. It looks to be able to cut through any armor."
	icon = 'modular_skyrat/icons/obj/rapier.dmi'
	icon_state = "rapier"
	item_state = "rapier"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/rapier_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/rapier_righthand.dmi'
	force = 21
	throwforce = 20
	block_chance = 50
	armour_penetration = 200
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	sharpness = IS_SHARP_ACCURATE //It cant be sharpend cook -_-
	attack_verb = list("slashed", "cut", "pierces", "pokes")
	total_mass = 3.4

/obj/item/melee/rapier/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 65, 0)

/obj/item/melee/rapier/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	return ..()

/obj/item/melee/rapier/attack(mob/living/target, mob/living/user)
	. = ..()]

//blueshield's baton
/obj/item/melee/baton/electricprod
	name = "blueshield electric prod"
	desc = "A non-lethal takedown is always the most silent way to eliminate resistance."
	icon = 'modular_skyrat/icons/obj/stunprod.dmi'
	icon_state = "electricprod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi' //pissholder
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi' //placeholder fuck
	item_state = "telebaton_1" //placeholder fuck piss
	stamforce = 35 //considerably better than a normal baton
	hitcost = 500 //less energy cost per hit
	throw_hit_chance = 10 //don't throw that shit it won't work bro
	slot_flags = null //you'll have to put it on a belt or whatever
	force = 15 //robust harmbatoning
	attack_verb = list("prodded", "struck", "\"non-lethalled\"", "silent takedowned") //le deus ex
	w_class = WEIGHT_CLASS_SMALL //small but packs a PUNCH.
	preload_cell_type = /obj/item/stock_parts/cell/high/plus/blueshield
	obj_flags = UNIQUE_RENAME

/obj/item/stock_parts/cell/high/plus/blueshield
	name = "centcomm exclusive power cell"
	self_recharge = 1