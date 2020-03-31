/datum/species/synth
	name = "Synthetic" //inherited from the real species, for health scanners and things
	id = "synth"
	say_mod = "beep boops" //inherited from a user's real species
	sexes = 1 //read below, degenerate
	species_traits = list(NOTRANSSTING) //all of these + whatever we inherit from the real species. I know you sick fucks want to fuck synths so yes you get genitals. Degenerates.
	inherent_traits = list(TRAIT_VIRUSIMMUNE,TRAIT_NOHUNGER,TRAIT_NOBREATH) //Now limbs can be disabled and dismembered. Why the fuck would they not? IT'S A FUCKING ROBOT NOT LIKE A FUCKING GOLEM
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	dangerous_existence = 0 //not dangerous anymore i guess
	blacklisted = 0 //not blacklisted anymore
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc //fuck it
	gib_types = /obj/effect/gibspawner/robot
	damage_overlay_type = "synth"
	limbs_id = "synth"
	initial_species_traits = list(NOTRANSSTING) //for getting these values back for assume_disguise()
	initial_inherent_traits = list(TRAIT_VIRUSIMMUNE,TRAIT_NOHUNGER,TRAIT_NOBREATH) //blah blah i explained above piss
	disguise_fail_health = 75 //When their health gets to this level their synthflesh partially falls off
	fake_species = null //a species to do most of our work for us, unless we're damaged

/datum/species/synth/assume_disguise(datum/species/S, mob/living/carbon/human/H) //rework the proc for it to NOT fuck up with dunmers/other skyrat custom races
	if(S && !istype(S, type))
		name = S.name
		say_mod = S.say_mod
		sexes = S.sexes
		species_traits = initial_species_traits.Copy()
		inherent_traits = initial_inherent_traits.Copy()
		species_traits |= S.species_traits
		inherent_traits |= S.inherent_traits
		attack_verb = S.attack_verb
		attack_sound = S.attack_sound
		miss_sound = S.miss_sound
		meat = S.meat
		mutant_bodyparts = S.mutant_bodyparts.Copy()
		mutant_organs = S.mutant_organs.Copy()
		nojumpsuit = S.nojumpsuit
		no_equip = S.no_equip.Copy()
		icon_limbs = S.icon_limbs //there you go bubsy, now dunmer synths and shit wont be FUCKING INVISIBLE
		limbs_id = S.limbs_id
		use_skintones = S.use_skintones
		fixed_mut_color = S.fixed_mut_color
		hair_color = S.hair_color
		fake_species = new S.type
	else
		name = initial(name)
		say_mod = initial(say_mod)
		species_traits = initial_species_traits.Copy()
		inherent_traits = initial_inherent_traits.Copy()
		attack_verb = initial(attack_verb)
		attack_sound = initial(attack_sound)
		miss_sound = initial(miss_sound)
		mutant_bodyparts = list()
		nojumpsuit = initial(nojumpsuit)
		no_equip = list()
		qdel(fake_species)
		fake_species = null
		meat = initial(meat)
		limbs_id = initial(limbs_id)
		use_skintones = initial(use_skintones)
		sexes = initial(sexes)
		fixed_mut_color = ""
		hair_color = ""

	for(var/X in H.bodyparts) //propagates the damage_overlay changes
		var/obj/item/bodypart/BP = X
		BP.update_limb()
	H.update_body_parts() //to update limb icon cache with the new damage overlays