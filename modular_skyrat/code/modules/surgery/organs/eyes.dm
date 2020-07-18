/obj/item/organ/eyes/robotic/glow/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = FALSE)
    RegisterSignal(M,COMSIG_LIVING_STATUS_UNCONSCIOUS,.proc/deactivate)
    . = ..()
	// makes High lum eyes depower upon conciousness loss

/obj/item/organ/eyes/robot_ipc
	name = "robotic eyes"
	icon_state = "cybernetic_eyeballs"
	desc = "A very basic set of optical sensors with no extra vision modes or functions."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/eyes/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	to_chat(owner, "<span class='warning'>Static obfuscates your vision!</span>")
	owner.flash_act(visual = 1)
	if(severity == EMP_HEAVY)
		owner.adjustOrganLoss(ORGAN_SLOT_EYES, 20) 

//moth eyes
/obj/item/organ/eyes/insect/moth
	name = "moffic eyes"
	desc = "They can only see lämp."
