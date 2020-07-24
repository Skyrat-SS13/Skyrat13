//brig physician
/obj/item/radio/headset/headset_medsec
	name = "medical-security radio headset"
	desc = "Used to hear how many security officers need to be stiched back together."
	icon = 'modular_skyrat/icons/obj/radio.dmi'
	icon_state = "medsec_headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

//bloueshield
/obj/item/radio/headset/heads/blueshield
	name = "\proper the blueshield's headset"
	icon = 'modular_skyrat/icons/obj/radio.dmi'
	icon_state = "bshield_headset"
	keyslot = new /obj/item/encryptionkey/heads/blueshield

/obj/item/radio/headset/heads/blueshield/alt
	icon_state = "bshield_headset_alt"
	bowman = TRUE

//mining overseer
/obj/item/radio/headset/headset_cargo/mining/overseer
	name = "mining overseer radio headset"
	desc = "Headset used by mining overseers to overseer operations, or something."
	keyslot = new /obj/item/encryptionkey/headset_mining/overseer
