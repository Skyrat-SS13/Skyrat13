/obj/item/stigma
	name = "Burning Sword"
	desc = "An old relic from the Stigma workshop. It's hot to the touch!"
	icon_state = "stigma"
	item_state = "spellblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 35
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	damtype = BURN
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	armour_penetration = 35
	block_chance = 35
	sharpness = IS_SHARP
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON