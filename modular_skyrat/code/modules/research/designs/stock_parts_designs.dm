////////////////////////////////////////
/////////////Stock Parts////////////////
////////////////////////////////////////

//Utility
/datum/design/RPED
	name = "Rapid Part Exchange Device (RPED)"
	desc = "Special mechanical module made to store, sort, and apply standard machine parts."
	id = "rped"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 5000) //hardcore
	build_path = /obj/item/storage/part_replacer
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/BS_RPED
	name = "Bluespace Rapid Part Exchange Device (B-RPED)"
	desc = "Powered by bluespace technology, this RPED variant can upgrade buildings from a distance, without needing to remove the panel first."
	id = "bs_rped"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 15000, /datum/material/glass = 5000, /datum/material/silver = 2500) //hardcore
	build_path = /obj/item/storage/part_replacer/bluespace
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

//Capacitors
/datum/design/capacitor_t1
	name = "Basic Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "capacitor_t1"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 100)
	build_path = /obj/item/stock_parts/capacitor
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/capacitor_t2
	name = "Advanced Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "capacitor_t2"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 150)
	build_path = /obj/item/stock_parts/capacitor/t2
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/capacitor_t3
	name = "Super Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "capacitor_t3"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/gold = 100)
	build_path = /obj/item/stock_parts/capacitor/t3
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/capacitor_t4
	name = "Mega Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "capacitor_t4"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/gold = 100, /datum/material/diamond = 100)
	build_path = /obj/item/stock_parts/capacitor/t4
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/capacitor_t5
	name = "Bluespace Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "capacitor_t5"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/gold = 100, /datum/material/diamond = 100, /datum/material/bluespace = 30 )
	build_path = /obj/item/stock_parts/capacitor/t5
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/capacitor_t6
	name = "Quantum Capacitor"
	desc = "A stock part used in the construction of various devices."
	id = "capacitor_t6"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/gold = 100, /datum/material/diamond = 200, /datum/material/bluespace = 100 )
	build_path = /obj/item/stock_parts/capacitor/t6
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

//Scanning modules
/datum/design/scanning_t1
	name = "Basic Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "scanning_t1"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 50)
	build_path = /obj/item/stock_parts/scanning_module
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/scanning_t2
	name = "Advanced Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "scanning_t2"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 100)
	build_path = /obj/item/stock_parts/scanning_module/t2
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/scanning_t3
	name = "Super Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "scanning_t3"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 150, /datum/material/silver = 60)
	build_path = /obj/item/stock_parts/scanning_module/t3
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/scanning_t4
	name = "Mega Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "scanning_t4"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/diamond = 30, /datum/material/bluespace = 30)
	build_path = /obj/item/stock_parts/scanning_module/t4
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/scanning_t5
	name = "Bluespace Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "scanning_t5"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/diamond = 60, /datum/material/bluespace = 60)
	build_path = /obj/item/stock_parts/scanning_module/t5
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/scanning_t6
	name = "Quantum Scanning Module"
	desc = "A stock part used in the construction of various devices."
	id = "scanning_t6"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/diamond = 100, /datum/material/bluespace = 100)
	build_path = /obj/item/stock_parts/scanning_module/t6
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

//Maipulators
/datum/design/manipulator_t1
	name = "Basic Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "manipulator_t1"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/stock_parts/manipulator
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/manipulator_t2
	name = "Advanced Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "manipulator_t2"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/stock_parts/manipulator/t2
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/manipulator_t3
	name = "Super Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "manipulator_t3"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/stock_parts/manipulator/t3
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/manipulator_t4
	name = "Mega Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "manipulator_t4"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/diamond = 30, /datum/material/titanium = 30)
	build_path = /obj/item/stock_parts/manipulator/t4
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/manipulator_t5
	name = "Bluespace Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "manipulator_t5"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/diamond = 30, /datum/material/titanium = 30, /datum/material/bluespace = 30)
	build_path = /obj/item/stock_parts/manipulator/t5
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/manipulator_t6
	name = "Quantum Manipulator"
	desc = "A stock part used in the construction of various devices."
	id = "manipulator_t6"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/diamond = 60, /datum/material/titanium = 60, /datum/material/bluespace = 60)
	build_path = /obj/item/stock_parts/manipulator/t6
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE


