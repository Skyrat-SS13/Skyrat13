/obj/item/organ/heart/freedom
	name = "heart of freedom"
	desc = "This heart pumps with the passion to give... something freedom."
	organ_flags = ORGAN_SYNTHETIC //the power of freedom prevents heart attacks
	var/min_next_adrenaline = 0

/obj/item/organ/heart/freedom/on_life()
	. = ..()
	if(. && owner.health < 5 && world.time > min_next_adrenaline)
		min_next_adrenaline = world.time + rand(250, 600) //anywhere from 4.5 to 10 minutes
		to_chat(owner, "<span class='userdanger'>You feel yourself dying, but you refuse to give up!</span>")
		owner.heal_overall_damage(15, 15)
		if(owner.reagents.get_reagent_amount(/datum/reagent/medicine/ephedrine) < 20)
			owner.reagents.add_reagent(/datum/reagent/medicine/ephedrine, 10)
