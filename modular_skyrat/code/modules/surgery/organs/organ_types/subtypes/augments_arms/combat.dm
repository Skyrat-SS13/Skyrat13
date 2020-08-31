
/obj/item/organ/cyberimp/arm/gun/laser
	name = "arm-mounted laser implant"
	desc = "A variant of the arm cannon implant that fires lethal laser beams. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_laser"
	contents = newlist(/obj/item/gun/energy/laser/mounted)

/obj/item/organ/cyberimp/arm/gun/taser
	name = "arm-mounted taser implant"
	desc = "A variant of the arm cannon implant that fires electrodes and disabler shots. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_taser"
	contents = newlist(/obj/item/gun/energy/e_gun/advtaser/mounted)

/obj/item/organ/cyberimp/arm/flash
	name = "integrated high-intensity photon projector" //Why not
	desc = "An integrated projector mounted onto a user's arm that is able to be used as a powerful flash."
	contents = newlist(/obj/item/assembly/flash/armimplant)

/obj/item/organ/cyberimp/arm/flash/Initialize()
	. = ..()
	if(locate(/obj/item/assembly/flash/armimplant) in items_list)
		var/obj/item/assembly/flash/armimplant/F = locate(/obj/item/assembly/flash/armimplant) in items_list
		F.I = src

/obj/item/organ/cyberimp/arm/baton
	name = "arm electrification implant"
	desc = "An illegal combat implant that allows the user to administer disabling shocks from their arm."
	contents = newlist(/obj/item/borg/stun)

/obj/item/organ/cyberimp/arm/combat
	name = "combat cybernetics implant"
	desc = "A powerful cybernetic implant that contains combat modules built into the user's arm."
	contents = newlist(/obj/item/melee/transforming/energy/blade/hardlight, /obj/item/gun/medbeam, /obj/item/borg/stun, /obj/item/assembly/flash/armimplant)

/obj/item/organ/cyberimp/arm/combat/Initialize()
	. = ..()
	if(locate(/obj/item/assembly/flash/armimplant) in items_list)
		var/obj/item/assembly/flash/armimplant/F = locate(/obj/item/assembly/flash/armimplant) in items_list
		F.I = src

/obj/item/organ/cyberimp/arm/esword
	name = "arm-mounted energy blade"
	desc = "An illegal and highly dangerous cybernetic implant that can project a deadly blade of concentrated energy."
	contents = newlist(/obj/item/melee/transforming/energy/blade/hardlight)

/obj/item/organ/cyberimp/arm/shield
	name = "arm-mounted riot shield"
	desc = "A deployable riot shield to help deal with civil unrest."
	contents = newlist(/obj/item/shield/riot/implant)

/obj/item/organ/cyberimp/arm/shield/Extend(obj/item/I)
	if(I.obj_integrity == 0)				//that's how the shield recharge works
		to_chat(owner, "<span class='warning'>[I] is still too unstable to extend. Give it some time!</span>")
		return FALSE
	return ..()

/obj/item/organ/cyberimp/arm/shield/emag_act()
	. = ..()
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(usr, "<span class='notice'>You unlock [src]'s high-power flash!</span>")
	var/obj/item/assembly/flash/armimplant/F = new(src)
	items_list += F
	F.I = src

///ARM BLADE FOR ARM BLADE IMPLANT - Based off of the Mantis Blades from 2077.
/obj/item/melee/implantarmblade
	name = "implanted arm blade"
	desc = "A long, sharp, mantis-like blade implanted into someones arm. Cleaves through flesh like its particularly strong butter."
	icon = 'modular_skyrat/icons/obj/implanted_blade.dmi'
	righthand_file = 'modular_skyrat/icons/mob/inhands/implanted_blade_righthand.dmi'
	lefthand_file = 'modular_skyrat/icons/mob/inhands/implanted_blade_lefthand.dmi'
	icon_state = "mantis_blade"
	item_state = "mantis_blade"
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 25
	armour_penetration = 20
	sharpness = SHARP_EDGED
	item_flags = NEEDS_PERMIT
	hitsound = 'modular_skyrat/sound/weapons/bloodyslice.ogg'

/obj/item/melee/implantarmblade/energy
	name = "energy arm blade"
	desc = "A long mantis-like blade made entirely of blazing-hot energy. Stylish and EXTRA deadly!"
	icon = 'modular_skyrat/icons/obj/implanted_blade.dmi'
	icon_state = "energy_mantis_blade"
	item_state = "energy_mantis_blade"
	force = 30
	armour_penetration = 10 //Energy isn't as good at going through armor as it is through flesh alone.
	hitsound = 'sound/weapons/blade1.ogg'

/obj/item/organ/cyberimp/arm/armblade
	name = "arm blade implant"
	desc = "An integrated blade implant designed to be installed into a persons arm. Stylish and deadly; Although, being caught with this without proper permits is sure to draw unwanted attention."
	contents = newlist(/obj/item/melee/implantarmblade)
	icon = 'modular_skyrat/icons/obj/implanted_blade.dmi'
	icon_state = "mantis_blade"

/obj/item/organ/cyberimp/arm/armblade/emag_act()
	. = ..()
	if(obj_flags & EMAGGED)
		return
	obj_flags |= EMAGGED
	to_chat(usr, "<span class='notice'>You unlock [src]'s integrated energy arm blade! You madman!</span>")
	items_list += new /obj/item/melee/implantarmblade/energy(src)
	return TRUE
