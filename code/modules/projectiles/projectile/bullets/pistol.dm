// 9mm (Stechkin APS)

/obj/item/projectile/bullet/c9mm
	name = "9mm bullet"
	damage = 25  //Skyrat edit: Same damage as .38, they're literally the same round with a different load.
	wound_bonus = -10
	embedding = list(embed_chance=15, fall_chance=3, jostle_chance=4, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.4, pain_mult=5, jostle_pain_mult=6, rip_time=10)

/obj/item/projectile/bullet/c9mm_ap
	name = "9mm armor-piercing bullet"
	damage = 15
	armour_penetration = 40
	embedding = null
	wound_bonus = 15

/obj/item/projectile/bullet/incendiary/c9mm
	name = "9mm incendiary bullet"
	damage = 10
	fire_stacks = 1
	wound_bonus = -50

// 10mm (Stechkin)

/obj/item/projectile/bullet/c10mm
	name = "10mm bullet"
	damage = 30
	wound_bonus = 10
	stamina = 5  //Skyrat edit: Stopping power, 10x25mm is almost the same as .45 ACP if not bigger.

/obj/item/projectile/bullet/c10mm_ap
	name = "10mm armor-piercing bullet"
	damage = 27
	armour_penetration = 40
	wound_bonus = 20

/obj/item/projectile/bullet/c10mm_hp
	name = "10mm hollow-point bullet"
	damage = 40
	armour_penetration = -50
	stamina = 8 //Skyrat edit: Stopping power, but better. JHP rounds inflict a lot of pain and won't penetrate.

/obj/item/projectile/bullet/incendiary/c10mm
	name = "10mm incendiary bullet"
	damage = 15
	fire_stacks = 2
	wound_bonus = -80

/obj/item/projectile/bullet/c10mm/soporific
	name ="10mm soporific bullet"
	nodamage = TRUE
	wound_bonus = CANT_WOUND

/obj/item/projectile/bullet/c10mm/soporific/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if((blocked != 100) && isliving(target))
		var/mob/living/L = target
		L.blur_eyes(6)
		if(L.getStaminaLoss() >= 60)
			L.Sleeping(300)
		else
			L.adjustStaminaLoss(25) 

// .32 ACP (Improvised Pistol)

/obj/item/projectile/bullet/c32acp
	name = ".32 bullet"
	damage = 13
	wound_bonus = 5

/obj/item/projectile/bullet/r32acp
	name = ".32 rubber bullet"
	damage = 3
	eyeblur = 1
	stamina = 20
	wound_bonus = 5
	embedding = EMBED_NONE

