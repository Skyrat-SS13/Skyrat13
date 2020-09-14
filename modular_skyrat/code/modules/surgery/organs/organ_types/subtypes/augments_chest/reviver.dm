
#define MAX_HEAL_COOLDOWN 15 MINUTES
#define DEF_CONVALESCENCE_TIME 15 SECONDS

/obj/item/organ/cyberimp/chest/reviver
	name = "Reviver implant"
	desc = "This implant will attempt to revive and heal you if you lose consciousness. For the faint of heart!"
	icon_state = "chest_implant"
	implant_color = "#AD0000"
	slot = ORGAN_SLOT_HEART_AID
	var/revive_cost = 0
	var/reviving = FALSE
	var/cooldown = 0
	var/convalescence_time = 0

/obj/item/organ/cyberimp/chest/reviver/on_life()
	. = ..()
	if(reviving)
		var/do_heal = . && world.time < convalescence_time
		if(revive_cost >= MAX_HEAL_COOLDOWN)
			do_heal = FALSE
		else if(owner?.stat && owner.stat != DEAD)
			do_heal = TRUE
		else if(!do_heal)
			convalescence_time = world.time + DEF_CONVALESCENCE_TIME
		if(. && (do_heal || world.time < convalescence_time))
			addtimer(CALLBACK(src, .proc/heal), 3 SECONDS)
		else
			cooldown = revive_cost + world.time
			reviving = FALSE
			if(owner)
				to_chat(owner, "<span class='notice'>Your reviver implant shuts down and starts recharging. It will be ready again in [DisplayTimeText(revive_cost)].</span>")
		return

	if(!. || cooldown > world.time || owner.stat == CONSCIOUS || owner.stat == DEAD || owner.suiciding)
		return

	revive_cost = 0
	convalescence_time = 0
	reviving = TRUE
	to_chat(owner, "<span class='notice'>You feel a faint buzzing as your reviver implant starts patching your wounds...</span>")

/obj/item/organ/cyberimp/chest/reviver/proc/heal()
	if(!owner)
		return
	if(owner.getOxyLoss())
		owner.adjustOxyLoss(-5)
		revive_cost += 0.5 SECONDS
	if(owner.getBruteLoss())
		owner.adjustBruteLoss(-2)
		revive_cost += 4 SECONDS
	if(owner.getFireLoss())
		owner.adjustFireLoss(-2)
		revive_cost += 4 SECONDS
	if(owner.getToxLoss())
		owner.adjustToxLoss(-1)
		revive_cost += 4 SECONDS


/obj/item/organ/cyberimp/chest/reviver/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return

	if(reviving)
		revive_cost += 20 SECONDS
	else
		cooldown += 20 SECONDS

	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.stat != DEAD && prob(50 / severity) && H.can_heartattack())
			H.set_heartattack(TRUE)
			to_chat(H, "<span class='userdanger'>You feel a horrible agony in your chest!</span>")
			addtimer(CALLBACK(src, .proc/undo_heart_attack), 60 SECONDS / severity)

/obj/item/organ/cyberimp/chest/reviver/proc/undo_heart_attack()
	var/mob/living/carbon/human/H = owner
	if(!H || !istype(H))
		return
	H.set_heartattack(FALSE)
	if(H.stat == CONSCIOUS || H.stat == SOFT_CRIT)
		to_chat(H, "<span class='notice'>You feel your heart beating again!</span>")

#undef MAX_HEAL_COOLDOWN
#undef DEF_CONVALESCENCE_TIME
