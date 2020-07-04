/datum/species/synth
	name = "Synthetic" //inherited from the fake species, for health scanners and things
	id = "synth"
	say_mod = "states" //inherited from a user's fake species
	sexes = 0 //it gets it's sexes by the fake species
	species_traits = list(NOTRANSSTING,NOZOMBIE,REVIVESBYHEALING,NOHUSK,ROBOTIC_LIMBS,NO_DNA_COPY) //all of these + whatever we inherit from the real species. I know you sick fucks want to fuck synths so yes you get genitals. Degenerates.
	inherent_traits = list(TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_TOXIMMUNE, TRAIT_CLONEIMMUNE)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	dangerous_existence = 0 //not dangerous anymore i guess
	blacklisted = 0 //not blacklisted anymore
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ipc //fuck it
	gib_types = /obj/effect/gibspawner/robot
	damage_overlay_type = "robotic"
	limbs_id = "synth"
	icon_limbs = 'modular_skyrat/icons/mob/synth_parts.dmi'
	//mutant_bodyparts = list("legs" = "Digitigrade", "taur" = "None") //this probably isn't gonna work. Note: it didn't work.
	initial_species_traits = list(NOTRANSSTING,NOZOMBIE,REVIVESBYHEALING,NOHUSK,ROBOTIC_LIMBS,NO_DNA_COPY) //for getting these values back for assume_disguise()
	initial_inherent_traits = list(TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_TOXIMMUNE, TRAIT_EASYDISMEMBER, TRAIT_EASYLIMBDISABLE, TRAIT_CLONEIMMUNE) //blah blah i explained above
	disguise_fail_health = 45 //When their health gets to this level their synthflesh partially falls off
	fake_species = null //a species to do most of our work for us, unless we're damaged
	var/isdisguised = FALSE //boolean to help us with disguising proper
	var/actualhealth = 100 //value we calculate to assume disguise and etc
	//Same organs as an IPC basically, to share functionality.
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutant_heart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	exotic_blood = /datum/reagent/blood/synthetics
	//variables used for snowflakey ass races and stuff god i fukcing hate this
	var/storedeardamage = 0
	var/storedtaildamage = 0
	//Skyrat change - blood
	bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "SY")
	exotic_bloodtype = "SY"
	//AAAAAAAAAAAAAAAAAAAAAAAA I CANT EAT AAAAAAAAAAAAAAAAAAAAAAAAAA
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)

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
		nojumpsuit = S.nojumpsuit
		no_equip = S.no_equip.Copy()
		icon_limbs = S.icon_limbs //there you go bubsy, now dunmer synths and shit wont be FUCKING INVISIBLE
		limbs_id = S.limbs_id
		use_skintones = S.use_skintones
		fixed_mut_color = S.fixed_mut_color
		hair_color = S.hair_color
		screamsounds = S.screamsounds.Copy()
		femalescreamsounds = S.femalescreamsounds.Copy()
		storedeardamage = H.getOrganLoss(ORGAN_SLOT_EARS)
		mutantears = S.mutantears
		qdel(H.getorganslot(ORGAN_SLOT_EARS))
		var/obj/item/organ/ears = new mutantears
		ears.Insert(H)
		H.setOrganLoss(ORGAN_SLOT_EARS, storedeardamage)
		mutanttail = S.mutanttail
		if(mutanttail)
			qdel(H.getorganslot(ORGAN_SLOT_TAIL))
			var/obj/item/organ/tail = new mutanttail
			tail.Insert(H)
		H.setOrganLoss(ORGAN_SLOT_TAIL, storedtaildamage)
		isdisguised = TRUE
		fake_species = new S.type
	else
		name = initial(name)
		say_mod = initial(say_mod)
		species_traits = initial_species_traits.Copy()
		inherent_traits = initial_inherent_traits.Copy()
		attack_verb = initial(attack_verb)
		attack_sound = initial(attack_sound)
		miss_sound = initial(miss_sound)
		nojumpsuit = initial(nojumpsuit)
		no_equip = list()
		meat = initial(meat)
		icon_limbs = initial(icon_limbs)
		limbs_id = initial(limbs_id)
		use_skintones = initial(use_skintones)
		sexes = initial(sexes)
		fixed_mut_color = ""
		hair_color = ""
		screamsounds = list('modular_citadel/sound/voice/scream_silicon.ogg')
		femalescreamsounds = list()
		fake_species = new /datum/species/human
		isdisguised = FALSE

	handle_mutant_bodyparts(H)
	H.regenerate_icons()

