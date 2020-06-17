//synth thing (doing it as an actual species thing would be wayyy harder to do).
/datum/quirk/synthetic
	name = "Synthetic"
	desc = "You're not actually the species you seem to be. You're a synth! You generally function in the same manner as IPCs, but with a organic skin hiding your true self."
	value = 0
	mob_trait = TRAIT_SYNTH
	languagewhitelist =list("Encoded Audio Language")
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

//speech impediments
/datum/quirk/speech_impediment_rl
	name = "Speech impediment (r as l)"
	desc = "You mispronounce \"r\" as \"l\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_rl/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_rl)

/datum/quirk/speech_impediment_rl/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_rl)


/datum/quirk/speech_impediment_lw
	name = "Speech impediment (l as w)"
	desc = "You mispronounce \"l\" as \"w\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_lw/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_lw)

/datum/quirk/speech_impediment_lw/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_lw)


/datum/quirk/speech_impediment_rw
	name = "Speech impediment (r as w)"
	desc = "You mispronounce \"r\" as \"w\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_rw/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_rw)

/datum/quirk/speech_impediment_rw/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_rw)

/datum/quirk/speech_impediment_rw_lw
	name = "Speech impediment (r and l as w)"
	desc = "You mispronounce \"r\" and \"l\" as \"w\""
	value = 0
	medical_record_text = "Patient experiences difficulty in pronouncing certain phonemes."

/datum/quirk/speech_impediment_rw_lw/add()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.enable_speech_mod(/datum/speech_mod/impediment_rw_lw)

/datum/quirk/speech_impediment_rw_lw/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		H.disable_speech_mod(/datum/speech_mod/impediment_rw_lw)

/datum/quirk/hypnotic_stupor
	name = "Hypnotic Stupor"
	desc = "Your prone to episodes of extreme stupor that leaves you extremely suggestible."
	value = 0
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "Patient has an untreatable condition with their brain, wiring them to be extreamly suggestible..."

/datum/quirk/hypnotic_stupor/add()
	var/datum/brain_trauma/severe/hypnotic_stupor/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

//uncontrollable laughter
/datum/quirk/joker
	name = "Pseudobulbar Affect"
	desc = "At random intervals, you suffer uncontrollable bursts of laughter."
	value = 0
	medical_record_text = "Patient suffers with sudden and uncontrollable bursts of laughter."
	var/pcooldown = 0
	var/pcooldown_time = 60 SECONDS

/datum/quirk/joker/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	if(H && istype(H))
		var/obj/item/paper/joker/laughing = new(get_turf(H))
		H.put_in_active_hand(laughing)

/obj/item/paper/joker
	name = "disability card"
	icon = 'modular_skyrat/icons/obj/card.dmi'
	icon_state = "joker"
	desc = "Smile, though your heart is aching."
	info = "<i>\
			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>\
			<div style='margin-top:20px;margin-bottom:20px;font-size:150%;'>\
			Forgive my laughter:<br>\
			I have a condition.\
			</div>\
			</div>\
			</i>\
			<br>\
			<center>\
			<b>\
			MORE ON BACK\
			</b>\
			</center>"
	var/info2 = "<i>\
			<div style='border-style:solid;text-align:center;border-width:5px;margin: 20px;margin-bottom:0px'>\
			<div style='margin-top:20px;margin-bottom:20px;font-size:100%;'>\
			<b>\
			It's a medical condition causing sudden,<br>\
			frequent and uncontrollable laughter that<br>\
			doesn't match how you feel.<br>\
			It can happen in people with a brain injury<br>\
			or certain neurological conditions.<br>\
			</b>\
			</div>\
			</div>\
			</i>\
			<br>\
			<center>\
			<b>\
			KINDLY RETURN THIS CARD\
			</b>\
			</center>"
	var/flipped = FALSE

/obj/item/paper/joker/update_icon()
	..()
	icon_state = "joker"

/obj/item/paper/joker/AltClick(mob/living/carbon/user, obj/item/I)
	if(flipped)
		info = initial(info)
		flipped = FALSE
		to_chat(user, "<span class='notice'>You unflip the card.</span>")
	else
		info = info2
		flipped = TRUE
		to_chat(user, "<span class='notice'>You flip the card.</span>")

/datum/quirk/joker/process()
	if(pcooldown > world.time)
		return
	pcooldown = world.time + pcooldown_time
	var/mob/living/carbon/human/H = quirk_holder
	if(H && istype(H))
		if(H.stat == CONSCIOUS)
			if(prob(20))
				H.emote("laugh")
				addtimer(CALLBACK(H, /mob/proc/emote, "laugh"), 5 SECONDS)
				addtimer(CALLBACK(H, /mob/proc/emote, "laugh"), 10 SECONDS)

/datum/quirk/longtimer
	name = "Longtimer"
	desc = "You've been around for a long time and seen more than your fair share of action, suffering some pretty nasty scars along the way. For whatever reason, you've declined to get them removed or augmented."
	value = 0
	gain_text = "<span class='notice'>Your body has seen better days.</span>"
	lose_text = "<span class='notice'>Your sins may wash away, but those scars are here to stay...</span>"
