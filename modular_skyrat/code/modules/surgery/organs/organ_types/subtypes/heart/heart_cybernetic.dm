
/obj/item/organ/heart/cybernetic
	name = "cybernetic heart"
	desc = "An electronic device designed to mimic the functions of an organic human heart. Offers no benefit over an organic heart other than being easy to make."
	icon_state = "heart-c"
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/heart/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	Stop()
	addtimer(CALLBACK(src, .proc/Restart), 20/severity SECONDS)
	damage += 100/severity

/obj/item/organ/heart/cybernetic/upgraded
	name = "upgraded cybernetic heart"
	desc = "An electronic device designed to mimic the functions of an organic human heart. Also holds an emergency dose of epinephrine, used automatically after facing severe trauma. This upgraded model can regenerate its dose after use."
	icon_state = "heart-c-u"
	maxHealth = 2 * STANDARD_ORGAN_THRESHOLD

	//I put it on upgraded for now.
	var/dose_available = TRUE
	var/rid = /datum/reagent/medicine/epinephrine
	var/ramount = 10

obj/item/organ/heart/cybernetic/upgraded/on_life()
	. = ..()
	if(!.)
		return
	if(dose_available && owner.health <= owner.crit_threshold && !owner.reagents.has_reagent(rid))
		owner.reagents.add_reagent(rid, ramount)
		used_dose()
	if(ramount < 10) //eats your nutrition to regen epinephrine
		var/regen_amount = owner.nutrition/2000
		owner.adjust_nutrition(-regen_amount)
		ramount += regen_amount

/obj/item/organ/heart/cybernetic/upgraded/proc/used_dose()
	addtimer(VARSET_CALLBACK(src, dose_available, TRUE), 5 MINUTES)
	ramount = 0