/datum/species/synth/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	//H.grant_language(/datum/language/machine)
	assume_disguise(old_species, H)
	RegisterSignal(H, COMSIG_MOB_SAY, .proc/handle_speech)
	for(var/obj/item/bodypart/BP in H.bodyparts)
		BP.synthetic = TRUE
		BP.change_bodypart_status(BODYPART_ROBOTIC)
		BP.render_like_organic = TRUE

/datum/species/synth/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	//H.remove_language(/datum/language/machine)
	UnregisterSignal(H, COMSIG_MOB_SAY)
	for(var/obj/item/bodypart/BP in H.bodyparts)
		BP.synthetic = FALSE
		BP.change_bodypart_status(BODYPART_ORGANIC)
		BP.render_like_organic = TRUE

/datum/species/synth/proc/handle_speech(datum/source, list/speech_args)
	if(ishuman(source))
		var/mob/living/carbon/human/H = source
		actualhealth = (100 - (H.getBruteLoss() + H.getFireLoss() + H.getOxyLoss() + H.getToxLoss() + H.getCloneLoss()))
		if(!isdisguised || (actualhealth < disguise_fail_health))
			speech_args[SPEECH_SPANS] |= SPAN_ROBOT
	return

/datum/species/synth/proc/unassume_disguise(mob/living/carbon/human/H)
	name = initial(name)
	say_mod = initial(say_mod)
	species_traits = initial_species_traits.Copy()
	inherent_traits = initial_inherent_traits.Copy()
	attack_verb = initial(attack_verb)
	attack_sound = initial(attack_sound)
	miss_sound = initial(miss_sound)
	nojumpsuit = initial(nojumpsuit)
	no_equip = list()
	meat = initial(meat)
	limbs_id = initial(limbs_id)
	use_skintones = initial(use_skintones)
	storedeardamage = H.getOrganLoss(ORGAN_SLOT_EARS)
	mutantears = initial(mutantears)
	qdel(H.getorganslot(ORGAN_SLOT_EARS))
	var/obj/item/organ/ears = new mutantears
	ears.Insert(H)
	H.setOrganLoss(ORGAN_SLOT_EARS, storedeardamage)
	storedtaildamage = H.getOrganLoss(ORGAN_SLOT_TAIL)
	mutanttail = initial(mutanttail)
	qdel(H.getorganslot(ORGAN_SLOT_TAIL))
	sexes = initial(sexes)
	fixed_mut_color = ""
	hair_color = ""
	screamsounds = list('modular_citadel/sound/voice/scream_silicon.ogg')
	femalescreamsounds = list()
	isdisguised = FALSE
	handle_mutant_bodyparts(H)
	H.regenerate_icons()

/datum/species/synth/spec_life(mob/living/carbon/human/H)
	. = ..()
	actualhealth = (100 - (H.getBruteLoss() + H.getFireLoss() + H.getOxyLoss() + H.getToxLoss() + H.getCloneLoss()))
	if((actualhealth < disguise_fail_health) && isdisguised)
		unassume_disguise(H)
		H.visible_message("<span class='danger'>[H]'s disguise falls apart!</span>", "<span class='userdanger'>Your disguise falls apart!</span>")
	else if((actualhealth >= disguise_fail_health) && !isdisguised)
		assume_disguise(fake_species, H)
		H.visible_message("<span class='warning'>[H] morphs their appearance to that of [fake_species.name].</span>", "<span class='notice'>You morph your appearance to that of [fake_species.name].</span>")

/datum/species/synth/handle_hair(mob/living/carbon/human/H, forced_colour)
	if(fake_species && isdisguised)
		return fake_species.handle_hair(H, forced_colour)
	else
		return ..()

/datum/species/synth/handle_body(mob/living/carbon/human/H)
	if(fake_species && isdisguised)
		return fake_species.handle_body(H)
	else
		return ..()


/datum/species/synth/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	if(fake_species && isdisguised)
		return fake_species.handle_mutant_bodyparts(H,forced_colour)
	else
		return ..()
