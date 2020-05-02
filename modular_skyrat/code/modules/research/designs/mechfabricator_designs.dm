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
	name = "Exosuit Chassis (APLU \"Killdozeer\")"
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
