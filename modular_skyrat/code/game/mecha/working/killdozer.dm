/obj/mecha/working/ripley/firefighter/killdozer
	desc = "Autonomous Power Loader Unit. This model is refitted with additional thermal and kinetic protection. Capable of accepting illegal upgrades, as well as damaging government property."
	name = "\improper APLU \"Killdozer\""
	icon = 'modular_skyrat/icons/mecha/sometimesreasonablemenmustdounreasonablethings.dmi'
	icon_state = "ripley"
	opacity = 1
	bumpsmash = 1
	step_in = 2
	step_energy_drain = 3
	normal_step_energy_drain = 3
	melee_energy_drain = 7
	fast_pressure_step_in = 2
	slow_pressure_step_in = 2
	max_temperature = 80000 //NOTHING BURNS BRIGHTER THAN PURE HATRED.
	max_integrity = 275
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	armor = list("melee" = 40, "bullet" = 25, "laser" = 25, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 65, "fire" = 100, "acid" = 100)
	max_equip = 4
	wreckage = /obj/structure/mecha_wreckage/ripley/firefighter/killdozer
	cargo_capacity = 20
	schut = TRUE
	smashcooldown = 6 //you can still cause a lotta damage with this
