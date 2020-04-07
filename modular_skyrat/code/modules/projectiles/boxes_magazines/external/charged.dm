////// CHARGE WEAPONS MAGAZINES (EXTERNAL AND INTERNAL) //////
/obj/item/ammo_box/magazine/charged
	name = "unbranded charged shot box"
	desc = "This doesn't seem... quite right." //If you see this something went "uwu uh oh! Stinky winky! we made a fucky wucky! owowowowowowo"
	icon = 'modular_skyrat/icon/obj/guns/chargeweapons.dmi'
	icon_state = "mag_bugged"
	ammo_type = /obj/item/ammo_casing/charged
	caliber = "chargednull"
	max_ammo = 5

/obj/item/ammo_box/magazine/charged/chargerifle
	name = "charge rifle magazine"
	desc = "A magazine for a charged rifle. Takes CH1212-R type rounds."
	icon_state = "chargerifle_mag"
	ammo_type = /obj/item/ammo_casing/charged/riflecasing
	caliber = "CH1212-R"
	max_ammo = 10

/obj/item/ammo_box/magazine/charged/chargerifle/update_icon() //This could have probably been shortended down to one overall proc for all of /magazine/charged/ but im too lazy to figure it out.
	if(ammo_count())
		icon_state = "chargerifle_mag"
	else
		icon_state = "chargerifle_mag-e"

/obj/item/ammo_box/magazine/charged/chargepistol
	name = "charge pistol magazine"
	desc = "A magazine for a charged pistol. Takes CH1212-P type rounds."
	icon_state = "chargepistol_mag"
	ammo_type = /obj/item/ammo_casing/charged/pistolcasing
	caliber = "CH1212-P"
	max_ammo = 16 //8 on the outside sticking out plus more in the chonky middle section of the magazine.

/obj/item/ammo_box/magazine/charged/chargepistol/update_icon()
	if(ammo_count())
		icon_state = "chargepistol_mag"
	else
		icon_state = "chargepistol_mag-e"

/obj/item/ammo_box/magazine/charged/chargesmg
	name = "charge SMG magazine"
	desc = " A magazine for a charged SMG. Holds numerous small charged munitions. Takes CH1212-S type rounds."
	icon_state = "chargesmg_mag"
	ammo_type = /obj/item/ammo_casing/charged/smgcasing
	caliber = "CH1212-S"
	max_ammo = 20

/obj/item/ammo_box/magazine/charged/chargepistol/update_icon()
	if(ammo_count())
		icon_state = "chargesmg_mag"
	else
		icon_state = "chargesmg_mag-e"

/obj/item/ammo_box/magazine/internal/charged/chargeshotgun
	name = "charge shotgun internal magazine"
	desc = "You shouldn't be seeing this. What the fuck did you do?" //You also shouldn't see this.
	icon = 'modular_skyrat/icons/obj/guns/chargeweapons.dmi'
	icon_state = "mag_bugged"
	ammo_type = /obj/item/ammo_casing/charged/shotgun
	caliber = "CH1212-H"
	max_ammo = 6 //As good as a combat shotgun
	multiload = 0

/obj/item/ammo_box/magazine/internal/charged/chargeshotgun/ammo_count(countempties = 1) //copypasta'd from shotgun internal magazine code.
	if (!countempties)
		var/boolets = 0
		for(var/obj/item/ammo_casing/bullet in stored_ammo)
			if(bullet.BB)
				boolets++
		return boolets
	else
		return ..()

/obj/item/ammo_box/magazine/internal/charged/chargeshotgun/nonlethal
	ammo_type = /obj/item/ammo_casing/charged/shotgun/nonlethal

/obj/item/ammo_box/magazine/charged/toyrifle
	name = "toy charge rifle magazine"
	desc = "A cheap plastic magazine used in toy charge rifles. Cute, if ineffective."
	icon_state = "nerfchargerifle_mag" //Its nerf or nothing. Just like im probably going to have to NERF this or NOTHING is getting accepted, hahaaaaaaaa.
	ammo_type = /obj/item/ammo_casing/charged/toy
	caliber = "charged foam"
	max_ammo = 10

/obj/item/ammo_box/magazine/charged/chargerifle/update_icon()
	if(ammo_count())
		icon_state = "nerfchargerifle_mag"
	else
		icon_state = "nerfchargerifle_mag-e"