//Micro-lasers
/datum/design/micro_laser_t1
	name = "Basic Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "laser_t1"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/glass = 50, /datum/material/titanium = 60, )
	build_path = /obj/item/stock_parts/micro_laser
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/micro_laser_t2
	name = "Advanced Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "laser_t2"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150, /datum/material/glass = 100)
	build_path = /obj/item/stock_parts/micro_laser/t2
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/micro_laser_t3
	name = "Super Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "laser_t3"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 150, /datum/material/uranium = 60)
	build_path = /obj/item/stock_parts/micro_laser/t3
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/micro_laser_t4
	name = "Mega Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "laser_t4"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/uranium = 100, /datum/material/diamond = 60)
	build_path = /obj/item/stock_parts/micro_laser/t4
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/micro_laser_t5
	name = "Bluespace Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "laser_t5"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/uranium = 100, /datum/material/diamond = 60, /datum/material/bluespace = 30)
	build_path = /obj/item/stock_parts/micro_laser/t5
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/micro_laser_t6
	name = "Quantum Micro-Laser"
	desc = "A stock part used in the construction of various devices."
	id = "laser_t6"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200, /datum/material/glass = 200, /datum/material/uranium = 100, /datum/material/diamond = 120, /datum/material/bluespace = 60)
	build_path = /obj/item/stock_parts/micro_laser/t6
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

//Matter bins
/datum/design/matter_bin_t1
	name = "Basic Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "matter_bin_t1"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/stock_parts/matter_bin
	category = list("Stock Parts","Machinery","initial")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/matter_bin_t2
	name = "Advanced Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "matter_bin_t2"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 150)
	build_path = /obj/item/stock_parts/matter_bin/t2
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/matter_bin_t3
	name = "Super Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "matter_bin_t3"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/stock_parts/matter_bin/t3
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/matter_bin_t4
	name = "Mega Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "matter_bin_t4"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/diamond = 100)
	build_path = /obj/item/stock_parts/matter_bin/t4
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/matter_bin_t5
	name = "Bluespace Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "matter_bin_t5"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/diamond = 100, /datum/material/bluespace = 100)
	build_path = /obj/item/stock_parts/matter_bin/t5
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/matter_bin_t6
	name = "Quantum Matter Bin"
	desc = "A stock part used in the construction of various devices."
	id = "matter_bin_t6"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 250, /datum/material/diamond = 200, /datum/material/bluespace = 200)
	build_path = /obj/item/stock_parts/matter_bin/t6
	category = list("Stock Parts")
	lathe_time_factor = 0.2
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

//T-Comms devices
/datum/design/subspace_ansible
	name = "Subspace Ansible"
	desc = "A compact module capable of sensing extradimensional activity."
	id = "s-ansible"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 100)
	build_path = /obj/item/stock_parts/subspace/ansible
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/hyperwave_filter
	name = "Hyperwave Filter"
	desc = "A tiny device capable of filtering and converting super-intense radiowaves."
	id = "s-filter"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 100)
	build_path = /obj/item/stock_parts/subspace/filter
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/subspace_amplifier
	name = "Subspace Amplifier"
	desc = "A compact micro-machine capable of amplifying weak subspace transmissions."
	id = "s-amplifier"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/gold = 100, /datum/material/uranium = 100)
	build_path = /obj/item/stock_parts/subspace/amplifier
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/subspace_treatment
	name = "Subspace Treatment Disk"
	desc = "A compact micro-machine capable of stretching out hyper-compressed radio waves."
	id = "s-treatment"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/silver = 200)
	build_path = /obj/item/stock_parts/subspace/treatment
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/subspace_analyzer
	name = "Subspace Wavelength Analyzer"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	id = "s-analyzer"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 100, /datum/material/gold = 100)
	build_path = /obj/item/stock_parts/subspace/analyzer
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/subspace_crystal
	name = "Ansible Crystal"
	desc = "A sophisticated analyzer capable of analyzing cryptic subspace wavelengths."
	id = "s-crystal"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 800, /datum/material/silver = 100, /datum/material/gold = 100)
	build_path = /obj/item/stock_parts/subspace/crystal
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE

/datum/design/subspace_transmitter
	name = "Subspace Transmitter"
	desc = "A large piece of equipment used to open a window into the subspace dimension."
	id = "s-transmitter"
	build_type = PROTOLATHE
	materials = list(/datum/material/glass = 100, /datum/material/silver = 100, /datum/material/uranium = 100)
	build_path = /obj/item/stock_parts/subspace/transmitter
	category = list("Stock Parts")
	departmental_flags = DEPARTMENTAL_FLAG_ENGINEERING | DEPARTMENTAL_FLAG_SCIENCE
