/datum/interaction/lewd/kiss
	command = "deepkiss"
	description = "Kiss them deeply."
	require_user_mouth = TRUE
	require_target_mouth = TRUE
	write_log_user = "kissed"
	write_log_target = "was kissed by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/kiss/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(user.lust < 5)
		user.lust = 5
	if(target.lust < 5)
		target.lust = 5

/datum/interaction/lewd/kiss/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.lust >= 3)
		user.visible_message("<span class='warning'>\The [user] gives an intense, lingering kiss to \the [target].</span>")
	else
		user.visible_message("<span class='warning'>\The [user] kisses \the [target] deeply.</span>")

/datum/interaction/lewd/titgrope
	command = "titgrope"
	description = "Grope their breasts."
	require_target_breasts = TRUE
	write_log_user = "groped"
	write_log_target = "was groped by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/titgrope/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()

/datum/interaction/lewd/titgrope/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.a_intent == INTENT_HELP)
		user.visible_message(
				pick("<span class='warning'>\The [user] gently gropes \the [target]'s breast.</span>",
					 "<span class='warning'>\The [user] softly squeezes \the [target]'s breasts.</span>",
					 "<span class='warning'>\The [user] grips \the [target]'s breasts.</span>",
					 "<span class='warning'>\The [user] runs a few fingers over \the [target]'s breast.</span>",
					 "<span class='warning'>\The [user] delicately teases \the [target]'s nipple.</span>",
					 "<span class='warning'>\The [user] traces a touch across \the [target]'s breast.</span>"))
	if(user.a_intent == INTENT_HARM)
		user.visible_message(
				pick("<span class='warning'>\The [user] aggressively gropes \the [target]'s breast.</span>",
					 "<span class='warning'>\The [user] grabs \the [target]'s breasts.</span>",
					 "<span class='warning'>\The [user] tightly squeezes \the [target]'s breasts.</span>",
					 "<span class='warning'>\The [user] slaps at \the [target]'s breasts.</span>",
					 "<span class='warning'>\The [user] gropes \the [target]'s breasts roughly.</span>"))
	if(prob(5 + target.lust))
		if(target.a_intent == INTENT_HELP)
			user.visible_message(
				pick("<span class='warning'>\The [target] shivers in arousal.</span>",
					 "<span class='warning'>\The [target] moans quietly.</span>",
					 "<span class='warning'>\The [target] breathes out a soft moan.</span>",
					 "<span class='warning'>\The [target] gasps.</span>",
					 "<span class='warning'>\The [target] shudders softly.</span>",
					 "<span class='warning'>\The [target] trembles as hands run across bare skin.</span>"))
			if(target.lust < 5)
				target.lust = 5
		if(target.a_intent == INTENT_DISARM)
			if (target.restrained())
				user.visible_message(
					pick("<span class='warning'>\The [target] twists playfully against the restraints.</span>",
						 "<span class='warning'>\The [target] squirms away from [user]'s hand.</span>",
						 "<span class='warning'>\The [target] slides back from [user]'s roaming hand.</span>",
						 "<span class='warning'>\The [target] thrusts bare breasts forward into [user]'s hands.</span>"))
			else
				user.visible_message(
					pick("<span class='warning'>\The [target] playfully bats at [user]'s hand.</span>",
						 "<span class='warning'>\The [target] squirms away from [user]'s hand.</span>",
						 "<span class='warning'>\The [target] guides [user]'s hand across bare breasts.</span>",
						 "<span class='warning'>\The [target] teasingly laces a few fingers over [user]'s knuckles.</span>"))
			if(target.lust < 10)
				target.lust += 1
	if(target.a_intent == INTENT_GRAB)
		user.visible_message(
				pick("<span class='warning'>\The [target] grips [user]'s wrist tight.</span>",
				 "<span class='warning'>\The [target] digs nails into [user]'s arm.</span>",
				 "<span class='warning'>\The [target] grabs [user]'s wrist for a second.</span>"))
	if(target.a_intent == INTENT_HARM)
		user.adjustBruteLoss(1)
		user.visible_message(
				pick("<span class='warning'>\The [target] pushes [user] roughly away.</span>",
				 "<span class='warning'>\The [target] digs nails angrily into [user]'s arm.</span>",
				 "<span class='warning'>\The [target] fiercely struggles against [user].</span>",
				 "<span class='warning'>\The [target] claws [user]'s forearm, drawing blood.</span>",
				 "<span class='warning'>\The [target] slaps [user]'s hand away.</span>"))
	return

/datum/interaction/lewd/oral
	command = "suckvag"
	description = "Go down on them."
	require_user_mouth = TRUE
	require_target_vagina = TRUE
	write_log_user = "gave head to"
	write_log_target = "was given head by"
	interaction_sound = null
	user_not_tired = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/oral/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_oral(target)

/datum/interaction/lewd/oral/blowjob
	command = "suckcock"
	description = "Suck them off."
	require_target_vagina = FALSE
	require_target_penis = TRUE
	target_not_tired = TRUE

/datum/interaction/lewd/fuck
	command = "fuckvag"
	description = "Fuck their pussy."
	require_user_penis = TRUE
	require_target_vagina = TRUE
	write_log_user = "fucked"
	write_log_target = "was fucked by"
	interaction_sound = null
	user_not_tired = TRUE
	require_user_bottomless = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/fuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_vaginal(target)

/datum/interaction/lewd/fuck/anal
	command = "fuckass"
	description = "Fuck their ass."
	require_target_vagina = FALSE
	require_target_anus = TRUE
	user_not_tired = TRUE

