/obj/machinery/scp294
	name = "\improper Solar's Best Hot Drinks"
	desc = "A vending machine which dispenses hot drinks. Nothing to see here."
	icon = 'icons/obj/vending.dmi'
	icon_state = "coffee"
	var/cooldown_time = 45 SECONDS
	var/cooldown = 0

/obj/machinery/scp294/attack_hand(mob/living/user)
	if(!user.canUseTopic(src, TRUE))
		return
	if(world.time < cooldown)
		to_chat(user, "<span class='warning'>\The [src] is still recharging!</span>")
		return
	var/reagent = input(user, "What do you want to drink?", "Coffee Vendor", "Nothing") as text
	if(!reagent)
		return
	var/drinkie
	for(var/r in subtypesof(/datum/reagent))
		var/datum/reagent/reagentie = r
		if(lowertext(initial(reagentie.name)) == lowertext(reagent))
			drinkie = reagentie
	if(drinkie)
		var/obj/item/reagent_containers/food/drinks/mug/mug = new(get_turf(src))
		mug.name = "cup of [reagent]"
		mug.reagents.add_reagent(drinkie, mug.reagents.maximum_volume)
		say("Enjoy your drink! Beep.")
	else
		say("Invalid drink!")
	cooldown = world.time + cooldown
