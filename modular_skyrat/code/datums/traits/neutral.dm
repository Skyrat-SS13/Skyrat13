//gigantism
/datum/quirk/gigantism
	name = "Gigantism"
	desc = "You are exceptionally big."
	value = 0
	mob_trait = TRAIT_GIGANTISM
	medical_record_text = "Patient's body is exceptionally large."

/datum/quirk/gigantism/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(1.25, 1.25)

/datum/quirk/gigantism/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(0.8, 0.8)

//small
/datum/quirk/small
	name = "Small"
	desc = "You are a bit... small. With none of the benefits."
	value = 0
	mob_trait = TRAIT_SMALL

/datum/quirk/small/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(0.9, 0.9)

/datum/quirk/small/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.transform = H.transform.Scale(1.1, 1.1)

//synth thing (doing it as an actual species thing would be wayyy harder to do).
/datum/quirk/synthetic
	name = "Synthetic"
	desc = "You're not actually the species you seem to be. You're a synth! You will still have your old species traits, however you will not be infected by viruses, get hungry nor process any reagents aside from synthflesh."
	value = 0
	mob_trait = TRAIT_SYNTH
	var/list/blacklistedspecies = list(/datum/species/synth, /datum/species/android, /datum/species/ipc, /datum/species/synthliz, /datum/species/shadow, /datum/species/plasmaman, /datum/species/jelly, /datum/species/jelly/slime)

/datum/quirk/synthetic/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		if(!(H.dna.species.type in blacklistedspecies))
			H.set_species(/datum/species/synth) //the synth on_gain stuff handles everything, that's why i made this shit a quirk and not a roundstart race or whatever
		else
			to_chat(H, "<span class='warning'>Your species is blacklisted from being a synth. Your synth quirk will be removed and your species has not been changed.</span>")
			QDEL_IN(src, 120)
			return

/datum/quirk/synthetic/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/thespecies = H.dna.species
		if(thespecies.type == /datum/species/synth)
			var/datum/species/synth/synthspecies = thespecies
			var/datum/species/oldspecies = synthspecies.fake_species
			if(oldspecies)
				H.set_species(oldspecies)
			else
				H.set_species(/datum/species/ipc) //we fall back on IPC if something stinky happens. Shouldn't happe but you know.
				to_chat(H, "<span class='warning'>Uh oh, stinky! Something poopy happened to your fakespecies! You have been set to an IPC as a fallback.</span>") //shouldn't happen. if it does uh oh.
		else
			to_chat(H, "<span class='warning'>The [H.dna.species.name] species is blacklisted from being a synth. You will stay with the normal, non-synth race. It could mean that Bob Joga broke the code too.</span>")
