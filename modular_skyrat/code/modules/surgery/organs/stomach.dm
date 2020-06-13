/obj/item/organ/stomach/robot_ipc
	name = "IPC power cell"
	icon_state = "microcell"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	attack_verb = list("assault and battery'd")
	desc = "A specialised cell, for IPC use only. Do not swallow."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/stomach/robot_ipc/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, "<span class='warning'>Alert: Detected severe battery discharge!</span>")
		if(2)
			owner.nutrition = 250
			to_chat(owner, "<span class='warning'>Alert: Minor battery discharge!</span>") 

/obj/item/organ/stomach/cybernetic
	name = "cybernetic stomach"
	desc = "A cybernetic version of the stomach found in traditional humanoid entities. It functions similarly to the organic one and is merely meant as a replacement."
	icon_state = "stomach-ipc"
	organ_flags = ORGAN_SYNTHETIC
	maxHealth = 400

/obj/item/organ/stomach/cybernetic/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	owner.adjust_nutrition(-50)
	owner.adjustOrganLoss(ORGAN_SLOT_STOMACH, 25)
	if(severity == 1 && prob(50)) //I guess vomiting is a rough one so lets put it on a prob 50
		owner.vomit()
