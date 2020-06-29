/datum/reagent/medicine/strange_reagent
	description = "A miracle drug that can bring people back from the dead based on the dosage. For every 20 units of brute or burn damage, 1u of this reagent is required. Deals a small amount of damage on metabolism."

/datum/reagent/medicine/strange_reagent/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(M.stat == DEAD)
		var/true_reaction_volume = reac_volume + M.reagents.get_reagent_amount(/datum/reagent/medicine/strange_reagent)
		if(M.suiciding || M.hellbound) //they are never coming back
			M.visible_message("<span class='warning'>[M]'s body does not react... it seems they are not meant for this world.</span>")
			return
		if(M.getFireLoss() + M.getBruteLoss() >= true_reaction_volume*20) //body is too damaged to be revived
			//10u is required to heal 200 total damage.
			//20u is required to heal 400 total damage.
			//40u is required to heal 800 total damage.
			M.visible_message("<span class='warning'>[M]'s body convulses a bit, and then falls still once more.</span>")
			M.do_jitter_animation(10)
			return
		else
			M.visible_message("<span class='warning'>[M]'s body starts convulsing!</span>")
			M.notify_ghost_cloning(source = M)
			M.do_jitter_animation(10)
			addtimer(CALLBACK(M, /mob/living/carbon.proc/do_jitter_animation, 10), 40) //jitter immediately, then again after 4 and 8 seconds
			addtimer(CALLBACK(M, /mob/living/carbon.proc/do_jitter_animation, 10), 80)
			spawn(100) //so the ghost has time to re-enter
				if(iscarbon(M))
					var/mob/living/carbon/C = M
					if(!(C.dna && C.dna.species && (NOBLOOD in C.dna.species.species_traits)))
						C.blood_volume = max(C.blood_volume, BLOOD_VOLUME_BAD * 1.2) //so you don't instantly re-die from a lack of blood
					for(var/organ in C.internal_organs)
						var/obj/item/organ/O = organ
						if(O.damage > O.maxHealth * 0.8)
							O.setOrganDamage(O.maxHealth * 0.8) //so you don't instantly die from organ damage when being revived

				M.adjustOxyLoss(-reac_volume/2, TRUE) //we use reac_volume instead of the true volume to impede cheeky healing stacking
				M.adjustToxLoss(-reac_volume/3, TRUE)
				M.updatehealth()
				if(M.revive())
					M.grab_ghost()
					M.emote("gasp")
					log_combat(M, M, "revived", src)
	..()

/datum/reagent/medicine/strange_reagent/on_mob_life(mob/living/carbon/M)
	M.adjustBruteLoss(0.2*REM, 0)
	M.adjustFireLoss(0.2*REM, 0)
	..()
	. = 1

/datum/reagent/medicine/synthflesh
	description = "Instantly heals brute and burn damage when the chemical is applied via touch application, but also deals toxin damage relative to the brute and burn damage healed. Capable of restoring the appearance of synths."
	overdose_threshold = 35 //no synth species abusing

/datum/reagent/medicine/synthflesh/reaction_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)

	if(!iscarbon(M))
		return ..()

	if(M.stat == DEAD)
		show_message = 0

	switch(method)
		if(INJECT)
			return
		if(INGEST)
			var/mob/living/carbon/C = M
			C.emote("cough")
			C.vomit()
			if(show_message) to_chat(C, "<span class='danger'>Your stomach starts to hurt!</span>")
		if(PATCH,TOUCH,VAPOR)
			var/amount_healed = -(M.adjustBruteLoss(-1.25 * reac_volume) + M.adjustFireLoss(-1.25 * reac_volume))
			if(amount_healed && M.stat != DEAD)
				var/mob/living/carbon/human/ourguy = M
				if(ourguy)
					if(ourguy.dna.species.type != /datum/species/synth)
						ourguy.adjustToxLoss(amount_healed * 0.25)
					else
						if(!overdosed)
							ourguy.adjustToxLoss(-(amount_healed * 0.75)) //synths heal toxins with synthflesh
							ourguy.adjustCloneLoss(-(amount_healed * 1))
						else
							ourguy.adjustToxLoss(1)
				else
					M.adjustToxLoss(amount_healed * 0.25)
				SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "painful_medicine", /datum/mood_event/painful_medicine)
				if(show_message) to_chat(M, "<span class='danger'>You feel your burns and bruises healing! It stings like hell!</span>")
			else if(!amount_healed && M.stat != DEAD) //synths can use it to heal toxins and cloning damage even without other injuries
				var/mob/living/carbon/human/ourguy = M
				if(ourguy)
					if(ourguy.dna.species.type == /datum/species/synth)
						ourguy.adjustToxLoss(-(reac_volume * 0.75))
						ourguy.adjustCloneLoss(-(reac_volume * 1))
						var/datum/species/synth/replicant = ourguy.dna.species
						if(replicant.fake_species && (replicant.isdisguised == FALSE))
							if(replicant.actualhealth >= replicant.disguise_fail_health)
								replicant.assume_disguise(replicant.fake_species, ourguy)
			var/vol = reac_volume + M.reagents.get_reagent_amount(/datum/reagent/medicine/synthflesh)
			if(HAS_TRAIT_FROM(M, TRAIT_HUSK, "burn") && M.getFireLoss() < THRESHOLD_UNHUSK && (vol > overdose_threshold))
				M.cure_husk("burn")
				M.visible_message("<span class='nicegreen'>Most of [M]'s burnt off or charred flesh has been restored!")
	..()

