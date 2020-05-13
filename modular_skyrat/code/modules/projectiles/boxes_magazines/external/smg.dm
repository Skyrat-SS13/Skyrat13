//HoS MP5
/obj/item/ammo_box/magazine/smgm9mm/rubber
	name = "SMG magazine (9mm rubber)"
	caliber = "9mmr"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	max_ammo = 20

/obj/item/ammo_box/magazine/smgm9mm/rubber/emag_act(mob/user)
	..()
	to_chat(user, "<span class='notice'>The [src] can now accept lethal 9mm rounds, but cannot accept rubber rounds anymore.</span>")
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = "9mm"
