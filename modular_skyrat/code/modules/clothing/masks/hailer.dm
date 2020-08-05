/obj/item/clothing/mask/gas/sechailer/cpmask
	name = "Civil Protection gas mask"
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	icon_state = "cpmask"
	item_state = "cpmask"
	actions_types = list(/datum/action/item_action/halt)
	aggressiveness = 3
	desc = "A standard issue metropolice gas mask. Now you too can make random citizens pick up that can."
	var/list/saved_screams = list()

/obj/item/clothing/mask/gas/sechailer/cpmask/halt()
	set category = "Object"
	set name = "HALT"
	set src in usr
	if(!isliving(usr))
		return
	if(!can_use(usr))
		return
	if(broken_hailer)
		to_chat(usr, "<span class='warning'>\The [src]'s hailing system is broken.</span>")
		return

	var/phrase = 0	//selects which phrase to use
	var/phrase_text = null
	var/phrase_sound = null


	if(cooldown < world.time - 30) // A cooldown, to stop people being jerks
		recent_uses++
		if(cooldown_special < world.time - 180) //A better cooldown that burns jerks
			recent_uses = initial(recent_uses)

		switch(recent_uses)
			if(3)
				to_chat(usr, "<span class='warning'>\The [src] is starting to heat up.</span>")
			if(4)
				to_chat(usr, "<span class='userdanger'>\The [src] is heating up dangerously from overuse!</span>")
			if(5) //overload
				broken_hailer = 1
				to_chat(usr, "<span class='userdanger'>\The [src]'s power modulator overloads and breaks.</span>")
				return
		switch(aggressiveness)
			if(3)
				phrase = rand(1,8)
			else
				to_chat(usr, "<span class='userdanger'>\The [src] is broken.</span>")
		switch(phrase)	//sets the properties of the chosen phrase
			if(1)
				phrase_text = "Watch it."
				phrase_sound = "watchit"
			if(2)
				phrase_text = "Pick up that can."
				phrase_sound = "pickupthecan1"
			if(3)
				phrase_text = "Investigate."
				phrase_sound = "investigate"
			if(4)
				phrase_text = "Hold it right there."
				phrase_sound = "holditrightthere"
			if(5)
				phrase_text = "Don't move."
				phrase_sound = "dontmove2"
			if(6)
				phrase_text = "11-99! Officer needs assistance!"
				phrase_sound = "officerneedsassistance"
			if(7)
				phrase_text = "Move it."
				phrase_sound = "moveit"
			if(8)
				phrase_text = "Move along."
				phrase_sound = "movealong"
		usr.audible_message("[usr]'s Compli-o-Nator: <font color='red' size='4'><b>[phrase_text]</b></font>")
		var/OFF = rand(1,4)
		var/ON = rand(1,2)
		playsound(src.loc, "modular_skyrat/sound/voice/complionator/on[ON].ogg", 100, 0, 4)
		playsound(src.loc, "modular_skyrat/sound/voice/complionator/[phrase_sound].ogg", 100, 0, 4)
		playsound(src.loc, "modular_skyrat/sound/voice/complionator/off[OFF].ogg", 100, 0, 4)
		cooldown = world.time
		cooldown_special = world.time

/obj/item/clothing/mask/gas/sechailer/cpmask/emag_act(mob/user)
	return

/obj/item/clothing/mask/gas/sechailer/cpmask/screwdriver_act(mob/living/user, obj/item/I)
	return

/obj/item/clothing/mask/gas/sechailer/cpmask/wirecutter_act(mob/living/user, obj/item/I)
	return

/obj/item/clothing/mask/gas/sechailer/cpmask/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == SLOT_WEAR_MASK)
		var/mob/living/carbon/human/H = user
		var/obj/item/implant/flatline/F = new
		F.implant(H, H)
		saved_screams = H.alternate_screams.Copy()
		H.alternate_screams = list('modular_skyrat/sound/voice/complionator/pain1.ogg','modular_skyrat/sound/voice/complionator/pain2.ogg','modular_skyrat/sound/voice/complionator/pain3.ogg','modular_skyrat/sound/voice/complionator/pain1.ogg',)

/obj/item/clothing/mask/gas/sechailer/cpmask/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	else
		var/mob/living/carbon/human/H = user
		for(var/obj/item/implant/flatline/F in H.implants)
			F.removed(H)
		H.alternate_screams = saved_screams.Copy()
		saved_screams = list()

//Flatline implant

