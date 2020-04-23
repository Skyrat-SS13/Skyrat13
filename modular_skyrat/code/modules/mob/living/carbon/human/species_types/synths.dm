/datum/species/synth
	name = "Synthetic" //inherited from the real species, for health scanners and things
	id = "synth"
	say_mod = "beep boops" //inherited from a user's real species
	sexes = 1 //read below, degenerate
	species_traits = list(NOTRANSSTING) //all of these + whatever we inherit from the real species. I know you sick fucks want to fuck synths so yes you get genitals. Degenerates.
	inherent_traits = list(TRAIT_VIRUSIMMUNE,TRAIT_NOHUNGER) //Now limbs can be disabled and dismembered, and they breathe for balance reasons.
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	dangerous_existence = 0 //not dangerous anymore i guess
	blacklisted = 0 //not blacklisted anymore
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc //fuck it
	gib_types = /obj/effect/gibspawner/robot
	damage_overlay_type = "synth"
	limbs_id = "synth"
	initial_species_traits = list(NOTRANSSTING) //for getting these values back for assume_disguise()
	initial_inherent_traits = list(TRAIT_VIRUSIMMUNE,TRAIT_NOHUNGER) //blah blah i explained above piss
	disguise_fail_health = 45 //When their health gets to this level their synthflesh partially falls off
	fake_species = null //a species to do most of our work for us, unless we're damaged
	var/isdisguised = FALSE //boolean to help us with disguising proper
	var/obj/item/organ/tongue/faketongue //tongue we use when disguised to handle speech

/datum/species/synth/proc/assume_disguise(datum/species/S, mob/living/carbon/human/H) //rework the proc for it to NOT fuck up with dunmer/other skyrat custom races
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
		screamsounds = S.screamsounds
		femalescreamsounds = S.femalescreamsounds
		isdisguised = TRUE
		if((S.mutanttongue && !faketongue) || (S.mutanttongue.type != faketongue.type))
			if(faketongue)
				qdel(faketongue)
			faketongue = new S.mutanttongue()
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
		icon_limbs = initial(icon_limbs)
		limbs_id = initial(limbs_id)
		use_skintones = initial(use_skintones)
		sexes = initial(sexes)
		fixed_mut_color = ""
		hair_color = ""
		screamsounds = initial(screamsounds)
		femalescreamsounds = initial(femalescreamsounds)
		if(faketongue)
			qdel(faketongue)
		isdisguised = TRUE

	for(var/X in H.bodyparts) //propagates the damage_overlay changes
		var/obj/item/bodypart/BP = X
		BP.update_limb()
	H.update_body_parts() //to update limb icon cache with the new damage overlays

/datum/species/synth/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	H.physiology.clone_mod = 0
	assume_disguise(old_species, H)
	RegisterSignal(H, COMSIG_MOB_SAY, .proc/handle_speech)

/datum/species/synth/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.physiology.clone_mod = initial(H.physiology.clone_mod)
	UnregisterSignal(H, COMSIG_MOB_SAY)

/datum/species/synth/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/medicine/synthflesh)
		chem.reaction_mob(H, TOUCH, 2 ,0) //heal a little
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE
	return ..()

/datum/species/synth/proc/handle_speech(datum/source, list/speech_args)
	if(ishuman(source))
		var/mob/living/carbon/human/L = source
		if(fake_species && L.health >= disguise_fail_health)
			if(faketongue)
				faketongue.handle_speech(source, speech_args) //if we're above the health threshold, we use our fake tongue
		else if(L.health < disguise_fail_health)
			speech_args[SPEECH_SPANS] |= SPAN_ROBOT //otherwise, robospeak
	else
		return

/datum/species/synth/proc/unassume_disguise(mob/living/carbon/human/H)
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
	screamsounds = initial(screamsounds)
	femalescreamsounds = initial(femalescreamsounds)
	isdisguised = FALSE

/datum/species/synth/apply_damage(damage, damagetype = BRUTE, def_zone = null, blocked, mob/living/carbon/human/H, forced = FALSE)
	..()
	var/actualhealth = (100 - (H.getBruteLoss() + H.getFireLoss() + H.getOxyLoss() + H.getToxLoss() + H.getCloneLoss()))
	if((H.actualhealth < disguise_fail_health) && isdisguised)
		unassume_disguise(H)
		isdisguised = !isdisguised
	else if((H.actualhealth >= disguise_fail_health) && !isdisguised)
		assume_disguise(fake_species, H)
		isdisguised = !isdisguised

/datum/species/synth/handle_hair(mob/living/carbon/human/H, forced_colour)
	if(fake_species && isdisguised)
		fake_species.handle_hair(H, forced_colour)
	else
		return ..()


/datum/species/synth/handle_body(mob/living/carbon/human/H)
	if(fake_species && isdisguised)
		fake_species.handle_body(H)
	else
		return ..()


/datum/species/synth/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	if(fake_species && isdisguised)
		fake_species.handle_body(H,forced_colour)
	else
		return ..()
