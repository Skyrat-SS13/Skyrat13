/obj/machinery/scp294
	name = "\improper Solar's Best Hot Drinks"
	desc = "A vending machine which dispenses hot drinks. Nothing to see here."
	icon = 'icons/obj/vending.dmi'
	icon_state = "coffee"
	var/dispensing = FALSE
	var/cooldown_time = 5 MINUTES
	var/cooldown = 0
	var/malf_chance = 5
	var/malf_chance_powerchem = 50
	var/list/power_chems = list(
	)

/obj/machinery/scp294/attack_hand(mob/living/user)
	if(!user.canUseTopic(src, TRUE))
		return
	if(world.time < cooldown)
		to_chat(user, "<span class='warning'>\The [src] is still recharging!</span>")
		return
	if(dispensing)
		to_chat(user, "<span class='warning'>\The [src] is in use.</span>")
		return
	dispensing = TRUE
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
	dispensing = FALSE
	var/malf = malf_chance
	if(drinkie in power_chems)
		malf = malf_chance_powerchem
	if(prob(malf))
		audible_message("<span class='warning'>\The [src] starts shaking and humming loudly... this can't be good.</span>")
		sleep(15)
		reagents.add_reagent(drinkie, 50)
		reagents.add_reagent(/datum/reagent/toxin/amanitin, 200)
		var/datum/effect_system/smoke_spread/chem/smoke = new()
		smoke.set_up(reagents, 3, src, FALSE)
		explosion(src, 0, 0, 3, 3)
		qdel(src)
	dispensing = FALSE

/obj/machinery/scp294/emag_act()
	say("Beep.")
	malf_chance = 0
	malf_chance_powerchem = 0
