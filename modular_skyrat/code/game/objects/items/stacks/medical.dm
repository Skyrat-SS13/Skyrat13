/obj/item/stack/medical/gauze/splint
	name = "medical splints"
	singular_name = "medical splint"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "splint"
	desc = "Oofie ouchie my bones."
	self_delay = 75
	other_delay = 30
	amount = 8
	max_amount = 16
	custom_price = 150
	absorption_rate = 0.30
	absorption_capacity = 8
	splint_factor = 0.75
	custom_price = PRICE_EXPENSIVE
	novariants = TRUE

/obj/item/stack/medical/gauze/splint/tribal
	name = "tribal splints"
	singular_name = "tribal splint"
	icon_state = "tribal_splint"
	desc = "Ooga booga rock crush bone."
	self_delay = 90
	other_delay = 45
	absorption_rate = 0.10
	absorption_capacity = 3.5
	splint_factor = 0.65
	novariants = TRUE

/obj/item/stack/medical/nanopaste
	name = "nanite paste"
	singular_name = "nanite paste"
	icon = 'modular_skyrat/icons/obj/medical.dmi'
	icon_state = "nanopaste"
	desc = "A paste composed of silicon and healing nanites. Very efficient tool to heal robotic limbs."
	novariants = TRUE
	self_delay = 60
	other_delay = 25
	heal_brute = 20
	heal_burn = 20
	required_status = BODYPART_ROBOTIC

/obj/item/stack/medical/fixovein
	name = "fix o' vein"
	singular_name = "fix o' vein"
	desc = "A tube filled with fibrous cabling, perfectly able to replace damaged veins."
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
	icon_state = "fixovein"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount = 5
	max_amount = 10
	self_delay = 80
	other_delay = 40
	grind_results = list(/datum/reagent/medicine/fibrin = 10, /datum/reagent/medicine/coagulant = 10)
	novariants = TRUE