/datum/interaction/lewd/fuck/anal/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_anal(target)

/datum/interaction/lewd/finger
	command = "finger"
	description = "Finger their pussy."
	require_user_hands = TRUE
	require_target_vagina = TRUE
	interaction_sound = null
	user_not_tired = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/finger/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_fingering(target)

/datum/interaction/lewd/fingerass
	command = "fingerm"
	description = "Finger their ass."
	interaction_sound = null
	require_user_hands = TRUE
	require_target_anus = TRUE
	user_not_tired = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/fingerass/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_fingerass(target)


/datum/interaction/lewd/facefuck
	command = "facefuck"
	description = "Fuck their mouth."
	interaction_sound = null
	require_target_mouth = TRUE
	user_not_tired = TRUE
	require_user_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/facefuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_facefuck(target)

/datum/interaction/lewd/throatfuck
	command = "throatfuck"
	description = "Fuck their throat. | Does oxy damage."
	interaction_sound = null
	require_user_penis = TRUE
	require_target_mouth = TRUE
	user_not_tired = TRUE
	require_user_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/throatfuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_throatfuck(target)

/datum/interaction/lewd/handjob
	command = "handjob"
	description = "Jerk them off."
	interaction_sound = null
	require_user_hands = TRUE
	require_target_penis = TRUE
	target_not_tired = TRUE
	require_target_bottomless = TRUE
	max_distance = 1

/datum/interaction/lewd/handjob/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_handjob(target)

/datum/interaction/lewd/breastfuck
	command = "breastfuck"
	description = "Fuck their breasts."
	interaction_sound = null
	require_user_penis = TRUE
	user_not_tired = TRUE
	require_user_bottomless = TRUE
	require_target_topless = TRUE
	require_target_vagina = TRUE
	max_distance = 0

/datum/interaction/lewd/breastfuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_breastfuck(target)

/datum/interaction/lewd/mount
	command = "mount"
	description = "Mount with your pussy."
	interaction_sound = null
	require_user_vagina = TRUE
	require_target_penis = TRUE
	user_not_tired = TRUE
	target_not_tired = TRUE
	require_user_bottomless = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/mount/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_mount(target)

/datum/interaction/lewd/mountass
	command = "mountm"
	description = "Mount with your ass."
	interaction_sound = null
	require_user_vagina = FALSE
	require_user_anus = TRUE
	require_target_penis = TRUE
	user_not_tired = TRUE
	target_not_tired = TRUE
	require_user_bottomless = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/mountass/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_mountass(target)

/datum/interaction/lewd/tribadism
	command = "tribadism"
	description = "Grind your pussy against theirs."
	interaction_sound = null
	require_target_vagina = TRUE
	require_user_vagina = TRUE
	user_not_tired = TRUE
	require_user_bottomless = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/tribadism/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_tribadism(target)

/datum/interaction/lewd/rimjob
	command = "rimjob"
	description = "Lick their ass."
	interaction_sound = null
	require_user_mouth = TRUE
	require_target_anus = TRUE
	user_not_tired = TRUE
	require_target_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/rimjob/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_rimjob(target)

/datum/interaction/lewd/mountface
	command = "mountface"
	description = "Ass to face."
	interaction_sound = null
	require_target_mouth = TRUE
	require_user_anus = TRUE
	user_not_tired = TRUE
	require_user_bottomless = TRUE
	max_distance = 0

/datum/interaction/lewd/mountface/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_mountface(target)

/datum/interaction/lewd/lickfeet
	command = "lickfeet"
	description = "Lick their feet."
	interaction_sound = null
	require_user_mouth = TRUE
	max_distance = 1

/datum/interaction/lewd/lickfeet/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_lickfeet(target)

/datum/interaction/lewd/grindface
	command = "grindface"
	description = "Feet grind their face."
	interaction_sound = null
	require_target_mouth = TRUE
	max_distance = 0

/datum/interaction/lewd/grindface/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_grindface(target)

/datum/interaction/lewd/grindmouth
	command = "grindmouth"
	description = "Feet grind their mouth."
	interaction_sound = null
	require_target_mouth = TRUE
	max_distance = 0

/datum/interaction/lewd/grindmouth/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_grindmouth(target)


/datum/interaction/lewd/thighs
	command = "thigh_smother"
	description = "Smother them."
	max_distance = 0
	require_user_bottomless = TRUE
	require_target_mouth = TRUE
	interaction_sound = null
	user_not_tired = TRUE
	write_log_user = "thigh-trapped"
	write_log_target = "was smothered by"


/datum/interaction/lewd/thighs/display_interaction(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
    user.thigh_smother(target)

/datum/interaction/lewd/nuts
	command = "nut_face"
	description = "Nuts to face."
	interaction_sound = null
	require_user_bottomless = TRUE
	require_user_penis = TRUE
	require_target_mouth = TRUE
	max_distance = 0
	write_log_user = "make-them-suck-their-nuts"
	write_log_target = "was made to suck nuts by"

/datum/interaction/lewd/nuts/display_interaction(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
	user.nut_face(target)

/datum/interaction/lewd/nut_smack
	command = "smack_nuts"
	description = "Smack their nuts."
	interaction_sound = "honk/sound/interactions/slap.ogg"
	simple_message = "USER slaps TARGET's nuts!"
	require_target_penis = TRUE
	require_target_bottomless = TRUE
	needs_physical_contact = TRUE
	max_distance = 1
	write_log_user = "slapped-nuts"
	write_log_target = "had their nuts slapped by"
