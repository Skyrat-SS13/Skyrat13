/obj/item/projectile/bullet
	name = "bullet"
	icon_state = "bullet"
	damage = 60
	damage_type = BRUTE
	nodamage = FALSE
	candink = TRUE
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	//skyrat edit
	sharpness = SHARP_POINTY
	shrapnel_type = /obj/item/shrapnel/bullet
	embedding = list(embed_chance=15, fall_chance=2, jostle_chance=0, ignore_throwspeed_threshold=TRUE, pain_stam_pct=0.5, pain_mult=3, rip_time=10)
	wound_falloff_tile = -5
	embed_falloff_tile = -5
	//

/obj/item/projectile/bullet/process_hit(turf/T, atom/target, qdel_self, hit_something)
	. = ..()
	var/mob/living/L = target
	if((damage_type == BRUTE) && istype(L) && ((L.mob_biotypes & MOB_ORGANIC) || (L.mob_biotypes & MOB_HUMANOID)) && (damage >= 10) && !nodamage)
		var/obj/effect/decal/cleanable/blood/hitsplatter/B = new(target.loc, L.get_blood_dna_list())
		B.add_blood_DNA(L.get_blood_dna_list())
		var/dist = rand(1,min(damage/10, 5))
		var/turf/targ = get_ranged_target_turf(target, get_dir(starting, target), dist)
		B.GoTo(targ, dist)