/obj/item/implant/flatline
	name = "flatline implant"
	activated = 0

/obj/item/implant/flatline/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Combine Civil Protection flatline Implant<BR>
				<b>Life:</b> Activates upon death.<BR>
				"}
	return dat

/obj/item/implant/flatline/trigger(emote, mob/source)
	if(emote == "deathgasp")
		switch(rand(1,4))
			if(1)
				playsound(source.loc, "modular_skyrat/sound/voice/complionator/die1.ogg", 50, 0)
			if(2)
				playsound(source.loc, "modular_skyrat/sound/voice/complionator/die2.ogg", 50, 0)
			if(3)
				playsound(source.loc, "modular_skyrat/sound/voice/complionator/die3.ogg", 50, 0)
			if(4)
				playsound(source.loc, "modular_skyrat/sound/voice/complionator/die4.ogg", 50, 0)


/obj/item/implanter/flatline
	name = "implanter (flatline)"
	imp_type = /obj/item/implant/flatline

/obj/item/implantcase/flatline
	name = "implant case - 'Flatline'"
	desc = "A glass case containing a flatline implant."
	imp_type = /obj/item/implant/flatline

//HECU mask
/obj/item/clothing/mask/gas/sechailer/hecu
	name = "HECU mask"
	desc = "MY. ASS. IS. HEAVY."
	icon = 'modular_skyrat/icons/obj/clothing/masks.dmi'
	icon_state = "hecu"
	mob_overlay_icon = 'modular_skyrat/icons/mob/clothing/mask.dmi'
	anthro_mob_worn_overlay  = 'modular_skyrat/icons/mob/clothing/mask_muzzled.dmi'
	actions_types = list(/datum/action/item_action/halt)
	flags_inv = HIDEFACIALHAIR|HIDEFACE|HIDEEYES
	aggressiveness = 4

/obj/item/clothing/mask/gas/sechailer/hecu/halt()
	set category = "Object"
	set name = "HALT"
	set src in usr
	if(!isliving(usr))
		return
	if(!can_use(usr))
		return
	if(broken_hailer)
		to_chat(usr, "<span class='warning'>\The [src]'s hailing system is broken.</span>")
		return

	var/phrase = 0	//selects which phrase to use
	var/phrase_text = null
	var/phrase_sound = null


	if(cooldown < world.time - 30) // A cooldown, to stop people being jerks
		recent_uses++
		if(cooldown_special < world.time - 180) //A better cooldown that burns jerks
			recent_uses = initial(recent_uses)

		switch(recent_uses)
			if(3)
				to_chat(usr, "<span class='warning'>\The [src] is starting to heat up.</span>")
			if(4)
				to_chat(usr, "<span class='userdanger'>\The [src] is heating up dangerously from overuse!</span>")
			if(5) //overload
				broken_hailer = 1
				to_chat(usr, "<span class='userdanger'>\The [src]'s power modulator overloads and breaks.</span>")
				return
		switch(aggressiveness)
			if(4)
				phrase = rand(1,9)
			else
				to_chat(usr, "<span class='userdanger'>\The [src] is broken.</span>")
		switch(phrase)	//sets the properties of the chosen phrase
			if(1)
				phrase_text = "GO, MOVE!"
				phrase_sound = "gomove"
			if(2)
				phrase_text = "GO, RECON!"
				phrase_sound = "gorecon"
			if(3)
				phrase_text = "I NEED BACKUP!"
				phrase_sound = "ineedbackup"
			if(4)
				phrase_text = "MOVE, IN!"
				phrase_sound = "movein"
			if(5)
				phrase_text = "I NEED SUPPRESSING FIRE!"
				phrase_sound = "supressingfire"
			if(6)
				phrase_text = "SWEEP THIS AREA!"
				phrase_sound = "sweepthisarea"
			if(7)
				phrase_text = "TAKE DOWN THAT TANGO!"
				phrase_sound = "takedowntango"
			if(8)
				phrase_text = "TANGO!"
				phrase_sound = "tango"
			if(9)
				phrase_text = "DAMN, WE HAVE HOSTILES!"
				phrase_sound = "wehavehostiles"
		usr.audible_message("[usr]'s Compli-o-Nator: <font color='red' size='4'><b>[phrase_text]</b></font>")
		cooldown = world.time
		cooldown_special = world.time
		playsound(src.loc, "modular_skyrat/sound/voice/complionator/hecu/[phrase_sound].wav", 100, 0, 4)
