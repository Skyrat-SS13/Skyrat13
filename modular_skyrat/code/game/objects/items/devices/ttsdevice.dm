/obj/item/ttsdevice
	name = "TTS Device"
	desc = "A small device with a keyboard attached. Anything entered on the keyboard is played out the speaker. \n <span class='notice'>Alt-click the device to make it beep.</span>"
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-purple"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	obj_flags = UNIQUE_RENAME
	slot_flags = ITEM_SLOT_BELT

/obj/item/ttsdevice/attack_self(mob/user)
	var/input = stripped_input(user,"What would you like the device to say?", ,"", 500)
	if(QDELETED(src) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(input)
		src.say(input)
	input = null


/obj/item/ttsdevice/AltClick(mob/living/user)
	var/noisechoice = input(user, "What noise would you like to make?", "Robot Noises") as null|anything in list("Beep","Buzz","Ping")
	if(noisechoice == "Beep")
		user.visible_message("[user] has made their TTS beep!", "You make your TTS beep!")
		playsound(user, 'sound/machines/twobeep.ogg', 50, 1, -1)
	if(noisechoice == "Buzz")
		user.visible_message("[user] has made their TTS buzz!", "You make your TTS buzz!")
		playsound(user, 'sound/machines/buzz-sigh.ogg', 50, 1, -1)
	if(noisechoice == "Ping")
		user.visible_message("[user] has made their TTS ping!", "You make your TTS ping!")
		playsound(user, 'sound/machines/ping.ogg', 50, 1, -1)


