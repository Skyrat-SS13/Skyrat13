//Spleen: Regenerates blood over time
//Without it, you cannot generate blood without transfusions.
/obj/item/organ/spleen
	name = "spleen"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "spleen"
	desc = "Need blood? Spleendid!"
	slot = ORGAN_SLOT_SPLEEN
	zone = BODY_ZONE_CHEST
	low_threshold = 20
	high_threshold = 40
	maxHealth = 50
	relative_size = 8
	var/blood_amount = 0.5

/obj/item/organ/spleen/proc/get_blood()
	var/blood = blood_amount
	if(is_broken())
		blood = 0
	else if(is_bruised())
		blood *= (damage/maxHealth)
	return blood
