//morph cube
GLOBAL_LIST_INIT(blacklistedmorphcubemobs, typecacheof(list(\
										/mob/living/simple_animal/hostile/boss,\
										/mob/living/simple_animal/hostile/megafauna,\
										/mob/living/carbon,\
										/mob/living/silicon,\
										/mob/dead,\
										/mob/living/brain,\
										/mob/living/simple_animal/hostile/guardian)))

/obj/item/morphcube
	name = "strange cube"
	desc = "It has a small red button hidden on it."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "posibrain"
	var/grants = 1
	var/mob/living/ourmob = /mob/living/simple_animal/mouse
	var/mob/living/targettype
	var/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/ourspell

/obj/item/morphcube/attack_self(mob/user)
	if(grants > 0)
		grants--
		var/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/spell = new /obj/effect/proc_holder/spell/targeted/shapeshift/morphcube()
		user.mind.AddSpell(spell)
		spell.owner = user.mind
		spell.possible_shapes = list()
		spell.possible_shapes += ourmob
		spell.shapeshift_type = ourmob
		spell.ourcube = src
		ourspell = spell
		to_chat(user, "<span class='danger'>[src] grants you a new ability...</span>")
	else
		to_chat(user, "<span class='notice'>[src] fizzles uselessly.</span>")

/obj/item/morphcube/attack(mob/living/target, mob/living/carbon/human/user)
	if(ourspell && user.mind == ourspell.owner)
		if(target.type in GLOB.blacklistedmorphcubemobs)
			to_chat(user, "<span class='danger'>The target is too complex to be scanned.</span>")
			return FALSE
		targettype = target.type
		to_chat(user, "<span class='danger'>[src] stores the form of the target.</span>")
		ourspell.possible_shapes = list()
		ourspell.possible_shapes += targettype
		ourspell.shapeshift_type = targettype
		ourmob = targettype
	else if(user.mind)
		if(target.type in GLOB.blacklistedmorphcubemobs)
			to_chat(user, "<span class='danger'>The target is too complex to be scanned.</span>")
			return FALSE
		var/mob/living/targettype = target.type
		to_chat(user, "<span class='notice'>[src] stores the form of the target.</span>")
		ourmob = targettype

/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube
	name = "Morphing"
	desc = "Take the shape of the animal selected by your morph cube. Only works within a 7 tile range of the cube!"
	invocation = "none" //it really doesn't do you much good if everything around you knows who you are
	invocation_type = "none"
	charge_max = 100
	possible_shapes = list()
	var/datum/mind/owner = null
	var/obj/item/morphcube/ourcube = null

/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/cast(list/targets, mob/user = usr)
	if(istype(user, /mob/living/carbon) && get_dist(get_turf(ourcube),get_turf(user)) > 7)
		to_chat(user, "<span class='danger'>The cube is out of range, or has been entirely destroyed!</span>")
		return FALSE
	..()
	return TRUE

/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/Shapeshift(mob/living/caster)
	var/obj/shapeshift_holder/H = locate() in caster
	if(H)
		to_chat(caster, "<span class='warning'>You're already shapeshifted!</span>")
		return

	var/mob/living/shape = new shapeshift_type(caster.loc)
	if(shape.maxHealth > 300)
		shape.maxHealth = 300
	shape.faction = list()
	H = new(shape,src,caster)

	clothes_req = NONE
	mobs_whitelist = null
	mobs_blacklist = null

//jammer pen
/obj/item/pen/jammerpen
	icon = 'modular_skyrat/icons/obj/radio.dmi'
	icon_state = "jammerpen0"
	var/active = FALSE
	var/range = 12

/obj/item/pen/jammerpen/update_icon()
	icon_state = "jammerpen[active]"

/obj/item/pen/jammerpen/AltClick(mob/user)
	to_chat(user,"<span class='notice'>You [active ? "deactivate" : "activate"] [src].</span>")
	active = !active
	if(active)
		GLOB.active_jammers |= src
	else
		GLOB.active_jammers -= src
	update_icon()
