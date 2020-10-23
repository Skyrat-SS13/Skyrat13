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
				//literally nothing is healed, we just revive the person
				M.updatehealth()
				if(M.revive())
					M.grab_ghost()
					M.emote("gasp")
					log_combat(M, M, "revived", src)
	..()

/datum/reagent/medicine/strange_reagent/on_mob_life(mob/living/carbon/M)
	//just to override the original lmao
	. = ..()

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
			var/current_brute_damage = M.getBruteLoss()
			var/current_fire_damage = M.getFireLoss()
			M.adjustBruteLoss(-1.25 * reac_volume)
			M.adjustFireLoss(-1.25 * reac_volume)
			var/amount_healed = ((current_brute_damage - M.bruteloss) + (current_fire_damage - M.fireloss))
			if(amount_healed && M.stat != DEAD)
				var/mob/living/carbon/human/ourguy = M
				if(ourguy)
					if(ourguy.dna.species.type != /datum/species/synth)
						ourguy.adjustToxLoss(-(amount_healed * 0.25))
					else
						if(!overdosed)
							ourguy.adjustToxLoss(amount_healed * 0.75) //synths heal toxins with synthflesh
							ourguy.adjustCloneLoss(amount_healed * 1)
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

/datum/reagent/medicine/kerosene
	name = "Kerosene"
	description = "When injected or ingested by a synthetic, slowly regenerates oxygen damage. When applied with a patch, instantly regenerates some oxygen damage."
	reagent_state = LIQUID
	pH = 7.2
	color = "#cccccc"
	process_flags = REAGENT_SYNTHETIC
	metabolization_rate = 1

/datum/reagent/medicine/kerosene/reaction_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(method == TOUCH)
		M.adjustOxyLoss(min(-10, -reac_volume))
	..()

/datum/reagent/medicine/kerosene/on_mob_life(mob/living/L)
	L.adjustOxyLoss(-1 * REM)
	..()
	. = 1

//Repathed preservahyde
/datum/reagent/medicine/preservahyde
	name = "Preservahyde"
	description = "A powerful preservation agent, utilizing the preservative effects of formaldehyde with significantly less of the histamine."
	reagent_state = LIQUID
	color = "#f7685e"
	metabolization_rate = REAGENTS_METABOLISM * 0.25

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
				while(reac_volume && length(C.all_wounds))
					var/datum/wound/W = pick(C.all_wounds)
					if(istype(W))
						W.on_hemostatic(reac_volume)
						reac_volume = max(0, reac_volume - 10)
	else
		M.adjustToxLoss(reac_volume * 0.8)

//Painkiller medicine
/datum/reagent/medicine/paracetamol
	name = "Paracetamol"
	description = "Most probably know this as Tylenol, but this chemical is a mild, simple painkiller."
	taste_description = "sickness"
	reagent_state = LIQUID
	color = "#c8a5dc"
	overdose_threshold = 30
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/medicine/paracetamol/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, 40) //Very effective painkiller

/datum/reagent/medicine/paracetamol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 40)

/datum/reagent/medicine/paracetamol/overdose_process(mob/living/M)
	. = ..()
	if(iscarbon(M) && prob(15))
		var/mob/living/carbon/C = M
		C.custom_pain("Your head feels like it's going to explode!", 20, FALSE, C.get_bodypart(BODY_ZONE_HEAD))

/datum/reagent/medicine/tramadol
	name = "Tramadol"
	description = "A simple, yet effective painkiller. Don't mix with alcohol."
	taste_description = "sourness"
	reagent_state = LIQUID
	color = "#c86dfd"
	var/initial_volume = 0 //Hacky way to make tramadol heal pain about equal to the quantity consumed

/datum/reagent/medicine/tramadol/reaction_mob(mob/living/M, method, reac_volume, show_message, touch_protection)
	. = ..()
	initial_volume = reac_volume

/datum/reagent/medicine/tramadol/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, min(initial_volume, 20))

/datum/reagent/medicine/tramadol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, min(initial_volume, 20))

/datum/reagent/medicine/tramadol/on_mob_life(mob/living/carbon/M)
	. = ..()
	if(M.drunkenness)
		M.adjustOrganLoss(ORGAN_SLOT_LIVER, initial_volume/30) // More tramadol = More liver destruction

/datum/reagent/medicine/bicaridine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/bicaridine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/kelotane/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/kelotane/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/tricordrazine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, 15)

/datum/reagent/medicine/tricordrazine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 15)

/datum/reagent/medicine/modafinil/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, 45)

/datum/reagent/medicine/modafinil/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 45)

/datum/reagent/medicine/lavaland_extract/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_PAINKILLER, 30)

/datum/reagent/medicine/lavaland_extract/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 30)

/datum/reagent/medicine/antitoxin/on_mob_life(mob/living/carbon/M)
	. = ..()
	for(var/obj/item/organ/O in M.internal_organs)
		if(prob(20) && !(O.slot == ORGAN_SLOT_BRAIN))
			O.applyOrganDamage(-5 * REM)

