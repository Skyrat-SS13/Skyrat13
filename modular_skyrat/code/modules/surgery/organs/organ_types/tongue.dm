#define TONGUE_MAX_HEALTH 60

/obj/item/organ/tongue
	name = "tongue"
	desc = "A fleshy muscle mostly used for lying."
	icon_state = "tonguenormal"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_TONGUE
	attack_verb = list("licked", "slobbered", "slapped", "frenched", "tongued")
	var/list/languages_possible
	var/say_mod = null
	var/taste_sensitivity = 15 // lower is more sensitive.
	maxHealth = TONGUE_MAX_HEALTH
	var/modifies_speech = FALSE
	var/static/list/languages_possible_base = typecacheof(list(
		/datum/language/common,
		/datum/language/draconic,
		/datum/language/codespeak,
		/datum/language/monkey,
		/datum/language/narsie,
		/datum/language/beachbum,
		/datum/language/ratvar,
		/datum/language/aphasia,
		/datum/language/slime,
		/datum/language/vampiric,
		/datum/language/dwarf,
		/datum/language/vox, //Skyrat change - adds vox language
		/datum/language/machine, //Skyrat change - adds machine language
		/datum/language/calcic, //Skyrat change - plasmaman language
		/datum/language/dunmeri, //Skyrat change - dunmer language
		/datum/language/moffic, //Skyrat change - insect language
		/datum/language/neokanji, //Skyrat change - generally asian language
		/datum/language/shadowtongue, //Skyrat change - shadowpeople language
		/datum/language/solcommon, //Skyrat change - sol common blah blah
		/datum/language/sylvan, //Skyrat change - plantpeople langauge
		/datum/language/technorussian //Skyrat change - russian stereotype language
	))
	healing_factor = STANDARD_ORGAN_HEALING*5 //Fast!!
	decay_factor = STANDARD_ORGAN_DECAY/2

/obj/item/organ/tongue/Initialize(mapload)
	. = ..()
	low_threshold_passed = "<span class='info'>Your [name] feels a little sore.</span>"
	low_threshold_cleared = "<span class='info'>Your [name] soreness has subsided.</span>"
	high_threshold_passed = "<span class='warning'>Your [name] is really starting to hurt.</span>"
	high_threshold_cleared = "<span class='info'>The pain of your [name] has subsided a little.</span>"
	now_failing = "<span class='warning'>Your [name] feels like it's about to fall out!.</span>"
	now_fixed = "<span class='info'>The excruciating pain of your [name] has subsided.</span>"
	languages_possible = languages_possible_base

/obj/item/organ/tongue/proc/handle_speech(datum/source, list/speech_args)
	return

/obj/item/organ/tongue/applyOrganDamage(d, maximum = maxHealth)
	. = ..()
	if (damage >= maxHealth)
		to_chat(owner, "<span class='userdanger'>Your tongue is singed beyond recognition, and disintegrates!</span>")
		SSblackbox.record_feedback("tally", "fermi_chem", 1, "Tongues lost to Fermi")
		qdel(src)

/obj/item/organ/tongue/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	..()
	if(say_mod && M.dna && M.dna.species)
		M.dna.species.say_mod = say_mod
	if (modifies_speech)
		RegisterSignal(M, COMSIG_MOB_SAY, .proc/handle_speech)
	M.UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/organ/tongue/Remove(special = FALSE)
	if(!QDELETED(owner))
		if(say_mod && owner.dna?.species)
			owner.dna.species.say_mod = initial(owner.dna.species.say_mod)
		UnregisterSignal(owner, COMSIG_MOB_SAY, .proc/handle_speech)
		owner.RegisterSignal(owner, COMSIG_MOB_SAY, /mob/living/carbon/.proc/handle_tongueless_speech)
	return ..()

/obj/item/organ/tongue/could_speak_language(language)
	return is_type_in_typecache(language, languages_possible)

