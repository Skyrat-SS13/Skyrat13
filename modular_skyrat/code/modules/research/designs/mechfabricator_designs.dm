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
