/datum/design/borg_upgrade_xwelding
	name = "Cyborg Upgrade (Experimental Welding Tool)"
	id = "borg_upgrade_xwelding"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/xwelding
	materials = list(/datum/material/iron = 1000, /datum/material/plasma = 1000, /datum/material/titanium = 1000)
	construction_time = 100
	category = list("Cyborg Upgrade Modules")
/* Shit doesnt work, work on it later
/datum/design/borg_upgrade_plasma
	name = "Cyborg Upgrade (Plasma Resource)"
	id = "borg_upgrade_plasma"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/plasma
	materials = list(/datum/material/plasma = 1000, /datum/material/bluespace = 1000)
	construction_time = 100
	category = list("Cyborg Upgrade Modules")
*/
/datum/design/borg_upgrade_bsrpd
	name = "Cyborg Upgrade (Bluespace RPD)"
	id = "borg_upgrade_bsrpd"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/bsrpd
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 1000, /datum/material/bluespace = 500)
	construction_time = 100
	category = list("Cyborg Upgrade Modules")

/datum/design/borg_upgrade_premiumka
	name = "Cyborg Upgrade (Premium Kinetic Accelerator)"
	id = "borg_upgrade_premiumka"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/premiumka
	materials = list(/datum/material/iron=8000, /datum/material/glass=4000, /datum/material/titanium=2000)
	construction_time = 120
	category = list("Cyborg Upgrade Modules")

/datum/design/borg_upgrade_expand
	name = "Cyborg Upgrade (Expand)"
	id = "borg_upgrade_expand"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/expand
	materials = list(/datum/material/iron=20000, /datum/material/glass=5000)
	construction_time = 120
	category = list("Cyborg Upgrade Modules")

/datum/design/borg_upgrade_shrink
	name = "Cyborg Upgrade (shrink)"
	id = "borg_upgrade_shrink"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/shrink
	materials = list(/datum/material/iron=20000, /datum/material/glass=5000)
	construction_time = 120
	category = list("Cyborg Upgrade Modules")


//Killdozer
/datum/design/killdozer_chassis
	name = "Exosuit Chassis (APLU \"Killdozer\")"
	id = "killdozer_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/killdozer
	materials = list(/datum/material/iron=40000, /datum/material/diamond=3000, /datum/material/uranium=5000)
	construction_time = 120
	category = list("Killdozer")

/datum/design/killdozer_clamp
	name = "Killdozer Upgrade (Kill-clamp)"
	id = "killdozer_clamp"
	build_type = MECHFAB
	build_path =/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/real/killdozer
	materials = list(/datum/material/iron=25000, /datum/material/diamond=1000, /datum/material/uranium=2500)
	construction_time = 80
	category = list("Exosuit Equipment")

/datum/design/killdozer_drill
	name = "Killdozer Upgrade (Kill-drill)"
	id = "killdozer_drill"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/drill/killdozer
	materials = list(/datum/material/iron=25000, /datum/material/diamond=1000, /datum/material/uranium=2500)
	construction_time = 80
	category = list("Exosuit Equipment")

/datum/design/killdozer_pistol
	name = "Killdozer Upgrade (10mm pistol)"
	id = "killdozer_pistol"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/killdozer
	materials = list(/datum/material/iron=30000, /datum/material/diamond=2500, /datum/material/uranium=3500)
	construction_time = 100
	category = list("Exosuit Equipment")

/datum/design/killdozer_pistol_ammo
	name = "Exosuit Stetchkin Ammo"
	id = "killdozer_pistol_ammo"
	build_type = MECHFAB
	build_path = /obj/item/mecha_ammo/stetchkin
	materials = list(/datum/material/iron=1000, /datum/material/diamond=100, /datum/material/uranium=500)
	construction_time = 50
	category = list("Exosuit Equipment")

//Changes to ripley parts to accomodate the Killdozer
/datum/design/ripley_torso
	name = "Exosuit Torso (APLU \"Ripley\")"
	id = "ripley_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_torso
	materials = list(/datum/material/iron=20000, /datum/material/glass=7500)
	construction_time = 200
	category = list("Ripley","Firefighter", "Killdozer")

