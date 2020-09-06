
/obj/item/organ/cyberimp/chest/nutriment
	name = "Nutriment pump implant"
	desc = "This implant will synthesize and pump into your bloodstream a small amount of nutriment when you are starving."
	icon_state = "chest_implant"
	implant_color = "#00AA00"
	var/hunger_threshold = NUTRITION_LEVEL_STARVING
	var/synthesizing = 0
	var/poison_amount = 5
	slot = ORGAN_SLOT_STOMACH_AID

/obj/item/organ/cyberimp/chest/nutriment/on_life()
	. = ..()
	if(!. || synthesizing)
		return

	if(owner.nutrition <= hunger_threshold)
		synthesizing = TRUE
		to_chat(owner, "<span class='notice'>You feel less hungry...</span>")
		owner.adjust_nutrition(50)
		addtimer(CALLBACK(src, .proc/synth_cool), 50)

/obj/item/organ/cyberimp/chest/nutriment/proc/synth_cool()
	synthesizing = FALSE

/obj/item/organ/cyberimp/chest/nutriment/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	owner.reagents.add_reagent(/datum/reagent/toxin/bad_food, poison_amount / severity)
	to_chat(owner, "<span class='warning'>You feel like your insides are burning.</span>")


/obj/item/organ/cyberimp/chest/nutriment/plus
	name = "Nutriment pump implant PLUS"
	desc = "This implant will synthesize and pump into your bloodstream a small amount of nutriment when you are hungry."
	icon_state = "chest_implant"
	implant_color = "#006607"
	hunger_threshold = NUTRITION_LEVEL_HUNGRY
	poison_amount = 10
