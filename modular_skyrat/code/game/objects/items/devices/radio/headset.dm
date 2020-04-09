/obj/item/radio/headset/headset_medsec
	name = "medical-security radio headset"
	desc = "Used to hear how many security officers need to be stiched back together."
	icon = 'modular_skyrat/icons/obj/radio.dmi'
	icon_state = "medsec_headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/item/radio/headset/heads/blueshield
	name = "\proper the blueshield's headset"
	icon = 'modular_skyrat/icons/obj/radio.dmi'
	icon_state = "bshield_headset"
	keyslot = new /obj/item/encryptionkey/heads/blueshield

/obj/item/radio/headset/heads/blueshield/alt
	icon_state = "bshield_headset_alt"
	bowman = TRUE

/obj/item/radio/headset/warden
	name = "\proper the warden's headset"
	desc = "Headset of the one who keeps the armoury and the prisoners in check."
	icon_state = "sec_headset"
	keyslot = new /obj/item/encryptionkey/heads/warden

/obj/item/radio/headset/warden/alt
	name = "\proper the warden's bowman headset"
	desc = "Headset of the one who keeps the armoury and the prisoners in check. Protects ears from flashbangs."
	icon_state = "sec_headset_alt"
	item_state = "sec_headset_alt"
	bowman = TRUE