/datum/design/ripley_left_arm
	name = "Exosuit Left Arm (APLU \"Ripley\")"
	id = "ripley_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_left_arm
	materials = list(/datum/material/iron=15000)
	construction_time = 150
	category = list("Ripley","Firefighter", "Killdozer")

/datum/design/ripley_right_arm
	name = "Exosuit Right Arm (APLU \"Ripley\")"
	id = "ripley_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_right_arm
	materials = list(/datum/material/iron=15000)
	construction_time = 150
	category = list("Ripley","Firefighter", "Killdozer")

/datum/design/ripley_left_leg
	name = "Exosuit Left Leg (APLU \"Ripley\")"
	id = "ripley_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_left_leg
	materials = list(/datum/material/iron=15000)
	construction_time = 150
	category = list("Ripley","Firefighter", "Killdozer")

/datum/design/ripley_right_leg
	name = "Exosuit Right Leg (APLU \"Ripley\")"
	id = "ripley_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/ripley_right_leg
	materials = list(/datum/material/iron=15000)
	construction_time = 150
	category = list("Ripley","Firefighter", "Killdozer")

///Power Armor
/datum/design/powerarmor_skeleton
	name = "Power Armor Skeleton"
	id = "powerarmor_skeleton"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/powerarmor
	materials = list(/datum/material/iron=15000, /datum/material/plasma=5000)
	construction_time = 500
	category = list("Misc")

/datum/design/powerarmor_torso
	name = "Power Armor Torso"
	id = "powerarmor_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_torso
	materials = list(/datum/material/iron=40000, /datum/material/plasma=10000, /datum/material/titanium=5000)
	construction_time = 500
	category = list("Misc")

/datum/design/powerarmor_helmet
	name = "Power Armor Helmet"
	id = "powerarmor_helmet"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_helmet
	materials = list(/datum/material/iron=20000, /datum/material/plasma=10000, /datum/material/titanium=5000, /datum/material/glass=5000)
	construction_time = 500
	category = list("Misc")

/datum/design/powerarmor_armL
	name = "Power Armor Left Arm"
	id = "powerarmor_armL"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_left_arm
	materials = list(/datum/material/iron=20000, /datum/material/plasma=10000, /datum/material/titanium=5000,)
	construction_time = 500
	category = list("Misc")

/datum/design/powerarmor_armR
	name = "Power Armor Right Arm"
	id = "powerarmor_armR"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_right_arm
	materials = list(/datum/material/iron=20000, /datum/material/plasma=10000, /datum/material/titanium=5000,)
	construction_time = 500
	category = list("Misc")

/datum/design/powerarmor_legL
	name = "Power Armor Left Leg"
	id = "powerarmor_legL"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_left_leg
	materials = list(/datum/material/iron=20000, /datum/material/plasma=10000, /datum/material/titanium=5000,)
	construction_time = 500
	category = list("Misc")

/datum/design/powerarmor_legR
	name = "Power Armor Right Leg"
	id = "powerarmor_legR"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_right_leg
	materials = list(/datum/material/iron=20000, /datum/material/plasma=10000, /datum/material/titanium=5000,)
	construction_time = 500
	category = list("Misc")

//Clarke
/datum/design/clarke_chassis
	name = "Exosuit Chassis (\"Clarke\")"
	id = "clarke_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/clarke
	materials = list(/datum/material/iron=20000)
	construction_time = 100
	category = list("Clarke")

/datum/design/clarke_torso
	name = "Exosuit Torso (\"Clarke\")"
	id = "clarke_torso"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_torso
	materials = list(/datum/material/iron=20000,/datum/material/glass = 7500)
	construction_time = 200
	category = list("Clarke")

/datum/design/clarke_head
	name = "Exosuit Head (\"Clarke\")"
	id = "clarke_head"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_head
	materials = list(/datum/material/iron=6000,/datum/material/glass = 10000)
	construction_time = 100
	category = list("Clarke")

