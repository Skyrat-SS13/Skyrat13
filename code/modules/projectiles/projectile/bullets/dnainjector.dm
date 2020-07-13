/obj/item/projectile/bullet/dnainjector
	name = "\improper DNA injector"
	icon_state = "syringeproj"
	var/obj/item/dnainjector/injector
	damage = 5
	hitsound_wall = "shatter"
	wound_bonus = CANT_WOUND
	embedding = list(embed_chance=0, fall_chance=2, jostle_chance=0, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.5, pain_mult=3, rip_time=10)

/obj/item/projectile/bullet/dnainjector/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		if(blocked != 100)
			if(M.can_inject(null, FALSE, def_zone, FALSE))
				if(injector.inject(M, firer))
					QDEL_NULL(injector)
					return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message("<span class='danger'>\The [src] was deflected!</span>", \
									   "<span class='userdanger'>You were protected against \the [src]!</span>")
	return ..()

/obj/item/projectile/bullet/dnainjector/Destroy()
	QDEL_NULL(injector)
	return ..()
