/obj/item/organ/stomach/robot_ipc
	name = "IPC micro cell"
	icon = 'modular_skyrat/icons/obj/surgery.dmi'
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

//shitadel
/obj/item/organ/stomach/ipc
	name = "ipc stomach"
	icon_state = "stomach-ipc"