/datum/design/clarke_left_arm
	name = "Exosuit Left Arm (\"Clarke\")"
	id = "clarke_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_left_arm
	materials = list(/datum/material/iron=15000)
	construction_time = 150
	category = list("Clarke")

/datum/design/clarke_right_arm
	name = "Exosuit Right Arm (\"Clarke\")"
	id = "clarke_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/clarke_right_arm
	materials = list(/datum/material/iron=15000)
	construction_time = 150
	category = list("Clarke")

/datum/design/conveyor_belt_mechfab
	name = "Conveyor Belt"
	id = "conveyor_belt_mechfab"
	build_type = MECHFAB
	build_path = /obj/item/stack/conveyor
	materials = list(/datum/material/iron=2000) //costs less than building one at the autolathe
	construction_time = 30
	category = list("Clarke")

//Buzz
/datum/design/buzz_chassis
	name = "Exosuit Chassis (\"Buzz\")"
	id = "buzz_chassis"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/chassis/buzz
	materials = list(/datum/material/iron=10000, /datum/material/titanium=3000)
	construction_time = 200
	category = list("Buzz")

/datum/design/buzz_harness
	name = "Exosuit Harness (\"Buzz\")"
	id = "buzz_harness"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/buzz_harness
	materials = list(/datum/material/iron=15000, /datum/material/titanium=2000)
	construction_time = 165
	category = list("Buzz")

/datum/design/buzz_cockpit
	name = "Exosuit Cockpit (\"Buzz\")"
	id = "buzz_cockpit"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/buzz_cockpit
	materials = list(/datum/material/iron=3000,/datum/material/glass = 15000)
	construction_time = 150
	category = list("Buzz")

/datum/design/buzz_left_arm
	name = "Exosuit Left Arm (\"Buzz\")"
	id = "buzz_left_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/buzz_left_arm
	materials = list(/datum/material/iron=15000, /datum/material/titanium=2500)
	construction_time = 100
	category = list("Buzz")

/datum/design/buzz_right_arm
	name = "Exosuit Right Arm (\"Buzz\")"
	id = "buzz_right_arm"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/buzz_right_arm
	materials = list(/datum/material/iron=15000, /datum/material/titanium=2500)
	construction_time = 100
	category = list("Buzz")

/datum/design/buzz_left_leg
	name = "Exosuit Left Leg (\"Buzz\")"
	id = "buzz_left_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/buzz_left_leg
	materials = list(/datum/material/iron=10000, /datum/material/titanium=2500)
	construction_time = 75
	category = list("Buzz")

/datum/design/buzz_right_leg
	name = "Exosuit Right Leg (\"Buzz\")"
	id = "buzz_right_leg"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/buzz_right_leg
	materials = list(/datum/material/iron=10000, /datum/material/titanium=2500)
	construction_time = 75
	category = list("Buzz")