/datum/reagent/medicine/antitoxin/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_ANTITOX)

/datum/reagent/medicine/antitoxin/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_ANTITOX)

/datum/reagent/medicine/charcoal/on_mob_life(mob/living/carbon/M)
	. = ..()
	for(var/obj/item/organ/O in M.internal_organs)
		if(prob(20) && !(O.slot == ORGAN_SLOT_BRAIN))
			O.applyOrganDamage(-5 * REM)

/datum/reagent/medicine/charcoal/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_ANTITOX)

/datum/reagent/medicine/charcoal/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_ANTITOX)

/datum/reagent/medicine/cryoxadone/on_mob_metabolize(mob/living/L)
	. = ..()
	if(L.bodytemperature < T0C)
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.add_chem_effect(CE_PAINKILLER, 100)

/datum/reagent/medicine/cryoxadone/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 100)

/datum/reagent/medicine/pyroxadone/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		if(C.bodytemperature >= BODYTEMP_HEAT_DAMAGE_LIMIT)
			C.add_chem_effect(CE_PAINKILLER, 100)

/datum/reagent/medicine/pyroxadone/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_PAINKILLER, 100)

//Sterilizine actually does double the cleaning since it calls the parent
/datum/reagent/space_cleaner/sterilizine/reaction_obj(obj/O, reac_volume)
	. = ..()
	if(O.germ_level)
		O.janitize(-(reac_volume * 100))

/datum/reagent/space_cleaner/sterilizine/reaction_turf(turf/T, reac_volume)
	. = ..()
	if(T.germ_level)
		T.janitize(-(reac_volume * 100))

/datum/reagent/space_cleaner/sterilizine/reaction_mob(mob/living/M, method, reac_volume)
	. = ..()
	if(M.germ_level < INFECTION_LEVEL_TWO)
		M.janitize(-(reac_volume * 20))

//Antibiotics
/datum/reagent/space_cleaner/sterilizine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_ANTIBIOTIC, 35)

/datum/reagent/space_cleaner/sterilizine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_ANTIBIOTIC, 35)

/datum/reagent/medicine/spaceacillin/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_ANTIBIOTIC, 75)

/datum/reagent/medicine/spaceacillin/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_ANTIBIOTIC, 75)

/datum/reagent/medicine/nalidixic_acid
	name = "Nalidixic Acid"
	description = "A weak, but synthetizable, antibiotic."
	color = "#fc7a7a"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	pH = 8.1

/datum/reagent/medicine/nalidixic_acid/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_ANTIBIOTIC, 50)

/datum/reagent/medicine/nalidixic_acid/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_ANTIBIOTIC, 50)

//Stabilizing medicine
/datum/reagent/medicine/inaprovaline/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_STABLE)
		C.add_chem_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/inaprovaline/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_STABLE)
		C.remove_chem_effect(CE_PAINKILLER, 10)

/datum/reagent/medicine/epinephrine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_STABLE)
		C.add_chem_effect(CE_PAINKILLER, 15)

/datum/reagent/medicine/epinephrine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_STABLE)
		C.remove_chem_effect(CE_PAINKILLER, 15)

/datum/reagent/medicine/atropine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_STABLE)
		C.add_chem_effect(CE_PAINKILLER, 15)

/datum/reagent/medicine/atropine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_STABLE)
		C.remove_chem_effect(CE_PAINKILLER, 25)

/datum/reagent/medicine/earthsblood/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_STABLE)
		C.add_chem_effect(CE_PAINKILLER, 20)

/datum/reagent/medicine/earthsblood/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_STABLE)
		C.remove_chem_effect(CE_PAINKILLER, 20)

/datum/reagent/medicine/adminordrazine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_STABLE)
		C.add_chem_effect(CE_PAINKILLER, 200)
		C.add_chem_effect(CE_OXYGENATED, 2)

/datum/reagent/medicine/adminordrazine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_STABLE)
		C.remove_chem_effect(CE_PAINKILLER, 200)
		C.remove_chem_effect(CE_OXYGENATED, 2)

//Oxygenation medicine
/datum/reagent/medicine/omnizine/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_OXYGENATED)

/datum/reagent/medicine/omnizine/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_OXYGENATED)

/datum/reagent/medicine/salbutamol/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_OXYGENATED)

/datum/reagent/medicine/salbutamol/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_OXYGENATED)

/datum/reagent/medicine/perfluorodecalin/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_OXYGENATED, 2)

/datum/reagent/medicine/perfluorodecalin/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_OXYGENATED, 2)

/datum/reagent/medicine/dexalin/on_mob_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.add_chem_effect(CE_OXYGENATED, 2)

/datum/reagent/medicine/dexalin/on_mob_end_metabolize(mob/living/L)
	. = ..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.remove_chem_effect(CE_OXYGENATED, 2)
