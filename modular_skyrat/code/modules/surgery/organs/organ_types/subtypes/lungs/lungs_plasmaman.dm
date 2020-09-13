/obj/item/organ/lungs/plasmaman
	name = "plasma filter"
	desc = "A spongy rib-shaped mass for filtering plasma from the air."
	icon_state = "lungs-plasma"

	safe_oxygen_min = 0 //We don't breath this
	safe_oxygen_max = 0 // Like, at all.
	safe_toxins_min = 16 //We breath THIS!
	safe_toxins_max = 0
	maxHealth = INFINITY//I don't understand how plamamen work, so I'm not going to try t give them special lungs atm
