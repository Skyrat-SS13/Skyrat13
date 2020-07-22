/obj/mecha/medical/medigax
	desc = "A specialized variant of the standard Gygax, stripped of its weaponry holsters in place of medical apparatus slots, coated in a slick white color scheme. Produced by Vey-Med.(&copy; All rights reserved)."
	deflect_chance = 5
	force = 30
	internal_damage_threshold = 50
	leg_overload_coeff = 300

/obj/mecha/medical/medigax/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Grant(user, src)

/obj/mecha/medical/medigax/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)