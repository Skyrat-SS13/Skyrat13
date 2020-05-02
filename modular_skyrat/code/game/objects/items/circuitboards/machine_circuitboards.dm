/obj/item/circuitboard/machine/bluespace_miner
	name = "Bluespace Miner (Machine Board)"
	build_path = /obj/machinery/mineral/bluespace_miner
	req_components = list(
		/obj/item/stock_parts/matter_bin = 5,
		/obj/item/stock_parts/micro_laser = 5,
		/obj/item/stock_parts/manipulator = 5,
		/obj/item/stock_parts/scanning_module = 5,
		/obj/item/stack/ore/bluespace_crystal = 5)
	needs_anchored = FALSE

/obj/item/circuitboard/machine/biogenerator/prisoner
	name = "Prisoner Biogenerator (Machine Board)"
	build_path = /obj/machinery/biogenerator/prisoner
	req_components = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/stock_parts/manipulator = 1,
		/obj/item/stack/cable_coil = 1,
		/obj/item/stack/sheet/glass = 1)

/obj/item/circuitboard/machine/vendor/New()
	. = ..()
	vending_names_paths += list(/obj/machinery/vending/dinnerware/prisoner = "\improper Plasteel Chef's Prisoner Dinnerware Vendor",
								/obj/machinery/vending/hydronutrients/prisoner = "\improper Prisoner NutriMax")
