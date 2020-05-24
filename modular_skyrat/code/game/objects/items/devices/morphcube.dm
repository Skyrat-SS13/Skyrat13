GLOBAL_LIST_INIT(blacklistedmorphcubemobs, typecacheof(list(\
										/mob/living/simple_animal/hostile/boss,\
										/mob/living/carbon, /mob/living/simple_animal/hostile/asteroid/elite,\
										/mob/living/simple_animal/hostile/megafauna, /mob/living/silicon,\
										/mob/dead)))

/obj/item/morphcube
	name = "strange cube"
	desc = "It has a small red button hidden on it."
	icon = 'icons/obj/assemblies.dmi'
	icon_state = "posibrain"
	var/grants = 1
	var/mob/living/ourmob = /mob/living/simple_animal/mouse
	var/mob/living/targettype
	var/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/ourspell
	var/list/cubelist = list()

/obj/item/morphcube/attack_self(mob/user)
	if(grants > 0)
		grants--
		var/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/spell = new /obj/effect/proc_holder/spell/targeted/shapeshift/morphcube()
		user.mind.AddSpell(spell)
		spell.owner = user.mind
		spell.possible_shapes = list()
		spell.possible_shapes += ourmob
		spell.shapeshift_type = ourmob
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
	invocation = "MORPH!!"
	charge_max = 100
	possible_shapes = list()
	var/datum/mind/owner = null

/obj/effect/proc_holder/spell/targeted/shapeshift/morphcube/cast(list/targets, mob/user = usr)
	if(istype(user, /mob/living/carbon))
		for(var/obj/item/morphcube/ourcube in view(user, 7))
			if(ourcube.ourspell == src)
				..()
				return TRUE
		to_chat(user, "<span class='danger'>The cube is out of range, or has been entirely destroyed!</span>")
		return FALSE
	else
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
