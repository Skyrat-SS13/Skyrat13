
/datum/antagonist/vampire
	name = "Vampire"
	roundend_category = "bloodline vampire"
	antagpanel_category = "Bloodline Vampire"
	job_rank = ROLE_BLOODLINE_VAMPIRE
	threat = 5

	var/power = 0
	var/max_power = 100
	var/list/powers = list() //all powers we've gained from being a vampire

/datum/antagonist/vampire/on_gain()
	SSticker.mode.vampires |= owner
	AssignStarterPowersAndStats()// Give Powers & Stats

/datum/antagonist/vampire/proc/BuyPower(datum/action/vampire/power) //(obj/effect/proc_holder/spell/power)
	powers += power
	power.Grant(owner.current)// owner.AddSpell(power)

/datum/antagonist/vampire/proc/AssignStarterPowersAndStats()
	// Blood/Rank Counter
	//add_hud()
	//update_hud(TRUE) 	// Set blood value, current rank
	// Powers
	BuyPower(new /datum/action/vampire/vitality)
	BuyPower(new /datum/action/vampire/stamina)
	//BuyPower(new /datum/action/vampire/masquerade)
	//BuyPower(new /datum/action/vampire/veil)
	/*
	// Traits
	for(var/T in defaultTraits)
		ADD_TRAIT(owner.current, T, BLOODSUCKER_TRAIT)
	if(HAS_TRAIT(owner.current, TRAIT_TOXINLOVER)) //No slime bonuses here, no thank you
		had_toxlover = TRUE
		REMOVE_TRAIT(owner.current, TRAIT_TOXINLOVER, SPECIES_TRAIT)
	// Traits: Species
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		S.species_traits |= DRINKSBLOOD
	// Clear Addictions
	owner.current.reagents.addiction_list = list() // Start over from scratch. Lucky you! At least you're not addicted to blood anymore (if you were)
	// Stats
	if(ishuman(owner.current))
		var/mob/living/carbon/human/H = owner.current
		var/datum/species/S = H.dna.species
		// Make Changes
		H.physiology.brute_mod *= 0.8
		H.physiology.cold_mod = 0
		H.physiology.stun_mod *= 0.5
		H.physiology.siemens_coeff *= 0.75 	//base electrocution coefficient  1
		S.punchdamagelow += 1       //lowest possible punch damage   0
		S.punchdamagehigh += 1      //highest possible punch damage	 9
		if(istype(H) && owner.assigned_role == "Clown")
			H.dna.remove_mutation(CLOWNMUT)
			to_chat(H, "As a vampiric clown, you are no longer a danger to yourself. Your nature is subdued.")
	// Physiology
	CheckVampOrgans() // Heart, Eyes
	// Language
	owner.current.grant_language(/datum/language/vampiric, TRUE, TRUE, LANGUAGE_BLOODSUCKER)
	owner.hasSoul = FALSE 		// If false, renders the character unable to sell their soul.
	owner.isholy = FALSE 		// is this person a chaplain or admin role allowed to use bibles
	// Disabilities
	CureDisabilities()
	*/