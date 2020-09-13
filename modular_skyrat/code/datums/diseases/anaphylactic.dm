//"disease" caused by eating something you're allergic to
/datum/disease/anaphylactic_shock
	disease_flags = CURABLE
	spread_flags = 0
	form = "Auto-immune reaction"
	name = "Anaphylactic Shock"
	desc = "Caused by an extreme allergic reaction."
	agent = "anti-bodies"
	cure_text = "Epinephrine"
	viable_mobtypes = list(/mob/living/carbon/human)
	cures = list(/datum/reagent/medicine/epinephrine)
	infectivity = 0
	cure_chance = 20
	bypasses_immunity = TRUE
	severity = DISEASE_SEVERITY_DANGEROUS
	infectable_biotypes = MOB_ORGANIC | MOB_HUMANOID

/datum/disease/anaphylactic_shock/stage_act()
	..()
	var/mob/living/carbon/human/H = affected_mob
	if(!H || !istype(H))
		return FALSE
	SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "allergyshock", /datum/mood_event/allergyshock)
	if(prob(20))
		H.Jitter(100)
	if(prob(10))
		to_chat(H, "<span class='userdanger'>You can feel your throat constricting!</span>")
		H.adjustOxyLoss(rand(5, 25))
	else if(prob(5))
		H.vomit(10, 10, 1)
	else if(prob(5))
		H.Unconscious(200)

/datum/disease/anaphylactic_shock/Destroy()
	. = ..()
	affected_mob.jitteriness = 0
	affected_mob.Jitter(0)
