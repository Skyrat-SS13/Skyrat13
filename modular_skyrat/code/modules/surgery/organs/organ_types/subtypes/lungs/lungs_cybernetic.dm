/obj/item/organ/lungs/cybernetic
	name = "cybernetic lungs"
	desc = "A cybernetic version of the lungs found in traditional humanoid entities. It functions the same as an organic lung and is merely meant as a replacement."
	icon_state = "lungs-c"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = 400
	safe_oxygen_min = 13

/obj/item/organ/lungs/cybernetic/emp_act()
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	owner.losebreath = 20
	owner.adjustOrganLoss(ORGAN_SLOT_LUNGS, 25)


/obj/item/organ/lungs/cybernetic/upgraded
	name = "upgraded cybernetic lungs"
	desc = "A more advanced version of the stock cybernetic lungs. They are capable of filtering out lower levels of toxins and carbon dioxide."
	icon_state = "lungs-c-u"
	safe_toxins_max = 20
	safe_co2_max = 20
	safe_oxygen_max = 250

	cold_level_1_threshold = 200
	cold_level_2_threshold = 140
	cold_level_3_threshold = 100
	maxHealth = 550
