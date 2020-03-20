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
	. = ..()