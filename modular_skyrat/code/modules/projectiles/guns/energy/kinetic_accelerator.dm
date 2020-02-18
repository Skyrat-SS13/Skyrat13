/obj/item/gun/energy/kinetic_accelerator/premiumka/bdminer
	name = "bloody accelerator"
	desc = "A modded premium kinetic accelerator with an increased mod capacity as well as lesser cooldown."
	icon = 'modular_skyrat/icons/obj/guns/energy.dmi'
	icon_state = "bdpka"
	overheat_time = 13
	max_mod_capacity = 125

/obj/item/ammo_casing/energy/kinetic/premium/bdminer
	projectile_type = /obj/item/projectile/kinetic/premium/bdminer

/obj/item/projectile/kinetic/premium/bdminer
	name = "bloody kinetic force"
	icon_state = "ka_tracer"
	color = "#FF0000"
	damage = 50
	damage_type = BRUTE
	flag = "bomb"
	range = 4
	log_override = TRUE
