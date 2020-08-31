//MAKE RAPIER GREAT AGAIN
/obj/item/melee/rapier
	name = "plastitanium rapier"
	desc = "A impossibly thin blade made of plastitanium with a tip coated in diamonds. It looks to be able to cut through any armor."
	icon = 'modular_skyrat/icons/obj/items_and_weapons.dmi'
	icon_state = "rapier"
	item_state = "rapier"
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 21
	throwforce = 20
	block_chance = 50
	armour_penetration = 200
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "cut", "pierces", "pokes")
	total_mass = 3.4

/obj/item/melee/rapier/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 65, 0)

/obj/item/melee/rapier/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	return ..()

/obj/item/melee/rapier/attack(mob/living/target, mob/living/user)
	. = ..()

//blueshield's baton
/obj/item/melee/baton/blueshieldprod
	name = "\improper The electrifryer"
	desc = "A non-lethal takedown is always the most silent way to eliminate resistance."
	icon = 'modular_skyrat/icons/obj/stunprod.dmi'
	icon_state = "bsprod"
	item_state = "bsprod"
	obj_flags = UNIQUE_RENAME
	lefthand_file = 'modular_skyrat/icons/mob/inhands/weapons/melee_lefthand.dmi' //pissholder
	righthand_file = 'modular_skyrat/icons/mob/inhands/weapons/melee_righthand.dmi' //placeholder fuck
	stamforce = 35 //considerably better than a normal baton
	hitcost = 600 //less energy cost per hit
	slot_flags = null //you'll have to put it on a belt or whatever
	force = 11
	attack_verb = list("prodded", "struck", "\"non-lethalled\"", "silent takedowned") //le deus ex
	w_class = WEIGHT_CLASS_SMALL //small but packs a PUNCH.
	preload_cell_type = /obj/item/stock_parts/cell/high/plus

/obj/item/melee/baton/blueshieldprod/update_icon_state() // Thanks Trilby i nut -CinderWC
    if(turned_on)
        icon_state = "bsprod_active"
    else if(!cell)
        icon_state = "bsprod_nocell"
    else
        icon_state = "bsprod"

/obj/item/melee/baton/blueshieldprod/common_baton_melee(mob/M, mob/living/user, disarming = FALSE)
    if(iscyborg(M) || !isliving(M))        //can't baton cyborgs
        return FALSE
    if(!HAS_TRAIT(user, TRAIT_MINDSHIELD))
        clowning_around(user)
        return TRUE
    if(IS_STAMCRIT(user))            //CIT CHANGE - makes it impossible to baton in stamina softcrit
        to_chat(user, "<span class='danger'>You're too exhausted for that.</span>")
        return TRUE
    if(ishuman(M))
        var/mob/living/carbon/human/L = M
        if(check_martial_counter(L, user))
            return TRUE
    if(turned_on)
        if(baton_stun(M, user, disarming))
            user.do_attack_animation(M)
            user.adjustStaminaLossBuffered(getweight())        //CIT CHANGE - makes stunbatonning others cost stamina
    else if(user.a_intent != INTENT_HARM)            //they'll try to bash in the last proc.
        M.visible_message("<span class='warning'>[user] has prodded [M] with [src]. Luckily it was off.</span>", \
                        "<span class='warning'>[user] has prodded you with [src]. Luckily it was off</span>")
    return disarming || (user.a_intent != INTENT_HARM)
    // This code makes it so that non-mindshielded users of the item will stun themselves. Thanks Jake and Useroth -CinderWC
