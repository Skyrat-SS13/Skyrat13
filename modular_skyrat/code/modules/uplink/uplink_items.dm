/datum/uplink_item
  var/surplus_nullcrates //Chance of being included in null crates. null = pull from surplus
  
/datum/uplink_item/New()
	. = ..()
	if(isnull(surplus_nullcrates))
		surplus_nullcrates = surplus

/datum/uplink_item/ammo/machinegun/match
	name = "7.12x82mm (Match) Box Magazine"
	desc = "A 50-round magazine of 7.12x82mm ammunition for use in the L6 SAW; you didn't know there was a demand for match grade \
			precision bullet hose ammo, but these rounds are finely tuned and perfect for ricocheting off walls all fancy-like."
	item = /obj/item/ammo_box/magazine/mm712x82/match
	cost = 10
