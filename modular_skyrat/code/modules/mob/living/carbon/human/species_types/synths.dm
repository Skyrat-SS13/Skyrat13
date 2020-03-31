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