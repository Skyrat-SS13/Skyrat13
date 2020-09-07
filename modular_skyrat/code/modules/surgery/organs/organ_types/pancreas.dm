//Pancreas, regulates blood sugar
//(Injects you with insulin if you have too much)
//Most pancreas code is done in species.dm
/obj/item/organ/pancreas
	name = "pancreas"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "pancreas"
	desc = "Causes a lot of pandemonium."
	slot = ORGAN_SLOT_PANCREAS
	zone = BODY_ZONE_CHEST
	low_threshold = 20
	high_threshold = 40
	maxHealth = 50
	relative_size = 8
	var/insulin_amount = 30

/obj/item/organ/pancreas/proc/get_insulin()
	var/insulin = insulin_amount
	if(is_broken())
		insulin = 0
	else if(is_bruised())
		insulin *= (damage/maxHealth)
	return insulin
