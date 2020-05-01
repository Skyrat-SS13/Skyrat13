#define DRILL_BASIC 1
#define DRILL_HARDENED 2

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/killdozer
	name = "Mech-adapted Stetchkin 10mm Pistol"
	desc = "A weapon for combat exosuits. Shoots 10mm bullets."
	icon_state = "mecha_carbine"
	equip_cooldown = 10
	projectile = /obj/item/projectile/bullet/c10mm
	projectiles = 30
	projectiles_cache = 30
	projectiles_cache_max = 125
	harmful = TRUE
	ammo_type = "10mm"

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/real/killdozer
	name = "killdozer hydraulic clamp"
	desc = "Equipment for engineering exosuits. Lifts objects and loads them into cargo. Very fast and powerful."
	icon_state = "mecha_clamp"
	equip_cooldown = 5
	energy_drain = 5
	dam_force = 22.5
	harmful = TRUE
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 0.3

/obj/item/mecha_parts/mecha_equipment/drill/killdozer
	name = "killdozer exosuit drill"
	desc = "Equipment for engineering and combat exosuits. This is an upgraded version of the drill that'll pierce the government's heart!"
	icon_state = "mecha_diamond_drill"
	equip_cooldown = 5
	drill_delay = 4
	drill_level = DRILL_HARDENED
	force = 35
	toolspeed = 0.4

/obj/item/mecha_ammo/stetchkin
	name = "10mm exosuit ammo"
	desc = "A box of linked ammunition, designed for the exosuit adapted Stetchkin."
	icon_state = "lmg"
	rounds = 50
	ammo_type = "lmg"

#undef DRILL_BASIC
#undef DRILL_HARDENED
