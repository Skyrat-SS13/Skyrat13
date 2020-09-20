/obj/item/organ
	name = "organ"
	icon = 'icons/obj/surgery.dmi'
	var/mob/living/carbon/owner = null
	var/status = ORGAN_ORGANIC
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	var/zone = BODY_ZONE_CHEST
	var/slot
	// DO NOT add slots with matching names to different zones - it will break internal_organs_slot list!
	var/organ_flags = ORGAN_EDIBLE
	var/maxHealth = STANDARD_ORGAN_THRESHOLD
	var/damage = 0		//total damage this organ has sustained
	///Healing factor and decay factor function on % of maxhealth, and do not work by applying a static number per tick
	var/healing_factor 	= STANDARD_ORGAN_HEALING				//fraction of maxhealth healed per on_life(), set to 0 for generic organs
	var/decay_factor 	= STANDARD_ORGAN_DECAY					//same as above but when without a living owner, set to 0 for generic organs
	var/high_threshold	= STANDARD_ORGAN_THRESHOLD * 0.45		//when severe organ damage occurs
	var/low_threshold	= STANDARD_ORGAN_THRESHOLD * 0.1		//when minor organ damage occurs

	///Organ variables for determining what we alert the owner with when they pass/clear the damage thresholds
	var/prev_damage = 0
	var/low_threshold_passed
	var/high_threshold_passed
	var/now_failing
	var/now_fixed
	var/high_threshold_cleared
	var/low_threshold_cleared

	///When you take a bite you cant jam it in for surgery anymore.
	var/useable = TRUE
	var/list/food_reagents = list(/datum/reagent/consumable/nutriment = 5)

	//Bobmed variables
	var/etching = ""
	var/surface_accessible = FALSE
	var/relative_size = 25 // Relative size of the organ. Roughly % of space they take in the limb
	var/damage_modifier = 0.2 // Modifier when the limb gets damaged, and fricks up the organs inside
	var/damage_reduction = 0 // Flat reduction of the damage when the limb affects us
	germ_level = 0 // Geeeerms!
	var/death_time = 0 // Used to check if we can recover from complete sepsis
	var/pain_multiplier = 1 // How much pain this causes in relation to damage (pain_multiplier * damage)
	var/toxin_multiplier = 0.65 // When filtering toxins, how much of the brunt we actually take.
	// Used to handle rejection
	var/rejecting = 0
	var/datum/dna/original_dna
	var/datum/species/original_species

/obj/item/organ/Initialize()
	. = ..()
	if(organ_flags & ORGAN_EDIBLE)
		AddComponent(/datum/component/edible, food_reagents, null, RAW | MEAT | GROSS, null, 10, null, null, null, CALLBACK(src, .proc/OnEatFrom))
	START_PROCESSING(SSobj, src)

/obj/item/organ/Destroy()
	if(owner)
		// The special flag is important, because otherwise mobs can die
		// while undergoing transformation into different mobs.
		Remove(TRUE)
	return ..()

/obj/item/organ/janitize(add_germs, minimum_germs, maximum_germs)
	..()
	if(germ_level >= INFECTION_LEVEL_THREE)
		kill_organ()
	else
		revive_organ()

/obj/item/organ/proc/is_working()
	return !CHECK_BITFIELD(organ_flags, ORGAN_FAILING | ORGAN_DEAD)

/obj/item/organ/proc/is_bruised()
	return damage >= low_threshold

/obj/item/organ/proc/is_broken()
	return ((organ_flags & ORGAN_FAILING) || (damage >= high_threshold))

/obj/item/organ/proc/is_dead()
	return (organ_flags & ORGAN_DEAD)

/obj/item/organ/proc/bruise_organ()
	damage = max(damage, low_threshold)

/obj/item/organ/proc/break_organ()
	damage = max(damage, high_threshold)

/obj/item/organ/proc/kill_organ()
	organ_flags |= ORGAN_DEAD
	death_time = world.time
	if(organ_flags & ORGAN_VITAL)
		if(owner)
			owner.death()

