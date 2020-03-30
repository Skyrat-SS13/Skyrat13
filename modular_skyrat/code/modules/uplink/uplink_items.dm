/datum/uplink_item
  var/surplus_nullcrates //Chance of being included in null crates. null = pull from surplus
  
/datum/uplink_item/New()
	. = ..()
	if(isnull(surplus_nullcrates))
		surplus_nullcrates = surplus
