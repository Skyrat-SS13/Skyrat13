/obj/machinery/dish_drive
	name = "dish drive"
	desc = "A culinary marvel that uses matter-to-energy conversion to store dishes and shards. Convenient! \
	Additional features include a vacuum function to suck in nearby dishes, and an automatic transfer beam that empties its contents into nearby disposal bins every now and then. \
	Or you can just drop your plates on the floor, like civilized folk."
	icon = 'goon/icons/obj/kitchen.dmi'
	icon_state = "synthesizer"
	idle_power_usage = 8 //5 with default parts
	active_power_usage = 13 //10 with default parts
	density = FALSE
	circuit = /obj/item/circuitboard/machine/dish_drive
	pass_flags = PASSTABLE
	var/static/list/item_types = list(/obj/item/trash/waffles,
		/obj/item/trash/plate,
		/obj/item/trash/tray,
		/obj/item/shard,
		/obj/item/broken_bottle)
	var/time_since_dishes = 0
	var/suction_enabled = TRUE
	var/transmit_enabled = TRUE