/datum/design/exosuit_gps
	name = "Exosuit GPS"
	desc = "Allows for the construction of an exosuit-fitted GPS."
	build_type = MECHFAB
	id = "exogps"
	build_path = /obj/item/mecha_parts/mecha_equipment/gps
	materials = list(/datum/material/iron=5000)
	construction_time = 100
	category = list("Exosuit Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/buzz_lance
	name = "Buzz Energy Lance"
	desc = "Allows for the construction of an energy lance module for Buzz mechs."
	id = "buzz_lance"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/energylance
	materials = list(/datum/material/iron=5000, /datum/material/titanium=7500, /datum/material/plasma=5000, /datum/material/glass=5000)
	construction_time = 100
	category = list("Exosuit Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/buzz_clamp
	name = "Buzz Hydraulic Clamp"
	desc = "Allows for the construction of a titanium alloy clamp for Buzz mechs."
	id = "buzz_clamp"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/buzz
	materials = list(/datum/material/iron=5000, /datum/material/titanium=5000, /datum/material/glass=5000, /datum/material/diamond=1000)
	construction_time = 100
	category = list("Exosuit Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/datum/design/buzz_thrusters
	name = "Buzz Thrusters"
	desc = "Allows for the construction of a thruster module for Buzz mechs."
	id = "buzz_thrusters"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/buzzthrusters
	materials = list(/datum/material/iron=5000, /datum/material/titanium=5000, /datum/material/diamond=3000, /datum/material/uranium=5000)
	construction_time = 100
	category = list("Exosuit Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE

/*
	IPC/SYNTHLIZ/SYNTH CONSTRUCTION
	HELL YEAH LETS GET THIS BREAD
*/

/datum/design/power_cord
	name = "Arm Power Cord"
	id = "arm_cord"
	build_type = MECHFAB
	build_path = /obj/item/organ/cyberimp/arm/power_cord
	materials = list(/datum/material/iron = 1200, /datum/material/gold = 200, /datum/material/glass = 500)
	construction_time = 25
	category = list("IPC")

/datum/design/ipc_chassis
	name = "IPC chassis"
	id = "ipc_chassis"
	build_type = MECHFAB
	research_icon = 'modular_skyrat/icons/mob/ipc/ipc_parts.dmi'
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/ipc/mangled
	materials = list(/datum/material/iron = 5000, /datum/material/titanium = 10000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 150
	category = list("IPC")

/datum/design/synth_chassis
	name = "Synth chassis"
	id = "synth_chassis"
	build_type = MECHFAB
	research_icon = 'modular_skyrat/icons/mob/ipc/ipc_parts.dmi'
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/synth/mangled
	materials = list(/datum/material/iron = 7000, /datum/material/titanium = 10000, /datum/material/plasma = 5000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 150
	category = list("IPC")

/datum/design/synthliz_chassis
	name = "Synth lizard chassis"
	id = "synthliz_chassis"
	build_type = MECHFAB
	research_icon = 'modular_skyrat/icons/mob/ipc/ipc_parts.dmi'
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/synthliz/mangled
	materials = list(/datum/material/iron = 7000, /datum/material/titanium = 10000, /datum/material/plasma = 5000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 150
	category = list("IPC")

/datum/design/android_chassis
	name = "Android chassis"
	id = "android_chassis"
	build_type = MECHFAB
	research_icon = 'modular_skyrat/icons/mob/ipc/ipc_parts.dmi'
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/android/mangled
	materials = list(/datum/material/iron = 10000, /datum/material/titanium = 30000, /datum/material/plasma = 5000, /datum/material/gold = 5000, /datum/material/glass = 1000, /datum/material/silver = 5000)
	construction_time = 150
	category = list("IPC")

/datum/design/military_synth_chassis
	name = "Military synth chassis"
	id = "military_synth_chassis"
	build_type = MECHFAB
	research_icon = 'modular_skyrat/icons/mob/ipc/ipc_parts.dmi'
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/synth/military/mangled
	materials = list(/datum/material/iron = 25000, /datum/material/titanium = 30000, /datum/material/plasma = 15000, /datum/material/gold = 15000, /datum/material/glass = 10000, /datum/material/silver = 5000)
	construction_time = 150
	category = list("IPC")

/datum/design/corporate_chassis
	name = "Corporate synth chassis"
	id = "corporate_chassis"
	build_type = MECHFAB
	research_icon = 'modular_skyrat/icons/mob/ipc/ipc_parts.dmi'
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/corporate/mangled
	materials = list(/datum/material/iron = 25000, /datum/material/titanium = 30000, /datum/material/plasma = 30000, /datum/material/gold = 30000, /datum/material/glass = 10000, /datum/material/silver = 20000)
	construction_time = 150
	category = list("IPC")

//ipc organs
/datum/design/ipc_heart
	name = "IPC heart"
	id = "ipc_heart"
	build_type = MECHFAB
	build_path = /obj/item/organ/heart/robot_ipc
	materials = list(/datum/material/iron = 3000, /datum/material/gold = 1000, /datum/material/titanium = 500)
	construction_time = 150
	category = list("IPC")

/datum/design/ipc_lungs
	name = "IPC lungs"
	id = "ipc_lungs"
	build_type = MECHFAB
	build_path = /obj/item/organ/lungs/robot_ipc
	materials = list(/datum/material/iron = 1500, /datum/material/gold = 500)
	construction_time = 150
	category = list("IPC")

/datum/design/ipc_tongue
	name = "IPC tongue"
	id = "ipc_tongue"
	build_type = MECHFAB
	build_path = /obj/item/organ/tongue/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000)
	construction_time = 100
	category = list("IPC")

/datum/design/ipc_stomach
	name = "IPC stomach cell"
	id = "ipc_stomach"
	build_type = MECHFAB
	build_path = /obj/item/organ/stomach/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000, /datum/material/uranium = 2500)
	construction_time = 100
	category = list("IPC")

/datum/design/ipc_liver
	name = "IPC liver processor"
	id = "ipc_liver"
	build_type = MECHFAB
	build_path = /obj/item/organ/liver/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000, /datum/material/uranium = 2500)
	construction_time = 100
	category = list("IPC")

/datum/design/ipc_eyes
	name = "IPC eyes"
	id = "ipc_eyes"
	build_type = MECHFAB
	build_path = /obj/item/organ/eyes/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000, /datum/material/uranium = 2500, /datum/material/glass = 1000)
	construction_time = 100
	category = list("IPC")

/datum/design/ipc_ears
	name = "IPC ears"
	id = "ipc_ears"
	build_type = MECHFAB
	build_path = /obj/item/organ/ears/robot_ipc
	materials = list(/datum/material/iron = 3000, /datum/material/silver = 1000, /datum/material/titanium = 2000)
	construction_time = 100
	category = list("IPC")

//cybernetic genitals
/datum/design/cybernetic_penis
	name = "Cybernetic Penis"
	id = "cyborg_penis"
	build_type = MECHFAB
	research_icon_state = "penis_human_3_s"
	research_icon = 'icons/obj/genitals/penis.dmi'
	build_path = /obj/item/organ/genital/penis/robotic
	materials = list(/datum/material/iron = 2000, /datum/material/titanium = 500)
	construction_time = 75
	category = list("IPC")

/datum/design/cybernetic_testicles
	name = "Cybernetic Testicles"
	id = "cyborg_testicles"
	build_type = MECHFAB
	research_icon_state = "testicles_single_3_s"
	research_icon = 'icons/obj/genitals/testicles.dmi'
	build_path = /obj/item/organ/genital/testicles/robotic
	materials = list(/datum/material/iron = 2000, /datum/material/titanium = 500)
	construction_time = 75
	category = list("IPC")

/datum/design/cybernetic_breasts
	name = "Cybernetic Breasts"
	id = "cyborg_breasts"
	build_type = MECHFAB
	research_icon_state = "breasts_pair_e_s"
	research_icon = 'icons/obj/genitals/breasts.dmi'
	build_path = /obj/item/organ/genital/breasts/robotic
	materials = list(/datum/material/iron = 2000, /datum/material/titanium = 500)
	construction_time = 75
	category = list("IPC")

/datum/design/cybernetic_vagina
	name = "Cybernetic Vagina"
	id = "cyborg_vagina"
	build_type = MECHFAB
	research_icon_state = "vagina-s"
	research_icon = 'icons/obj/genitals/vagina.dmi'
	build_path = /obj/item/organ/genital/vagina/robotic
	materials = list(/datum/material/iron = 2000, /datum/material/titanium = 500)
	construction_time = 75
	category = list("IPC")

/datum/design/cybernetic_womb
	name = "Cybernetic Womb"
	id = "cyborg_womb"
	build_type = MECHFAB
	research_icon_state = "womb"
	research_icon = 'icons/obj/genitals/vagina.dmi'
	build_path = /obj/item/organ/genital/womb/robotic
	materials = list(/datum/material/iron = 2000, /datum/material/titanium = 500)
	construction_time = 75
	category = list("IPC")