/datum/reagent/medicine/synthflesh/overdose_start(mob/living/M)
	var/mob/living/carbon/human/H = M
	if(H)
		if((H.dna.species.type == /datum/species/synth) && (H.stat != DEAD))
			to_chat(H, "<span class='userdanger'>You feel like you took too much of [name]!</span>")
			overdosed = 1

/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Let's not cripple synth ops

/datum/reagent/medicine/lesser_syndicate_nanites
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/stimulants
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Syndicate developed 'accelerants' for synths?

/datum/reagent/medicine/neo_jelly
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Should synthetic miners not be able to use pens? Up for a debate probably but for now lets leave their contents in

/datum/reagent/medicine/lavaland_extract
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/leporazine
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

//REAGENTS FOR SYNTHS
/datum/reagent/medicine/system_cleaner
	name = "System Cleaner"
	description = "Neutralizes harmful chemical compounds inside synthetic systems."
	reagent_state = LIQUID
	color = "#F1C40F"
	taste_description = "ethanol"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/system_cleaner/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-2*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type,1)
	..()

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	description = "Repairs brain damage in synthetics."
	color = "#727272"
	taste_description = "metal"
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3*REM)
	if(prob(10))
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	..() 

/datum/reagent/medicine/nanite_slurry
	name = "Nanite Slurry"
	description = "If used in touch-based applications, immediately repairs and refurbishes synthetic lifeforms, also does that while circulating in their system."
	reagent_state = LIQUID
	pH = 7.2
	color = "#cccccc"
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/nanite_slurry/reaction_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	var/mob/living/carbon/C = M
	if(C)
		if(!(method in list(INGEST, VAPOR, INJECT)))
			C.heal_bodypart_damage(reac_volume, reac_volume, stamina = 0, updating_health = TRUE, only_robotic = TRUE, only_organic = FALSE)
			if(show_message)
				to_chat(C, "<span class='notice'>You feel much better...</span>")
	..()

/datum/reagent/medicine/nanite_slurry/on_mob_life(mob/living/L)
	var/mob/living/carbon/C = L
	C.heal_bodypart_damage(0.5*REM, 0.5*REM, stamina = 0, updating_health = TRUE, only_robotic = TRUE, only_organic = FALSE)
	..()
	. = 1

//Used to cure scars easily
/datum/reagent/medicine/corticosteroids
	name = "Corticosteroids"
	description = "Synthetic steroids, used to rapidly stimulate the repair process of keratin on the user."
	reagent_state = LIQUID
	color = "#ff0095"
	metabolization_rate = 1.5 * REAGENTS_METABOLISM
	pH = 6.5
	value = REAGENT_VALUE_RARE
	can_synth = TRUE
	var/method_used = INJECT

/datum/reagent/medicine/corticosteroids/reaction_mob(mob/living/M, method, reac_volume, show_message, touch_protection)
	. = ..()
	method_used = method

/datum/reagent/medicine/corticosteroids/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(method_used in list(INJECT, PATCH))
			if(C.all_scars && C.all_scars.len)
				var/datum/scar/S = pick(C.all_scars)
				if(istype(S) && !S.permanent)
					to_chat(C, "<span class='notice'>You feel one of your scars quickly fading away!</span>")
					qdel(S)
		else
			C.adjust_disgust(10)
			C.adjust_blurriness(10)
			C.AdjustDazed(15)
			if(prob(15))
				C.vomit(20, TRUE, TRUE)
			if(prob(5))
				C.AdjustKnockdown(50, TRUE)
				C.AdjustUnconscious(50)

//Used to treat wounds - the effects vary depending on type
/datum/reagent/medicine/fibrin
	name = "Fibrin"
	description = "A substance used to treat exposed wounds - effect varies."
	reagent_state = LIQUID
	pH = 7.2
	color = "#c0a890"
	process_flags = REAGENT_ORGANIC

/datum/reagent/medicine/fibrin/reaction_mob(mob/living/M, method, reac_volume, show_message, touch_protection)
	. = ..()
	if(method == TOUCH)
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			if(C.all_wounds.len)
				var/datum/wound/W = pick(C.all_wounds)
				if(istype(W))
					W.on_hemostatic(reac_volume)
	else
		M.adjustToxLoss(reac_volume * 0.8)
