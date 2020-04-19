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
	construction_time = 120
	category = list("Exosuit Equipment")

/datum/design/killdozer_drill
	name = "Killdozer Upgrade (Kill-drill)"
	id = "killdozer_drill"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/drill/killdozer
	materials = list(/datum/material/iron=25000, /datum/material/diamond=1000, /datum/material/uranium=2500)
	construction_time = 120
	category = list("Exosuit Equipment")

/datum/design/killdozer_pistol
	name = "Killdozer Upgrade (10mm pistol)"
	id = "killdozer_pistol"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/killdozer
	materials = list(/datum/material/iron=30000, /datum/material/diamond=2500, /datum/material/uranium=3500)
	construction_time = 120
	category = list("Exosuit Equipment")

/datum/design/killdozer_pistol
	name = "Exosuit Stetchkin Ammo"
	id = "killdozer_pistol_ammo"
	build_type = MECHFAB
	build_path = /obj/item/mecha_ammo/10mm
	materials = list(/datum/material/iron=1000, /datum/material/diamond=100, /datum/material/uranium=500)
	construction_time = 120
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
	category = list("Cyborg Upgrade Modules")

///Power Armor
/datum/design/powerarmor_skeleton
	name = "Power Armor Skeleton"
	id = "powerarmor_skeleton"
	build_type = MECHFAB
	build_path = /obj/item/mecha_parts/part/powerarmor_chassis
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
///End of Power Armor
