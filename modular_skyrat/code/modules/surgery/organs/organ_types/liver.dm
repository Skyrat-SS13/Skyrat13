#define LIVER_DEFAULT_HEALTH 100 //amount of damage required for liver failure
#define LIVER_DEFAULT_TOX_TOLERANCE 3 //amount of toxins the liver can filter out
#define LIVER_DEFAULT_TOX_LETHALITY 0.01 //lower values lower how harmful toxins are to the liver

/obj/item/organ/liver
	name = "liver"
	icon_state = "liver"
	w_class = WEIGHT_CLASS_NORMAL
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_LIVER
	desc = "Pairing suggestion: chianti and fava beans."

	maxHealth = STANDARD_ORGAN_THRESHOLD
	healing_factor = STANDARD_ORGAN_HEALING
	decay_factor = STANDARD_ORGAN_DECAY

	high_threshold_passed = "<span class='warning'>You feel a stange ache in your abdomen, almost like a stitch. This pain is encumbering your movements.</span>"
	high_threshold_cleared = "<span class='notice'>The stitching ache in your abdomen passes away, unencumbering your movements.</span>"
	now_fixed = "<span class='notice'>The stabbing pain in your abdomen slowly calms down into a more tolerable ache.</span>"

	var/alcohol_tolerance = ALCOHOL_RATE//affects how much damage the liver takes from alcohol
	var/toxTolerance = LIVER_DEFAULT_TOX_TOLERANCE//maximum amount of toxins the liver can just shrug off
	var/toxLethality = LIVER_DEFAULT_TOX_LETHALITY//affects how much damage toxins do to the liver
	var/filterToxins = TRUE //whether to filter toxins
	var/cachedmoveCalc = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/iron = 5)

/obj/item/organ/liver/on_life()
	. = ..()
	if(!. || !owner)//can't process reagents with a failing liver
		return

	if(filterToxins && !HAS_TRAIT(owner, TRAIT_TOXINLOVER))
		//handle liver toxin filtration
		for(var/datum/reagent/toxin/T in owner.reagents.reagent_list)
			var/thisamount = owner.reagents.get_reagent_amount(T.type)
			if (thisamount && thisamount <= toxTolerance)
				owner.reagents.remove_reagent(T.type, 1)
			else
				damage += (thisamount*toxLethality*T.toxpwr) //SKYRAT CHANGE - makes livers respect toxin power, as a lot of toxins should be harmless, and some extra deadly
	//metabolize reagents
	owner.reagents.metabolize(owner, can_overdose=TRUE)

	if(damage > 10 && prob(damage/3))//the higher the damage the higher the probability
		to_chat(owner, "<span class='warning'>You feel a dull pain in your abdomen.</span>")

/obj/item/organ/liver/applyOrganDamage(d, maximum = maxHealth)
	. = ..()
	if(!. || QDELETED(owner))
		return
	if(damage >= high_threshold)
		var/move_calc = 1+((round(damage) - high_threshold)/(high_threshold/3))
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/liver_cirrhosis, multiplicative_slowdown = move_calc)
		sizeMoveMod(move_calc, owner)
	else
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/liver_cirrhosis)
		sizeMoveMod(1, owner)

/obj/item/organ/liver/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(. && damage >= high_threshold)
		var/move_calc = 1+((round(damage) - high_threshold)/(high_threshold/3))
		M.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/liver_cirrhosis, multiplicative_slowdown = move_calc)
		sizeMoveMod(move_calc, owner)

/obj/item/organ/liver/Remove(special = FALSE)
	if(!QDELETED(owner))
		owner.remove_movespeed_modifier(/datum/movespeed_modifier/liver_cirrhosis)
		sizeMoveMod(1, owner)
	return ..()

/obj/item/organ/liver/proc/sizeMoveMod(value, mob/living/carbon/C)
	if(cachedmoveCalc == value)
		return
	C.next_move_modifier /= cachedmoveCalc
	C.next_move_modifier *= value
	cachedmoveCalc = value
