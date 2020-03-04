/obj/item/organ/stomach/cell
	name = "micro-cell"
	icon_state = "microcell"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	attack_verb = list("assault and battery'd")
	desc = "A micro-cell, for IPC use only. Do not swallow."
	status = ORGAN_ROBOTIC

/obj/item/organ/stomach/cell/emp_act(severity)
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, "<span class='warning'>Alert: Heavy EMP Detected. Rebooting power cell to prevent damage.</span>")
		if(2)
			owner.nutrition = 250
			to_chat(owner, "<span class='warning'>Alert: EMP Detected. Cycling battery.</span>") 