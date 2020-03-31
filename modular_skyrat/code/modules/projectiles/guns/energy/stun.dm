//chameleon taser
/obj/item/gun/energy/e_gun/advtaser/chameleon
	name = "Chameleon Taser"
	desc = "An advanced hybrid taser that can mimmick the appearance of other guns."
	actions_types = list(/datum/action/item_action/chameleon/taser)
	w_class = WEIGHT_CLASS_TINY
	cell_type = /obj/item/stock_parts/cell/chameleongun
	var/list/gun_options = list()
	modifystate = FALSE
	item_state = null
	shaded_charge = FALSE

/datum/action/item_action/chameleon/taser
	name = "Chameleon change"
	desc = "Change your taser's appearance."

/obj/item/gun/energy/e_gun/advtaser/chameleon/Initialize()
	. = ..()
	for(var/obj/item/gun/G in subtypesof(/obj/item/gun))
		gun_options[G.name] = G

/obj/item/gun/energy/e_gun/advtaser/chameleon/equipped(mob/user, slot)
	. = ..()
	for(var/datum/action/item_action/I in actions_types)
		I.Grant(user)

/obj/item/gun/energy/e_gun/advtaser/chameleon/dropped(mob/user, slot)
	. = ..()
	for(var/datum/action/item_action/I in actions_types)
		I.Remove(user)

/obj/item/gun/energy/e_gun/advtaser/chameleon/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/chameleon/taser) && user)
		var/obj/item/gun/newgun = input("Select gun style to change into", "Gun Skin") as null|anything in gun_options
		if(!newgun)
			return
		else
			name = newgun.name
			desc = newgun.desc
			icon = newgun.icon
			icon_state = newgun.icon_state
			item_state = newgun.item_state
			lefthand_file = newgun.lefthand_file
			righthand_file = newgun.righthand_file
			return TRUE

/obj/item/stock_parts/cell/chameleongun
	name = "chameleon gun internal cell"
	maxcharge = 1500

/obj/item/stock_parts/cell/chameleongun/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF)

/obj/item/gun/energy/e_gun/advtaser/chameleon/emp_act(severity)
	var/obj/item/gun/newgun = pick(gun_options)
	if(!newgun)
		return
	else
		name = newgun.name
		desc = newgun.desc
		icon = newgun.icon
		icon_state = newgun.icon_state
		item_state = newgun.item_state
		lefthand_file = newgun.lefthand_file
		righthand_file = newgun.righthand_file
		return TRUE
	visible_message("<span class='warning'>\the [initial(name)] malfunctions into a [name]!</span>", "<span class='warning'>\the [initial(name)] malfunctions into a [name]!</span>")
	var/datum/effect_system/spark_spread/S = new /datum/effect_system/spark_spread()
	S.set_up(5, 0, src)
	S.attach(src)
	S.start()
	playsound(src, "sparks", 100, 1)

/obj/item/gun/energy/e_gun/advtaser/update_icon()
	return