/obj/item/organ/proc/revive_organ()
	organ_flags &= ~ORGAN_DEAD

/obj/item/organ/proc/can_recover()
	return ((maxHealth > 0) && !(organ_flags & ORGAN_DEAD)) || (death_time >= world.time - ORGAN_RECOVERY_THRESHOLD)

/obj/item/organ/proc/listen()
	return

/obj/item/organ/proc/get_pain()
	var/damage_mult = 1
	//Robotic organs do not feel pain, simply for balancing reasons
	//Thus lowering the shock of IPCs and other synths is easier, as
	//they don't have many painkillers
	if(status & ORGAN_ROBOTIC)
		damage_mult *= 0
	return (damage * damage_mult * pain_multiplier)

/obj/item/organ/proc/is_robotic()
	return (status & ORGAN_ROBOTIC)

/obj/item/organ/proc/is_synthetic()
	return (organ_flags & ORGAN_SYNTHETIC)

/obj/item/organ/proc/Insert(mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	if(!iscarbon(M) || owner == M)
		return FALSE

	var/obj/item/organ/replaced = M.getorganslot(slot)
	if(replaced)
		replaced.Remove(TRUE)
		if(drop_if_replaced)
			replaced.forceMove(get_turf(M))
		else
			qdel(replaced)

	//Hopefully this doesn't cause problems
	organ_flags &= ~ORGAN_FROZEN

	owner = M
	M.internal_organs |= src
	M.internal_organs_slot[slot] = src
	moveToNullspace()
	for(var/X in actions)
		var/datum/action/A = X
		A.Grant(M)
	STOP_PROCESSING(SSobj, src)

	if(!original_dna && M.dna)
		original_dna = M.dna
		if(!original_species && M.dna.species)
			original_species = M.dna.species
	return TRUE

//Special is for instant replacement like autosurgeons
/obj/item/organ/proc/Remove(special = FALSE)
	if(owner)
		owner.internal_organs -= src
		if(owner.internal_organs_slot[slot] == src)
			owner.internal_organs_slot.Remove(slot)
		if((organ_flags & ORGAN_VITAL) && !special && !(owner.status_flags & GODMODE))
			owner.death()
		for(var/X in actions)
			var/datum/action/A = X
			A.Remove(owner)
		. = owner //for possible subtypes specific post-removal code.
	owner = null
	START_PROCESSING(SSobj, src)

/obj/item/organ/proc/on_find(mob/living/finder)
	return

/obj/item/organ/process()	//runs decay when outside of a person AND ONLY WHEN OUTSIDE (i.e. long obj).
	on_death() //Kinda hate doing it like this, but I really don't want to call process directly.

//Sources; life.dm process_organs
/obj/item/organ/proc/on_death() //Runs when outside AND inside.
	if(owner)
		STOP_PROCESSING(SSobj, src)
		return
	decay()

//Applys the slow damage over time decay
/obj/item/organ/proc/decay()
	if(!can_decay())
		STOP_PROCESSING(SSobj, src)
		return
	is_cold()
	if((organ_flags & ORGAN_FROZEN) || (organ_flags & ORGAN_DEAD))
		return
	germ_level += rand(MIN_ORGAN_DECAY_INFECTION,MAX_ORGAN_DECAY_INFECTION)
	if(germ_level >= INFECTION_LEVEL_TWO)
		germ_level += rand(MIN_ORGAN_DECAY_INFECTION,MAX_ORGAN_DECAY_INFECTION)
	if(germ_level >= INFECTION_LEVEL_THREE)
		kill_organ()
	applyOrganDamage(maxHealth * decay_factor)

/obj/item/organ/proc/can_decay()
	if(CHECK_BITFIELD(organ_flags, ORGAN_NO_SPOIL | ORGAN_SYNTHETIC | ORGAN_FAILING | ORGAN_DEAD))
		return FALSE
	if(is_robotic())
		return FALSE
	return TRUE

//Checks to see if the organ is frozen from temperature
/obj/item/organ/proc/is_cold()
	if(istype(loc, /obj/))//Freezer of some kind, I hope.
		if(is_type_in_typecache(loc, GLOB.freezing_objects))
			if(!(organ_flags & ORGAN_FROZEN))//Incase someone puts them in when cold, but they warm up inside of the thing. (i.e. they have the flag, the thing turns it off, this rights it.)
				organ_flags |= ORGAN_FROZEN
			return TRUE
		return (organ_flags & ORGAN_FROZEN) //Incase something else toggles it

	var/local_temp
	if(istype(loc, /turf/))//Only concern is adding an organ to a freezer when the area around it is cold.
		var/turf/T = loc
		var/datum/gas_mixture/enviro = T.return_air()
		local_temp = enviro.temperature

	else if(!owner && ismob(loc))
		var/mob/M = loc
		if(is_type_in_typecache(M.loc, GLOB.freezing_objects))
			if(!(organ_flags & ORGAN_FROZEN))
				organ_flags |= ORGAN_FROZEN
			return TRUE
		var/turf/T = M.loc
		var/datum/gas_mixture/enviro = T.return_air()
		local_temp = enviro.temperature

	if(owner)
		//Don't interfere with bodies frozen by structures.
		if(is_type_in_typecache(owner.loc, GLOB.freezing_objects))
			if(!(organ_flags & ORGAN_FROZEN))
				organ_flags |= ORGAN_FROZEN
			return TRUE
		local_temp = owner.bodytemperature

	if(!local_temp)//Shouldn't happen but in case
		return
	if(local_temp < 154)//I have a pretty shaky citation that states -120 allows indefinite cyrostorage
		organ_flags |= ORGAN_FROZEN
		return TRUE
	organ_flags &= ~ORGAN_FROZEN
	return FALSE

/obj/item/organ/proc/on_life()	//repair organ damage if the organ is not failing or synthetic
	//Process infections/germs
	if(owner && can_decay() && !(NOINFECTION in owner?.dna?.species?.species_traits) && !(owner && owner.bodytemperature <= 170))
		handle_antibiotics()
		handle_rejection()
		handle_germ_effects()
	else
		germ_level = 0
	if(CHECK_BITFIELD(organ_flags, ORGAN_FAILING | ORGAN_DEAD) || !owner)
		return FALSE
	if(!is_cold() && damage)
		///Damage decrements by a percent of its maxhealth
		var/healing_amount = -(maxHealth * healing_factor)
		///Damage decrements again by a percent of its maxhealth, up to a total of 4 extra times depending on the owner's satiety
		healing_amount -= owner.satiety > 0 ? 4 * healing_factor * owner.satiety / MAX_SATIETY : 0
		if(healing_amount)
			applyOrganDamage(healing_amount) //to FERMI_TWEAK
	return TRUE

//Germs
/obj/item/organ/proc/handle_antibiotics()
	if(!owner || !germ_level)
		return

	var/antibiotics = owner.get_antibiotics()
	if(antibiotics <= 0)
		return

	if(germ_level < INFECTION_LEVEL_ONE)
		germ_level = 0	//cure instantly
	else
		germ_level -= antibiotics * SANITIZATION_ANTIBIOTIC	//at germ_level == 500 and 50 antibiotic, this should cure the infection in 5 minutes
	if(owner && owner.lying)
		germ_level -= SANITIZATION_LYING
	germ_level = max(0, germ_level)

/obj/item/organ/proc/handle_germ_effects()
	//Handle infection effects
	var/virus_immunity = owner.virus_immunity()
	var/antibiotics = owner.get_antibiotics()

	if(germ_level > 0 && germ_level < INFECTION_LEVEL_ONE/2 && prob(virus_immunity*0.3))
		germ_level--
	
	if(germ_level >= INFECTION_LEVEL_ONE/2)
		//Aiming for germ level to go from ambient to INFECTION_LEVEL_TWO in an average of 15 minutes, when immunity is full.
		if(antibiotics < 5 && prob(round(germ_level/6 * owner.immunity_weakness() * 0.01)))
			if(virus_immunity > 0)
				germ_level += clamp(round(1/virus_immunity), 1, 10) // Immunity starts at 100. This doubles infection rate at 50% immunity. Rounded to nearest whole.
			else // Will only trigger if immunity has hit zero. Once it does, 10x infection rate.
				germ_level += 10
	
	if(germ_level >= INFECTION_LEVEL_ONE)
		var/fever_temperature = (BODYTEMP_HEAT_DAMAGE_LIMIT - BODYTEMP_NORMAL - 5)* min(germ_level/INFECTION_LEVEL_TWO, 1) + BODYTEMP_NORMAL
		owner.bodytemperature += clamp((fever_temperature - T20C)/BODYTEMP_COLD_DIVISOR + 1, 0, fever_temperature - owner.bodytemperature)

	if(germ_level >= INFECTION_LEVEL_TWO)
		var/obj/item/bodypart/bodypart = owner.get_bodypart(zone)
		if(bodypart)
			//Spread germs
			if(antibiotics < 5 && bodypart.germ_level < germ_level && (bodypart.germ_level < INFECTION_LEVEL_ONE*2 || prob(owner.immunity_weakness() * 0.3)))
				bodypart.germ_level++
			//Cause organ damage about once every ~30 seconds
			//The bodypart deals with dealing raw toxin damage, let's not stack onto the problem now
			if(prob(3))
				applyOrganDamage(2)
	
	//Organ is just completely dead by this point
	if(germ_level >= INFECTION_LEVEL_THREE)
		kill_organ()
		var/obj/item/bodypart/bodypart = owner.get_bodypart(zone)
		if(bodypart)
			//Spread germs
			if(antibiotics < 10 && bodypart.germ_level < germ_level && (bodypart.germ_level < INFECTION_LEVEL_THREE))
				bodypart.germ_level++
			//Cause toxin damage
			bodypart.receive_damage(toxin = rand(1,2))

//Rejection
/obj/item/organ/proc/handle_rejection()
	// Process unsuitable transplants. TODO: consider some kind of
	// immunosuppressant that changes transplant data to make it match.
	var/antibiotics = owner.get_antibiotics()
	if(antibiotics >= 50) //for now just having antibiotics will suppress it
		if(prob(antibiotics*0.4))
			rejecting = FALSE
			original_dna = owner.dna
			original_species = owner.dna?.species
		return
	if(is_robotic() || is_synthetic())
		return
	if(original_dna)
		if(!rejecting)
			if(original_dna && !(owner.dna.blood_type in get_safe_blood(original_dna?.blood_type)))
				rejecting = REJECTION_LEVEL_1
		else
			//Rejection severity increases over time.
			rejecting++
			//Only fire every ten rejection ticks.
			if(rejecting % 10 == 0)
				switch(rejecting)
					if(REJECTION_LEVEL_1 to REJECTION_LEVEL_2)
						germ_level++
					if(REJECTION_LEVEL_2 to REJECTION_LEVEL_3)
						germ_level += rand(1,2)
					if(REJECTION_LEVEL_3 to REJECTION_LEVEL_4)
						germ_level += rand(2,3)
					if(REJECTION_LEVEL_4 to INFINITY)
						germ_level += rand(3,5)
						var/obj/item/bodypart/affected = owner.get_bodypart(zone)
						if(affected)
							affected.receive_damage(toxin = rand(1,2))

//Medical scans
/obj/item/organ/proc/get_scan_results(do_tag = FALSE)
	. = list()
	if(is_robotic())
		. += do_tag ? "<span class='warning'>Mechanical</span>" : "Mechanical"
	if(is_synthetic())
		. += do_tag ? "<span class='warning'>Synthetic</span>" : "Synthetic"
	if(organ_flags & ORGAN_DEAD)
		if(can_recover())
			. += do_tag ? "<span class='danger'>Decaying</span>" : "Decaying"
		else
			. += do_tag ? "<span class='deadsay'>Necrotic</span>" : "Necrotic"

	switch(germ_level)
		if(INFECTION_LEVEL_ONE to INFECTION_LEVEL_ONE + ((INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3))
			. +=  "Mild Infection"
		if(INFECTION_LEVEL_ONE + ((INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3) to INFECTION_LEVEL_ONE + (2 * (INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3))
			. +=  "Mild Infection+"
		if(INFECTION_LEVEL_ONE + (2 * (INFECTION_LEVEL_TWO - INFECTION_LEVEL_ONE) / 3) to INFECTION_LEVEL_TWO)
			. +=  "Mild Infection++"
		if(INFECTION_LEVEL_TWO to INFECTION_LEVEL_TWO + ((INFECTION_LEVEL_THREE - INFECTION_LEVEL_THREE) / 3))
			if(do_tag)
				. += "<span class='warning'>Acute Infection</span>"
			else
				. +=  "Acute Infection"
		if(INFECTION_LEVEL_TWO + ((INFECTION_LEVEL_THREE - INFECTION_LEVEL_THREE) / 3) to INFECTION_LEVEL_TWO + (2 * (INFECTION_LEVEL_THREE - INFECTION_LEVEL_TWO) / 3))
			if(do_tag)
				. += "<span class='warning'>Acute Infection+</span>"
			else
				. +=  "Acute Infection+"
		if(INFECTION_LEVEL_TWO + (2 * (INFECTION_LEVEL_THREE - INFECTION_LEVEL_TWO) / 3) to INFECTION_LEVEL_THREE)
			if(do_tag)
				. += "<span class='warning'>Acute Infection++</span>"
			else
				. +=  "Acute Infection++"
		if(INFECTION_LEVEL_THREE to INFINITY)
			if(do_tag)
				. += "<span class='danger'>Septic</span>"
			else
				. +=  "Septic"
	if(rejecting)
		if(do_tag)
			. += "<span class='danger'>Genetic Rejection</span>"
		else
			. += "Genetic Rejection"

/obj/item/organ/examine(mob/user)
	. = ..()
	. |= surgical_examine(user)

/obj/item/organ/proc/surgical_examine(mob/user)
	. = list()
	var/failing = FALSE
	var/decayed = FALSE
	var/damaged = FALSE
	if(organ_flags & ORGAN_DEAD)
		decayed = TRUE
	if(organ_flags & ORGAN_FAILING)
		failing = TRUE
		if(status & ORGAN_ROBOTIC)
			. += "<span class='warning'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] seems to be broken!</span>"
		else
			. += "<span class='warning'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] is severely damaged, and doesn't seem like it will work anymore!</span>"
	if(damage > high_threshold)
		if(!failing)
			damaged = TRUE
			. += "<span class='warning'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] is starting to look discolored.</span>"
	if(!failing && !damaged)
		. += "<span class='notice'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] seems to be quite healthy.</span>"
	if(decayed)
		. += "<span class='deadsay'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] seems to have decayed, reaching a putrid state...</span>"
	if(germ_level)
		switch(germ_level)
			if(INFECTION_LEVEL_ONE to INFECTION_LEVEL_TWO)
				. +=  "<span class='deadsay'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] seems to be mildly infected.</span>"
			if(INFECTION_LEVEL_TWO to INFECTION_LEVEL_THREE)
				. +=  "<span class='deadsay'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] seems to be oozing some foul pus...</span>"
			if(INFECTION_LEVEL_THREE to INFINITY)
				. += "<span class='deadsay'>[owner ? "[owner.p_their(TRUE)] " : ""][owner ? src.name : capitalize(src.name)] seems to be awfully necrotic and riddled with dead tissue!</span>"
	if(etching)
		. += "<span class='notice'>[owner ? "[owner.p_their(TRUE)] " : ""][src] has <b>\"[etching]\"</b> inscribed on it.</span>"
	if(!owner)
		. += "<span class='notice'>This organ can be inserted into \the [parse_zone(zone)].</span>"

/obj/item/organ/proc/OnEatFrom(eater, feeder)
	useable = FALSE //You can't use it anymore after eating it you spaztic

/obj/item/organ/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if((istype(I, /obj/item/cautery) || istype(I, /obj/item/pen)) && user.a_intent == INTENT_HELP)
		var/badboy = input(user, "What do you want to etch on [src]?", "Malpractice", "") as text
		if(badboy)
			badboy = strip_html_simple(badboy)
			etching = "[badboy]"
			user.visible_message("<span class='notice'>[user] etches something on \the [src] with \the [I].</span>", " <span class='notice'>You etch <b>\"[badboy]\"</b> on [src] with \the [I]. Hehe.</span>")
		else
			return ..()

/obj/item/organ/item_action_slot_check(slot,mob/user)
	return //so we don't grant the organ's action to mobs who pick up the organ.

///Adjusts an organ's damage by the amount "dam", up to a maximum amount, which is by default max damage
/obj/item/organ/proc/applyOrganDamage(dam, maximum = maxHealth)	//use for damaging effects
	if(!dam || maximum < damage) //Micro-optimization.
		return FALSE
	if((dam < 0) && !can_recover())
		return FALSE
	damage = clamp(damage + dam, 0, maximum)
	var/mess = check_damage_thresholds()
	prev_damage = damage
	if(mess && owner)
		to_chat(owner, mess)
	return TRUE

///SETS an organ's damage to the amount "d", and in doing so clears or sets the failing flag, good for when you have an effect that should fix an organ if broken
/obj/item/organ/proc/setOrganDamage(var/d)	//use mostly for admin heals
	applyOrganDamage(d - damage)

/** check_damage_thresholds
  * input: M (a mob, the owner of the organ we call the proc on)
  * output: returns a message should get displayed.
  * description: By checking our current damage against our previous damage, we can decide whether we've passed an organ threshold.
  *				 If we have, send the corresponding threshold message to the owner, if such a message exists.
  */
/obj/item/organ/proc/check_damage_thresholds()
	if(damage == prev_damage)
		return
	var/delta = damage - prev_damage
	if(delta > 0)
		if(damage >= maxHealth)
			organ_flags |= ORGAN_FAILING
			if(owner)
				owner.med_hud_set_status()
			return now_failing
		if(damage > high_threshold && prev_damage <= high_threshold)
			return high_threshold_passed
		if(damage > low_threshold && prev_damage <= low_threshold)
			return low_threshold_passed
	else
		organ_flags &= ~ORGAN_FAILING
		if(owner)
			owner.med_hud_set_status()
		if(!owner)//Processing is stopped when the organ is dead and outside of someone. This hopefully should restart it if a removed organ is repaired outside of a body.
			START_PROCESSING(SSobj, src)
		if(prev_damage > low_threshold && damage <= low_threshold)
			return low_threshold_cleared
		if(prev_damage > high_threshold && damage <= high_threshold)
			return high_threshold_cleared
		if(prev_damage == maxHealth)
			return now_fixed

//Runs some code on the organ when damage is taken/healed
/obj/item/organ/proc/onDamage(var/d, var/maximum = maxHealth)
	return

//Runs some code on the organ when damage is taken/healed
/obj/item/organ/proc/onSetDamage(var/d, var/maximum = maxHealth)
	return

//Looking for brains?
//Try code/modules/mob/living/carbon/brain/brain_item.dm

/mob/living/proc/regenerate_organs()
	return 0

/mob/living/carbon/regenerate_organs(only_one = FALSE)
	var/breathes = TRUE
	var/blooded = TRUE
	if(dna && dna.species)
		if(HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT))
			breathes = FALSE
		if(NOBLOOD in dna.species.species_traits)
			blooded = FALSE
		var/has_liver = (!(NOLIVER in dna.species.species_traits))
		var/has_stomach = (!(NOSTOMACH in dna.species.species_traits))
		var/has_kidneys = (!(NOKIDNEYS in dna.species.species_traits))
		var/has_intestines = (!(NOINTESTINES in dna.species.species_traits))
		var/has_spleen = (!(NOSPLEEN in dna.species.species_traits))

		for(var/obj/item/organ/O in internal_organs)
			if(O.organ_flags & ORGAN_FAILING)
				O.setOrganDamage(0)
			if(O.organ_flags & ORGAN_DEAD)
				O.organ_flags &= ~ORGAN_DEAD
			if(only_one)
				return TRUE

		if(has_liver && !getorganslot(ORGAN_SLOT_LIVER))
			var/obj/item/organ/liver/LI

			if(dna.species.mutantliver)
				LI = new dna.species.mutantliver()
			else
				LI = new()
			LI.Insert(src)
			if(only_one)
				return TRUE

		if(has_stomach && !getorganslot(ORGAN_SLOT_STOMACH))
			var/obj/item/organ/stomach/S

			if(dna.species.mutantstomach)
				S = new dna.species.mutantstomach()
			else
				S = new()
			S.Insert(src)
			if(only_one)
				return TRUE

		if(has_kidneys && !getorganslot(ORGAN_SLOT_KIDNEYS))
			var/obj/item/organ/kidneys/K

			if(dna.species.mutantkidneys)
				K = new dna.species.mutantkidneys()
			else
				K = new()
			K.Insert(src)
			if(only_one)
				return TRUE

		if(has_intestines && !getorganslot(ORGAN_SLOT_INTESTINES))
			var/obj/item/organ/intestines/IN

			if(dna.species.mutantintestines)
				IN = new dna.species.mutantintestines()
			else
				IN = new()
			IN.Insert(src)
			if(only_one)
				return TRUE

		if(has_spleen && !getorganslot(ORGAN_SLOT_SPLEEN))
			var/obj/item/organ/spleen/SP

			if(dna.species.mutantspleen)
				SP = new dna.species.mutantspleen()
			else
				SP = new()
			SP.Insert(src)
			if(only_one)
				return TRUE

	if(breathes && !getorganslot(ORGAN_SLOT_LUNGS))
		var/obj/item/organ/lungs/L = new()
		L.Insert(src)
		if(only_one)
			return TRUE

	if(blooded && !getorganslot(ORGAN_SLOT_HEART))
		var/obj/item/organ/heart/H = new()
		H.Insert(src)
		if(only_one)
			return TRUE

	if(!getorganslot(ORGAN_SLOT_TONGUE))
		var/obj/item/organ/tongue/T

		if(dna && dna.species && dna.species.mutanttongue)
			T = new dna.species.mutanttongue()
		else
			T = new()

		// if they have no mutant tongues, give them a regular one
		T.Insert(src)
		if(only_one)
			return TRUE

	else if (!only_one)
		var/obj/item/organ/tongue/oT = getorganslot(ORGAN_SLOT_TONGUE)
		if(oT.name == "fluffy tongue")
			var/obj/item/organ/tongue/T
			if(dna && dna.species && dna.species.mutanttongue)
				T = new dna.species.mutanttongue()
			else
				T = new()
			oT.Remove()
			qdel(oT)
			T.Insert(src)

	if(!getorganslot(ORGAN_SLOT_EYES))
		var/obj/item/organ/eyes/E

		if(dna && dna.species && dna.species.mutanteyes)
			E = new dna.species.mutanteyes()

		else
			E = new()
		E.Insert(src)
		if(only_one)
			return TRUE

	if(!getorganslot(ORGAN_SLOT_EARS))
		var/obj/item/organ/ears/ears
		if(dna && dna.species && dna.species.mutantears)
			ears = new dna.species.mutantears
		else
			ears = new

		ears.Insert(src)
		if(only_one)
			return TRUE

	if(!getorganslot(ORGAN_SLOT_TAIL))
		var/obj/item/organ/tail/tail
		if(dna && dna.species && dna.species.mutanttail)
			tail = new dna.species.mutanttail
			tail.Insert(src)
			if(only_one)
				return TRUE

/obj/item/organ/random
	name = "Illegal organ"
	desc = "Something hecked up"

/obj/item/organ/random/Initialize()
	..()
	var/list = list(/obj/item/organ/tongue, /obj/item/organ/brain, /obj/item/organ/heart, /obj/item/organ/liver, /obj/item/organ/ears, /obj/item/organ/eyes, /obj/item/organ/tail, /obj/item/organ/stomach)
	var/newtype = pick(list)
	new newtype(loc)
	return INITIALIZE_HINT_QDEL
